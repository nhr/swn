const SVG_NS = "http://www.w3.org/2000/svg";
// The angle between points is 2*PI/6, so the angle between a
// point and the midpoint of the side must be half that (PI/6),
// so the length of the inradius (the adjacent line) is cos(PI/6).
const CIRCUM_TO_INNER = Math.cos(Math.PI/6);
const CIRCUM_TO_HALFSIDE = Math.sin(Math.PI/6);

// determined by what looked good
const MAX_RING_FACTOR = 0.75;
const MIN_RING_FACTOR = 0.375;
const STAR_RADIUS_FACTOR = 0.1875;
const PLANET_RADIUS_FACTOR = 0.0625;

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
    constructor(grid) {
        this._grid = grid;

        // determined by "what looks good"
        this._maxRingRadius = this._grid.cellSize * MAX_RING_FACTOR;
        this._starRadius = this._grid.cellSize * STAR_RADIUS_FACTOR;
        this._minRingRadius = this._grid.cellSize * MIN_RING_FACTOR;
        this._planetRadius = this._grid.cellSize * PLANET_RADIUS_FACTOR;
    }

    svgFor(system) {
        // within the overall group, we use a fixed coordinate system of the cell size, and then
        // translate the group to the correct location.
        let cellCenter = this._grid.centerPointFor(0, 0);

        // render the star
        let star = `<circle class="central-star" cx="${cellCenter[0]}" cy="${cellCenter[1]}" r="${this._starRadius}"/>`

        // render the label
        let label = `<text text-anchor="middle" x="${cellCenter[0]}" y="${cellCenter[1]+this._grid.cellHeight}">${system.name}</text>`

        // render the world rings
        const ringIncrement = Math.floor((this._maxRingRadius - this._minRingRadius) / system.worlds.length);
        let worldRings = system.worlds.map((world, ind) => {
            let ringRadius = this._minRingRadius + ringIncrement*ind;
            return `
            <g class="world" style="transform-origin: ${cellCenter[0]}px ${cellCenter[1]}px">
                <circle cx="${cellCenter[0]}" cy="${cellCenter[1]}" r="${ringRadius}" class="orbit"/>
                <g class="planet-wrapper" style="transform-origin: ${cellCenter[0]}px ${cellCenter[1]}px"><circle cx="${cellCenter[0]}" cy="${cellCenter[1]+ringRadius}" r="${this._planetRadius}" class="planet" style="transform-origin: ${cellCenter[0]}px ${cellCenter[1]}px"/></g>
            </g>
            `
        });

        let centerPos = this._grid.centerPointFor(system.column, system.row);
        let pos = [centerPos[0] - this._grid.cellWidth, centerPos[1] - this._grid.cellHeight];
        let overallGroup = document.createElementNS(SVG_NS, "g");
        overallGroup.innerHTML = `<g class="system" style="transform-origin: ${cellCenter[0]}px ${cellCenter[1]}px;">${star}<g>${worldRings.join("\n")}</g></g>${label}`;
        /*overallGroup.style = `transform-origin: ${cellCenter[0]}px ${cellCenter[1]}px;`;
        overallGroup.setAttribute('x', pos[0]);
        overallGroup.setAttribute('y', pos[1]);*/
        overallGroup.setAttribute('transform', `translate(${pos[0]}, ${pos[1]})`);


        return overallGroup;
    }
}

class SectorHexGrid {
    constructor(columns, rows, cellSize) {
        this.columns = columns;
        this.rows = rows;
        // cellSize is the circumradius of the hexes
        this.cellSize = cellSize;

        this._inradius = CIRCUM_TO_INNER*this.cellSize;
        this._halfSideLen = CIRCUM_TO_HALFSIDE*this.cellSize;
    }

    // centerPointFor produces the coordinates of the center of the hex
    // at the given column and row.
    centerPointFor(column, row) {
        const y = (row*2*this._inradius)+(this._inradius * (column%2))+this._inradius;
        const x = ((column+1)*this.cellSize)+(column*this._halfSideLen);

        return [x, y];
    }

    // cellIdFor returns the cell ID for the given hex.
    cellIdFor(column, row) {
        const rowRaw = `0${row}`;
        const colRaw = `0${column}`;

        return `${colRaw.slice(rowRaw.length-2)}${rowRaw.slice(colRaw.length-2)}`;
    }

    // centerPoints returns the center point for every hex in this hex grid.
    get centerPoints() {
        let points = new Array(this.columns * this.rows);
        for (let row = 0; row < this.rows; row++) {
            for (let col = 0; col < this.columns; col++) {
                points[row*this.columns+col] = this.centerPointFor(col, row);
            }
        }
        return points;
    }

    get cellWidth() {
        return this.cellSize;
    }

    get cellHeight() {
        return this._inradius;
    }

    // totalSize returns the total size of the bounding box of the grid.
    get totalSize() {
        let lastCenterPoint = this.centerPointFor(this.columns-1, this.rows-1);
        return [lastCenterPoint[0]+this.cellSize, lastCenterPoint[1]+this._inradius];
    }

    static cellSizeFor(columns, rows, width, height) {
        let [unitWidth, unitHeight] = new SectorHexGrid(columns, rows, 1).totalSize;
        let widthCircumradius = width/unitWidth;
        let heightCircumradius = height/unitHeight;

        return Math.min(widthCircumradius, heightCircumradius);
    }
}

class SectorHexGridRenderer {
    // _hexPoints produces the points of a hexagon on the given
    // grid with the given center.
    _hexPoints(grid, center) {
        let points = new Array(6);
        const pointAngles = 2*Math.PI/6;

        for (let i = 0; i < 6; i++) {
            points[i] = [Math.cos(pointAngles*i)*grid.cellSize+center[0], Math.sin(pointAngles*i)*grid.cellSize+center[1]];
        }

        return points;
    }

    // _hexPolygon produces a polygon element for a hex at the given location
    // on the given grid.
    _hexPolygon(grid, center) {
        let points = this._hexPoints(grid, center);
        let polygon = document.createElementNS(SVG_NS, "polygon");
        polygon.setAttribute("points", points.map((pts) => `${Math.round(pts[0])},${Math.round(pts[1])}`).join(" "));
        return polygon;
    }

    // _cellLabel produces the label element for a cell at the given row and column in the
    // given grid.
    _cellLabel(grid, column, row) {
        let elem = document.createElementNS(SVG_NS, "text");
        elem.setAttribute("text-anchor", "middle")
        elem.textContent = grid.cellIdFor(column, row);

        return elem;
    }

    svgFor(grid) {
        return grid.centerPoints.map((center, ind) => {
            let poly = this._hexPolygon(grid, center)
            let label = this._cellLabel(grid, ind%grid.columns, Math.floor(ind/grid.columns));
            label.setAttribute("x", center[0]);
            label.setAttribute("y", center[1]-grid.cellHeight);

            let group = document.createElementNS(SVG_NS, "g");
            group.appendChild(poly);
            group.appendChild(label);

            return group;
        });
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

        this._lastGrid = new SectorHexGrid(0, 0, 0);

        // handle star clicks
        this._container.addEventListener('click', this._handleClick.bind(this));

        this._systems = null;

        this._selectedSystem = null;
    }

    get rows() { return parseInt(this.getAttribute('rows')); }
    set rows(v) { this.setAttribute('rows', v); }

    get columns() { return parseInt(this.getAttribute('columns')); }
    set columns(v) { this.setAttribute('columns', v); }

    static get observedAttributes() {
        return ['rows', 'columns', 'circumradius'];
    }

    attributeChangedCallback(attr, oldVal, newVal) {
        this._renderGrid();
        if (this._starData) {
            this._updateStars();
        }
    }

    connectedCallback() {
        this._renderGrid();
    }

    get _dimensionsChanged() {
        return this._lastGrid.rows !== this.rows ||
            this._lastGrid.columns !== this.columns ||
            this._lastGrid.cellSize !== this.cellSize;
    }

    _renderGrid() {
        if (!this._dimensionsChanged) { return; }

        // we start out with a fixed "virtual" canvas size...
        let circumradius = SectorHexGrid.cellSizeFor(this.columns, this.rows, this.columns*100, this.rows*100);

        let grid = new SectorHexGrid(this.columns, this.rows, circumradius);
        let renderer = new SectorHexGridRenderer();
        let polys = renderer.svgFor(grid);
        this._gridContainer.innerHTML = '';

        polys.forEach((poly, ind) => {
            poly.classList.add('hex');
            poly.dataset.cell = grid.cellIdFor(ind % this.columns, Math.floor(ind / this.columns));
            this._gridContainer.appendChild(poly);
        });

        // ...adjust the viewbox according to the actual extents...
        let actualCanvasSize = grid.totalSize;
        this._container.setAttribute("viewBox", `0 0 ${actualCanvasSize[0]} ${actualCanvasSize[1]}`);

        // ...and let the browser handle actual scaling

        this._lastGrid = grid;
    }

    _updateStars() {
        let renderer = new StarSystemRenderer(this._lastGrid);
        let systems = StarSystem.fromData(this._starData.stars, this._starData.worlds);
        let stars = systems.map((system) => renderer.svgFor(system));
        this._starsContainer.innerHTML = '';
        stars.forEach((grp, ind) => {
            grp.classList.add('star');
            let star = this._starData.stars[ind];
            grp.dataset.starName = star.name;
            grp.dataset.starId = star.id;
            grp.dataset.starCell = star.cell;
            grp.dataset.starCount = star.count;
            this._starsContainer.appendChild(grp);
        });

        this._systems = systems;
    }

    _handleClick(evt) {
        // TODO: use drag and drop API
        if (evt.target.matches(".star.move, .star.move *")) {
            this._showStarInfo(evt.target.closest(".star"));
        } else if (evt.target.matches(".star, .star *")) {
            this._beginStarMove(evt.target.closest(".star"));
        } else if (evt.target.matches(".hex, .hex *")) {
            this._endStarMove(evt.target.closest(".hex").dataset.cell);
        }
    }

    get selectedSystem() {
        return this._selectedSystem;
    }

    _showStarInfo(starElem) {
        this._endStarMove()
        starElem.classList.add('info');

        // show the info pane
        let system = this._systems.find((sys) => sys.name === starElem.dataset.starName);
        this._selectedSystem = system;
        this.dispatchEvent(new Event('display-info', {bubbles: false}));
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

        if (!targetHex) { return; }

        // make sure to figure out if there was already a star in the target hex, so we can swap
        let existingStarData = this._starData.stars.find((star) => star.cell === targetHex);

        // find the data for the star that we're moving
        let starData = this._starData.stars.find((star) => star.name === targetStar.dataset.starName);


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
