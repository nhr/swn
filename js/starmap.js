const SVG_NS = "http://www.w3.org/2000/svg";
// The angle between points is 2*PI/6, so the angle between a
// point and the midpoint of the side must be half that (PI/6),
// so the length of the inradius (the adjacent line) is cos(PI/6).
const CIRCUM_TO_INNER = Math.cos(Math.PI/6);
const CIRCUM_TO_HALFSIDE = Math.sin(Math.PI/6);

class Starmap extends HTMLElement {
    constructor() {
        super();
        const shadowRoot = this.attachShadow({mode: 'open'});
        shadowRoot.innerHTML = '<link type="text/css" href="css/starmap.css" rel="stylesheet" /><svg xmlns="http://www.w3.org/2000/svg" version="1.1"></svg>';
        this._container = shadowRoot.querySelector("svg");

        this._lastDimensions = {rows: 0, columns: 0, circumradius: 0};
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
        //polygon.setAttribute("points", points.map((pts) => `${Math.round(pts[0])},${Math.round(pts[1])}`).join(" "));
        polygon.setAttribute("points", points.map((pts) => `${Math.round(pts[0])},${Math.round(pts[1])}`).join(" "));
        return polygon;
    }

    // _hexGridPolygons produces polygon elements for a grid of hexagons `columns` wide
    // and `rows` tall, with hexes of the given circumradius.
    _hexGridPolygons(columns, rows, circumradius) {
        let centers = this._centerPoints(columns, rows, circumradius);
        return centers.map((center) => this._hexPolygon(center, circumradius));
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

    _renderGrid() {
        if (!this._dimensionsChanged) { return; }

        let polys = this._hexGridPolygons(this.columns, this.rows, this.circumradius);
        this._container.innerHTML = '';

        polys.forEach((poly, ind) => {
            poly.classList.add('hex');
            this._container.appendChild(poly);
        });

        let containerSize = this._desiredContainerSize;
        this._container.setAttribute('width', containerSize[0]);
        this._container.setAttribute('height', containerSize[1]);

        this._lastDimensions = {rows: this.rows, columns: this.columns, circumradius: this.circumradius};
    }
}

customElements.define('star-map', Starmap);
