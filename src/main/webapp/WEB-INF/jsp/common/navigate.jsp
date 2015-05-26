<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="main-sidebar">
<section class="sidebar">

  <form action="#" method="get" class="sidebar-form">
    <div class="input-group">
      <input type="text" name="q" class="form-control" placeholder="Search..."/>
              <span class="input-group-btn">
                <button type='submit' name='search' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
    </div>
  </form>
<ul class="sidebar-menu">
  <li class="header">Navigation</li>
  <li id="dashtree" class="treeview">
    <a href="#">
      <i class="fa fa-dashboard"></i> <span>监控</span>
      <i class="fa fa-angle-left pull-right"></i>
    </a>
    <ul class="treeview-menu">
      <li id="dashAlarm">
        <a href="/dashboard/index.htm"><i class="fa fa-circle-o"></i>告警总览</a>
      </li>
      <li id="dashAc">
        <a href="/dashboard/ac.htm"><i class="fa fa-circle-o"></i>AC告警</a>
      </li>
      <li id="dashServer">
        <a href="/dashboard/server.htm"><i class="fa fa-circle-o"></i>服务器告警</a>
      </li>
      <li id="dashSms">
        <a href="/dashboard/sms.htm"><i class="fa fa-circle-o"></i>短信网关告警</a>
      </li>
    </ul>
  </li>

  <li id="stattree" class="treeview">
    <a href="#">
      <i class="fa fa-pie-chart"></i> <span>统计</span>
      <i class="fa fa-angle-left pull-right"></i>
    </a>
    <ul class="treeview-menu">
      <li id="statScreen">
        <a href="/stat/index.htm"><i class="fa fa-circle-o"></i>用户统计总览</a>
      </li>
      <li id="statCurOnline">
        <a href="#" onclick="navControl('stattree','statCurOnline');"><i class="fa fa-circle-o"></i>今日在线用户</a>
      </li>
      <li id="statCurIncr">
        <a href="#" onclick="navControl('stattree','statCurIncr');"><i class="fa fa-circle-o"></i>今日新增用户</a>
      </li>
      <li id="statHisOnline">
        <a href="#" onclick="navControl('stattree','statHisOnline');"><i class="fa fa-circle-o"></i>历史在线用户</a>
      </li>
      <li id="statHisIncr">
        <a href="#" onclick="navControl('stattree','statHisIncr');"><i class="fa fa-circle-o"></i>历史新增用户</a>
      </li>
    </ul>
  </li>

  <li id="mtctree" class="treeview">
    <a href="/mwl/list.htm">
      <i class="fa fa-edit"></i> <span>维护工具</span>
      <i class="fa fa-angle-left pull-right"></i>
    </a>
    <ul class="treeview-menu">
      <li id="mtcWhl"><a href="/mwl/list.htm"><i class="fa fa-circle-o"></i> Mac白名单维护</a></li>
      <li id="mtcOnline"><a href="/onlineuser/find.htm"><i class="fa fa-circle-o"></i> 在线用户维护</a></li>
      <li id="mtcUser"><a href="#" onclick="navControl('mtctree','mtcUser');"><i class="fa fa-circle-o"></i> 用户信息维护</a></li>
    </ul>
  </li>
</ul>
</section>
</aside>