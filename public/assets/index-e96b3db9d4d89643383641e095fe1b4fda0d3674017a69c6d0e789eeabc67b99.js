var PS = PS || {};

PS.Index = function() {
    this.initialize();
}

PS.Index.prototype = {
    initialize: function () {
        this.menuClickEvent();
    },

    menuClickEvent: function () {
        $('#schoolContainer #schoolMenu').click(function () {
            $('#schoolDashboard').removeClass('hidden');
            $('#homeDashboard').addClass('hidden');
            var schoolIndex = new PS.schoolIndex();
        })

        $('#schoolProjectIndex #mainPage').click(function () {
            $('#schoolDashboard').addClass('hidden');
            $('#homeDashboard').removeClass('hidden');
        })
    }
}
;
