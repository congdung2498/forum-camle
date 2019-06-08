$(document).ready(function () {
    if(Cookies.get('Cookie')==null){
        window.location.href = '/login/login.html';
    }
    if( Cookies.get('Cookie') != null && Cookies.get('Role') == "ROLE_USER" ){
        window.location.href = '/user_site/index.html';
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
});
