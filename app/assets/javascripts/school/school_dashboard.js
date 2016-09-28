var PS = PS || {};

PS.schoolIndex = function() {
    this.initialize();
}

PS.schoolIndex.prototype = {
    initialize: function () {
        this.showSchoolList();
    },

    showSchoolList: function () {
        var self = this;
        $.ajax({
            async: false,
            url: "/schools",
            type: "GET",
            format: "JSON",
            success: function(data)
            {
                // $.each(data,function(i,item) {
                //     console.log(item.name, item.address);
            // })

                var school_list = '';

                $.each(data,function(i, item) {
                    school_list +='<tr><td>'+item.name+'</td><td>'+item.address+'</td><td>'+item.city+'</td><td>'+item.state+'</td><td>'+item.zipcode+'</td><td>'+item.phone+'</td><td><a class="btn btn-success btn-xs">Show</a></td><td><a class="btn btn-warning btn-xs">Edit</a></td><td><a class="btn btn-danger btn-xs">Delete</a></td></tr>';
                });

                $('#schoolDashboard .school-list-table').append(school_list);
            },

            error: function (msg) {

                alert(msg.responseText);
            }
        });
    }
}