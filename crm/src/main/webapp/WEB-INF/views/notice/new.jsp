
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM新建公告</title>
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
    <link rel="stylesheet" href="/static/plugins/simditor/styles/simditor.css">
    <![endif]-->
</head>

<body class="hold-transition skin-blue  sidebar-mini">
<div class="wrapper">


    <%@include file="../include/header.jsp"%>
    <jsp:include page="../include/leftside.jsp">
        <jsp:param name="menu" value="notice"/>
    </jsp:include>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" style="background-image: url(/static/dist/img/asanoha-400px.png)">
        <!-- Content Header (Page header) -->
        <section class="content">
            <ol class="breadcrumb">
                <li><a href="/home"><i class="fa fa-dashboard"></i>主页</a></li>
                <li class="active">新建公告</li>
            </ol>
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">新建公告</h3>
                </div>
                <div class="box-body">
                    <form method="post" id="newForm">
                        <div class="form-group">
                            <label>标题</label>
                            <input type="text" name="title" class="form-control" id="title">
                        </div>
                        <div class="form-group">
                            <label>公告内容</label>
                            <textarea name="context" id="context" rows="10" class="form-control"></textarea>
                        </div>
                    </form>
                    <div class="box-footer">
                        <button id="saveBtn" class="btn btn-primary pull-right">发表</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Main content -->
        <section class="content">

            <!-- Your Page Content Here -->

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 2.2.3 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script src="/static/plugins/simditor/scripts/module.min.js"></script>
<script src="/static/plugins/simditor/scripts/hotkeys.min.js"></script>
<script src="/static/plugins/simditor/scripts/uploader.min.js"></script>
<script src="/static/plugins/simditor/scripts/simditor.min.js"></script>

<script>
    $(function(){
        var edit = new Simditor({
            textarea:$("#context")
        });
        $("#saveBtn").click(function(){
            if (!$("#title").val()){
                $("#title").focus();
                return;
            }
            if (!$("#context").val()){
                $("#context").focus();
                return;
            }
            $("#newForm").submit();
        });
    });
</script>
</body>
</html>

