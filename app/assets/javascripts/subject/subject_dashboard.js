var PS = PS || {};

PS.subjectIndex = function() {
    this.initialize();
}

PS.subjectIndex.prototype = {
    initialize: function () {
        this.getAllSubjects();
    },

    //Listing all the subject of a particular school
    getAllSubjects:function() {
        var school_id = $('#subjectDashboard .school-id').val();
        var table = $('#subjectDashboard .subject-list-table').DataTable();
        table.clear();
        var self = this;
        $.ajax({
            url: "/subjects/index_by_school_id."+school_id,
            async: true,
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
                        '<td><a class="btn btn-warning btn-xs edit-school" school_id="'+item.id+'">Edit</a></td>' +
                        '<td><a class="btn btn-danger btn-xs delete-school" school_id="'+item.id+'">Delete</a></td>' +
                        '</tr>'
                    )).draw();
                });
                // self.subjectEdit();
                // self.subjectDelete();
            },

            error: function (jqXHR, textStatus, errorThrown) {

                alert(jqXHR.responseText);
            }
        });
    }
}