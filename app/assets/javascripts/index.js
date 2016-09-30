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
            $('#schoolProjectIndex #newSchoolButton').addClass('hidden');
            $('#schoolShow .schoolHead').addClass('hidden');
        });

        // School Index Button
        $('#schoolProjectIndex #schoolDashboardButton').click(function () {
            $('#schoolProjectIndex #schoolDashboardButton').text('Schools');
            $('#schoolProjectIndex #schoolDashboard').removeClass('hidden');
            $('#schoolProjectIndex #homeDashboard').addClass('hidden');
            $('#schoolProjectIndex #schoolDashboardButton').addClass('hidden');
            $('#schoolProjectIndex #newSchoolButton').removeClass('hidden');
            $('#schoolProjectIndex #schoolShow').addClass('hidden');
            var schoolIndex = new PS.schoolIndex();
        });

        // New School Modal Button
        $('#schoolProjectIndex #newSchoolButton').click(function () {
            $('#schoolNewModal .new-school-form #inputSchoolName').val('');
            $('#schoolNewModal .new-school-form #inputSchoolAddress').val('');
            $('#schoolNewModal .new-school-form #inputSchoolCity').val('');
            $('#schoolNewModal .new-school-form #inputSchoolState').val('');
            $('#schoolNewModal .new-school-form #inputSchoolZipcode').val('');
            $('#schoolNewModal .new-school-form #inputSchoolPhone').val('');
            $('#schoolDashboard #schoolNewModal').modal('show');
        });

        // Edit School Modal Button
        $('#schoolProjectIndex #editSchoolButton').click(function() {
            $('#schoolShow #schoolEditModal').modal('show');
        });

        // New Subject Modal Button
        $('#schoolProjectIndex #newSubjectButton').click(function() {
            $('#schoolShow .new-subject-form #inputSubjectName').val('');
            $('#schoolShow #subjectNewModal').modal('show');
        });

        // New Class Modal Button
        $('#schoolProjectIndex #newClassButton').click(function() {
            $('#schoolShow #classNewModal').modal('show');
        });

        // New Teacher Modal Button
        $('#schoolProjectIndex #newTeacherButton').click(function() {
            $('#schoolShow #teacherNewModal').modal('show');
        });
    }
}