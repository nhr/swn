class SystemListDB {
    constructor(db) {
        this._db = db;
    }

    static open() {
        return new Promise((resolve, reject) => {
            let dbReq = window.indexedDB.open('swn-systems-list', 1);
            dbReq.onerror = (evt) => {
                reject(new Error(`unable to open the local SWN database for seed ${this.seed}: ${dbReq.error}`));
            };
            dbReq.onsuccess = (evt) => {
                resolve(new SystemListDB(dbReq.result));
            }
            dbReq.onupgradeneeded = (evt) =>  {
                let db = new SystemListDB(dbReq.result);
                db._upgradeDB(evt.oldVersion, evt.newVersion).then(() => { resolve(db); });
            }
        });
    }

    _upgradeDB(oldVer, newVer) {
        return new Promise((resolve, reject) => {
            // TODO: do we need to handle diffing the current schema against past ones?
            if (oldVer) {
                reject(new Error(`upgrade to a non-existant newer version (${newVer}) from current version (${oldVer}).`));
                return;
            }

            let store = this._db.createObjectStore('systems', {keyPath: 'seed'});
            store.createIndex('name', 'name', { unique: false });
            store.transaction.oncomplete = () => { resolve(); };
        });
    }

    static dbNameFor(systemSeed, systemName) {
        return `swn-system-${systemSeed.toUpperCase()}`;
    }

    registerIfNecessary(seed, systemName) {
        return new Promise((resolve, reject) => {
            let dbName = SystemListDB.dbNameFor(seed, systemName);
            let tr = this._db.transaction(['systems'], 'readwrite');

            let checkReq = tr.objectStore('systems').get(seed);
            checkReq.onerror = (evt) => {
                reject(new Error(`unable to check the systems list database for the presence of ${systemName} (${seed}): ${checkReq.error}`));
            };
            checkReq.onsuccess = (evt) => {
                if (checkReq.result) {
                    resolve();
                    return;
                }
                let putReq = tr.objectStore('systems').add({seed: seed, name: systemName, _dbName: dbName});
                putReq.onerror = (evt) => { reject(new Error(`unable to check the systems list database for the presence of ${systemName} (${seed}): ${putReq.error}`)); };
                putReq.onsuccess = (evt) => { resolve(); };
            };
        });
    }

    list() {
        return new Promise((resolve, reject) => {
            let tr = this._db.transaction(['systems']);
            let req = tr.objectStore('systems').openCursor();
            req.onerror = (evt) => { reject(new Error(`unable to list systems: ${req.error}`)); }
            let systems = [];
            req.onsuccess = (evt) => {
                let cursor = req.result;
                if (cursor) {
                    let sysInfo = cursor.value;
                    systems.push(new SystemDB(sysInfo.seed, sysInfo.name));
                    cursor.continue();
                } else {
                    resolve(systems);
                }
            }
        });
    }
}


class SystemDB {
    constructor(systemSeed, systemName) {
        this._seed = systemSeed.toUpperCase();
        this._systemName = systemName;
        this._dbName = SystemListDB.dbNameFor(systemSeed, systemName);
    }

    open() {
        return new Promise((resolve, reject) => {
            let dbReq = window.indexedDB.open(this._dbName, 1);
            dbReq.onerror = (evt) => {
                reject(new Error(`unable to open the local SWN database for seed ${this.seed}: ${dbReq.error}`));
            };
            dbReq.onsuccess = (evt) => {
                this._db = dbReq.result;
                SystemListDB.open().then((db) => db.registerIfNecessary(this._seed, this._systemName))
                    .then(resolve)
                    .catch((err) => {
                        window.indexedDB.deleteDatabase(this._dbName);
                        reject(new Error(`unable to properly register seed with the global list, deleting database: ${err}`));
                    });
            };
            dbReq.onupgradeneeded = (evt) => {
                this._db = dbReq.result;
                this._upgradeDB(evt.oldVersion, evt.newVersion)
                    .then(() => SystemListDB.open())
                    .then((db) => db.registerIfNecessary(this._seed, this._systemName))
                    .then(resolve)
                    .catch((err) => {
                        window.indexedDB.deleteDatabase(this._dbName);
                        reject(new Error(`unable to properly register seed with the global list, deleting database: ${err}`));
                    });
            };
        });
    }

    _upgradeDB(oldVer, newVer) {
        return new Promise((resolve, reject) => {
            // TODO: do we need to handle diffing the current schema against past ones?
            if (oldVer) {
                reject(new Error(`upgrade to a non-existant newer version (${newVer}) from current version (${oldVer}).`));
            }

            let aliens = this._db.createObjectStore('aliens', {keyPath: 'name'});
            let corps = this._db.createObjectStore('corps', {keyPath: 'name'});
            let npcs = this._db.createObjectStore('npcs', {keyPath: 'name'});
            let politics = this._db.createObjectStore('pols', {keyPath: 'name'});
            let religions = this._db.createObjectStore('rels', {keyPath: 'name'});

            let stars = this._db.createObjectStore('stars', {keyPath: 'name'});
            stars.createIndex('id', 'id', { unique: true });

            // NB: using sys_name allows us to support two different systems having
            // worlds with the same name...
            let worlds = this._db.createObjectStore('worlds', {keyPath: 'sys_name'});
            worlds.createIndex('name', 'name', { unique: false });
            worlds.createIndex('system', 'star_id', { unique: false });
            // NB: we'll have to massage the data a bit here, since IndexDB doesn't support
            // indexing into array elements
            worlds.createIndex('tags', 'tag_names', { unique: false, multiEntry: true });
            // TODO: add indexes for other world stuff?

            // TODO: ensure the object store creation is complete before adding data?
            worlds.transaction.oncomplete = () => { resolve(); };
            worlds.transaction.onerror = (evt) => { reject(new Error(`unable to upgrade database for ${this._systemName} (${this._seed}): ${evt.target.error}`)); };
        });
    }

    populate(sectorData) {
        return new Promise((resolve, reject) => {
            // start a transaction around the entire DB
            let transaction = this._db.transaction(["aliens", "corps", "npcs", "pols", "rels", "stars", "worlds"], "readwrite");

            // TODO: what to do on complete?
            transaction.onerror = (evt) => {
                reject(new Error(`unable to populate the database with the initial sector data: ${evt.target.error}`));
            };


            for (let storeName of transaction.objectStoreNames) {
                let data = sectorData[storeName];
                let store = transaction.objectStore(storeName);
                data.forEach((entry) => {
                    // TODO: handle the result of the operation?
                    let req = store.add(entry);
                });
            }
            transaction.oncomplete = () => { resolve(); };
        });
    }

    system(key, value) {
        return new Promise((resolve, reject) => {
            let tr = this._db.transaction(['worlds', 'stars']);
            let worldIdx = tr.objectStore('worlds').index('system');
            let starStore = tr.objectStore('stars');
            if (key === 'name') {
                var starsReq = starStore.get(value);
            } else {
                var starsReq = starStore.index(key).get(value);
            }
            starsReq.onsuccess = (evt) => {
                console.log('req 1 done');
                let star = starsReq.result;
                if (!star) {
                    reject(new Error(`unable to fetch the system where ${key}=${value}: no such system found`));
                    return;
                }
                let worlds = [];
                let worldsReq = worldIdx.openCursor(IDBKeyRange.only(star.id));
                worldsReq.onerror = (evt) => { reject(new Error(`unable to worlds for the star system around ${star.name}: ${worldsReq.error}`)); };
                worldsReq.onsuccess = (evt) => {
                    let cursor = worldsReq.result;
                    if (cursor) {
                        worlds.push(cursor.value);
                        cursor.continue();
                    } else {
                        let system = new StarSystem(star.name, star.cell, worlds);
                        resolve(system);
                    }
                };
            };
            starsReq.onerror = (evt) => { reject(new Error(`unable to fetch the system where ${key}=${value}: ${starsReq.error}`)); };

            tr.oncomplete = (evt) => {
                console.log('tr done');
            };
        });
    }

    fullSector() {
        return new Promise((resolve, reject) => {
            let transaction = this._db.transaction(["aliens", "corps", "npcs", "pols", "rels", "stars", "worlds"]);

            // TODO: what to do on complete?
            transaction.onerror = (evt) => {
                reject(new Error(`unable to populate the database with the initial sector data: ${evt.target.error}`));
            };

            let sector = {name: this.name};
            for (let storeName of transaction.objectStoreNames) {
                sector[storeName] = [];
                let store = transaction.objectStore(storeName);
                let curReq = store.openCursor();
                curReq.onerror = (evt) => { reject(new Error(`unable to load sector data on ${storeName}: ${evt.target.error}`)); };
                curReq.onsuccess = (evt) => {
                    let cursor = evt.target.result;
                    if (cursor) {
                        sector[storeName].push(cursor.value);
                        cursor.continue();
                    }
                };
            }
            transaction.oncomplete = () => { resolve(sector); };
        });
    }

    get seed() {
        return this._seed;
    }

    get name() {
        return this._systemName;
    }
}
