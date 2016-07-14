<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>DwT CRM客户管理</title>
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
    <link rel="stylesheet" href="/static/plugins/datatables/css/dataTables.bootstrap.min.css">
</head>

<body class="hold-transition skin-blue  sidebar-mini">
<div class="wrapper">


    <%@include file="../include/header.jsp" %>
    <jsp:include page="../include/leftside.jsp">
        <jsp:param name="menu" value="customer"/>
    </jsp:include>
    <div class="content-wrapper" style="background-image: url(/static/dist/img/asanoha-400px.png)">

        <section class="content">
            <div class="row">
                <div class="col-xs-12">

                    <div class="box box-primary">
                        <ol class="breadcrumb">
                            <li><a href="/home"><i class="fa fa-home"></i>首页</a></li>

                            <a href="/customer">客户管理</a></li>
                        </ol>
                        <div class="box-header with-border">


                            <h3 class="box-title">客户管理</h3>

                            <div class="box-tools">
                                <button class="btn btn-bitbucket btn-xs" id="newCompany">
                                    <i class="fa fa-users"></i> 新增客户
                                </button>
                            </div>
                        </div>

                        <div class="box-body">

                            <table class="table" id="customerTable">
                                <thead>
                                <tr>
                                    <th style="width:20px;"></th>
                                    <th>客户</th>
                                    <th>电话</th>
                                    <th>地址</th>
                                    <th>微信</th>
                                    <th>邮箱</th>
                                    <th>等级</th>

                                </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal fade" id="companyModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">新增客户</h4>
                                </div>
                                <div class="modal-body">
                                    <form id="saveCompanyForm">
                                            <div class="form-group">
                                                <label>类型</label>
                                                <div>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="type" value="person" checked
                                                               id="radioPerson"> 个人
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="type" value="company"
                                                               id="radioCompany"> 公司
                                                    </label>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>名称</label>
                                                <input type="text" class="form-control" name="name">
                                            </div>
                                            <div class="form-group">
                                                <label>电话</label>
                                                <input type="text" class="form-control" name="tel">
                                            </div>
                                            <div class="form-group">
                                                <label>微信</label>
                                                <input type="text" class="form-control" name="weixin">
                                            </div>
                                            <div class="form-group">
                                                <label>邮箱</label>
                                                <input type="text" class="form-control" name="email">
                                            </div>
                                            <div class="form-group">
                                                <label>地址</label>
                                                <input type="text" class="form-control" name="address">
                                            </div>
                                            <div class="form-group">
                                                <label>等级</label>
                                                <select name="level" class="form-control">
                                                    <option value=""></option>
                                                    <option value="★">★</option>
                                                    <option value="★★">★★</option>
                                                    <option value="★★★">★★★</option>
                                                    <option value="★★★★">★★★★</option>
                                                    <option value="★★★★★">★★★★★</option>
                                                </select>
                                            </div>
                                            <div class="form-group" id="companyList">
                                                <label>所属公司</label>
                                                <select name="companyid" class="form-control">
                                                    <option value=""></option>
                                                    <c:forEach items="${companyList}" var="company">
                                                        <option value="${company.id}">${company.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="button" id="saveCompanyBtn" class="btn btn-primary">保存</button>
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
<script src="/static/plugins/moment/moment.min.js"></script>
<script src="/static/plugins/datatables/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/validate/jquery.validate.min.js"></script>
<script src="/static/plugins/datatables/js/dataTables.bootstrap.min.js"></script>

<script>
    $(function () {

        var dateTable = $("#customerTable").DataTable({
            serverSide: true,
            ajax: "/customer/load",
            ordering: false,
            "autoWidth": false,
            columns: [
                {
                    "data": function (row) {
                        if (row.type == 'company') {
                            return "<i class='fa fa-bank'></i>";
                        }
                        return "<i class='fa fa-user'></i>";
                    }
                },
                {
                    "data": function (row) {
                        if (row.companyname) {
                            return row.name + " - " + row.companyname;
                        }
                        return row.name;
                    }
                },
                {"data": "tel"},
                {"data": "address"},
                {"data": "weixin"},
                {"data": "email"},
                {"data": function(row){
                    return "<span style='color: gold'>"+row.level+"</span>";
                }}
            ],
            "language": {
                "search": "请输入姓名或电话:",
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

        $("#saveCompanyForm").validate({
            errorClass:"text-danger",
            errorElement:"span",
            rules:{
                name:{
                    required:true
                },
                tel:{
                    required:true
                }
            },
            messages:{
                name:{
                    required:"请输入客户名称"
                },
                tel:{
                    required:"请输入联系电话"
                }
            },
            submitHandler:function(form){
                $.post("/customer/new",$(form).serialize()).done(function(data){
                    if ("success"==data){
                        $("#companyModal").modal('hide');
                        dateTable.ajax.reload();
                    }
                }).fail(function(){
                    alert("服务器异常")
                });
            }
        });
        $("#newCompany").click(function () {
            $("#saveCompanyForm")[0].reset();
            $("#companyModal").modal({
                show: true,
                backdrop: 'static',
                keyboard: false
            });
        });

        $("#radioCompany").click(function () {
            if ($(this)[0].checked) {
                $("#companyList").hide();
            }
        });

        $("#saveCompanyBtn").click(function () {
            $("#saveCompanyForm").submit();
        });

    });
</script>
</body>
</html>


