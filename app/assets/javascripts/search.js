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
            conselho_classe: 'conselho-de-classe',
            projeto_pedagogico_partic: 'projeto-pedagogico-democratico',
            apoio_comunidade: 'apoio-da-comunidade',
            formacao_inicial_prof: 'formacao-inicial',
            equip_pedagogica_completa: 'equipe-pedagogica-completa'
        };

        $.get('/school/info/'+id, function (school) {
            _clearStatus();
            $('.search').removeClass('ui-autocomplete-loading')
                        .val(school.nome);
            $.each(school.indicators, function (indicator, value) {
                if (indicator === "cod_escola") { return; }
                var cssClass = (value ? "icon-ok" : "icon-remove");
                var mappedIndicator = dbToCssClass[indicator];
                $("."+mappedIndicator+" .status").addClass(cssClass);
            });
            var ideb = school.calculate_ideb_2011;
            var idebElement = $('.ideb');
            _changeBar(idebElement.children('.school'), ideb.ideb_2011);
            _changeBar(idebElement.children('.city'), ideb.avg_ideb_2011_city);
            _changeBar(idebElement.children('.state'), ideb.avg_ideb_2011_state);
            _changeBar(idebElement.children('.brazil'), ideb.avg_ideb_2011);
            $('.drilldowns .state').data('drilldown', school.uf);
            $('.drilldowns .city').data('drilldown', school.cod_municipio);
         });
    }

    function loadIndicators(id, indicators) {
        var cssClassToDb = {
            'estrutura-basica': 'infra_basica',
            'biblioteca': 'biblioteca',
            'sala-de-informatica': 'informatica',
            'quadra-de-esportes': 'quadra_esportiva',
            'merenda': 'alimentacao',
            'merenda-de-qualidade': 'merenda_gostosa',
            'projeto-pedagogico': 'projeto_pedagogico',
            'livro-didatico': 'livro_didatico',
            'conselho-escolar-democratico': 'conselho_escolar_partic',
            'conselho-de-classe': 'conselho_classe',
            'projeto-pedagogico-democratico': 'projeto_pedagogico_partic',
            'apoio-da-comunidade': 'apoio_comunidade',
            'formacao-inicial': 'formacao_inicial_prof',
            'equipe-pedagogica-completa': 'equip_pedagogica_completa'
        };

        $.get('/school/your_indicator/'+id, {
            indicadores: indicators.map(function (indicator) { return cssClassToDb[indicator]; }).join(',')
        }, function (indicator) {
            var indicatorElement = $('.your-indicator');
            _changeBar(indicatorElement.children('.school'), indicator.your_indicator);
            _changeBar(indicatorElement.children('.city'), indicator.avg_your_indicator_city);
            _changeBar(indicatorElement.children('.state'), indicator.avg_your_indicator_state);
            _changeBar(indicatorElement.children('.brazil'), indicator.avg_your_indicator);
        });
    }

    function _clearStatus() {
        $('.status').removeClass('icon-ok').removeClass('icon-remove');
    }

    function _changeBar(element, value) {
        element.text(value || 'N/A')
               .attr('style', 'width: '+parseFloat(value) * 10 + '%');
    }

    $('.search').autocomplete({
        source: "/school/search",
        minLength: 3,
        select: function (evt, ui) {
            $('.search').addClass('ui-autocomplete-loading');
            redirectTo(undefined, ui.item.id);
        }
    });

    $('.indicator').click(function () {
        var indicators = [];
        $(this).toggleClass('active');
        $('.active').each(function (i, d) { indicators.push($(d).data('indicator-key')); });
        redirectTo(indicators);
    });

    function redirectTo(indicators, school) {
        var route = parseUri();
        var newParts = [];

        if (indicators) {
            route.indicadores = $.unique(indicators).sort();
        }
        if (school) {
            route.escola = school;
        }

        $.each(['indicadores', 'escola'], function (i, key) {
            if (route[key] && route[key].length > 0) {
                newParts.push(key + '=' + route[key]);
            }
        });
        window.location.hash = newParts.join('/');
    }

    function parseUri() {
        var hash = window.location.hash.substr(1);
        var route = {};
        var parts = hash.split("/");
        $.each(parts, function (i, part) {
            var param_value = part.split("=");
            var key = param_value[0];
            var value = param_value[1];

            if (key === 'indicadores') {
                value = value.split(',');
            }

            route[key] = value;
        });
        return route;
    }

    function updateRoute() {
        var route = parseUri();
        if (route.escola) {
            loadSchool(route.escola);
        }
        if (route.indicadores) {
            $.each(route.indicadores, function (i, indicador) {
                $('.'+indicador).addClass('active');
            });
            loadIndicators(route.escola, route.indicadores);
        } else {
            $('.your-indicator').children('.bar').each(function (i, element) {
                $(element).attr('style', 'width: 0;')
                          .text('0.0');
            });
        }
    }
    window.onhashchange = updateRoute;
    updateRoute();
});
