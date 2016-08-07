<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>DwT | 客户信息</title>
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
                        <div class="box box-solid">
                            <div class="box-header with-border">
                                <h3 class="box-title"><i class="fa fa-calendar-check-o"></i>我的超时事项</h3>

                                <div class="box-tools">
                                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="box-body no-padding" style="display: block;">
                                <ul class="nav nav-pills nav-stacked todo-list">
                                    <c:forEach items="${timeoutTaskList}" var="task">
                                        <li>

                                            <span class="text">${task.title}</span>
                                            <div class="tools">
                                                <i rel="${task.id}" class="fa  fa-check-square-o" id="done" style="color: #008d4c"></i>
                                                <i rel="${task.id}" class="fa fa-trash-o" id="del"></i>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <!-- /.box-body -->
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
                                <input type="text" class="form-control pull-right" name="start" id="startDate">
                            </div>
                        </div>
                        <div class="form-group">
                            <label>结束时间</label>
                            <div class="input-group date">
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                                <input type="text" class="form-control pull-right" name="end" id="endDate">
                            </div>
                        </div>
                        <div class="form-group">
                            <label>提醒时间</label>
                            <div>
                                <select name="hour" style="width: 100px">
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
                                    <option>12</option>
                                    <option>13</option>
                                    <option>14</option>
                                    <option>15</option>
                                    <option>16</option>
                                    <option>17</option>
                                    <option>18</option>
                                    <option>19</option>
                                    <option>20</option>
                                    <option>21</option>
                                    <option>22</option>
                                    <option>23</option>
                                    <option>0</option>
                                </select> :
                                <select name="min" style="width: 100px">
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
                            <input type="text" class="form-control my-colorpicker1 colorpicker-element" name="color" id="color">
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
                        <input type="hidden" id="event_id">
                        <div class="form-group">
                            <label>待办内容</label>
                            <div id="event_title"></div>
                        </div>
                        <div class="form-group">
                            <label>开始日期 ~ 结束时间</label>
                            <div><span id="event_start"></span>  ~  <span id="event_end"></span></div>
                        </div>
                        <div class="form-group">
                            <label>提醒时间</label>
                            <div id="event_remindtime"></div>
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
<script src="/static/plugins/fullcalendar/fullcalendar.min.js"></script>
<script src="/static/plugins/fullcalendar/lang/zh-cn.js"></script>
<script src="/static/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="/static/plugins/datepicker/locales/bootstrap-datepicker.zh-CN.js"></script>
<script src="/static/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<style>

</style>
<script>
    $(function () {

        var _event = null;
        var $calendar = $('#calendar');
        $calendar.fullCalendar({
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
                //alert(calEvent.id + " : " + calEvent.title);
                _event = calEvent;
                $("#event_id").val(calEvent.id);
                $("#event_title").text(calEvent.title);
                $("#event_start").text(moment(calEvent.start).format("YYYY-MM-DD"));
                $("#event_end").text(moment(calEvent.end).format("YYYY-MM-DD"));
                if(calEvent.remindertime) {
                    $("#event_remindtime").text(calEvent.remindertime);
                } else {
                    $("#event_remindtime").text('无');
                }

                $("#eventTaskModal").modal({
                    show:true,
                    backdrop:'static'
                });
                if (calEvent.done==1){
                    $("#doneBtn").hide();
                }else {
                    $("#doneBtn").show();
                }
            },
            events:"/task/load"
        });

        $('#startDate,#endDate').datepicker({
            format: 'yyyy-mm-dd',
            todayHighlight: true,
            language: "zh-CN",
            autoclose: true
        });

        $(".my-colorpicker1").colorpicker({
            color:'#61a5e8'
        });
        $("#saveBtn").click(function(){
            if(!$("#title").val()) {
                $("#title").focus();
                return;
            }
            if(moment($("#startDate").val()).isAfter(moment($("#endDate").val()))) {
                alert("结束时间必须大于开始时间");
                return;
            }
            $.post("/task/new",$("#newTaskForm").serialize()).done(function(result){
                if(result.state == "success") {
                    $calendar.fullCalendar( 'renderEvent', result.data );
                    $("#newTaskModal").modal('hide');
                    window.history.go(0);
                }
            }).fail(function(){
                alert("服务器异常")
            });
        });

        //删除日程
        $("#delBtn").click(function(){
            var id  = $("#event_id").val();
            if (confirm("确认要删除吗？")){
                $.get("/task/del/"+id).done(function(data){
                    if ("success"==data){
                        $calendar.fullCalendar('removeEvents',id);
                        $("#eventTaskModal").modal('hide');
                        window.history.go(0);
                    }
                }).fail(function(){
                    alert("服务器异常");
                });
            }
        });

        $("#del").click(function(){
            var id = $("#del").attr("rel");
            if(confirm("确认要删除吗？")){
                $.get("/task/del/"+id).done(function(data){
                    if ("success"==data){
                        $calendar.fullCalendar('removeEvents',id);
                        $("#eventTaskModal").modal('hide');
                        window.history.go(0);
                    }
                }).fail(function(){
                    alert("服务器异常");
                });
            }
        });

        //将日程标记为已完成
        $("#doneBtn").click(function(){
            var id  = $("#event_id").val();
            $.post("/task/"+id+"/done").done(function(result){
                if (result.state=="success"){
                    _event.color="#cccccc";
                    $calendar.fullCalendar('updateEvent',_event);
                    $("#eventTaskModal").modal('hide');

                }
            }).fail(function(){
                alert("服务器异常")
            });
        });
        $("#done").click(function(){
            var id = $("#done").attr("rel");
            if(confirm("确认要标记为已完成？")){
                $.post("/task/"+id+"/done").done(function(result){
                    if (result.state=="success"){
                        _event.color="#cccccc";
                        $calendar.fullCalendar('updateEvent',_event);
                        $("#eventTaskModal").modal('hide');
                    }
                }).fail(function(){
                    alert("服务器异常")
                });
            }
        });
    });
</script>
</body>
</html>

