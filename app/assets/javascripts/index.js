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
            $('#schoolProjectIndex #schoolDashboardButton').removeClass('hidden');
            $('#schoolProjectIndex #newSchoolButton').addClass('hidden')
            $('#schoolShow .schoolHead').addClass('hidden')
        });

        // School Index
        $('#schoolProjectIndex #schoolDashboardButton').click(function () {
            $('#schoolProjectIndex #schoolDashboard').removeClass('hidden');
            $('#schoolProjectIndex #homeDashboard').addClass('hidden');
            $('#schoolProjectIndex #schoolDashboardButton').addClass('hidden');
            $('#schoolProjectIndex #newSchoolButton').removeClass('hidden');
            var schoolIndex = new PS.schoolIndex();
        });

        // New School Form
        $('#schoolProjectIndex #newSchoolButton').click(function () {
            $('#schoolNewModal .new-school-form #inputSchoolName').val('');
            $('#schoolNewModal .new-school-form #inputSchoolAddress').val('');
            $('#schoolNewModal .new-school-form #inputSchoolCity').val('');
            $('#schoolNewModal .new-school-form #inputSchoolState').val('');
            $('#schoolNewModal .new-school-form #inputSchoolZipcode').val('');
            $('#schoolNewModal .new-school-form #inputSchoolPhone').val('');
        });
    }
}