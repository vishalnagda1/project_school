var PS = PS || {};

PS.schoolShow = function() {
    this.initialize();
}

PS.schoolShow.prototype = {
    initialize: function () {
        this.showSchoolDetails();
        this.modalFormValidation();
        this.updateSchoolDetails();
        this.addNewSubject();
        this.listSubjects();
    },

    // Getting School Details
    showSchoolDetails: function () {
        var school_id = $('#schoolShow .school-id').val();
        // $('#schoolShow .school-name').text(school_id);
        $.ajax({
            url: "/schools/"+school_id,
            type: "GET",
            format: "JSON",
            success: function(data, textStatus, jqXHR)
            {
                $('#schoolShow .school-name').text(data.name);
                $('#schoolShow .school-address-details').text(data.address+", "+data.city+", "+data.state+" - "+data.zipcode);
                $('#schoolShow .school-contact-details').text(data.phone);

                $('#schoolShow #schoolEditModal #inputSchoolName').val(data.name);
                $('#schoolShow #schoolEditModal #inputSchoolAddress').val(data.address);
                $('#schoolShow #schoolEditModal #inputSchoolCity').val(data.city);
                $('#schoolShow #schoolEditModal #inputSchoolState').val(data.state);
                $('#schoolShow #schoolEditModal #inputSchoolZipcode').val(data.zipcode);
                $('#schoolShow #schoolEditModal #inputSchoolPhone').val(data.phone);
            },

            error: function (jqXHR, textStatus, errorThrown) {

                alert(jqXHR.responseText);
            }
        });
    },

    // Applying validation on Edit form
    modalFormValidation:function () {
        // Edit Form Validation
        $('#schoolShow #schoolEditModal .edit-school-form').validate({
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

        // Subject Form Validation
        $('#schoolShow #subjectNewModal .new-subject-form').validate({
            rules: {
                name: {
                    required: true
                }
            }
        });
    },

    // updating School Details
    updateSchoolDetails:function() {
        var self = this;
        $('#schoolEditModal .modal-footer #schoolEditButton').click(function () {
            if ($('#schoolShow #schoolEditModal .edit-school-form').valid()) {
                var school_data = {};
                var school_id = $('#schoolShow .school-id').val();
                school_data['name'] = $('#schoolEditModal .edit-school-form #inputSchoolName').val();
                school_data['address'] = $('#schoolEditModal .edit-school-form #inputSchoolAddress').val();
                school_data['city'] = $('#schoolEditModal .edit-school-form #inputSchoolCity').val();
                school_data['state'] = $('#schoolEditModal .edit-school-form #inputSchoolState').val();
                school_data['zipcode'] = $('#schoolEditModal .edit-school-form #inputSchoolZipcode').val();
                school_data['phone'] = $('#schoolEditModal .edit-school-form #inputSchoolPhone').val();
                // console.log(school_data);
                $.ajax({
                    url: "/schools/"+school_id,
                    type: "PUT",
                    data: {school:school_data},
                    format: "JSON",
                    success: function(data, textStatus, jqXHR) {
                        // console.log(data);
                        $('#schoolShow #schoolEditModal').modal('hide');
                        self.showSchoolDetails();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert(jqXHR.responseText);
                    }
                });
            }
        });
    },

    // Adding new subject
    addNewSubject:function() {
        $('#subjectNewModal .modal-footer #subjectAddButton').click(function() {
            if ($('#schoolShow #subjectNewModal .new-subject-form').valid()) {
                var subject_data = {};
                subject_data['name'] = $('#subjectNewModal .new-subject-form #inputSubjectName').val();
                subject_data['school_id'] = $('#schoolShow .school-id').val();
                // console.log(subject_data);
                $.ajax({
                    url: "/subjects",
                    type: "POST",
                    data: {subject:subject_data},
                    format: "JSON",
                    success: function(data, textStatus, jqXHR) {
                        $('#schoolShow #subjectNewModal').modal('hide');
                        alert("Subject Added");
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert(jqXHR.responseText);
                    }
                });
            }
        });
    },

    // Listing all the subjects
    listSubjects:function() {
        $('#schoolProjectIndex #viewSubjectButton').click(function() {
            var school_id = $('#schoolShow .school-id').val();
            $('#schoolShow #subjectDashboard').removeClass('hidden');
            $('#subjectDashboard .school-id').val(school_id);
            var subjectIndex = new PS.subjectIndex();
        })
    }
}