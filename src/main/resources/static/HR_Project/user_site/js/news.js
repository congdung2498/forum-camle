$(document).ready(function () {

    if(Cookies.get('Cookie')==null){
        window.location.href = '/login/login.html';
    }

    $(document).ajaxError(function( event, jqxhr, settings, thrownError ) {
        console.log(jqxhr);
        if ( jqxhr.responseText = "Access Denied!" ) {
            $.toaster({message: 'Bạn không có quyền thực hiện thao tác này ', title: ' Lỗi(403) Access Denied !!', priority: 'danger'});
        }
    });
    $(document).ajaxStart(function(){
        $("#wait").css("display", "block");
    });
    $(document).ajaxComplete(function(){
        $("#wait").css("display", "none");
    });
    var List=[];
    var Obj={};
    $("#tinTuc").addClass('active');
    function GetData(){
        $(".newsbody").empty();
        $.ajax({
            type: "GET",
            contentType: "application/json",
            url: "/rest/getNews",
            dataType: 'json',
            headers: {
                "Authorization": Cookies.get('Cookie'),
            },
            cache: false,
            timeout: 600000,
            success: function (data) {
                List = data;
                for (var i = 0; i < data.length; i++) {
                    $(".newsbody").append("<div class=\"row-item row aos-init aos-animate\" style='border-bottom: 1px solid #dee2e6' data-aos=\"fade-up\">\n" +
                        "                            <div class=\"col-md-9 border-right\" style=\"padding: 15px\">\n" +
                        "                                <div class=\"col-md-12\">\n" +
                        "                                    <h3>" + data[i].title + "</h3>\n" +
                        "                                    <p>" + data[i].summary + "</p>\n" +
                        "                                    <a id='detail' onclick=\"detail(" + data[i].iD +")\" class=\"btn btn-primary\" href=\"Detail.html\">Xem thêm    <i class=\"fa fa-chevron-right\" aria-hidden=\"true\"></i></a>\n" +
                        "                                </div>\n" +
                        "\n" +
                        "                            </div>\n" +
                        "\n" +
                        "\n" +
                        "                            <div class=\"col-md-3 \" style=\"padding: 15px ;color: #878787; \">\n" +
                        "                                    <h4 style=\"padding: 5px; font-size: small;\">\n" +
                        "                                       <i class=\"fa fa-calendar\" aria-hidden=\"true\"></i>\n" +
                        "                                        Ngày đăng: <i>"+ data[i].date +"</i>\n" +
                        "                                    </h4>\n" +
                        "                                    <h4 style=\"padding: 5px; font-size: small;\">\n" +
                        "                                     <i class=\"fa fa-user-o\" aria-hidden=\"true\"></i>\n" +
                        "                                        Người đăng: <i>"+ data[i].author +"</i>\n" +
                        "                                    </h4>\n" +
                        "                                    <h4 style=\"padding: 5px; font-size: small;\">\n" +
                        "                                    <i class=\"fa fa-download\" aria-hidden=\"true\"></i>\n" +
                        "                                       Đính kèm: <i>"+ data[i].files.length +"</i>\n" +
                        "                                    </h4>\n" +
                        "                            </div>\n" +
                        "\n" +
                        "                            <div class=\"break\"></div>\n" +
                        "                        </div>")
                }
            }
        });

    }

    GetData();
});
function detail(id) {
    localStorage.setItem("id",id);
}
