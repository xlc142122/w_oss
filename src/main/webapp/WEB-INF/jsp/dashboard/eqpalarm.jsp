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
    <title>Alarm</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'/>

    <jsp:include page="../common/include-header.jsp"/>


    <style type="text/css">
        .content {
            margin-left: 30px;
            margin-right: 30px;
            min-height: 600px;
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

        #fullscreen {
            margin-left:0px !important
        }

    </style>

    <script type="text/javascript">
        function getAlarmPage(pageNum){
            var level = $("#almLevel").val();
            var status = $("#almStatus").val();
            var curPage = parseInt($("#curPage").val());

            var page = 0;
            if(pageNum == -2){  //上一页
                page = curPage - 1;
            }else if(pageNum == -1){//下一页
                page = curPage + 1;
            }else{
                page = pageNum;
            }

            if(page < 0){
                page = 0;

            }

            $("#curPage").val(page);

            $.ajax({
                url: "/alarm/findByLevelAndStatus?level=" + level + "&status=" + status + "&page=" + page,
                type: "GET",
                success: function(data){
                    if(data == null){
                        alert("无历史数据！");
                    }else{
                        if(status == 0){
                            appendActiveAlarmList(data);
                        }else{
                            appendInActiveAlarmList(data);
                        }
                    }
                },
                error: function(){
                    alert("请求数据失败！");
                }
            });
        }
        /**
        *
        * @param show_div
        * @param bg_div
        * @param level  告警级别
        * @param dealType   1:已处理；0:未处理
         */
        function showAlarmList(level, status, pageNum){
            $("#almLevel").val(level);
            $("#almStatus").val(status);
            $("#curPage").val(pageNum);

            $.ajax({
                url: "/alarm/findByLevelAndStatus?level=" + level + "&status=" + status + "&page=" + pageNum,
                type: "GET",
                success: function(data){
                    if(data == null){
                        alert("无历史数据！");
                    }else{
                        if(status == 0){
                            appendActiveAlarmList(data);
                            $('#activeAlarmModal').modal('show');
                        }else{
                            appendInActiveAlarmList(data);
                            $('#inactiveAlarmModal').modal('show');
                        }
                    }
                },
                error: function(){
                    alert("请求数据失败！");
                }
            });
        }

        function appendActiveAlarmList(message) {
            var len=$("#activeAlarmTab tr").length;
            while(len > 1){
                $("#activeAlarmTab tr:last").remove();
                len--;
            }

            var str = "";
            for(var i = 0; i < message.length; i++){
                var vendor = '华为';
                if(message[i].vendor == 1){
                    vendor = '华为';
                }

                var type = "";
                switch(message[i].type)
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

                str = "<tr class='info'><td>" + message[i].genTimeStr + "</td><td>" + vendor +
                        "</td><td>" + type + "</td><td>" +
                        message[i].eqIp + "</td><td>" + message[i].abDesc + "</td><td>" +
                        "<button class='btn btn-block btn-success' onclick='clearAlarm(" +
                        message[i].id+ ", this);'>清除</button>"+ "</td></tr>";


                $("#activeAlarmTab tr:last").after(str);
            }
        }

        function clearAlarm(id, obj, pageNum){
            $.ajax({
                url: "/alarm/clear?id=" + id,
                type: "GET",
                success: function(data){
                    $(obj).parent().parent().remove();
                },
                error: function(){
                    alert("请求数据失败！");
                }
            });
        }

        function appendInActiveAlarmList(message) {
            var len=$("#inactiveAlarmTab tr").length;
            while(len > 1){
                $("#inactiveAlarmTab tr:last").remove();
                len--;
            }

            var str = "";
            for(var i = 0; i < message.length; i++){
                var vendor = '华为';
                if(message[i].vendor == 1){
                    vendor = '华为';
                }

                var type = "";
                switch(message[i].type)
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

                str = "<tr class='info'><td>" + message[i].genTimeStr + "</td><td>" + vendor +
                        "</td><td>" + type + "</td><td>" +
                        message[i].eqIp + "</td><td>" + message[i].abDesc + "</td></tr>";


                $("#inactiveAlarmTab tr:last").after(str);
            }
        }

        function fullScreen(flag){
            if(flag == 0){  //恢复
                //$("#content").removeClass("fullscreen");
                //$("#content").addClass("content");
                $("#header").show();
                $("#navigate").show();
                $("wrapper").show();

                //$(".content-wrapper").css("margin-left","50px");
                $("#logoToggle").slideToggle();
                //$("#contentWrapper").addClass("margin-left:50px");
                //$("#contentWrapper").addClass("!important");

                $("#contentWrapper").addClass("content-wrapper");



                //50px!important

            }else{//全屏
                //$("#content").removeClass("content");
                //$("#content").addClass("fullscreen");

                $("#header").hide();
                $("#navigate").hide();
                $("wrapper").hide();

                $("#contentWrapper").removeClass("content-wrapper");
                $("#contentWrapper").css("background-color", "#ecf0f5");

                $("#logoToggle").slideToggle();

            }
        }
    </script>
</head>
<body class="skin-blue sidebar-mini">
<div class="wrapper">
    <div id="header">
        <jsp:include page="../common/head.jsp"/>
        <jsp:include page="../common/navigate.jsp"/>
    </div>
    <!-- Content Wrapper. Contains page content -->
    <!-- 主内容div -->
    <!-- Content Wrapper. Contains page content -->
    <div id="contentWrapper" class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                设备告警
                <%--<small>Preview page</small>--%>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/dashboard/ac.htm"><i class="fa fa-dashboard"></i> 监控</a></li>
                <li class="active">设备告警</li>&nbsp;&nbsp;
                <a href="javascript:" onclick="fullScreen(1)" data-toggle="offcanvas">全屏</a>
                <a href="javascript:" onclick="fullScreen(0)" data-toggle="offcanvas">恢复</a>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </ol>
        </section>

        <!-- Main content -->
        <section id="content" class="content">

            <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-red"><i class="fa fa-star-o"></i></span>

                        <input type="hidden" name="almLevel" id="almLevel" />
                        <input type="hidden" name="almStatus" id="almStatus" />
                        <input type="hidden" name="curPage" id="curPage" />

                        <div class="info-box-content" style="">
                            <span class="info-box-text">严重告警</span>
                            &nbsp;&nbsp;待处理: <a href="javascript:" onclick="showAlarmList(1, 0, 0);"><span id="level1NumActive">
                                ${level1NumActive}</span></a>
                            <br>
                            &nbsp;&nbsp;已处理: <a href="#" onclick="showAlarmList(1, 1, 0);"><span id="level1NumInActive">
                                ${level1NumInActive}</span></a>

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
                            &nbsp;&nbsp;待处理: <a href="#:" onclick="showAlarmList(2, 0, 0);"><span id="level2NumActive">
                            ${level2NumActive}</span></a>
                            <br>
                            &nbsp;&nbsp;已处理: <a href="#" onclick="showAlarmList(2, 1, 0);"><span id="level2NumInActive">
                            ${level2NumInActive}</span></a>
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
                            &nbsp;&nbsp;待处理: <a href="#" onclick="showAlarmList(3, 0, 0);"><span id="level3NumActive">
                            ${level3NumActive}</span></a>
                            <br>
                            &nbsp;&nbsp;已处理: <a href="#" onclick="showAlarmList(3, 1, 0);"><span id="level3NumInActive">
                            ${level3NumInActive}</span></a>
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
                <!-- Modal -->
                <div id="activeAlarmModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="activeAlarmLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="activeAlarmLabel">告警列表</h4>
                            </div>
                            <div class="modal-body">
                                <%--<div class="box">--%>
                                    <div class="box-body">
                                        <table id="activeAlarmTab" class="table table-bordered">
                                            <thead>
                                                <tr class='danger'>
                                                    <th>发生事件</th>
                                                    <th>设备厂家</th>
                                                    <th>告警类型</th>
                                                    <th>设备IP</th>
                                                    <th>告警信息</th>
                                                    <th>操作</th>
                                                </tr>
                                            </thead>
                                            <tbody id="activeAlarmTabBody">

                                            </tbody>
                                        </table>
                                    </div><!-- /.box-body -->
                                    <div class="box-footer clearfix">
                                        <ul class="pagination pagination-sm no-margin pull-right">
                                            <li><a href="#" onclick="getAlarmPage(-2);">&laquo;</a></li>
                                            <li><a href="#" onclick="getAlarmPage(1);">1</a></li>
                                            <li><a href="#" onclick="getAlarmPage(2);">2</a></li>
                                            <li><a href="#" onclick="getAlarmPage(3);">3</a></li>
                                            <li><a href="#" onclick="getAlarmPage(-1);">&raquo;</a></li>
                                        </ul>
                                    </div>
                                <%--</div><!-- /.box -->--%>
                                <%--<div class="table-responsive">--%>
                                <%--<table id="activeAlarmTab" class="table table-striped table-condensed">--%>
                                    <%--<thead>--%>
                                        <%--<tr class='danger'>--%>
                                            <%--<th>发生事件</th>--%>
                                            <%--<th>设备厂家</th>--%>
                                            <%--<th>告警类型</th>--%>
                                            <%--<th>设备IP</th>--%>
                                            <%--<th>告警信息</th>--%>
                                            <%--<th>操作</th>--%>
                                        <%--</tr>--%>
                                    <%--</thead>--%>
                                    <%--<tbody id="activeAlarmTabBody">--%>

                                    <%--</tbody>--%>
                                <%--</table>--%>
                                    <%--</div>--%>
                            </div>
                            <%--<div class="modal-footer">--%>
                                <%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
                                <%--<button type="button" class="btn btn-primary">Save changes</button>--%>
                            <%--</div>--%>
                        </div>
                    </div>
                </div>

                <div id="inactiveAlarmModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="inactiveAlarmLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="inactiveAlarmLabel">已处理告警列表</h4>
                            </div>
                            <div class="modal-body">
                                <div class="box-body">
                                    <table id="inactiveAlarmTab" class="table table-bordered">
                                        <thead>
                                        <tr class='danger'>
                                            <th>发生事件</th>
                                            <th>设备厂家</th>
                                            <th>告警类型</th>
                                            <th>设备IP</th>
                                            <th>告警信息</th>
                                        </tr>
                                        </thead>
                                        <tbody id="inactiveAlarmTabBody">

                                        </tbody>
                                    </table>
                                </div><!-- /.box-body -->
                                <div class="box-footer clearfix">
                                    <ul class="pagination pagination-sm no-margin pull-right">
                                        <li><a href="#" onclick="getAlarmPage(-2);">&laquo;</a></li>
                                        <li><a href="#" onclick="getAlarmPage(1);">1</a></li>
                                        <li><a href="#" onclick="getAlarmPage(2);">2</a></li>
                                        <li><a href="#" onclick="getAlarmPage(3);">3</a></li>
                                        <li><a href="#" onclick="getAlarmPage(-1);">&raquo;</a></li>
                                    </ul>
                                </div>
                                <%--<div class="table-responsive">--%>
                                    <%--<table id="inactiveAlarmTab" class="table table-striped table-condensed">--%>
                                        <%--<thead>--%>
                                        <%--<tr class='danger'>--%>
                                            <%--<th>发生事件</th>--%>
                                            <%--<th>设备厂家</th>--%>
                                            <%--<th>告警类型</th>--%>
                                            <%--<th>设备IP</th>--%>
                                            <%--<th>告警信息</th>--%>
                                        <%--</tr>--%>
                                        <%--</thead>--%>
                                        <%--<tbody id="inactiveAlarmTabBody">--%>

                                        <%--</tbody>--%>
                                    <%--</table>--%>
                                <%--</div>--%>
                            </div>
                            <%--<div class="modal-footer">--%>
                                <%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
                                <%--<button type="button" class="btn btn-primary">Save changes</button>--%>
                            <%--</div>--%>
                        </div>
                    </div>
                </div>
            </div>

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
                                    告警类型
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

    var infoSocket = null;
    var countSocket = null;

    window.onload = function() {
        infoSocket = new SockJS('/alarmInfoSocket');
        infoSocket.onopen = function() {
            console.log('Info: Alarm Info WebSocket connection opened.');
            infoSocket.send("ping");
        };
        infoSocket.onmessage = function(event) {
            //log('Received: ' + event.data);
            //console.log("receiver: " + event.data)

            var message = JSON.parse(event.data);
            appendAlarm(message);
        };
        infoSocket.onclose = function() {
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
            $("#level1NumInActive").text(message[1]);
            $("#level2NumActive").text(message[2]);
            $("#level2NumInActive").text(message[3]);
            $("#level3NumActive").text(message[4]);
            $("#level3NumInActive").text(message[5]);
        };
        countSocket.onclose = function() {
            console.log('Info: WebSocket connection closed.');
        };
    }

    window.onunload = function(){
        if(infoSocket != null){
            infoSocket.close();
        }

        if(countSocket != null){
            countSocket.close();
        }
    }

    function appendAlarm(message) {

        var log = $('#log');
        var showNum = $('#showNum').val();

        var len=$("#alarmTab tr").length;
        while(len > showNum){
            $("#alarmTab tr:last").remove();
            len--;
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
