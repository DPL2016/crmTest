<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM 客户信息</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/static/plugins/fontawesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="/static/plugins/ionicons-2.0.1/css/ionicons.min.css">

    <!-- Theme style -->
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="/static/dist/css/skins/skin-blue.min.css">
    <link rel="stylesheet" href="/static/plugins/fullcalendar/fullcalendar.css">
    <link rel="stylesheet" href="/static/plugins/datepicker/datepicker3.css">
    <link rel="stylesheet" href="/static/plugins/colorpicker/bootstrap-colorpicker.min.css">
</head>

<body class="hold-transition skin-blue  sidebar-mini">
<div class="wrapper">


    <%@include file="../include/header.jsp" %>
    <jsp:include page="../include/leftside.jsp">
        <jsp:param name="menu" value="task"/>
    </jsp:include>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" style="background-image: url(/static/dist/img/asanoha-400px.png)">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>　</h1>
            <ol class="breadcrumb" style="background-color: transparent">
                <li><a href="/home"><i class="fa fa-dashboard"></i>首页</a></li>
                <li class="active">待办事项</li>
            </ol>
            <div class="row">
                <div class="col-md-8">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">所有代办事项</h3>
                        </div>

                        <div class="box-body" id="calendar">

                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="box box-default">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa fa-calendar-check-o"></i>待办事项</h3>
                        </div>
                        <div class="box-body">
                            <h5>暂无代办事项</h5>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <!-- /.content-wrapper -->
    <div class="modal fade" id="newTaskModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">新增代办事项</h4>
                </div>
                <div class="modal-body">
                    <form id="newTaskForm" action="/task/new" method="post">
                        <div class="form-group">
                            <label>待办内容</label>
                            <input type="text" class="form-control" name="title" id="title">
                        </div>
                        <div class="form-group">
                            <label>开始时间</label>
                            <div class="input-group date">
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                                <input type="text" class="form-control pull-right" id="startDate">
                            </div>
                        </div>
                        <div class="form-group">
                            <label>结束时间</label>
                            <div class="input-group date">
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                                <input type="text" class="form-control pull-right" id="endDate">
                            </div>
                        </div>
                        <div class="form-group">
                            <label>提醒时间</label>
                            <div>
                                <select>
                                    <option></option>
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                    <option>6</option>
                                    <option>7</option>
                                    <option>8</option>
                                    <option>9</option>
                                    <option>10</option>
                                    <option>11</option>
                                    <option>0</option>
                                </select> :
                                <select>
                                    <option></option>
                                    <option>05</option>
                                    <option>10</option>
                                    <option>15</option>
                                    <option>20</option>
                                    <option>25</option>
                                    <option>30</option>
                                    <option>35</option>
                                    <option>40</option>
                                    <option>45</option>
                                    <option>50</option>
                                    <option>55</option>
                                    <option>00</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>显示颜色</label>
                            <input type="text" class="form-control my-colorpicker1 colorpicker-element" id="color">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="modal fade" id="eventTaskModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">查看代办事项</h4>
                </div>
                <div class="modal-body">
                    <form id="eventTaskForm">
                        <div class="form-group">
                            <label>待办内容</label>
                            <div>

                            </div>
                        </div>
                        <div class="form-group">
                            <label>开始时间 ~ 结束时间</label>
                            <div class="input-group date">
                                <div><span></span>~<span></span></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>提醒时间</label>
                            <div>

                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-danger" id="delBtn"><i class="fa fa-trash"></i> 删除</button>
                    <button type="button" class="btn btn-primary" id="doneBtn"><i class="fa fa-check"></i> 标记为已完成</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>

<!-- jQuery 2.2.3 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script src="/static/plugins/fullcalendar/lib/moment.min.js"></script>
<script src="/static/plugins/fullcalendar/fullcalendar.js"></script>
<script src="/static/plugins/fullcalendar/lang/zh-cn.js"></script>
<script src="/static/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="/static/plugins/datepicker/locales/bootstrap-datepicker.zh-CN.js"></script>
<script src="/static/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<style>

</style>
<script>
    $(function () {
        $('#calendar').fullCalendar({
            dayClick: function (date, jsEvent, view) {
                $("#newTaskForm")[0].reset();
                $("#startDate").val(date.format());
                $("#endDate").val(date.format());
                $("#newTaskModal").modal({
                    show: true,
                    backdrop: 'static',
                    keboard: false
                });
            },
            eventClick:function(calEvent, jsEvent, view){
                $("#eventModal").modal({
                    show:true,
                    backdrop:'static'
                });
            },
            events:"/task/load",
        });

        $('#startDate').datepicker({
            todayHighlight: true,
            language: "zh-CN",
            autoclose: true
        });
        $('#endDate').datepicker({
            todayHighlight: true,
            language: "zh-CN",
            autoclose: true
        });
        $(".my-colorpicker1").colorpicker({
            color:'#61a5e8'
        });
    });
</script>
</body>
</html>

