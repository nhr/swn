(function() {
    // for convenience
    var $ = document.querySelector.bind(document);

    document.addEventListener('DOMContentLoaded', function() {
        $('#about-button').addEventListener('click', function(evt) {
            $('#about').classList.toggle('closed');
        });
    });
})();
