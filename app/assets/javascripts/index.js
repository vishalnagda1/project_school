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
        $('#schoolProjectIndex #mainPage').unbind('click');
        $('#schoolProjectIndex #mainPage').click(function () {
            // Hiding Other Views
            $('#schoolProjectIndex #schoolDashboard').addClass('hidden');
            $('#schoolProjectIndex #schoolShow').addClass('hidden');
            // Hiding Other Menu Buttons
            $('#schoolProjectIndex #newSchoolButton').addClass('hidden');
            $('#schoolProjectIndex #schoolDashboardButton').addClass('hidden');
            $('#schoolProjectIndex #editSchoolButton').addClass('hidden');
            $('#schoolProjectIndex #newSubjectButton').addClass('hidden');
            $('#schoolProjectIndex #viewSubjectButton').addClass('hidden');
            $('#schoolProjectIndex #newClassButton').addClass('hidden');
            $('#schoolProjectIndex #viewClassButton').addClass('hidden');
            $('#schoolProjectIndex #newTeacherButton').addClass('hidden');
            $('#schoolProjectIndex #viewTeacherButton').addClass('hidden');
            $('#schoolProjectIndex #deleteButton').addClass('hidden');
            // Showing Current View's menu
            $('#schoolProjectIndex #schoolDashboardButton').text('Schools');
            $('#schoolProjectIndex #schoolDashboardButton').removeClass('hidden');
            // Displaying Welcome View
            $('#schoolProjectIndex #homeDashboard').removeClass('hidden');
        });

        // School Index Button/School Dashboard Button
        $('#schoolProjectIndex #schoolDashboardButton').unbind('click');
        $('#schoolProjectIndex #schoolDashboardButton').click(function () {
            // Hiding Welcome View
            $('#schoolProjectIndex #homeDashboard').addClass('hidden');
            // Hiding School Show View
            $('#schoolProjectIndex #schoolShow').addClass('hidden');
            // Hiding Subject Dashboard View
            $('#schoolProjectIndex #schoolShow #subjectDashboard').addClass('hidden');
            // Hiding Other menu buttons
            $('#schoolProjectIndex #schoolDashboardButton').addClass('hidden');
            $('#schoolProjectIndex #editSchoolButton').addClass('hidden');
            $('#schoolProjectIndex #newSubjectButton').addClass('hidden');
            $('#schoolProjectIndex #viewSubjectButton').addClass('hidden');
            $('#schoolProjectIndex #newClassButton').addClass('hidden');
            $('#schoolProjectIndex #viewClassButton').addClass('hidden');
            $('#schoolProjectIndex #newTeacherButton').addClass('hidden');
            $('#schoolProjectIndex #viewTeacherButton').addClass('hidden');
            $('#schoolProjectIndex #deleteButton').addClass('hidden');
            // Displaying School Menu Buttons
            $('#schoolProjectIndex #newSchoolButton').removeClass('hidden');
            // Unhide School Dashboard
            $('#schoolProjectIndex #schoolDashboard').removeClass('hidden');
            var schoolIndex = new PS.schoolIndex();
        });

        // New School Modal Button
        $('#schoolProjectIndex #newSchoolButton').unbind('click');
        $('#schoolProjectIndex #newSchoolButton').click(function () {
            // Clearing all values before rendring.
            $('#schoolNewModal .new-school-form #inputSchoolName').val('');
            $('#schoolNewModal .new-school-form #inputSchoolAddress').val('');
            $('#schoolNewModal .new-school-form #inputSchoolCity').val('');
            $('#schoolNewModal .new-school-form #inputSchoolState').val('');
            $('#schoolNewModal .new-school-form #inputSchoolZipcode').val('');
            $('#schoolNewModal .new-school-form #inputSchoolPhone').val('');
            // Showing New School Modal
            $('#schoolDashboard #schoolNewModal').modal('show');
        });

        // Edit School Modal Button
        $('#schoolProjectIndex #editSchoolButton').unbind('click');
        $('#schoolProjectIndex #editSchoolButton').click(function() {
            $('#schoolShow #schoolEditModal').modal('show');
        });

        // New Subject Modal Button
        $('#schoolProjectIndex #newSubjectButton').unbind('click');
        $('#schoolProjectIndex #newSubjectButton').click(function() {
            $('#schoolShow .new-subject-form #inputSubjectName').val('');
            $('#schoolShow #subjectNewModal').modal('show');
        });

        // New Class Modal Button
        $('#schoolProjectIndex #newClassButton').unbind('click');
        $('#schoolProjectIndex #newClassButton').click(function() {
            $('#schoolShow #classNewModal').modal('show');
        });

        // New Teacher Modal Button
        $('#schoolProjectIndex #newTeacherButton').unbind('click');
        $('#schoolProjectIndex #newTeacherButton').click(function() {
            $('#schoolShow #teacherNewModal').modal('show');
        });
    }
}