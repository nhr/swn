(function() {
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

        // populate the initial seed
        populateSeed(false);
    });

    // mainServer is the server to make API requests against.
    // We default to the hosting server.
    document.mainServer = "";

    // fetchSeed returns a promise for a seed value for
    // the given server.  The caller is responsible for
    // catching errors from the request.
    function fetchSeedFromServer(server) {
        return fetch(server+"/CGI/seed.cgi?action=request")
            .then(function(resp) {
                if (!resp.ok) {
                    return Promise.reject(resp.status+" "+resp.statusText);
                }
                return resp.json();
            }).then(function(seedJSON) {
                return seedJSON.entries[0];
            });
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

        fetchSeedFromServer(document.mainServer)
            .then(function(seed) {
                seedIDField.value = seed;
            }).catch(function(evt) {
                console.error("unable to fetch seed from server: ", evt)
                displayError("unable to fetch seed from server");
            });
    }
})();
