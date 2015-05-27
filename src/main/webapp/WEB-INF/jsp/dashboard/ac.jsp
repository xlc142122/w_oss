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

                        <div class="info-box-content" style="">
                            <span class="info-box-text">严重告警</span>
                            &nbsp;&nbsp;已处理: <a href="#"><span id="level1NumActive">${level1Num}</span></a>
                            <%--<span id="level1NumActive" class="info-box-number">--%>
                               <%--${level1Num}--%>
                            <%--</span>--%>
                            <br>
                            &nbsp;&nbsp;待处理: <a href="#"><span id="level1NumInActive">
                                ${level1Num}
                            </span></a>
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
                            <span class="info-box-text">次要告警</span>
                            <span id="level2Num" class="info-box-number">${level2Num}</span>
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
                            <span class="info-box-text">一般告警</span>
                            <span id="level3Num" class="info-box-number">${level3Num}</span>
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
                <div id="con">
                    <div class="table-responsive">
                        <table id="alarmTab" class="table table-condensed" data-sort-name="level" data-sore-order="desc">
                            <thead>
                            <th width="10%">
                                发生时间
                            </th>
                            <th width="8%">
                                设备厂家
                            </th>
                            <th width="10%">
                                错误类型
                            </th>
                            <th width="8%" data-sortable="true" data-field="level">
                                告警级别
                            </th>
                            <th width="8%">
                                设备IP
                            </th>
                            <th width="56%">
                                告警摘要
                            </th>
                            </thead>
                            <tbody id="log">
                            </tbody>
                        </table>
                    </div>
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

    var ws = null;

    window.onload = function() {
        ws = new SockJS('/alarmInfoSocket');
        ws.onopen = function() {
            console.log('Info: Alarm Info WebSocket connection opened.');
            ws.send("ping");
        };
        ws.onmessage = function(event) {
            //log('Received: ' + event.data);
            //console.log("receiver: " + event.data)

            var message = JSON.parse(event.data);
            appendAlarm(message);
        };
        ws.onclose = function() {
            console.log('Info: Alarm Info WebSocket connection closed.');
        };

        var countSocket = new SockJS('/alarmCountSocket');
        countSocket.onopen = function() {
            console.log('Info: Alarm Count WebSocket connection opened.');
            countSocket.send("ping");
        };
        countSocket.onmessage = function(event) {
            //console.log(event.data);
            var message = event.data.split("-");

            $("#level1NumActive").text(message[0]);
            $("#level1NumInActive").text(message[0]);
            $("#level2Num").text(message[1]);
            $("#level3Num").text(message[2]);
        };
        countSocket.onclose = function() {
            console.log('Info: WebSocket connection closed.');
        };
    }

//    function connect() {
////        var target = document.getElementById('target').value;
//        ws = new SockJS('/alarmSocket');
//        ws.onopen = function() {
//            console.log('Info: WebSocket connection opened.');
//
//        };
//        ws.onmessage = function(event) {
//            console.log('Received: ' + event.data);
//        };
//        ws.onclose = function() {
//            console.log('Info: WebSocket connection closed.');
//        };
//    }

    function disconnect() {
        if (ws != null) {
            ws.close();
            ws = null;
        }
        setConnected(false);
    }

    function appendAlarm(message) {

        var log = $('#log');
        var showNum = $('#showNum').val();

        var len=$("#alarmTab tr").length;
        //console.log("tab len: " + len + ", shownum: " + showNum);
        if(len > showNum){
            for(var i = showNum; i < len; i++){
                //console.log("remove:" + i)
                $("#alarmTab tr:eq(" + i + ")").remove();
            }
            //$("#alarmTab tr:last").remove();
        }

        log.show();

        var str = "";
        var vendor = '华为';
        if(message.vendor == 1){
            vendor = '华为';
        }

        var type = "";
        switch(message.type)
        {
            case 101:
                type = "端口起停";
                break;
            case 102:
                type = "系统重启";
                break;
            case 103:
                type = "光功率低";
                break;
            case 104:
                type = "CPU利用率高";
                break;
            case 105:
                type = "冷启动";
                break;
            case 106:
                type = "无线端口";
                break;
            case 107:
                type = "系统攻击";
                break;
            default:
                type = "";
        }

        //var rand = parseInt(Math.random() * 10);
        //message.level = rand % 3;
        //console.log("level:" + message.level);

        var level = "";
        switch(message.level){
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

        if (message.level == 3) {
            str = "<tr class='info'><td>" + message.genTimeStr + "</td><td>" + vendor +
                    "</td><td>" + type + "</td><td>" + level + "</td><td>" +
                    message.eqIp + "</td><td>" + message.abDesc + "</td></tr>";
        }
        if (message.level == 2) {
            str = "<tr class='warning'><td>" + message.genTimeStr + "</td><td>" + vendor +
                    "</td><td>" + type + "</td><td>" + level + "</td><td>" +
                    message.eqIp + "</td><td>" + message.abDesc + "</td></tr>";
        }
        if (message.level == 1) {
            str = "<tr class='danger'><td>" + message.genTimeStr + "</td><td>" + vendor +
                    "</td><td>" + type + "</td><td>" + level + "</td><td>" +
                    message.eqIp + "</td><td>" + message.abDesc + "</td></tr>";
        }

        log.prepend(str);

    }

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
