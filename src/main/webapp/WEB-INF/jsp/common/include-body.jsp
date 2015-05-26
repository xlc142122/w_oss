<!-- jQuery 2.1.4 -->
<script src="../../../plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.2 -->
<script src="../../../dist/js/jquery-ui.min.js" type="text/javascript"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.2 JS -->
<script src="../../../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!-- Morris.js charts -->
<script src="../../../dist/js/raphael-min.js"></script>
<script src="../../../plugins/morris/morris.min.js" type="text/javascript"></script>
<!-- Sparkline -->
<script src="../../../plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
<!-- jvectormap -->
<script src="../../../plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
<script src="../../../plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
<!-- jQuery Knob Chart -->
<script src="../../../plugins/knob/jquery.knob.js" type="text/javascript"></script>
<!-- daterangepicker -->
<script src="../../../dist/js/moment.min.js" type="text/javascript"></script>
<script src="../../../plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
<!-- datepicker -->
<script src="../../../plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="../../../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
<!-- Slimscroll -->
<script src="../../../plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<!-- FastClick -->
<script src="../../../plugins/fastclick/fastclick.min.js" type="text/javascript"></script>
<!-- AdminLTE App -->
<script src="../../../dist/js/app.min.js" type="text/javascript"></script>

<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="../../../dist/js/pages/dashboard.js" type="text/javascript"></script>

<!-- AdminLTE for demo purposes -->
<script src="../../../dist/js/demo.js" type="text/javascript"></script>

<!-- DATA TABES SCRIPT -->
<script src="../../../plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="../../../plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>

<!--菜单控制-->
<script type="text/javascript">
  //激活选中菜单
  function navControl(navId, menuId) {

    deactiveAllNav();
    $("#" + navId).addClass("active");
    $("#" + menuId).addClass("active");
  }

  //去激活所有NAV的li
  function deactiveAllNav(){
    $("#dashtree").removeClass("active");
    $("#stattree").removeClass("active");
    $("#mtctree").removeClass("active");

    $("#dashAlarm").removeClass("active");
    $("#dashAc").removeClass("active");
    $("#dashServer").removeClass("active");
    $("#dashSms").removeClass("active");

    $("#statScreen").removeClass("active");
    $("#statCurOnline").removeClass("active");
    $("#statCurIncr").removeClass("active");
    $("#statHisOnline").removeClass("active");
    $("#statHisIncr").removeClass("active");

    $("#mtcWhl").removeClass("active");
    $("#mtcOnline").removeClass("active");
    $("#mtcUser").removeClass("active");

  }
</script>