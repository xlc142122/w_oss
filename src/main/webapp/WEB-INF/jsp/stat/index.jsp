<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <title>统计总览</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'/>

    <jsp:include page="../common/include-header.jsp"/>


</head>
<body class="skin-blue sidebar-mini">
<div class="wrapper">

    <jsp:include page="../common/head.jsp" />
    <jsp:include page="../common/navigate.jsp"/>


    <!-- Content Wrapper. Contains page content -->
    <!-- 主内容div -->
    <div class="content-wrapper">
        <section class="content">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-lg-4 col-xs-6">
                    <!-- small box -->
                    <div class="small-box bg-aqua">
                        <div class="inner">
                            <h3>${portalUserCount}</h3>

                            <p>Portal在线用户</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-at"></i>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-xs-6">
                    <!-- small box -->
                    <div class="small-box bg-yellow">
                        <div class="inner">
                            <h3>${wechatUserCount}</h3>

                            <p>微信在线用户</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-person-add"></i>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-xs-6">
                    <!-- small box -->
                    <div class="small-box bg-red">
                        <div class="inner">
                            <h3>${appUserCount}</h3>

                            <p>App在线用户</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-playstation"></i>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.row -->
            <!-- Main row -->
            <div class="row">
                <!-- Left col -->
                <section class="col-lg-12">
                    <!-- Custom tabs (Charts with tabs)-->
                    <div class="nav-tabs-custom">
                        <!-- Tabs within a box -->
                        <ul class="nav nav-tabs pull-right">
                            <li class="active">
                                <a href="#onlineUserChart" data-toggle="tab">登录用户</a>
                            </li>
                            <!--<li>-->
                                <!--<a href="#incrUserChart" data-toggle="tab">新增用户</a>-->
                            <!--</li>-->
                            <li class="pull-left header">
                                <i class="fa fa-inbox"></i> 用户统计总览
                            </li>
                        </ul>
                        <div class="tab-content no-padding">
                            <!-- Morris chart - Sales -->
                            <%--<input id="oustime" type="hidden" value="${oustime}"/>--%>
                            <%--<input id="ousportal" type="hidden" value="${ousportal}" />--%>
                            <%--<input id="ouswechat" type="hidden" value="${ouswechat}" />--%>
                            <%--<input id="ousapp" type="hidden" value="${ousapp}" />--%>
                            <div class="chart tab-pane active" id="onlineUserChart" style="height:400px;width: 100%;"></div>
                            <!--<div class="chart tab-pane" id="incrUserChart" style="height:500px;width: 100%;"></div>-->
                        </div>
                    </div>
                    <!-- /.nav-tabs-custom -->


                </section>
                <!-- /.Left col -->

            </div>
            <!-- /.row (main row) -->

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <jsp:include page="../common/footer.jsp" />

    <!-- Add the sidebar's background. This div must be placed
         immediately after the control sidebar -->
    <div class='control-sidebar-bg'></div>
</div>

<jsp:include page="../common/include-body.jsp" />

<script src="../../../echarts/js/echarts.js" type="text/javascript"></script>

<script type="text/javascript">
    navControl('stattree','statScreen');

    // 路径配置
    require.config({
        paths: {
            echarts: '../../../echarts/js'
        }
    });

    // 使用
    require(
        [
            'echarts',
            'echarts/chart/line',
            'echarts/chart/bar'
        ],

        function (ec) {
            // 基于准备好的dom，初始化echarts图表
            var onlineUserChart = ec.init(document.getElementById('onlineUserChart'));

            var option =  {
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    data:['Portal','微信','App']
                },
                toolbox: {
                    show : true,
                    feature : {
                        mark : {show: true},
                        dataView : {show: true, readOnly: true},
                        magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : false,
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                        data : [
                            ${oustime}
                        ]
                    }
                ],
                yAxis : [
                    {
                        type : 'value'
                    }
                ],
                series : [
                    {
                        name:'Portal',
                        type:'line',
                        stack: '总量',
                        symbol: 'none',
                        itemStyle: {
                            normal: {
                                areaStyle: {
                                    color : (function (){
                                        var zrColor = require('zrender/tool/color');
                                        return zrColor.getLinearGradient(
                                                0, 200, 0, 400,
                                                [[0, 'rgba(255,0,0,0.8)'],[0.8, 'rgba(255,255,255,0.1)']]
                                        )
                                    })()
                                }
                            }
                        },
                        data:[
                            ${ousportal}
                        ]
                    },
                    {
                        name:'微信',
                        type:'line',
                        stack: '总量',
                        smooth: true,
                        symbol: 'none',
                        symbolSize: 8,
                        itemStyle: {
                            normal: {
                                color: 'blue',
                                lineStyle: {
                                    width: 2
                                }
                            }
                        },
                        data:[
                            ${ouswechat}
                        ]
                    },
                    {
                        name:'APP',
                        type:'line',
                        stack: '总量',
                        smooth: true,
                        symbol: 'none',
                        symbolSize: 8,
                        itemStyle: {
                            normal: {
                                color: 'green',
                                lineStyle: {
                                    width: 2
                                }
                            }
                        },
                        data:[
                            ${ousapp}
                        ]
                    }
                ]
            };

            onlineUserChart.setOption(option);
            onlineUserChart.setMagicType("tiled");
            window.onresize = onlineUserChart.resize;
        }
    );
</script>
</body>
</html>