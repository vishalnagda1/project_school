var PS = PS || {};

PS.schoolShow = function() {
    this.initialize();
}

PS.schoolShow.prototype = {
    initialize: function () {
        this.showSchoolDetails();
        this.modalEditFormValidation();
        this.updateSchoolDetails();
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
    modalEditFormValidation:function () {
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
    },

    // updating School Details
    updateSchoolDetails:function() {
        var self = this;
        $('#schoolEditModal .modal-footer #schoolEditButton').click(function () {
            if ($('#schoolShow #schoolEditModal .edit-school-form').valid()) {
                alert("Valid Form");
            }
        });
    }
}