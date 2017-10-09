class StarInfo extends HTMLElement {
    constructor() {
        super();

        this._system = null;
        this._templ = new TemplateRenderer(document.getElementById('starinfo-template'));
        this.attachShadow({mode: 'open'});

        this._container = null;
        this._systemContainer = null;
        this._calloutContainer = null;
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
        this._systemContainer = this._container.querySelector('#system');

        // use a fixed cell size of 100, and the browser handle scaling
        let grid = new SectorHexGrid(1, 1, 100);
        let hexDimensions = grid.totalSize;
        this._container.setAttribute('viewBox', `0 0 ${hexDimensions[0]} ${hexDimensions[1]}`);

        let systemRenderer = new StarSystemRenderer(grid);
        let renderedSystem = systemRenderer.svgFor(this.data);
        renderedSystem.removeAttribute('transform');
        renderedSystem.classList.add('star');
        renderedSystem.querySelectorAll('.world').forEach((world, ind) => {
            let worldInfo = this.data.worlds[ind];
            world.dataset.worldName = worldInfo.name;
            world.dataset.positionInSystem = worldInfo.sys_pos;
        });
        this._systemContainer.appendChild(renderedSystem);

        this._setupEventListeners();
        this.selectWorld(this.data.worlds[0].name);
    }
    
    selectWorld(worldName) {
        this.shadowRoot.querySelectorAll('#world-info .world').forEach((worldSection) => {
            worldSection.classList.remove('selected');
        });

        this._systemContainer.querySelectorAll('.world').forEach((worldSection) => {
            worldSection.classList.remove('selected');
        });

        let worldInfo = this.data.worlds.find((world) => worldName === world.name);
        let worldSection = this.shadowRoot.querySelector(`#world-info .world[data-world-name="${worldInfo.name}"]`);
        let worldElem = this._systemContainer.querySelector(`.world[data-world-name="${worldInfo.name}"]`);
        worldSection.classList.add('selected');
        worldElem.classList.add('selected');
    }

    _setupEventListeners() {

        this._container.querySelector('.star .central-star').addEventListener('click', () => {
            this.dispatchEvent(new Event('close-info', {bubbles: false}));
        });

        this.shadowRoot.querySelectorAll('svg .star .world, section.world > header').forEach((worldElem) => worldElem.addEventListener('click', (evt) => {
            let worldElem = evt.target.closest('.world');
            let worldName = worldElem.dataset.worldName;

            this.selectWorld(worldName);
        }));

        this.shadowRoot.querySelectorAll('.tags a').forEach((tag) => tag.addEventListener('click', (evt) => {
            let tag = evt.target.dataset.tagSelector;
            
            this.dispatchEvent(new CustomEvent('select-world-tag', {detail: tag, bubbles: false}));
        }));
    }
}

customElements.define('star-info', StarInfo)
