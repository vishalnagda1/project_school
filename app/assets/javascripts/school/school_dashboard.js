var PS = PS || {};

PS.schoolIndex = function() {
    this.initialize();
}

PS.schoolIndex.prototype = {
    initialize: function () {
        this.showSchoolList();
    },

    showSchoolList: function () {
        var table = $('#schoolDashboard .school-list-table').DataTable();
        table.clear();
        var self = this;
        $.ajax({
            url: "/schools",
            type: "GET",
            format: "JSON",
            success: function(data)
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
                        '<td><a class="btn btn-warning btn-xs edit-school" school_id="'+item.id+'">Edit</a></td>' +
                        '<td><a class="btn btn-danger btn-xs delete-school" school_id="'+item.id+'">Delete</a></td>' +
                        '</tr>'
                    )).draw();
                });
                self.schoolShow();
                self.schoolEdit();
                self.schoolDelete();
            },

            error: function (msg) {

                alert(msg.responseText);
            }
        });
    },

    // Show School Details
    schoolShow:function() {
        $('#schoolDashboard .school-list-table .show-school').click(function(){
            var schoolId = $(this).attr('school_id');
            // alert(schoolId+" Show");
            $('#schoolShow .schoolHead').removeClass('hidden')
            $('#schoolProjectIndex #schoolDashboard').addClass('hidden');
        });
    },

    // Edit School Details
    schoolEdit:function() {
        $('#schoolDashboard .school-list-table .edit-school').click(function(){
            var schoolId = $(this).attr('school_id');
            alert(schoolId+" Edit");
        });
    },

    // Delete School Details
    schoolDelete:function() {
        $('#schoolDashboard .school-list-table .delete-school').click(function(){
            var schoolId = $(this).attr('school_id');
            alert(schoolId+" Delete");
        });
    }

}