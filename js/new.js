// tab panel

class TabPanel extends HTMLElement {
    constructor() {
        super();
        this.attachShadow({mode: 'open'});

        this._tabSlot = undefined;
        this._panelSlot = undefined;
        this._selected = undefined;
    }

    get tabs() {
        if (!this._tabSlot) { return undefined; }
        return this._tabSlot.assignedNodes().filter((elem) => elem.nodeType === 1);
    }

    get panels() {
        if (!this._panelSlot) { return undefined; }
        return this._panelSlot.assignedNodes().filter((elem) => elem.nodeType === 1);
    }

    get selected() {
        return this._selected;
    }

    set selected(ind) {
        this._selected = ind;
        this._switchTo(ind);
    }

    connectedCallback() {
        let templ = document.getElementById("tab-panel-template");
        this.shadowRoot.appendChild(templ.content.cloneNode(true));

        this.setAttribute('role', 'tablist');

        this._tabSlot = this.shadowRoot.querySelector("#tabs > slot");
        this._panelSlot = this.shadowRoot.querySelector("#panels > slot");

        this.addEventListener('slotchange', this._updateTabs.bind(this));
        this._tabSlot.addEventListener('click', this._handleTabClick.bind(this));

        this._updateTabs();
        this.selected = 0;
    }

    _updateTabs() {
        for (let panel of this.panels) {
            panel.setAttribute("tabindex", 0);
            panel.setAttribute("role", "tabpanel");
        }
    }

    _handleTabClick(evt) {
        if (evt.target.slot !== this._tabSlot.name) { return; }

        this.selected = this.tabs.indexOf(evt.target);
        evt.target.focus();
    }

    _switchTo(ind) {
        for (let [i, tab] of this.tabs.entries()) {
            let selected = i === ind;
            tab.setAttribute("tabindex", selected ? 0 : -1);
            tab.setAttribute('aria-selected', selected);
            this.panels[i].setAttribute('aria-hidden', !selected)
        }
    }
}

customElements.define('tab-panel', TabPanel);

// lightweight templating
class TemplateRenderer {
    constructor(templ) {
        // the template element
        this._templ = templ;
        this._templateAttrs = ['-from', '-content', '-foreach', '-attrs', '-with'];
        this._validSelector = this._templateAttrs.map(function(attr) { return '[' + attr + ']'; }).join(', ');
    }

    render(data, shadow) {
        let content = this._templ.content.cloneNode(true);
        if (shadow !== undefined) {
            shadow.innerHTML = '';
            shadow.appendChild(content);
            content = shadow;
        }

        for (let child of content.children) {
            this._renderNode(content, child, data);
        }

        return content;
    }

    static _dataIn(node, attr, data) {
        let targetKey = node.getAttribute(attr);
        let newData = null;
        if (targetKey) {
            newData = data[targetKey];
        } else {
            newData = data;
        }

        return newData;
    }

    // TODO: trampoline this?
    _renderNode(root, node, data) {
        if (node.hasAttribute('-foreach')) {
            let collection = TemplateRenderer._dataIn(node, '-foreach', data);

            let nextInsertionPoint = node.nextSibling;

            let templNode = node;
            templNode.removeAttribute('-foreach');
            if (node.hasAttribute('-replace-with')) {
                let slotName = node.getAttribute('-replace-with');
                let slot = root.querySelector(`slot[name="${slotName}"]`);
                let templOptions = slot.assignedNodes({flatten: true})
                let templ = undefined;
                for (let opt of templOptions) {
                    if (opt.nodeType === 1) {
                        templ = opt;
                        break;
                    }
                }
                templNode = templ.content.children[0];
            }

            for (let collectionItem of collection) {
                let newNode = templNode.cloneNode(true);
                // don't re-process foreach
                this._renderNode(root, newNode, collectionItem);

                node.parentElement.insertBefore(newNode, nextInsertionPoint.nextSibling);
                nextInsertionPoint = newNode;
            }

            node.parentElement.removeChild(node);

            // don't do anything else to this node -- it's basically a template
            return;
        }

        if (node.hasAttribute('-from')) {
            let fromData = TemplateRenderer._dataIn(node, '-from', data);
            customElements.whenDefined(node.tagName.toLowerCase()).then(() => {
                node.data = fromData;
            });
        }

        if (node.hasAttribute('-content')) {
            let content = TemplateRenderer._dataIn(node, '-content', data);
            node.innerText = content;
        }

        if (node.hasAttribute('-with')) {
            data = TemplateRenderer._dataIn(node, '-with', data);
        }

        if (node.hasAttribute('-attrs')) {
            let attrsList = node.getAttribute("-attrs").split(" ");
            for (let attrName of attrsList) {
                let content = TemplateRenderer._dataIn(node, attrName, data);
                node.setAttribute(attrName, content);
            }
        }

        for (let attr of this._templateAttrs) {
            node.removeAttribute(attr);
        }

        if (!node.querySelector(this._validSelector)) { return; }

        for (let child of node.children) {
            this._renderNode(root, child, data);
        }
    }
}

class SectorDisplay extends HTMLElement {
    constructor() {
        super();
        this._templ = new TemplateRenderer(document.querySelector('#sector-display-template'));
        this._data = null;
        this.attachShadow({mode: 'open'});
    }

    set data(d) {
        this._data = d;

        var content = this._templ.render(this.data);

        // replace the current content
        this.shadowRoot._innerHTML = '';
        this.shadowRoot.appendChild(content);

        let starmap = this.shadowRoot.querySelector('star-map');
        let infoPane = this.shadowRoot.querySelector('star-info');
        let worldsTable = this.shadowRoot.querySelector('#worlds-table');
        let tabPanel = this.shadowRoot.querySelector('#sector');
        starmap.addEventListener('display-info', (evt) => {
            this.displayInfo(evt.detail);
        });
        infoPane.addEventListener('close-info', this.closeInfo.bind(this));
        infoPane.addEventListener('select-world-tag', (evt) => {
            this.closeInfo();

            // TODO: find a good way to select this programatically
            tabPanel.selected = 1; // world panel

            worldsTable.highlight('tags', evt.detail);
        });
        worldsTable.addEventListener('click-row', (evt) => {
            let worldName = evt.detail;
            let worldInfo = this.data.systems.worlds.find((world) => world.name === worldName);
            let starInfo = this.data.stars.find((star) => star.id === worldInfo.star_id);
            let system = starmap.systems.find((sys) => sys.name === starInfo.name);
            tabPanel.selected = 0;
            requestAnimationFrame(this.displayInfo.bind(this, system));
        });
    }

    get data() {
        return this._data;
    }

    closeInfo(evt) {
        let infoPane = this.shadowRoot.querySelector('star-info');
        infoPane.classList.remove('open');

        let starmap = this.shadowRoot.querySelector('star-map');
        starmap.classList.remove('info');
    }

    displayInfo(system) {
        // TODO: figure out a good way to make it look like the system
        // is zooming out of its normal position
        let starmap = this.shadowRoot.querySelector('star-map');
        starmap.classList.add('info');

        let infoPane = this.shadowRoot.querySelector('star-info');
        infoPane.data = system;
        infoPane.classList.add('open');
    }
}

customElements.define('sector-display', SectorDisplay);

class SectorTable extends HTMLElement {
    constructor() {
        super();
        this._templ = new TemplateRenderer(document.querySelector('#sector-table-template'));
        this._data = null;
        this.attachShadow({mode: 'open'});
    }

    set data(d) {
        this._data = d;

        var content = this._templ.render(this.dataWithColumns, this.shadowRoot);
        let wrapperDiv = content.getElementById('columns-wrapper');
        wrapperDiv.style.setProperty('--columns', this.columns);

        // TODO: handle addition and removal of the interactable attribute?
        content.querySelectorAll('tbody tr').forEach((row) => row.addEventListener('click', (evt) => {
            let rowId = evt.target.closest('tr').dataset.rowId;
            this.dispatchEvent(new CustomEvent('click-row', {detail: rowId, bubbles: false}));
        }));
    }

    get data() {
        return this._data;
    }

    get columns() {
        let cols = this.getAttribute("columns");
        if (cols) {
            return parseInt(cols);
        }

        return 1;
    }

    // can't just use CSS column-count because we want properly spaced headers
    get dataWithColumns() {
        let cols = [];
        let splitPoint = Math.floor(this._data.data.length / this.columns);
        for (let i = 0; i < this.columns; i++) {
            cols.push({
                headers: this._data.headers,
                data: this._data.data.slice(i*splitPoint, (i+1)*splitPoint),
            });
        }

        return cols;
    }

    highlight(dataName, value) {
        this.shadowRoot.querySelectorAll('.highlighted').forEach((row) => {
            row.classList.remove('highlighted');
        });
        // TODO: make the tags space-safe for later use
        this.shadowRoot.querySelectorAll(`tr[data-row-${dataName}*="${value}"]`).forEach((row) => {
            row.classList.add('highlighted');
        });
    }
}

customElements.define("sector-table", SectorTable);

(function() {
    // SEED_MAX is the maximum allowable raw seed value.
    // It comes from the original Perl.
    const SEED_MAX = Math.pow(2, 32);

    // for convenience
    var $ = document.querySelector.bind(document);

    document.addEventListener('DOMContentLoaded', function() {
        $('#about-button').addEventListener('click', function(evt) {
            $('#about').classList.toggle('closed');
        });

        $('#error-bar').addEventListener('click', function(evt) {
            evt.target.classList.add('closed');
        });

        $('#reroll-button').addEventListener('click', function(evt) {
            populateSeed(true);
        });

        $('#generator').addEventListener('submit', function(evt) {
            populateSector();
            evt.preventDefault();
        });

        SystemListDB.open().then((db) => db.list()).then((systems) => {
            let datalist = $('#existing-systems');
            systems.forEach((system) => {
                let opt = document.createElement('option');
                opt.setAttribute('value', system.seed);
                opt.setAttribute('label', system.name);
                datalist.appendChild(opt);
            });
        });
        // populate the initial seed
        populateSeed(false);

        // TODO: populate from the database if possible on seed id field change
    });

    // mainServer is the server to make API requests against.
    // We default to the hosting server.
    document.mainServer = "";

    // makeRandomSeed generates a random 7-character base36 seed
    // alphanumeric seed in the range [1, MAX_SEED).
    // The base and range are taken from the original Perl.
    function makeRandomSeed() {
        let seedNumber = Math.floor(Math.random() * SEED_MAX-1) + 1;
        return seedNumber.toString(36).toUpperCase();
    }

    // displayError displays an error in the error message bar
    function displayError(msg) {
        var errBar = $('#error-bar');
        errBar.innerText = msg;
        errBar.classList.remove('closed');
    }

    // populateSeed fetches the seed from the server, and populates
    // the seed-id field in the main document.  If the overwrite is
    // set to false, it will not overwrite an already-populated seed.
    function populateSeed(overwrite) {
        var seedIDField = $('#seed-id');
        if (!overwrite && seedIDField.value !== '') { return; }

        // TODO: close sector frame?

        seedIDField.value = makeRandomSeed();
    }

    // getSectorForSeed fetches sector JSON for the given seed.
    // the seed is assumed to be valid, but will be automatically
    // uppercased.
    function getSectorForSeed(server, seed) {
        var formData = new FormData();
        formData.append('action', 'display');
        formData.append('token', seed.toUpperCase());
        formData.append('advanced', 1);
        formData.append('isie', false); // WHY? WHY IS THIS A THING?
        return fetch(server+"/cgi-bin/sectorgen.cgi", {method: 'POST', body: formData})
            .then(function(resp) {
                if (!resp.ok) {
                    return Promise.reject(resp.status+" "+resp.statusText);
                }
                return resp.json();
            });
    }

    // populateSectorFromObject populates the sector based on the given object.
    function populateSectorFrom(obj) {
        let newDisplay = document.createElement('sector-display');
        newDisplay.data = obj;

        let currentDisplay = $('#sector-frame sector-display');
        if (currentDisplay) {
            currentDisplay.parentElement.removeChild(currentDisplay);
        }

        let seed = $('#seed-id').value;
        if (!$('#existing-systems').querySelector(`[value="${seed}"]`)) {
            let opt = document.createElement('option');
            opt.setAttribute('value', seed);
            opt.setAttribute('label', obj.name);
            $('#existing-systems').appendChild(opt);
        }
        $('#sector-frame').appendChild(newDisplay);
    }

    // populateSector fetches a sector based on the current seed, and then
    // displays it on the page.
    function populateSector() {
        let seedInput = $('#seed-id');
        if (!seedInput.checkValidity()) {
            displayError("invalid seed");
            return;
        }
        let seed = seedInput.value;

        let existingOpt = $('#existing-systems').querySelector(`[value="${seed}"]`);
        if (existingOpt) {
            let db = new SystemDB(seed, existingOpt.getAttribute('label'));
            db.open().then(() => db.fullSector()).then((systems) => populateSectorFrom(new SectorView(systems, systems.name))).catch((evt) => {
                console.error(`unable to load sector for seed ${seed}: `, evt);
                displayError(`unable to load sector for seed ${seed}`);
            });
            return;
        }

        getSectorForSeed(document.mainServer, seed)
            .then(function(sector) {
                populateSectorFrom(new SectorView(sector.systems, sector.name));
                window._db = new SystemDB(seed, sector.name);
                return window._db.open().then(() => {
                    return window._db.populate(sector.systems);
                });
            }).catch(function(evt) {
                console.error(`unable to fetch sector for seed ${seed}: `, evt);
                displayError(`unable to fetch sector for seed ${seed}`);
            });
        // TODO: wait dialog?
    }
})();
