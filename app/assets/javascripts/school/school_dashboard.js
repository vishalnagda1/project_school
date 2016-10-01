var PS = PS || {};

PS.schoolIndex = function() {
    this.initialize();
}

PS.schoolIndex.prototype = {
    initialize: function () {
        this.showSchoolList();
        this.modalFormValidation();
        this.addSchoolDetails();
        // this.viewAutoReload();
    },

    showSchoolList: function () {
        var table = $('#schoolDashboard .school-list-table').DataTable();
        table.clear();
        var self = this;
        $.ajax({
            url: "/schools",
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
                        '<td>'+item.address+'</td>' +
                        '<td>'+item.city+'</td>' +
                        '<td>'+item.state+'</td>' +
                        '<td>'+item.zipcode+'</td>' +
                        '<td>'+item.phone+'</td>' +
                        '<td><a class="btn btn-success btn-xs show-school" school_id="'+item.id+'">Show</a></td>' +
                        '</tr>'
                    )).draw();
                });
                self.schoolShow();
            },

            error: function (jqXHR, textStatus, errorThrown) {

                alert(jqXHR.responseText);
            }
        });
    },

    // Show School Details
    schoolShow:function() {
        var self = this;
        $('#schoolDashboard .school-list-table .show-school').unbind('click');
        $('#schoolDashboard .school-list-table .show-school').click(function(){
            var schoolId = $(this).attr('school_id');
            $('#schoolProjectIndex #schoolShow').removeClass('hidden')
            $('#schoolProjectIndex #schoolDashboard').addClass('hidden');
            $('#schoolProjectIndex #schoolDashboardButton').text('School Dashboard');
            $('#schoolProjectIndex #schoolDashboardButton').removeClass('hidden');
            $('#schoolProjectIndex #newSchoolButton').addClass('hidden');
            $('#schoolProjectIndex #editSchoolButton').removeClass('hidden');
            $('#schoolProjectIndex #newSubjectButton').removeClass('hidden');
            $('#schoolProjectIndex #viewSubjectButton').removeClass('hidden');
            $('#schoolProjectIndex #newClassButton').removeClass('hidden');
            $('#schoolProjectIndex #viewClassButton').removeClass('hidden');
            $('#schoolProjectIndex #newTeacherButton').removeClass('hidden');
            $('#schoolProjectIndex #viewTeacherButton').removeClass('hidden');
            $('#schoolProjectIndex #deleteButton').removeClass('hidden');
            $('#schoolShow .school-id').val(schoolId);
            var schoolShow = new PS.schoolShow();
        });
    },

    modalFormValidation:function () {
        $('#schoolDashboard #schoolNewModal .new-school-form').validate({
            rules: {
                name: {
                    required: true
                },
                address: {
                    required: true
                },
                city: {
                    required: true
                },
                state: {
                    required: true
                },
                zipcode: {
                    required: true
                },
                phone: {
                    required: true,
                    digits: true,
                    minlength: 10,
                    maxlength: 10
                }
            }
        });
    },

    addSchoolDetails:function () {
        var self = this;
        $('#schoolNewModal .modal-footer #schoolAddButton').click(function () {
            if($('#schoolDashboard #schoolNewModal .new-school-form').valid()) {
                var school_data = {};

                school_data['name'] = $('#schoolNewModal .new-school-form #inputSchoolName').val();
                school_data['address'] = $('#schoolNewModal .new-school-form #inputSchoolAddress').val();
                school_data['city'] = $('#schoolNewModal .new-school-form #inputSchoolCity').val();
                school_data['state'] = $('#schoolNewModal .new-school-form #inputSchoolState').val();
                school_data['zipcode'] = $('#schoolNewModal .new-school-form #inputSchoolZipcode').val();
                school_data['phone'] = $('#schoolNewModal .new-school-form #inputSchoolPhone').val();
                $.ajax({
                    url: "/schools",
                    type: "POST",
                    data: {school:school_data},
                    format: "JSON",
                    success: function(data, textStatus, jqXHR) {
                        console.log(data);
                        $('#schoolDashboard #schoolNewModal').modal('hide');
                        // self.showSchoolList();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert(jqXHR.responseText);
                    }
                });
            }
        });
    },

    viewAutoReload:function () {
        var self = this;
        setInterval( function () {
            self.showSchoolList();
        }, 1000 );
    }

}