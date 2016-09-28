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
        $ajax({
            async: false,
            url: "/schools",
            type: "GET",
            format: "JSON",
            success: function(data,textStatus,jqXHR)
            {
                console.log(data)
            }
        })
    }
}
;
