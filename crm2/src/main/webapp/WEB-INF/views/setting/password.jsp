<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>DwT CRM修改密码</title>
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

    <![endif]-->
</head>

<body class="hold-transition skin-blue  sidebar-mini">
<div class="wrapper">


    <%@include file="../include/header.jsp" %>
    <%@include file="../include/leftside.jsp" %>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" style="background-image: url(/static/dist/img/asanoha-400px.png)">

        <section class="content">
            <div class="row">
                <div class="col-xs-8 col-xs-offset-2">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <ol class="breadcrumb">
                        <li><a href="/home"><i class="fa fa-dashboard"></i>首页</a></li>
                        <li class="active">修改密码</li>
                    </ol>
                    <h3 class="box-title">设置密码</h3>
                </div>
                <div class="box-body">
                    <form method="post" id="changePasswordForm">
                        <div class="form-group">
                            <label>旧密码</label>
                            <input type="password" class="form-control" name="oldpassword">
                        </div>
                        <div class="form-group">
                            <label>新密码</label>
                            <input type="password" class="form-control" name="newpassword" id="newpassword">
                        </div>
                        <div class="form-group">
                            <label>确认密码</label>
                            <input type="password" class="form-control" name="replypassword">
                        </div>
                    </form>
                </div>
                <div class="box-footer">
                    <button id="saveBtn" class="btn btn-primary pull-right">保存</button>
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
<script src="/static/plugins/validate/jquery.validate.min.js"></script>
<script>
    $(function () {
        $("#changePasswordForm").validate({
            errorClass: "text-danger",
            errorElement: "span",
            rules: {
                oldpassword: {
                    required: true,
                    remote: "/user/validate/password"
                },
                newpassword: {
                    required: true,
                    rangelength: [6, 18]
                },
                replypassword: {
                    required: true,
                    rangelength: [6, 18],
                    equalTo: "#newpassword"
                }
            },
            messages: {
                oldpassword: {
                    required: "请输入旧密码",
                    remote: "旧密码错误"
                },
                newpassword: {
                    required: "请输入新密码",
                    rangelength: "密码长度6~18位"
                },
                replypassword: {
                    required: "请输入确认密码",
                    rangelength: "密码长度6~18位",
                    equalTo: "两次密码不一致"
                }
            },
            submitHandler:function(form){
                var password = $('#newpassword').val();
                $.post("/user/password",{"password":password}).done(function(data){
                    if (data=="success"){
                        alert("密码修改成功，请重新登录")
                        window.location.href="/";
                    }
                }).fail(function(){
                    alert("服务器异常")
                });
            }
        });

        $("#saveBtn").click(function(){
            $("#changePasswordForm").submit();
        });
    });
</script>
</body>
</html>


