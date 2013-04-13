$(document).ready(function () {
    $('.search').autocomplete({
        source: "/school/search",
        minLength: 3
    });
});
