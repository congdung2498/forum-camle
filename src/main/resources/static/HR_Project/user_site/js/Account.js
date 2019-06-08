$(document).ready(function () {
    var ListAcc = [];
    var Acc = {};

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
    if(Cookies.get('Cookie')==null){
        $.toaster('Xin mời đăng nhập', 'Thông báo', 'warning');
        window.location.href = '/login/login.html';
    }
    var id = Cookies.get('UserID');


    $("#changePass").click(function () {
        var newPass = $("#newpass").val();
        var rePass = $("#renew").val();
        console.log(newPass + " " + rePass);
        if (newPass == "") {
            $.toaster('Bạn chưa nhập mật khẩu', 'Thông báo', 'warning');
        } else if (rePass == "") {
            $.toaster('Bạn chưa nhập lại mật khẩu', 'Thông báo', 'warning');
        } else if (newPass != rePass) {
            $.toaster('Mật khẩu nhập lại không khớp', 'Thông báo', 'warning');
        } else {
            $.ajax({
                url: '/rest/changePass',
                dataType: 'json',
                type: 'POST',
                headers: {
                    "Authorization": Cookies.get('Cookie'),
                },
                cache: false,
                contentType: 'application/json',
                data: JSON.stringify({
                    id: id,
                    password: newPass
                }),

                success: function (data) {
                    if (data == true) {
                        $.toaster('Đổi mật khẩu thành công ', 'thông báo', 'success');
                        window.location.href = '#';
                    } else {
                        $.toaster({message: 'Có lỗi xảy ra: ', title: 'Thất bại', priority: 'danger'});
                    }

                },
                error: function (data) {
                    $.toaster({message: 'Có lỗi xảy ra: ', title: 'Thất bại', priority: 'danger'});
                }
            })
        }

    })
});
