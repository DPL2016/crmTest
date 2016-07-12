<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>DwT CRM Log in</title>
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
    <!-- iCheck -->
    <link rel="stylesheet" href="/static/plugins/iCheck/square/blue.css">

    <![endif]-->
</head>
<body class="hold-transition login-page" style="background-image:url(/static/dist/img/reactivex_bg.jpg)">
<div class="navbar" style="margin-left: 50px">
    <a class="navbar-brand" href="/" style="color:white"><img src="/static/dist/img/Rx_Icon.png" style="height:90%;" alt="" /> DwT CRM</a>
</div>
<div class="login-box">
    <div class="login-logo">
        <a href="../../index2.html" style="color: #ffffff"><b>DwT </b>CRM</a>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body" style="background-color: transparent">
        <c:if test="${not empty message}">
            <c:choose>
                <c:when test="${message.state=='success'}">
                    <div class="alert alert-success">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        ${message.message}
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-danger">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                            ${message.message}
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
        <form action="/" method="post" >
            <div id="username" class="form-group has-feedback ipt" style="border: #00ab1b 2px solid;">
                <input type="text" class="form-control" autofocus name="username" placeholder="账号">
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div id="password" class="form-group has-feedback ipt" style="border: #00ab1b 2px solid;">
                <input type="password" class="form-control" name="password" placeholder="密码">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="row">
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        <label>
                            <input type="checkbox"> 记住我
                        </label>
                    </div>
                </div>
                <!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">登录</button>
                </div>
                <!-- /.col -->
            </div>
        </form>

        <a href="#">忘记密码</a><br>

    </div>
    <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 2.2.3 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="/static/plugins/iCheck/icheck.min.js"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
</script>
</body>
</html>

