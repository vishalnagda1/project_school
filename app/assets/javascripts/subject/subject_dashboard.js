var PS = PS || {};

PS.subjectIndex = function() {
    this.initialize();
}

PS.subjectIndex.prototype = {
    initialize: function () {
        this.getAllSubjects();
        this.modalFormValidation();
        this.updateSubjectDetails();
        // this.viewAutoReload();
    },

    //Listing all the subject of a particular school
    getAllSubjects:function() {
        var school_id = $('#subjectDashboard .school-id').val();
        var table = $('#subjectDashboard .subject-list-table').DataTable();
        table.clear();
        var self = this;
        $.ajax({
            url: "/subjects/index_by_school_id."+school_id,
            type: "GET",
            format: "JSON",
            success: function(data, textStatus, jqXHR)
            {
                // $.each(data,function(i,item) {
                //     console.log(item);
                // console.log(data)
                // })

                $.each(data,function(i, item) {
                    table.row.add($(
                        '<tr><td>'+item.name+'</td>' +
                        '<td><a class="btn btn-warning btn-xs edit-subject" subject_id="'+item.id+'">Edit</a></td>' +
                        '<td><a class="btn btn-danger btn-xs delete-subject" subject_id="'+item.id+'">Delete</a></td>' +
                        '</tr>'
                    )).draw();
                });
                self.subjectEdit();
                // self.subjectDelete();
            },

            error: function (jqXHR, textStatus, errorThrown) {

                alert(jqXHR.responseText);
            }
        });
    },

    subjectEdit:function() {
        $('#subjectDashboard .subject-list-table .edit-subject').unbind('click')
        $('#subjectDashboard .subject-list-table .edit-subject').click(function() {
            var subject_id = $(this).attr('subject_id');
            $('#subjectDashboard .subject-id').val(subject_id);
            $.ajax({
                url: '/subjects/'+subject_id,
                type: 'GET',
                format: 'JSON',
                success: function(data, textStatus, jqXHR) {
                    $('#subjectDashboard #subjectEditModal #inputSubjectName').val(data.name);
                    $('#subjectDashboard #subjectEditModal').modal('show');
                },
                error: function (jqXHR, textStatus, errorThrown) {

                    alert(jqXHR.responseText);
                }
            });
        });
    },

    modalFormValidation:function() {
        $('#subjectDashboard #subjectEditModal .edit-subject-form').validate({
            rules: {
                name: {
                    required: true
                }
            }
        });
    },

    updateSubjectDetails:function() {
        var self = this;
        $('#subjectDashboard #subjectEditModal #subjectEditButton').unbind('click');
        $('#subjectDashboard #subjectEditModal #subjectEditButton').click(function() {
            if ($('#subjectDashboard #subjectEditModal .edit-subject-form').valid()) {
                var subject_data = {};
                subject_data['name'] = $('#subjectEditModal .edit-subject-form #inputSubjectName').val();
                subject_data['school_id'] = $('#subjectDashboard .school-id').val();
                var subject_id = $('#subjectDashboard .subject-id').val();
                // console.log(subject_data);
                $.ajax({
                    url: "/subjects/"+subject_id,
                    type: "PUT",
                    data: {subject:subject_data},
                    format: "JSON",
                    success: function(data, textStatus, jqXHR) {
                        $('#subjectDashboard #subjectEditModal').modal('hide');
                        self.getAllSubjects();

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert(jqXHR.responseText);
                    }
                });
            }
        });
    },

    // viewAutoReload:function () {
    //     var self = this;
    //     setInterval( function () {
    //         self.getAllSubjects();
    //     }, 1000 );
    // }
}