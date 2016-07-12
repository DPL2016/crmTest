<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>DwT CRM用户登录日志</title>
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
    <link rel="stylesheet" href="/static/plugins/datatables/css/dataTables.bootstrap.min.css">
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
                        <li class="active">登录日志</li>
                    </ol>
                    <h3 class="box-title">登录日志列表</h3>

                </div>
                <div class="box-body">
                    <table class="table" id="logTable">
                        <thead>
                        <tr>
                            <th>登录时间</th>
                            <th>登录IP</th>
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
<script>
    $(function () {
        var dataTable = $("#logTable").DataTable({
            searching: false,
            serverSide: true,
            ajax: "/user/log/load",
            ordering: false,
            "autoWidth": false,
            columns: [
                {"data": "logintime"},
                {"data": "loginip"}
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


