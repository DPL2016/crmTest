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
    <![endif]-->
</head>

<body class="hold-transition skin-blue  sidebar-mini">
<div class="wrapper">


    <%@include file="../include/header.jsp" %>
    <jsp:include page="../include/leftside.jsp">
        <jsp:param name="menu" value="sales"/>
    </jsp:include>
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" style="background-image: url(/static/dist/img/asanoha-400px.png)">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>　</h1>
            <ol class="breadcrumb" style="background-color: transparent">
                <li><a href="/sales"><i class="fa fa-dashboard"></i>机会列表</a></li>
                <li class="active">${sales.name}</li>
            </ol>
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">
                        ${sales.name}
                    </h3>

                    <div class="box-tools">
                        <shiro:hasRole name="经理">
                            <button class="btn btn-danger btn-xs" id="openCust">删除</button>
                        </shiro:hasRole>
                    </div>

                </div>
                <div class="box-body">
                    <table class="table">
                        <tr>
                            <td style="width: 100px;">客户名称</td>
                            <td style="width: 200px;"><a href="/customer/${sales.custid}" target="_blank">${sales.custname}</a></td>
                            <td style="width: 100px;">价值</td>
                            <td style="width: 200px;">￥<fmt:formatNumber value="${sales.price}"/> </td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">当前进度 </td>
                            <td style="width: 200px;">${sales.progress}&nbsp;<a href="javascript:;">修改</a></td>
                            <td style="width: 100px;">最后跟进时间</td>
                            <td style="width: 200px;">${empty sales.lasttime?'无':sales.lasttime}</td>
                        </tr>

                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-md-8">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">跟进记录</h3>
                        </div>
                        <div class="box-body">
                            <ul class="timeline">
                                <c:forEach items="${salesLogList}" var="log">
                                <li>
                                    <c:choose>
                                        <c:when test="${log.type=='auto'}">
                                            <i class="fa fa-history bg-yellow"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa fa-commenting bg-aqua"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="timeline-item">
                                        <span class="time"><i class="fa fa-clock-o"></i><span class="timeago" rel="${log.createtime}"></span></span>
                                        <h3 class="timeline-header no-border">
                                            ${log.context}
                                        </h3>
                                    </div>
                                </li>
                                    <li>
                                        <i class="fa fa-clock-o bg-gray"></i>
                                    </li>

                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="box box-default">
                        <div class="box-header with-border">
                            <h3 class="box-title"><i class="fa  fa-folder-o"></i>相关资料</h3>
                        </div>
                        <div class="box-body" style="text-align: center">

                        </div>
                    </div>
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
</div>

<!-- jQuery 2.2.3 -->
<script src="/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="/static/dist/js/app.min.js"></script>
<script src="/static/plugins/moment/moment.min.js"></script>

<script>
    $(function () {
        moment.local("zh_cn");
        $(".timeago").text(moment($(".timeago").attr('rel')).fromNow());
    });
</script>
</body>
</html>

