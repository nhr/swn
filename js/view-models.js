class FlatTableView {
    constructor(structuredTable, columns) {
        this._baseData = structuredTable;

        // columns are accessors internally
        this._columns = columns.map((spec) => {;
            let key = spec;
            if (Array.isArray(spec)) {
                key = spec[1];
            }
            if (typeof key !== "function") {
                return ((row) => row[key]);
            } else {
                return key;
            }
        });

        this._headers = columns.map((spec) => {
            if (Array.isArray(spec)) {
                return spec[0];
            } else {
                return `${spec[0].toUpperCase()}${spec.slice(1)}`;
            }
        });
    }

    get data() {
        return this._baseData.map((baseRow) => {
            return this._columns.map((key) => key(baseRow));
        });
    }

    get headers() {
        return this._headers;
    }
}

class SectorViewBase {
    constructor(rawData, name) {
        this._data = rawData;
        this._name = name;
    }

    get systems() {
        return this._data;
    }

    get name() {
        return this._name;
    }

    get stars() {
        return this._data.stars;
    }

    tableFor(name) {
        if (name in SectorViewBase.tables && name in this._data) {
            return new FlatTableView(this._data[name], SectorViewBase.tables[name]);
        }

        return undefined;
    }
}

function splitFirst(key, sep) {
    return (r) => r[key].split(sep, 1);
}

function bodyFunc(r) {
    if (Array.isArray(r.body[0])) {
        return r.body.map((b) => b[0]);
    }

    return r.body[0];
}

SectorViewBase.tables = {
    'npcs': ['name', ['M/F', (r) => r.gender.slice(0, 1)], 'age', 'height'],

    'corps': [['Company', 'name'], 'business'],

    'rels': ['name', ['Leadership', splitFirst('leadership', '.')]],

    'pols': [['Organization', 'name'], ['Leadership', splitFirst('leadership', ':')],
             ['Policy', splitFirst('policy', ':')],
             ['Outsiders', splitFirst('relationship', ':')],
             ['Issues', (r) => r.issues.map((i) => i.tag).join(', ')]],

    'worlds': ['name', ['Atmo.', (r) => r.atmosphere.short], ['Temp.', (r) => r.temperature.short],
               ['Biosphere', (r) => r.biosphere.short], ['Population', (r) => r.population.short],
               ['TL', (r) => r.tech_level.short],
               ['Tags', (r) => r.tags.map((t) => t.short).join(', ')]],

    'aliens': ['name', ['Body Type', bodyFunc], ['Lenses', (r) => r.lens.map((l) => l[0]).join(', ')],
               ['Structure', (r) => r.social.length > 1 ? 'Multiple' : r.social[0][0]]],
};

const sectorViewHandler = {
    get: (target, name) => {
        if (Reflect.has(target, name)) {
            return Reflect.get(target, name);
        }
        return target.tableFor(name);
    },
}

SectorView = new Proxy(SectorViewBase, {
    construct: (target, argumentsList, newTarget) => {
        return new Proxy(Reflect.construct(target, argumentsList, newTarget), sectorViewHandler);
    },
});

