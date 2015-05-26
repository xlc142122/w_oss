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
    <title>OnlineUser</title>
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

        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                在线用户维护
            </h1>
            <ol class="breadcrumb">
                <li><a href="/onlineuser/find.htm"><i class="fa fa-dashboard"></i> 维护工具</a></li>
                <li class="active">在线用户维护</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <form action="/onlineuser/find.htm" method="post">
                                <div class="col-xs-3">
                                    <input type="text" id="mac" name="mac" class="form-control" placeholder="Mac地址">
                                </div>
                                <div class="col-xs-3">
                                    <input type="text" id="userid" name="userid" class="form-control" placeholder="手机号码">
                                </div>
                                <div class="col-xs-1">
                                    <button class="btn btn-block btn-primary" type="submit">查询</button>
                                </div>
                            </form>
                        </div><!-- /.box-header -->

                        <div class="box-body">
                            <table id="mwltab" class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>Mac地址</th>
                                    <th>用户ID</th>
                                    <th>SSID</th>
                                    <th>上线时间</th>
                                    <th>到期时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>Trident</td>
                                    <td>Internet
                                        Explorer 4.0</td>
                                    <td>Win 95+</td>
                                    <td> 4</td>
                                    <td>X</td>
                                    <td>
                                        <a href="#">查看</a>&nbsp;&nbsp;
                                        <a href="#" class="text-red">删除</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Trident</td>
                                    <td>Internet
                                        Explorer 5.0</td>
                                    <td>Win 95+</td>
                                    <td>5</td>
                                    <td>C</td>
                                    <td>
                                        <a href="#">查看</a>&nbsp;&nbsp;
                                        <a href="#" class="text-red">删除</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Trident</td>
                                    <td>Internet
                                        Explorer 5.5</td>
                                    <td>Win 95+</td>
                                    <td>5.5</td>
                                    <td>A</td>
                                    <td>
                                        <a href="#">查看</a>&nbsp;&nbsp;
                                        <a href="#" class="text-red">删除</a>
                                    </td>
                                </tr>

                                </tbody>
                                <%--<tfoot>--%>
                                <%--<tr>--%>
                                    <%--<th>Rendering engine</th>--%>
                                    <%--<th>Browser</th>--%>
                                    <%--<th>Platform(s)</th>--%>
                                    <%--<th>Engine version</th>--%>
                                    <%--<th>CSS grade</th>--%>
                                <%--</tr>--%>
                                <%--</tfoot>--%>
                            </table>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->


                    <!-- /.box -->
                </div><!-- /.col -->
            </div><!-- /.row -->
        </section><!-- /.content -->

    </div>
    <!-- /.content-wrapper -->
    <jsp:include page="../common/footer.jsp"/>

    <div class='control-sidebar-bg'></div>
</div>

<jsp:include page="../common/include-body.jsp" />

<!-- page script -->
<script type="text/javascript">
    navControl('mtctree','mtcOnline');

    $(function () {
        //$("#example1").dataTable();
        $('#mwltab').dataTable({
            "bPaginate": true,
            "bLengthChange": false,
            "bFilter": false,
            "bSort": true,
            "bInfo": true,
            "bAutoWidth": false
        });
    });

</script>
</body>
</html>
