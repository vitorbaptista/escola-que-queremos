$(document).ready(function () {
    function loadSchool(id) {
        var dbToCssClass = {
            infra_basica: 'estrutura-basica',
            biblioteca: 'biblioteca',
            informatica: 'sala-de-informatica',
            quadra_esportiva: 'quadra-de-esportes',
            alimentacao: 'merenda',
            merenda_gostosa: 'merenda-de-qualidade',
            projeto_pedagogico: 'projeto-pedagogico',
            livro_didatico: 'livro-didatico',
            conselho_escolar_partic: 'conselho-escolar-democratico',
            conselho_classe: 'conselho-classe',
            projeto_pedagogico_partic: 'projeto-pedagogico-democratico',
            apoio_comunidade: 'apoio-da-comunidade',
            formacao_inicial_prof: 'formacao-inicial',
            equip_pedagogica_completa: 'equipe-pedagogica-completa'
        };

        _clearStatus();
        $.get('/school/info/'+id, function (school) {
            $('.search').val(school.nome);
            $('.search').removeClass('ui-autocomplete-loading');
            $.each(school.indicators, function (indicator, value) {
                if (indicator === "cod_escola") { return; }
                var cssClass = (value ? "icon-ok" : "icon-remove");
                var mappedIndicator = dbToCssClass[indicator];
                $("."+mappedIndicator+" .status").addClass(cssClass);
            });
         });
    }

    function _clearStatus() {
        $('.status').removeClass('icon-ok').removeClass('icon-remove');
    }

    $('.search').autocomplete({
        source: "/school/search",
        minLength: 3,
        select: function (evt, ui) {
            $('.search').addClass('ui-autocomplete-loading');
            redirectTo(ui.item.id);
        }
    });

    function redirectTo(escola_id) {
        window.location.hash = "#escola=" + escola_id;
    }

    function parseUri() {
        var hash = window.location.hash.substr(1);
        var route = {};
        var parts = hash.split("/");
        $.each(parts, function (i, part) {
            var param_value = part.split("=");
            route[param_value[0]] = param_value[1];
        });
        return route;
    }

    function updateRoute() {
        var route = parseUri();
        if (route.escola) {
            loadSchool(route.escola);
        }
    }
    window.onhashchange = updateRoute;
    updateRoute();
});
