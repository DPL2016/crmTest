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
                        <thead>
                        <tr>
                            <th>用户名</th>
                            <th>真实姓名</th>
                            <th>微信号</th>
                            <th>角色</th>
                            <th>权限</th>
                            <th>创建时间</th>
                        </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
                </div>
            </div>
        </section>
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
    });
</script>
</body>
</html>


