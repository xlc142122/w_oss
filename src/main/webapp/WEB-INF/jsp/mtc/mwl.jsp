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
    <title>SmartCity</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'/>

    <jsp:include page="../common/include-header.jsp" />

    <style>
        .black_overlay{
            display: none;
            position: absolute;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index:1001;
            -moz-opacity: 0.8;
            opacity:.80;
            filter: alpha(opacity=80);
        }
        .white_content {
            display: none;
            position: absolute;
            top: 10%;
            left: 10%;
            width: 50%;
            height: 350px;
            border: 1px solid lightblue;
            background-color: white;
            z-index:1002;
            overflow: auto;
        }
    </style>
    <script type="text/javascript">
        //弹出隐藏层
        function showAddMacModal(){
            $('#addMacModal').modal('show');
        }

    </script>
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
                Mac白名单维护
            </h1>
            <ol class="breadcrumb">
                <li><a href="/mwl/list.htm"><i class="fa fa-dashboard"></i> 维护工具</a></li>
                <li class="active">Mac白名单维护</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <div class="col-xs-3">
                                <input type="text" id="findMac" name="mac" class="form-control" placeholder="Mac地址">
                            </div>
                            <div class="col-xs-3">
                                <input type="text" id="findMerchant" name="merchant" class="form-control" placeholder="商户名称">
                            </div>
                            <div class="col-xs-1">
                                <button class="btn btn-block btn-primary" onclick="findWhl();">查询</button>
                            </div>
                            <div class="col-xs-1">

                                <button class="btn btn-block btn-primary" onclick="showAddMacModal();">添加</button>
                            </div>
                        </div><!-- /.box-header -->

                        <div id="addMacModal" class="modal">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">添加Mac白名单</h4>
                                    </div>
                                    <div class="modal-body">
                                        <form role="form">
                                            <div class="box-body">
                                                <div class="form-group">
                                                    <label for="addMac">Mac地址</label>
                                                    <input type="text" class="form-control" id="addMac" placeholder="Mac地址">
                                                </div>
                                                <div class="form-group">
                                                    <label for="addMerchant">商户名称</label>
                                                    <input type="text" class="form-control" id="addMerchant" placeholder="商户名称">
                                                </div>
                                                <div class="form-group">
                                                    <label for="addMarket">商场名称</label>
                                                    <input type="text" class="form-control" id="addMarket" placeholder="商场名称">
                                                </div>
                                                <div class="form-group">
                                                    <label for="addSsid">SSID</label>
                                                    <input type="text" class="form-control" id="addSsid" placeholder="SSID">
                                                </div>
                                            </div><!-- /.box-body -->

                                            <div class="box-footer">
                                                <div class="col-xs-3">
                                                    <button class="btn btn-block btn-primary" type="submit">添&nbsp;&nbsp;&nbsp;加</button>
                                                </div>
                                                <div class="col-xs-3">
                                                    <button class="btn btn-block btn-warning" type="reset">重&nbsp;&nbsp;&nbsp;置</button>
                                                </div>
                                            </div>
                                        </form>

                                    </div>
                                    <div class="modal-footer">
                                        <%--<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>--%>
                                        <%--<button type="button" class="btn btn-primary">添&nbsp;&nbsp;&nbsp;加</button>--%>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div>

                        <div class="box-body">
                            <table id="mwltab" class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>Mac地址</th>
                                    <th>SSID</th>
                                    <th>商户名称</th>
                                    <th>商场名称</th>
                                    <th>添加时间</th>
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
<!-- wrapper -->
<jsp:include page="../common/include-body.jsp" />

<script type="text/javascript">
    navControl('mtctree','mtcWhl');

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

    function findWhl(){
        var mac = $("#findMac").val();
        var merchant = $("#findMerchant").val();

        alert("mac = " + mac + ", merchant = " + merchant);
        //查询
    }
</script>
</body>
</html>
