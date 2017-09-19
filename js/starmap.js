const SVG_NS = "http://www.w3.org/2000/svg";
// The angle between points is 2*PI/6, so the angle between a
// point and the midpoint of the side must be half that (PI/6),
// so the length of the inradius (the adjacent line) is cos(PI/6).
const CIRCUM_TO_INNER = Math.cos(Math.PI/6);
const CIRCUM_TO_HALFSIDE = Math.sin(Math.PI/6);

const MAX_RING_RADIUS = 30;
const MIN_RING_RADIUS = 15;

class StarSystem {
    constructor(name, cell, worlds) {
        this.name = name;

        this.row = 0;
        this.column = 0;
        this.cell = cell;

        this.worlds = worlds.sort((a, b) => a.sys_pos - b.sys_pos);
    }

    get cell() {
        const rowRaw = `0${this.row}`;
        const colRaw = `0${this.column}`;

        return `${colRaw.slice(rowRaw.length-2)}${rowRaw.slice(colRaw.length-2)}`;

    }

    set cell(c) {
        this.column = parseInt(c.substring(1, 2));
        this.row = parseInt(c.substring(3, 4));
    }

    static fromData(stars, worlds) {
        let worldsByStarId = new Map();
        for (let star of stars) { worldsByStarId.set(star.id, []); }

        for (let world of worlds) {
            let starWorlds = worldsByStarId.get(world.star_id);
            starWorlds.push(world);
        }

        return stars.map((star) => new StarSystem(star.name, star.cell, worldsByStarId.get(star.id)));
    }
}

class StarSystemRenderer {
    constructor(columns, rows, circumradius) {
        this._columns = columns;
        this._rows = rows;
        this._circumradius = circumradius;

        this._inradius = CIRCUM_TO_INNER*circumradius;
        this._halfSideLen = CIRCUM_TO_HALFSIDE*circumradius;
    }

    _positionFor(system) {
        let y = (system.row*2*this._inradius)+(this._inradius * (system.column%2))+this._inradius;
        let x = ((system.column+1)*this._circumradius)+(system.column*this._halfSideLen);

        return [x, y];
    }

    svgFor(system) {
        let pos = this._positionFor(system);

        // render the star
        let star = `<circle cx="${pos[0]}" cy="${pos[1]}" r="7.5"/>`

        // render the label
        let label = `<text text-anchor="middle" x="${pos[0]}" y="${pos[1]}">${system.name}</text>`

        // render the world rings
        const ringIncrement = Math.floor((MAX_RING_RADIUS - MIN_RING_RADIUS) / system.worlds.length);
        let worldRings = system.worlds.map((world, ind) => {
            let ringRadius = MIN_RING_RADIUS + ringIncrement*ind;
            return `
            <g class="world" style="transform-origin: ${pos[0]}px ${pos[1]}px">
                <circle cx="${pos[0]}" cy="${pos[1]}" r="${ringRadius}" class="orbit"/>
                <g style="transform-origin: ${pos[0]}px ${pos[1]}px"><circle cx="${pos[0]}" cy="${pos[1]+ringRadius}" r="2.5" class="planet" style="transform-origin: ${pos[0]}px ${pos[1]}px"/></g>
            </g>
            `
        });

        let overallGroup = document.createElementNS(SVG_NS, "g");
        overallGroup.innerHTML = star+label+`<g>${worldRings.join("\n")}</g>`;
        overallGroup.style = `transform-origin: ${pos[0]}px ${pos[1]}px`;

        return overallGroup;
    }
}

class Starmap extends HTMLElement {
    constructor() {
        super();
        const templ = document.getElementById('starmap-template');
        const shadowRoot = this.attachShadow({mode: 'open'});
        shadowRoot.appendChild(templ.content.cloneNode(true));

        const svg = shadowRoot.querySelector("svg");
        this._gridContainer = svg.getElementById("grid");
        this._starsContainer = svg.getElementById("stars");
        this._container = svg;

        this._lastDimensions = {rows: 0, columns: 0, circumradius: 0};

        // handle star clicks
        this._container.addEventListener('click', this._handleClick.bind(this));
    }

    get rows() { return parseInt(this.getAttribute('rows')); }
    set rows(v) { this.setAttribute('rows', v); }

    get columns() { return parseInt(this.getAttribute('columns')); }
    set columns(v) { this.setAttribute('columns', v); }

    get circumradius() { return parseInt(this.getAttribute('circumradius')); }
    set circumradius(v) { this.setAttribute('circumradius', v); }

    static get observedAttributes() {
        return ['rows', 'columns', 'circumradius'];
    }

    attributeChangedCallback(attr, oldVal, newVal) {
        this._renderGrid();
    }

    connectedCallback() {
        this._renderGrid();
    }

    // _hexPoints produces the points of a hexagon with the given center
    // and circumradius.
    _hexPoints(center, circumradius) {
        let points = new Array(6);
        const pointAngles = 2*Math.PI/6;

        for (let i = 0; i < 6; i++) {
            points[i] = [Math.cos(pointAngles*i)*circumradius+center[0], Math.sin(pointAngles*i)*circumradius+center[1]];
        }

        return points;
    }

    // _centerPoints produces a list of center points for a grid of hexagons
    // `columns` hexagons wide and `rows` hexagons tall, for hexes with the
    // given circumradius.
    _centerPoints(columns, rows, circumradius) {
        const inradius = CIRCUM_TO_INNER*circumradius;
        const halfSideLen = CIRCUM_TO_HALFSIDE*circumradius;

        let points = new Array(columns * rows);
        for (let row = 0; row < rows; row++) {
            for (let col = 0; col < columns; col++) {
                // every other column is one radius down
                let y = (row*2*inradius)+(inradius * (col%2))+inradius;
                let x = ((col+1)*circumradius)+(col*halfSideLen);
                points[row*columns+col] = [x, y];
            }
        }
        return points;
    }

    // _hexPolygon produces a polygon element with points with the given center
    // and circumradius.
    _hexPolygon(center, circumradius) {
        let points = this._hexPoints(center, circumradius);
        let polygon = document.createElementNS(SVG_NS, "polygon");
        polygon.setAttribute("points", points.map((pts) => `${Math.round(pts[0])},${Math.round(pts[1])}`).join(" "));
        return polygon;
    }

    // _hexGridPolygons produces polygon elements for a grid of hexagons `columns` wide
    // and `rows` tall, with hexes of the given circumradius.
    _hexGridPolygons(columns, rows, circumradius) {
        let centers = this._centerPoints(columns, rows, circumradius);
        return centers.map((center, ind) => {
            let poly = this._hexPolygon(center, circumradius)
            let label = this._cellLabel(ind%columns, Math.floor(ind/columns));
            label.setAttribute("x", center[0]);
            label.setAttribute("y", center[1]);

            let group = document.createElementNS(SVG_NS, "g");
            group.appendChild(poly);
            group.appendChild(label);

            return group;
        });
    }

    // _cellLabel produces the label element for a cell at the given row and column.
    _cellLabel(column, row) {
        let elem = document.createElementNS(SVG_NS, "text");
        elem.setAttribute("text-anchor", "middle")
        elem.textContent = this._cellId(column, row);

        return elem;
    }

    get _dimensionsChanged() {
        return this._lastDimensions.rows !== this.rows ||
            this._lastDimensions.columns !== this.columns ||
            this._lastDimensions.circumradius !== this.circumradius;
    }

    get _desiredContainerSize() {
        const inradius = CIRCUM_TO_INNER*this.circumradius;
        const halfSideLen = CIRCUM_TO_HALFSIDE*this.circumradius;

        return [(this.columns+1)*this.circumradius+this.columns*halfSideLen,
                this.rows*2*inradius+(inradius*(this.columns%2))+inradius];
    }

    // cellId produces cell label text in the form of XXYY from the given
    // row and column.
    _cellId(column, row) {
        const rowRaw = `0${row}`;
        const colRaw = `0${column}`;

        return `${colRaw.slice(rowRaw.length-2)}${rowRaw.slice(colRaw.length-2)}`;
    }

    _renderGrid() {
        if (!this._dimensionsChanged) { return; }

        let polys = this._hexGridPolygons(this.columns, this.rows, this.circumradius);
        this._gridContainer.innerHTML = '';

        polys.forEach((poly, ind) => {
            poly.classList.add('hex');
            poly.dataset.cell = this._cellId(ind % this.columns, Math.floor(ind / this.columns));
            this._gridContainer.appendChild(poly);
        });

        let containerSize = this._desiredContainerSize;
        this._container.setAttribute('width', containerSize[0]);
        this._container.setAttribute('height', containerSize[1]);

        this._lastDimensions = {rows: this.rows, columns: this.columns, circumradius: this.circumradius};
    }

    // _starPolygons produces stars from the given star data positioned on a grid
    // of hexes according to columns, rows, and circumradius.
    _starPolygons(stars, columns, rows, circumradius) {
        let centers = this._centerPoints(columns, rows, circumradius);
        let elems = new Array(stars.length);
        for (let [ind, star] of stars.entries()) {
            // TODO: is this an SWN thing, or an nhr thing?
            let cellCol = parseInt(star.cell.substring(1,2));
            let cellRow = parseInt(star.cell.substring(3,4));

            let centerPoint = centers[cellRow*columns+cellCol];

            let groupElem = document.createElementNS(SVG_NS, "g");

            groupElem.innerHTML = `
            <circle cx="${centerPoint[0]}" cy="${centerPoint[1]}" r="7.5"/>
            <text text-anchor="middle" x="${centerPoint[0]}" y="${centerPoint[1]}">${star.name}</text>`

            elems[ind] = groupElem;
        }

        return elems;
    }

    _updateStars() {
        let renderer = new StarSystemRenderer(this.columns, this.rows, this.circumradius);
        let systems = StarSystem.fromData(this._starData.stars, this._starData.worlds);
        let stars = systems.map((system) => renderer.svgFor(system));
        this._starsContainer.innerHTML = '';
        stars.forEach((grp, ind) => {
            grp.classList.add('star');
            let star = this._starData.stars[ind];
            grp.dataset.starName = star.name;
            grp.dataset.starCell = star.cell;
            grp.dataset.starCount = star.count;
            this._starsContainer.appendChild(grp);
        });
    }

    _handleClick(evt) {
        // TODO: use drag and drop API
        if (evt.target.matches(".star, .star *")) {
            this._beginStarMove(evt.target.closest(".star"));
        } else if (evt.target.matches(".hex, .hex *")) {
            this._endStarMove(evt.target.closest(".hex").dataset.cell);
        }
    }

    _beginStarMove(starElem) {
        starElem.classList.add('move');
        this._container.classList.add('move');
    }

    _endStarMove(targetHex) {
        this._container.classList.remove('move');

        let targetStar = this._starsContainer.querySelector('.star.move');
        if (!targetStar) { return; }

        targetStar.classList.remove('move');

        // make sure to figure out if there was already a star in the target hex, so we can swap
        let existingStarData = this._starData.stars.find((star) => star.cell === targetHex);

        // find the data for the star that we're moving
        let starData = this._starData.stars.find((star) => star.cell === targetStar.dataset.starCell && star.name === targetStar.dataset.starName);

        starData.cell = targetHex;
        if (existingStarData) {
            existingStarData.cell = targetStar.dataset.starCell;
        }

        this._updateStars();
    }

    set data(d) {
        this._starData = d;

        this._updateStars();
    }

    get data() {
        return this._starData;
    }
}

customElements.define('star-map', Starmap);
