<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>DwT CRM文件管理</title>
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
    <link rel="stylesheet" href="/static/plugins/webuploader/webuploader.css">
</head>

<body class="hold-transition skin-blue  sidebar-mini">
<div class="wrapper">


    <%@include file="../include/header.jsp" %>
    <jsp:include page="../include/leftside.jsp">
        <jsp:param name="menu" value="document"/>
    </jsp:include>
    <div class="content-wrapper" style="background-image: url(/static/dist/img/asanoha-400px.png)">

        <section class="content">
            <div class="row">
                <div class="col-xs-12">

                    <div class="box box-primary">
                        <ol class="breadcrumb">
                            <li><a href="/home"><i class="fa fa-dashboard"></i>首页</a></li>
                            <li class="active">文档管理</li>
                        </ol>
                        <div class="box-header with-border">

                            <h3 class="box-title">文档管理-${fid}</h3>
                            <div class="box-tools">
                                <span id="uploadBtn"><span class="text"><i class="fa fa-upload"></i> 上传文件</span></span>
                                <button class="btn btn-bitbucket btn-xs" id="newDir"><i class="fa fa-folder"></i> 新建文件夹
                                </button>
                            </div>
                        </div>

                        <div class="box-body">

                            <table class="table" id="userTable">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>名称</th>
                                    <th>大小</th>
                                    <th>创建人</th>
                                    <th>创建时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:if test="${empty documentList}">
                                    <tr>
                                        <td colspan="5">暂时没有任何数据</td>
                                    </tr>
                                </c:if>
                                <c:forEach items="${documentList}" var="doc">
                                    <tr>
                                        <c:choose>
                                            <c:when test="${doc.type=='dir'}">
                                                <td><i class="fa fa-folder-open-o"></i></td>
                                                <td><a href="/doc?fid=${doc.id}">${doc.name}</a></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td><i class="fa fa-file-o"></i></td>
                                                <td><a href="/doc/download/${doc.id}">${doc.name}</a></td>
                                            </c:otherwise>
                                        </c:choose>
                                        <td>${doc.size}</td>
                                        <td>${doc.createuser}</td>
                                        <td><fmt:formatDate value="${doc.createtime}" pattern="y-M-d H:m" /></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal fade" id="dirModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">新建文件夹</h4>
                                </div>
                                <div class="modal-body">
                                    <form id="saveDirForm" action="/doc/dir/new" method="post">
                                        <input type="hidden" name="fid" value="${fid}">
                                        <div class="form-group">
                                            <label>文件夹名称</label>
                                            <input type="text" class="form-control" name="name" id="dirname">
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="button" id="saveDirBtn" class="btn btn-primary">保存</button>
                                </div>
                            </div>
                        </div><!-- /.modal-dialog -->
                    </div><!-- /.modal -->
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
<script src="/static/plugins/webuploader/webuploader.min.js"></script>
<script>
    $(function () {
        var uploader = WebUploader.create({
            swf:"/static/plugins/webuploader/Uploader.swf",
            pick:"#uploadBtn",
            server:"/doc/file/upload",
            fileVal:"file",
            formData:{"fid":"${fid}"},
            auto:true
        });
        uploader.on("startUpload",function(){
            $("#uploadBtn.text").html('<i class="fa fa-spinner fa-spin"></i> 上传中...');
        });
        uploader.on('uploadSuccess',function(file,data){
            if (data._raw=="success"){
                window.history.go(0);
            }
        });
        uploader.on('uploadError',function(file){
            alert("文件上传失败")
        });
        uploader.on('uploadComplete',function(file){
            $('#uploadBtn.text').html('<i class="fa fa-upload"></i>上传文件').removeAttr("disabled");
        });

        $("#newDir").click(function(){
            $("#dirModal").modal({
                show:true,
                backdrop:'static',
                keyboard:false
            });
        });
        $("#saveDirBtn").click(function(){
            if (!$("#dirname").val()){
                $("#dirname").focus();
                return;
            }
            $("#saveDirForm").submit();
        });
    });
</script>
</body>
</html>


