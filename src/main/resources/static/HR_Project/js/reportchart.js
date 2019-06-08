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
    // var maNV = Cookies.get('UserName');
    $("#name").val(Cookies.get('HoVaTen'));


    $(document).ajaxError(function( event, jqxhr, settings, thrownError ) {
        console.log(jqxhr);
        if ( jqxhr.responseText = "Access Denied!" ) {
            $.toaster({message: 'Bạn không có quyền thực hiện thao tác này ', title: ' Lỗi(403) Access Denied !!', priority: 'danger'});
        }
    });
    var Listdata=[];


    $.ajax({
        type: "GET",
        contentType: "application/json",
        url: "/rest/getStaffInfo",
        dataType: 'json',
        headers: {
            "Authorization": Cookies.get('Cookie'),
        },
        cache: false,
        timeout: 600000,
        success: function (data) {
            console.log(data);
            for (var i = 0; i < data.length; i++) {
                $('#select-manv').append($('<option>', {
                    value: data[i].maNV,
                    text: data[i].hoVaTen
                }));
            }
            $("#select-manv").select2( {
                placeholder: "Chọn nhân viên",
                allowClear: true
            } );
            getYear();
        }
    });

    $("#select-manv").change(function () {
        $("#year").empty();
        getYear();
    })

    $("#view").click(function () {
        var from = $('.from').val();
        var to = $('.to').val();
         console.log(from);
         console.log(to);
        var url = "/rest/getSalarybyYear?maNV=" + $("#select-manv").val()+"&from="+ from +"&to="+ to;
        $.ajax({
            type: "GET",
            contentType: "application/json",
            headers: {
                "Authorization": Cookies.get('Cookie'),
            },
            url: url,
            dataType: 'json',
            cache: false,
            timeout: 600000,
            success: function (data) {
                console.log(data);
                $("#barChart").empty();
                var thang=[];
                var tongthunhap=[];
                var sotiennhan = [];
                for (var i = 0; i < data.length; i++) {
                    thang.push(data[i].thang)
                    tongthunhap.push(data[i].tongThuNhap);
                    sotiennhan.push(data[i].soTienChuyenKhoan);
                }
                // for(var i=0; i<tongthunhap.length;i++){
                //     tongthunhap[i]=formatNumber(tongthunhap[i]);
                // }
                // for(var i=0; i<sotiennhan.length;i++){
                //     sotiennhan[i]=formatNumber(sotiennhan[i]);
                // }
                myChart.data.labels=thang;
                myChart.data.datasets[0].data=tongthunhap;
                myChart.data.datasets[1].data=sotiennhan;
                myChart.update();
            },
            error: function (data) {
                $.toaster({message: 'Có lỗi xảy ra: ', title: 'Thất bại', priority: 'danger'});
            }

        });
    });
    function getYear() {
        var manv = $("#select-manv").val();
        var url = "/rest/getAllMonthByMaNV?maNV=" + manv;
        $.ajax({
            type: "GET",
            contentType: "application/json",
            headers: {
                "Authorization": Cookies.get('Cookie'),
            },
            url: url,
            dataType: 'json',
            cache: false,
            timeout: 600000,
            success: function (data) {
                var Listdate=[];
                Listdata = data;
                for(var i=0; i< Listdata.length; i++){
                    var d= stringToDate(Listdata[i],"MM/yyyy","/");
                    Listdate.push(d);
                }
                Listdate.sort(date_sort_desc);

                var ListYear = [];

                for(var i=0; i< Listdate.length; i++){
                    var d = Listdate[i].getFullYear();
                    ListYear.push(d);
                }
                var yearunique = ListYear.filter( onlyUnique );
                $("#year").empty();
                for (var i = 0; i < yearunique.length; i++) {
                    $("#year").append(new Option(yearunique[i], yearunique[i]));
                }
                // $("#year").change();
            }
        });
    }
    function onlyUnique(value, index, self) {
        return self.indexOf(value) === index;
    }
    var date_sort_desc = function (date1, date2) {
        // This is a comparison function that will result in dates being sorted in
        // DESCENDING order.
        if (date1 > date2) return -1;
        if (date1 < date2) return 1;
        return 0;
    };
    var options = {
        animation: false,
        scaleLabel:
            function(label){return  ' $' + label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");}

    };
    function stringToDate(_date,_format,_delimiter)
    {
        var formatLowerCase=_format.toLowerCase();
        var formatItems=formatLowerCase.split(_delimiter);
        var dateItems=_date.split(_delimiter);
        var monthIndex=formatItems.indexOf("mm");
        var yearIndex=formatItems.indexOf("yyyy");
        var month=parseInt(dateItems[monthIndex]);
        month-=1;
        var formatedDate = new Date(dateItems[yearIndex],month);
        return formatedDate;
    }
    //bar chart
    var ctx = document.getElementById( "barChart" );
    //    ctx.height = 200;
    var myChart = new Chart( ctx, {
        type: 'bar',
        data: {
            labels: [ "January", "February", "March", "April", "May", "June", "July","August", "September", "October", "November", "December"],
            datasets: [
                {
                    label: "Tổng thu nhập",
                    data: [ ],
                    borderColor: "rgba(0, 123, 255, 0.9)",
                    borderWidth: "0",
                    backgroundColor: "rgba(0,0,0,0.07)"
                },
                {
                    label: "Số tiền nhận",
                    data: [  ],
                    borderColor: "rgba(0,0,0,0.09)",
                    borderWidth: "0",
                    backgroundColor: "rgba(0, 123, 255, 0.9)"
                }
            ]
        },
        options: {
            scales: {
                yAxes: [ {
                    ticks: {
                        beginAtZero: true
                    }
                } ]
            },
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        return formatNumber(tooltipItem.yLabel.toString()); }, },
            },
            scales: {
                yAxes: [{
                    ticks: {
                        callback: function(label, index, labels) { return formatNumber(label); },
                        beginAtZero:true,
                        fontSize: 10,
                    },
                    gridLines: {
                        display: true
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Số tiền (đồng)',
                        fontSize: 10,
                    }
                }],
                xAxes: [{
                    ticks: {
                        beginAtZero: true,
                        fontSize: 10
                    },
                    gridLines: {
                        display:true
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Tháng',
                        fontSize: 10,
                    }
                }]
            }
        },
    } );
    function formatNumber(num) {
        return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
    }
    var startDate = new Date();
    var fechaFin = new Date();
    var FromEndDate = new Date();
    var ToEndDate = new Date();

    $('.from').datepicker({
        autoclose: true,
        minViewMode: 1,
        format: 'mm/yyyy'
    }).on('changeDate', function(selected){
        startDate = new Date(selected.date.valueOf());
        startDate.setDate(startDate.getDate(new Date(selected.date.valueOf())));
        $('.to').datepicker('setStartDate', startDate);
    });

    $('.to').datepicker({
        autoclose: true,
        minViewMode: 1,
        format: 'mm/yyyy'
    }).on('changeDate', function(selected){
        FromEndDate = new Date(selected.date.valueOf());
        FromEndDate.setDate(FromEndDate.getDate(new Date(selected.date.valueOf())));
        $('.from').datepicker('setEndDate', FromEndDate);
    });


});

