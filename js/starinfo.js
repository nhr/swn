class StarInfo extends HTMLElement {
    constructor() {
        super();

        this._system = null;
        this._templ = new TemplateRenderer(document.getElementById('starinfo-template'));
        this.attachShadow({mode: 'open'});

        this._container = null;
    }

    connectedCallback() {
        if (this.data) {
            this._updatePane();
        }
    }

    get data() {
        return this._system;
    }

    set data(s) {
        this._system = s;
        this._updatePane();
    }

    _updatePane() {
        let content = this._templ.render(this.data);
        this.shadowRoot.innerHTML = "";
        this.shadowRoot.appendChild(content);

        this._container = this.shadowRoot.querySelector('svg');

        // use a fixed cell size of 100, and the browser handle scaling
        let grid = new SectorHexGrid(1, 1, 100);
        let hexDimensions = grid.totalSize;
        this._container.setAttribute('viewBox', `0 0 ${hexDimensions[0]} ${hexDimensions[1]}`);

        let systemRenderer = new StarSystemRenderer(grid);
        let renderedSystem = systemRenderer.svgFor(this.data);
        renderedSystem.removeAttribute('transform');
        renderedSystem.classList.add('star');

        this._container.appendChild(renderedSystem);

        this._container.querySelector('.star').addEventListener('click', () => {
            this.dispatchEvent(new Event('close-info', {bubbles: false}));
        });
    }
}

customElements.define('star-info', StarInfo)
