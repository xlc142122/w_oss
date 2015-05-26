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

    <jsp:include page="../common/include-header.jsp" />
</head>
<body class="skin-blue sidebar-mini">
<div class="wrapper">
    <jsp:include page="../common/head.jsp" />
    <jsp:include page="../common/navigate.jsp"/>

    <!-- Content Wrapper. Contains page content -->
    <!-- 主内容div -->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                告警总览
                <small>AC、Server、Sms...</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/dashboard/index.htm"><i class="fa fa-dashboard"></i> 监控</a></li>
                <li class="active">告警总览</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-red"><i class="fa fa-star-o"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">AC错误</span>
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
                            <span class="info-box-text">AC警告</span>
                            <span class="info-box-number">13,648</span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>
                <!-- /.col -->
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-red"><i class="fa fa-star-o"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text">服务器Down</span>
                            <span class="info-box-number">
                                 <a href="#">2</a>
                            </span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                    <!-- /.info-box -->
                </div>
                <!-- /.col -->
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box">
                        <span class="info-box-icon bg-red"><i class="fa fa-star-o"></i></span>

                        <div class="info-box-content">
                            <span class="info-box-text"><b>短信发送失败</b></span>
                            <span>
                                <small>
                                今日总计: <a href="#">5</a><br>
                                当月总计: <a href="#">50</a>
                                </small>
                            </span>
                        </div>
                        <!-- /.info-box-content -->
                    </div>
                </div>


                <!-- /.col -->
            </div>
            <!-- /.row -->

            <!-- =========================================================== -->

            <div class="row">

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
<jsp:include page="../common/include-body.jsp" />

<script type="text/javascript">
    navControl('dashtree','dashAlarm');
</script>
</body>
</html>
