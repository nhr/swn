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

        // populate the initial seed
        populateSeed(false);
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
})();
