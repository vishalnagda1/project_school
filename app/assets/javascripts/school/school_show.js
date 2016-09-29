var PS = PS || {};

PS.schoolShow = function() {
    this.initialize();
}

PS.schoolShow.prototype = {
    initialize: function () {
        this.showSchoolDetails();
        this.modalEditFormValidation();
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
            },

            error: function (jqXHR, textStatus, errorThrown) {

                alert(jqXHR.responseText);
            }
        });
    },

    // Applying validation on Edit form
    modalEditFormValidation:function () {
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
    }
}