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
        this._templateAttrs = ['-from', '-content', '-foreach'];
        this._validSelector = this._templateAttrs.map(function(attr) { return '[' + attr + ']'; }).join(', ');
    }

    render(data) {
        let content = this._templ.content.cloneNode(true);

        for (let child of content.children) {
            this._renderNode(child, data);
        }

        return content;
    }

    // TODO: trampoline this?
    _renderNode(node, data) {
        if (node.hasAttribute('-foreach')) {
            let targetKey = node.getAttribute('-foreach');
            let collection = null;
            if (targetKey) {
                collection = data[targetKey];
            } else {
                collection = data;
            }

            let nextInsertionPoint = node.nextSibling;

            for (let collectionItem of collection) {
                let newNode = node.cloneNode(true);
                // don't re-process foreach
                newNode.removeAttribute('-foreach');
                this._renderNode(newNode, collectionItem);

                node.parentElement.insertBefore(newNode, nextInsertionPoint.nextSibling);
                nextInsertionPoint = newNode;
            }

            node.parentElement.removeChild(node);

            // don't do anything else to this node -- it's basically a template
            return;
        }

        if (node.hasAttribute('-from')) {
            let fromKey = node.getAttribute('-from');
            customElements.whenDefined(node.tagName.toLowerCase()).then(() => {
                node.data = data[fromKey];
            });
        }

        if (node.hasAttribute('-content')) {
            // if contentKey is empty, use the current context as content
            let contentKey = node.getAttribute('-content');
            let content = null;
            if (contentKey) {
                content = data[contentKey];
            } else {
                content = data;
            }

            node.innerText = content;
        }

        for (let attr of this._templateAttrs) {
            node.removeAttribute(attr);
        }

        if (!node.querySelector(this._validSelector)) { return; }

        for (let child of node.children) {
            this._renderNode(child, data);
        }
    }

    static initializeCustomElements() {
        for (let elem of document.querySelectorAll('template[-for]')) {
            var customElemName = elem.getAttribute('-for');
            // skip already-registered custom elements
            if (customElements.get('customElemName')) { continue; }

            var customElem = class extends HTMLElement {
                constructor() {
                    super();
                    this._templ = new TemplateRenderer(elem);
                    this._viewModel =
                    this._data = null;
                    this.attachShadow({mode: 'open'});
                }

                set data(d) {
                    this._data = d;

                    var content = this._templ.render(this.data);

                    // replace the current content
                    this.shadowRoot._innerHTML = '';
                    this.shadowRoot.appendChild(content);
                }

                get data() {
                    return this._data;
                }
            }

            customElements.define(customElemName, customElem);
        };
    }
}

class SectorTable extends HTMLElement {
    constructor() {
        super();
        this._templ = new TemplateRenderer(document.querySelector('#sector-table-template'));
        this._data = null;
        this.attachShadow({mode: 'open'});
    }

    set data(d) {
        this._data = d;

        var content = this._templ.render(this.dataWithColumns);
        let wrapperDiv = content.getElementById('columns-wrapper');
        wrapperDiv.style.setProperty('--columns', this.columns);

        // replace the current content
        this.shadowRoot._innerHTML = '';
        this.shadowRoot.appendChild(content);
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
        let lastCol = undefined;
        for (let i = 0; i < this.columns; i++) {
            cols.push({
                headers: this._data.headers,
                data: this._data.data.slice(i*splitPoint, (i+1)*splitPoint),
            });
        }

        return cols;
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

        // populate the initial seed
        populateSeed(false);

        // lightweight custom elements and templating
        TemplateRenderer.initializeCustomElements();
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
        getSectorForSeed(document.mainServer, seed)
            .then(function(sector) {
                populateSectorFrom(sector);
            }).catch(function(evt) {
                console.error(`unable to fetch sector for seed ${seed}: `, evt);
                displayError(`unable to fetch sector for seed ${seed}`);
            });
        // TODO: wait dialog?
    }
})();
