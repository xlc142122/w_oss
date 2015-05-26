<!DOCTYPE html>
<%--
  Created by IntelliJ IDEA.
  User: Pasenger
  Date: 15/5/23
  Time: 上午10:06
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="UTF-8"/>
    <title>AC Alarm</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'/>

    <jsp:include page="../common/include-header.jsp"/>

    <style type="text/css">
        .content {
            margin-left: 30px;
            margin-right: 30px;
            min-height: 600px;
        }

        .btn-right {
            float: right;
            margin-left: 20px;
        }

        #con {
            margin-right: 15px;
        }

        tr {
            cursor: pointer;
        }

        tr:hover {
            border-bottom: solid 2px blue;
        }
    </style>
</head>
<body class="skin-blue sidebar-mini">
<div class="wrapper">

    <jsp:include page="../common/head.jsp"/>
    <jsp:include page="../common/navigate.jsp"/>

    <!-- Content Wrapper. Contains page content -->
    <!-- 主内容div -->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                AC告警
                <%--<small>Preview page</small>--%>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/dashboard/ac.htm"><i class="fa fa-dashboard"></i> 监控</a></li>
                <li class="active">AC告警</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-red"><i class="fa fa-star-o"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">错误</span>
                            <span class="info-box-number">93,139</span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>
                <!-- /.col -->
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-yellow"><i class="fa fa-files-o"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">警告</span>
                            <span class="info-box-number">13,648</span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>
                <!-- /.col -->
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-envelope-o"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">提示</span>
                            <span class="info-box-number">1,410</span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-green"><i class="fa fa-flag-o"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">显示条目
                            <%--<span class="info-box-number">--%>
                                <select class="form-control" id="showNum">
                                    <option selected="selected">10</option>
                                    <option>20</option>
                                    <option>50</option>
                                    <option>100</option>
                                    <option>150</option>
                                    <option>200</option>
                                    <option>500</option>
                                </select>
                            <%--</span>--%>
                                </span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>
            </div>
            <!-- /.row -->

            <div class="row">
                <table class="table">
                    <thead>
                        <th width="16%">
                            发生时间
                        </th>
                        <th width="8%">
                            设备厂家
                        </th>
                        <th width="10%">
                            错误类型
                        </th>
                        <th width="8%">
                            告警级别
                        </th>
                        <th width="8%">
                            设备IP
                        </th>
                        <th width="50%">
                            告警摘要
                        </th>
                    </thead>
                </table>
                <div id="con">
                    <table class="table">

                        <tbody id="log">
                        </tbody>
                    </table>
                </div>
            </div>


        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <!-- 主内容div -->

    <!-- /.content-wrapper -->
    <jsp:include page="../common/footer.jsp"/>

    <div class='control-sidebar-bg'></div>
</div>
<!-- wrapper -->
<jsp:include page="../common/include-body.jsp"/>
<script src="../../../dist/js/jquery.slimscroll.min.js"></script>
<script src="../../../dist/js/sockjs.min.js"></script>
<script type="text/javascript">
    navControl('dashtree', 'dashAc');

    var s = 0;

    function log(message) {

        var log = $('#log');
        var showNum = $('#showNum').val();

        if (s != 0 && s % showNum == 0) {
            log.slideUp();
            log.empty();
            s = 0;
        }

        log.show();

        var str = "";
        for (var i = 0; i < message.length; i++) {
            var vendor = '华为';
            if(message[i].vendor == 1){
                vendor = '华为';
            }

            var type = "";
            switch(message[i].type)
            {
                case 1:
                    type = "端口起停";
                    break;
                case 2:
                    type = "系统重启";
                    break;
                case 3:
                    type = "光功率低";
                    break;
                case 4:
                    type = "CPU利用率高";
                    break;
                case 5:
                    type = "冷启动";
                    break;
                case 6:
                    type = "无线端口";
                    break;
                default:
                    type = "";
            }

            var level = "";
            switch(message[i].level){
                case 1:
                    level = "严重";
                    break;
                case 2:
                    level = "次要";
                    break;
                case 3:
                    level = "一般";
                    break;
            }

//            if (message[i].level == 1) {
//                str = "<tr id='tr" + s + "'' class='success' style='display:none'><td width='10%'>" + message[i].genTime + "</td><td width='8%'>" + vendor +
//                        "</td><td width='10%'>" + type + "</td><td width='8%'>" + level + "</td><td width='8%'>" +
//                        message[i].eqIp + "</td><td width='54%'>" + message[i].abDesc + "</td></tr>";
//            }
//            if (message[i].level == 2) {
//                str = "<tr id='tr" + s + "'' class='danger' style='display:none'><td width='10%'>" + message[i].genTime + "</td><td width='8%'>" + vendor +
//                        "</td><td width='10%'>" + type + "</td><td width='8%'>" + level + "</td><td width='8%'>" +
//                        message[i].eqIp + "</td><td width='54%'>" + message[i].abDesc + "</td></tr>";var nowStr = now.format("yyyy-MM-dd hh:mm:ss");
//            }
            if (message[i].level == 3) {
                str = "<tr id='tr" + s + "'' class='info' style='display:none'><td width='16%'>" + message[i].genTimeStr + "</td><td width='8%'>" + endor +
                        "</td><td width='10%'>" + type + "</td><td width='8%'>" + level + "</td><td width='8%'>" +
                        message[i].eqIp + "</td><td width='50%'>" + message[i].abDesc + "</td></tr>";
            }
            if (message[i].level == 2) {
                str = "<tr id='tr" + s + "'' class='warning' style='display:none'><td width='16%'>" + message[i].genTimeStr + "</td><td width='8%'>" + vendor +
                        "</td><td width='10%'>" + type + "</td><td width='8%'>" + level + "</td><td width='8%'>" +
                        message[i].eqIp + "</td><td width='50%'>" + message[i].abDesc + "</td></tr>";
            }
            if (message[i].level == 1) {
                str = "<tr id='tr" + s + "'' class='danger' style='display:none'><td width='16%'>" + message[i].genTimeStr + "</td><td width='8%'>" + vendor +
                        "</td><td width='10%'>" + type + "</td><td width='8%'>" + level + "</td><td width='8%'>" +
                        message[i].eqIp + "</td><td width='50%'>" + message[i].abDesc + "</td></tr>";
            }

            log.prepend(str);
            $('#tr' + s).fadeIn();
            $('#tr' + s).click(function () {

                $('#detail').modal('show');

            });
            s++;
        }
    }

    setInterval(function () {
        var showNum = $('#showNum').val();

        $.ajax({
            url: "/getAlarm?number=" + showNum,
            type: "GET",
            success: function (data) {
                log(data);
            }
        });

    }, 5000);

    $(function () {
        $('#con').slimScroll({
            color: '#00f',
            size: '10px',
            height: '600px',
            allowPageScroll: true
        });
    });


</script>

</body>
</html>
