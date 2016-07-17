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
    <link rel="stylesheet" href="/static/plugins/simditor/styles/simditor.css">
    <link rel="stylesheet" href="/static/plugins/webuploader/webuploader.css">
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
                            <button class="btn btn-danger btn-xs" id="delSales">删除</button>
                        </shiro:hasRole>
                    </div>

                </div>
                <div class="box-body">
                    <table class="table">
                        <tr>
                            <td style="width: 100px;">客户名称</td>
                            <td style="width: 200px;"><a href="/customer/${sales.custid}"
                                                         target="_blank">${sales.custname}</a></td>
                            <td style="width: 100px;">价值</td>
                            <td style="width: 200px;">￥<fmt:formatNumber value="${sales.price}"/></td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">当前进度</td>
                            <td style="width: 200px;">${sales.progress}&nbsp;<a href="javascript:;"
                                                                                id="editProgress">修改</a></td>
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
                            <div class="box-tools">
                                <button class="btn btn-xs btn-success" id="newLogBtn"><i class="fa fa-plus"></i>新增记录
                                </button>
                            </div>
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
                                            <span class="time"><i class="fa fa-clock-o"></i><span class="timeago"
                                                                                                  title="${log.createtime}"></span></span>
                                            <h3 class="timeline-header no-border">
                                                    ${log.context}
                                            </h3>
                                        </div>
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
                            <div class="box-tools">
                                <div id="uploadBtn"><span class="text"><i class="fa fa-upload"></i></span></div>
                            </div>
                        </div>

                        <div class="box-body" style="text-align: center">
                            <ul class="list-unstyled files">
                                <c:if test="${empty salesFileList}">
                                    <li>暂无资料</li>
                                </c:if>
                                <c:forEach items="${salesFileList}" var="file">
                                    <li style="text-align: left"><a href="/sales/file/${file.id}/download">${file.name}</a></li>
                                </c:forEach>
                            </ul>
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
    <div class="modal fade" id="newLogModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">新增跟进</h4>
                </div>
                <div class="modal-body">
                    <form id="newLogForm" action="/sales/log/new" method="post">
                        <input type="hidden" name="salesid" value="${sales.id}">
                        <div class="form-group">
                            <textarea name="context" id="context"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="saveLogBtn">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="modal fade" id="progressModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">新增跟进</h4>
                </div>
                <div class="modal-body">
                    <form id="progressForm" action="/sales/progress/edit" method="post">
                        <input type="hidden" name="id" value="${sales.id}">
                        <div class="form-group">
                            <label>当前进度</label>
                            <select name="progress" class="form-control">
                                <option value="初次接触">初次接触</option>
                                <option value="确定意向">确定意向</option>
                                <option value="提供合同">提供合同</option>
                                <option value="交易完成">交易完成</option>
                                <option value="交易搁置">交易搁置</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="saveProgress">保存</button>
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
<script src="/static/plugins/timeago/timeago.js"></script>
<script src="/static/plugins/timeago/timeago_zh_cn.js"></script>
<script src="/static/plugins/simditor/scripts/module.min.js"></script>
<script src="/static/plugins/simditor/scripts/hotkeys.min.js"></script>
<script src="/static/plugins/simditor/scripts/uploader.min.js"></script>
<script src="/static/plugins/simditor/scripts/simditor.js"></script>
<script src="/static/plugins/webuploader/webuploader.min.js"></script>
<script>
    $(function () {

        $(".timeago").timeago();
        var edit = new Simditor({
            textarea: $("#context"),
            placeholder: '请输入跟进内容',
            toolbar: false
        });

        $("#newLogBtn").click(function () {
            $("#newLogModal").modal({
                show: true,
                backdrop: 'static'
            });
        });
        $("#saveLogBtn").click(function () {
            if (edit.getValue()) {
                $("#newLogForm").submit();
            } else {
                edit.focus();
            }
        });
        $("#editProgress").click(function () {
            $("#progressModal").modal({
                show: true,
                backdrop: 'static'
            });
        });
        $("#saveProgress").click(function () {
            $("#progressForm").submit();
        });

        var uploader = WebUploader.create({
            swf:"/static/plugins/webuploader/Uploader.swf",
            pick:"#uploadBtn",
            server:"/sales/file/upload",
            fileVal:"file",
            formData:{"salesid":"${sales.id}"},
            auto:true
        });
        uploader.on("startUpload",function(){
            $("#uploadBtn .text").html('<i class="fa fa-spinner fa-spin"></i>');
        });
        uploader.on("uploadSuccess",function(file,data){
            if (data._raw=="success"){
                window.history.go(0);
            }
        });
        upload.on("uploadError",function(file){
            alert("文件上传失败")
        });
        upload.on("updateComplete",function(file){
            $("#uploadBtn .text").html('<i class="fa fa-upload"></i>').removeAttr("disabled");
        });
    });
</script>
</body>
</html>

