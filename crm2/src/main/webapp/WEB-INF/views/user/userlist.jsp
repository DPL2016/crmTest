<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>DwT CRM用户管理</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="/static/dist/css/AdminLTE.min.css">

    <link rel="stylesheet" href="/static/dist/css/skins/skin-blue.min.css">
    <link rel="stylesheet" href="/static/plugins/datatables/css/dataTables.bootstrap.min.css">
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body class="hold-transition skin-blue  sidebar-mini">
<div class="wrapper">


    <%@include file="../include/header.jsp" %>
    <%@include file="../include/leftside.jsp" %>
    <div class="content-wrapper" style="background-image: url(/static/dist/img/asanoha-400px.png)">

        <section class="content">
            <div class="row">
                <div class="col-xs-12">

            <div class="box box-primary">
                <div class="box-header with-border">
                    <ol class="breadcrumb">
                        <li><a href="/home"><i class="fa fa-dashboard"></i>首页</a></li>
                        <li class="active">所有用户</li>
                    </ol>
                    <h3 class="box-title">用户列表</h3>
                </div>

                <div class="box-body">
                    <table class="table" id="userTable">
                        <div class="box-tools pull-right">
                            <a href="javascript:;" id="newBtn" class="btn btn-xs btn-success"><i class="fa fa-plus"></i> 新增</a>
                        </div>
                        <thead>
                        <tr>
                            <th>用户名</th>
                            <th>真实姓名</th>
                            <th>微信号</th>
                            <th>角色</th>
                            <th>权限</th>
                            <th>创建时间</th>
                            <th>#</th>
                        </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
                </div>
            </div>
        </section>
        <div class="modal fade" id="newModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">新增用户</h4>
                    </div>
                    <div class="modal-body">
                        <form id="newForm">
                            <div class="form-group">
                                <label>账号(用于系统登录)</label>
                                <input type="text" class="form-control" name="username">
                            </div>
                            <div class="form-group">
                                <label>员工姓名(真实姓名)</label>
                                <input type="text" class="form-control" name="realname">
                            </div>
                            <div class="form-group">
                                <label>密码(默认 000000)</label>
                                <input type="text" class="form-control" name="password" value="000000">
                            </div>
                            <div class="form-group">
                                <label>微信号</label>
                                <input type="text" class="form-control" name="weixin">
                            </div>
                            <div class="form-group">
                                <label>角色</label>
                                <select class="form-control" name="roleid">
                                    <c:forEach items="${roleList}" var="role">
                                        <option value="${role.id}">${role.rolename}</option>
                                    </c:forEach>
                                </select>
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
    </div>
</div>
<!-- jQuery 2.2.3 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script src="/static/plugins/datatables/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/datatables/js/dataTables.bootstrap.min.js"></script>
<script src="/static/plugins/moment/moment.min.js"></script>
<script src="/static/plugins/jQuery/"
<script>
    $(function () {
        var dataTable = $("#userTable").DataTable({
            searching: false,
            serverSide: true,
            ajax: "/user/users/load",
            ordering: false,
            "autoWidth": false,
            columns: [
                {"data": "username"},
                {"data": "realname"},
                {"data": "weixin"},
                {"data": "role.rolename"},
                {"data": function(row){
                    if (row.enable){
                        return "<span class='label label-success'>正常</span>"
                    }else {
                        return "<span class='label label-danger'>禁用</span>"
                    }
                }},
                {"data": function(row){
                    var time = moment(row.createtime);
                    return time.format("YYYY-MM-DD HH:mm");
                }},
                {"data":function(row){
                    return "<a class='label label-info' id='edit'>编辑</a>&nbsp;&nbsp;<a class='label label-danger' id='del'>重置密码</a>";
                }}
            ],
            "language": {
                "zeroRecords": "没有匹配的数据",
                "lengthMenu": "显示 _MENU_ 条数据",
                "info": "显示从 _START_ 到 _END_ 条数据 共 _TOTAL_ 条数据",
                "infoFiltered": "(从 _MAX_ 条数据中过滤得来)",
                "loadingRecords": "加载中...",
                "processing": "处理中...",
                "paginate": {
                    "first": "首页",
                    "last": "末页",
                    "next": "下一页",
                    "previous": "上一页"
                }
            }
        });

        $("#newForm").validate({

        });
        $("#newBtn").click(function(){
            $("#newForm")[0].reset();
            $("#newModal").modal({
                show:true,
                backdrop:'static',
                keyboard:false
            });
        });
    });
</script>
</body>
</html>


