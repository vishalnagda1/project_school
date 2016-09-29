var PS = PS || {};

PS.Index = function() {
    this.initialize();
}

PS.Index.prototype = {
    initialize: function () {
        this.menuClickEvent();
    },

    menuClickEvent: function () {

        // Home Button
        $('#schoolProjectIndex #mainPage').click(function () {
            $('#schoolProjectIndex #schoolDashboard').addClass('hidden');
            $('#schoolProjectIndex #homeDashboard').removeClass('hidden');
            $('#schoolProjectIndex #schoolMenu').removeClass('hidden');
            $('#schoolProjectIndex #newSchool').addClass('hidden')
            $('#schoolShow .schoolHead').addClass('hidden')
        });

        // School Index
        $('#schoolProjectIndex #schoolMenu').click(function () {
            $('#schoolProjectIndex #schoolDashboard').removeClass('hidden');
            $('#schoolProjectIndex #homeDashboard').addClass('hidden');
            $('#schoolProjectIndex #schoolMenu').addClass('hidden');
            $('#schoolProjectIndex #newSchool').removeClass('hidden');
            var schoolIndex = new PS.schoolIndex();
        });

        // New School Form
        $('#schoolProjectIndex #newSchool').click(function () {
            // alert("New School");
            $('.comman-modal #modalContant').removeClass('hidden');
        });
    }
}