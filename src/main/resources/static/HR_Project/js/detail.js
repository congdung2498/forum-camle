$(document).ready(function () {
    if(Cookies.get('Cookie')==null){
        window.location.href = '/login/login.html';
    }
    $(document).ajaxStart(function(){
        $("#wait").css("display", "block");
    });
    $(document).ajaxComplete(function(){
        $("#wait").css("display", "none");
    });

    $(document).ajaxError(function( event, jqxhr, settings, thrownError ) {
        console.log(jqxhr);
        if ( jqxhr.responseText = "Access Denied!" ) {
            $.toaster({message: 'Bạn không có quyền thực hiện thao tác này ', title: ' Lỗi(403) Access Denied !!', priority: 'danger'});
        }
    });
    var List=[];
    var Obj={};
    var id=localStorage.getItem("id");
    if(id==null){
        window.location.href = '/News.html';
    }
    var a =0;
    var News={};

    function GetData(){
        $(".newsbody").empty();
        $("#comment").empty();
        $.ajax({
            url: '/rest/getNewsbyID?id='+id,
            headers: {
                "Authorization": Cookies.get('Cookie'),
            },
            dataType: 'json',
            type: 'GET',
            cache: false,
            contentType: 'application/json',

            success: function (data) {
                News = data;
                $(".newsbody").append("   <!-- Title -->\n" +
                    "                            <h1>"+data.title+"</h1>\n" +
                    "                            <!-- Author -->\n" +
                    "                            <p class=\"lead\" style=\"color: #878787\" >\n" +
                    "                                 <i class=\"fa fa-user-o\" aria-hidden=\"true\"></i> by <a href=\"#\">"+data.author+"</a>\n" +
                    "                            </p>\n" +
                    "                            <!-- Date/Time -->\n" +
                    "                            <p style=\"color: #878787\"> <i class=\"fa fa-calendar\" aria-hidden=\"true\"></i> Posted on:"+data.date +" </p>\n" +
                    "                            <hr>\n" +
                    "                            <!-- Post Content -->\n" +
                    "                            <p style=\"color: black\" id=\"content\">\n" +
                    "                                     "+data.content+"\n" +
                    "                            </p>\n" +
                    "                            <hr>\n");

                if(data.files.length>0){
                    $(".newsbody").append(" <h3>Danh sách tệp đính kèm</h3>");
                    data.files.forEach(function(file) {
                        $(".newsbody").append("<p><a style='color: #0e6498' href="+file.fileName+">"+file.fileName+"</a></p>")
                    });

                }
                GetComment();


            },
            error: function (data) {
                $.toaster({message: 'Có lỗi xảy ra: ' + data, title: 'Thất bại', priority: 'danger'});
            }
        })
    }

    GetData();

    function GetComment(){
        for(var i= 0; i< News.comments.length; i++){

            if(News.comments[i].avatar != null && News.comments[i].userID != Cookies.get('UserID')){
                $("#comment").append(" <div class=\"media\" style=\"margin-top: 15px;\">\n" +
                    "                                <a class=\"pull-left\" href=\"#\" style=\"padding-right: 10px;\">\n" +
                    "                                    <img class=\"media-object\" style='height:64px; width: 64px; border-radius: 50%' src='" +News.comments[i].avatar+"' >\n" +
                    "                                </a>\n" +
                    "                                <div class=\"media-body\">\n" +
                    "                                    <h4 class=\"media-heading\"><b>"+News.comments[i].displayname+"</b>\n" +
                    "                                        <small style=\"color:#777;\">"+News.comments[i].date+"</small>\n" +
                    "                                    </h4>\n" +
                    "                                   "+News.comments[i].content+"" +
                    "                                </div>\n" +
                    "                            </div>")
            }
            else if(News.comments[i].avatar != null && News.comments[i].userID == Cookies.get('UserID')){
                $("#comment").append(" <div class=\"media\" style=\"margin-top: 15px;\">\n" +
                    "                                <a class=\"pull-left\" href=\"#\" style=\"padding-right: 10px;\">\n" +
                    "                                    <img class=\"media-object\" style='height:64px; width: 64px; border-radius: 50%' src='" +News.comments[i].avatar+"' >\n" +
                    "                                </a>\n" +
                    "                                <div class=\"media-body\">\n" +
                    "                                    <h4 class=\"media-heading\"><b>"+News.comments[i].displayname+"</b>\n" +
                    "                                        <small style=\"color:#777;\">"+News.comments[i].date+"</small>\n" +
                    "                                    </h4>\n" +
                    "                                   "+News.comments[i].content+"" +
                    "                                </div>\n" +
                    "                               <a class='delFile'><span style='display: none' class='commentID'>"+News.comments[i].id+"</span>" +
                    "<i style='color: darkblue;' class=\"fa fa-times \" aria-hidden=\"true\"></i><a>\n" +
                    "                            </div>")
            }
            else if(News.comments[i].avatar == null && News.comments[i].userID == Cookies.get('UserID')){
                $("#comment").append(" <div class=\"media\" style=\"margin-top: 15px;\">\n" +
                    "                                <a class=\"pull-left\" href=\"#\" style=\"padding-right: 10px;\">\n" +
                    "                                    <img class=\"media-object\" style='height:64px; width: 64px; border-radius: 50%' src='/images/admin.jpg' >\n" +
                    "                                </a>\n" +
                    "                                <div class=\"media-body\">\n" +
                    "                                    <h4 class=\"media-heading\"><b>"+News.comments[i].displayname+"</b>\n" +
                    "                                        <small style=\"color:#777;\">"+News.comments[i].date+"</small>\n" +
                    "                                    </h4>\n" +
                    "                                   "+News.comments[i].content+"" +
                    "                                </div>\n" +
                    "                               <a class='delFile'><span style='display: none' class='commentID'>"+News.comments[i].id+"</span>" +
                    "<i style='color: darkblue;' class=\"fa fa-times \" aria-hidden=\"true\"></i><a>\n" +
                    "                            </div>")
            }else if(News.comments[i].avatar == null && News.comments[i].userID != Cookies.get('UserID')) {
                $("#comment").append(" <div class=\"media\" style=\"margin-top: 15px;\">\n" +
                    "                                <a class=\"pull-left\" href=\"#\" style=\"padding-right: 10px;\">\n" +
                    "                                    <img class=\"media-object\" style='height:64px; width: 64px; border-radius: 50%' src='/images/admin.jpg' >\n" +
                    "                                </a>\n" +
                    "                                <div class=\"media-body\">\n" +
                    "                                    <h4 class=\"media-heading\"><b>"+News.comments[i].displayname+"</b>\n" +
                    "                                        <small style=\"color:#777;\">"+News.comments[i].date+"</small>\n" +
                    "                                    </h4>\n" +
                    "                                   "+News.comments[i].content+"" +
                    "                                </div>\n" +
                    "                            </div>")
            }
            if(a!=0){
                window.scrollTo(0, document.body.scrollHeight);
            }
        }
    }

    $("#sendComment").click(function () {
        a=1;
        $.ajax({
            url: '/rest/comment',
            dataType: 'json',
            type: 'POST',
            cache: false,
            headers: {
                "Authorization": Cookies.get('Cookie'),
            },
            contentType: 'application/json',
            data: JSON.stringify({
                userID:  Cookies.get('UserID'),
                newsID: News.iD,
                content: $("#NewComment").val()
            }),

            success: function (data) {

                console.log(data);
                if (data == true) {
                    GetData();
                    $("#NewComment").val("");

                } else {
                    $.toaster({
                        message: 'Có lỗi xảy ra xin vui lòng thử lại',
                        title: 'Thất bại',
                        priority: 'danger'
                    });
                }
            },
            error: function (data) {
                $.toaster({message: 'Có lỗi xảy ra: ' + data, title: 'Thất bại', priority: 'danger'});
            }
        })
    })
    $('#comment').on('click', '.delFile', function (event) {
        var commentID = $(this).find('.commentID').text().trim();
        var r = confirm("Bạn có chắc chắn muốn xóa bình luận này không?");
        if (r == true) {
            a=1;
            $.ajax({
                url: '/rest/deleteComment?id='+commentID,
                headers: {
                    "Authorization": Cookies.get('Cookie'),
                },
                dataType: 'json',
                type: 'POST',
                cache: false,
                contentType: 'application/json',

                success: function (data) {

                    if (data == true) {
                        $.toaster('Xóa thành công', 'Thông báo', 'success');
                        GetData();

                    } else {
                        $.toaster({message: 'Có lỗi xảy ra: ', title: 'Thất bại', priority: 'danger'});
                    }
                },
                error: function (data) {
                    $.toaster({message: 'Có lỗi xảy ra:' + data.responseText, title: 'Thất bại', priority: 'danger'});
                }
            })
        } else {
            console.log("cancel");
        }
    })
});


function detail(id) {
    localStorage.setItem("id",id);
}
