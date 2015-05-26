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
    <title>Sms Alarm</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'/>

    <jsp:include page="../common/include-header.jsp" />
</head>
<body class="skin-blue sidebar-mini">
<div class="wrapper">

    <jsp:include page="../common/head.jsp" />
    <jsp:include page="../common/navigate.jsp"/>

    <!-- Content Wrapper. Contains page content -->
    <!-- 主内容div -->
    <div class="content-wrapper">
        <div id="alarmDashboard">
            <section class="content-header">
                <h1>
                    短信网关告警
                </h1>
                <ol class="breadcrumb">
                    <li><a href="/dashboard/sms.htm"><i class="fa fa-dashboard"></i> 监控</a></li>
                    <li class="active">短信网关告警</li>
                </ol>
            </section>
        </div>

    </div>
    <!-- /.content-wrapper -->
    <jsp:include page="../common/footer.jsp"/>

    <div class='control-sidebar-bg'></div>
</div>
<!-- wrapper -->
<jsp:include page="../common/include-body.jsp" />

<script type="text/javascript">
    navControl('dashtree','dashSms');
</script>
</body>
</html>
