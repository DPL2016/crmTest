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
    <link rel="stylesheet" href="/static/plugins/datatables/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet" href="/static/plugins/rangepicker/daterangepicker.css">
</head>

<body class="hold-transition skin-blue  sidebar-mini">
<div class="wrapper">


    <%@include file="../include/header.jsp" %>
    <jsp:include page="../include/leftside.jsp">
        <jsp:param name="menu" value="sales"/>
    </jsp:include>
    <div class="content-wrapper" style="background-image: url(/static/dist/img/asanoha-400px.png)">

        <section class="content">
            <div class="row">
                <div class="col-xs-12">

                    <div class="box box-primary">
                        <ol class="breadcrumb" style="background-color: transparent">
                            <li><a href="/home"><i class="fa fa-home"></i>首页</a></li>
                            <li>机会列表</li>
                        </ol>
                        <div class="box box-default collapsed-box">

                            <div class="box-header with-border">
                                <h3 class="box-title">搜索</h3>
                                <div class="box-tools">
                                    <button class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip"><i
                                            class="fa fa-plus"></i></button>
                                </div>
                            </div>
                            <div class="box-body" style="text-align: center">
                                <div class="row">
                                    <form id="searchForm" method="get">
                                        <div class="col-xs-2">
                                            <input type="text" class="form-control" placeholder="机会名称" name="name" id="search_name">
                                        </div>
                                        <div class="col-xs-3">
                                            <select class="form-control" id="search_progress">
                                                <option>当前进度</option>
                                                <option>初次接触</option>
                                                <option>确定意向</option>
                                                <option>发送报价</option>
                                                <option>提供合同</option>
                                                <option>交易成功</option>
                                                <option>交易搁置</option>
                                            </select>
                                        </div>
                                        <div>
                                            <%
                                                String startDate = request.getParameter("startDate");
                                                String endDate = request.getParameter("startDate");
                                            %>
                                            <input type="hidden" id="search_startDate" name="startDate" value="">
                                            <input type="hidden" id="search_endDate" name="endDate">
                                        </div>
                                        <div class="col-xs-5 ">
                                            <div  id="reportrange" class="pull-right"
                                                 style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 100%">
                                                <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
                                                <span>2016-7-15 ~ 2016-7-15</span> <b class="caret"></b>
                                            </div>
                                        </div>
                                        <button id="searchBtn" type="submit" class="btn btn-default"><i class="fa fa-search"></i>搜索
                                        </button>
                                    </form>
                                </div>

                            </div>
                        </div>
                        <div class="box-header with-border">


                            <h3 class="box-title">机会列表</h3>

                            <div class="box-tools">
                                <button class="btn btn-bitbucket btn-xs" id="newSales">
                                    <i class="fa fa-plus"></i> 新增机会
                                </button>
                            </div>
                        </div>

                        <div class="box-body">

                            <table class="table" id="saleTable">
                                <thead>
                                <tr>
                                    <th>机会名称</th>
                                    <th>关联客户</th>
                                    <th>价值</th>
                                    <th>当前进度</th>
                                    <th>最后跟进时间</th>
                                    <th>所属员工</th>
                                </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal fade" id="newModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">新增机会</h4>
                                </div>
                                <div class="modal-body">
                                    <form id="salesForm">
                                        <div class="form-group">
                                            <label>机会名称</label>
                                            <input type="text" class="form-control" name="name">
                                        </div>
                                        <div class="form-group">
                                            <label>价值</label>
                                            <input type="text" class="form-control" name="price">
                                        </div>
                                        <div class="form-group" id="custList">
                                            <label>关联客户</label>
                                            <select name="custid" class="form-control"></select>
                                        </div>
                                        <div class="form-group">
                                            <label>当前进度</label>
                                            <select name="progress" class="form-control" id="progressList">
                                                <option>初次接触</option>
                                                <option>确定意向</option>
                                                <option>发送报价</option>
                                                <option>提供合同</option>
                                                <option>交易成功</option>
                                                <option>交易搁置</option>
                                            </select>
                                        </div>

                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="button" id="salesBtn" class="btn btn-primary">保存</button>
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
<script src="/static/plugins/validate/jquery.validate.min.js"></script>
<script src="/static/plugins/moment/moment.min.js"></script>
<script src="/static/plugins/datatables/js/jquery.dataTables.min.js"></script>
<script src="/static/plugins/datatables/js/dataTables.bootstrap.min.js"></script>
<script src="/static/plugins/rangepicker/daterangepicker.js"></script>

<script>
    $(function () {

        var dateTable = $("#saleTable").DataTable({
            searching: false,
            serverSide: true,
            "lengthChange": false,
            ajax: {
                url:"/sales/load",
                data:function(dataSource){
                    dataSource.name = $("#search_name").val();
                    dataSource.progress = $("#search_progress").val();
                    dataSource.startDate = $("#search_startDate").val();
                    dataSource.endDate = $("#search_endDate").val();
                }
            },
            ordering: false,
            "autoWidth": false,
            columns: [
                {"data": function(row){
                    return "<a href='/sales/"+row.id+"' rel='"+row.id+"'>"+row.name+"</a>";
                }},
                {"data": function(row){
                    return "<a href='/customer/"+row.id+"' rel='"+row.custid+"'>"+row.custname+"</a>"
                }},
                {"data": "price"},
                {"data": function(row){
                    if (row.progress =='交易成功'){
                        return "<span class='label label-success'>交易成功</span>"
                    }
                    if (row.progress =='交易搁置'){
                        return "<span class='label label-danger'>交易搁置</span>"
                    }
                    return "<span>"+row.progress+"</span>";


                }},
                {"data": "lasttime"},
                {"data": "username"}
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

        $("#salesForm").validate({
            errorClass: "text-danger",
            errorElement: "span",
            rules: {
                name: {
                    required: true
                },
                price: {
                    required: true
                }
            },
            messages: {
                name: {
                    required: "请输入机会名称"
                },
                price: {
                    required: "请输入价格"
                }
            },
            submitHandler: function (form) {
                $.post("/sales/new", $(form).serialize()).done(function (data) {
                    if ("success" == data) {
                        $("#newModal").modal('hide');
                        dateTable.ajax.reload();
                    }
                }).fail(function () {
                    alert("服务器异常")
                });
            }
        });
        $("#newSales").click(function () {
            $("#salesForm")[0].reset();
            $.get("/sales/customer.json").done(function (data) {
                var $select = $("#custList select");
                $select.html("");
                $select.append("<option></option>");
                if (data && data.length) {
                    for (var i = 0; i < data.length; i++) {
                        var customer = data[i];
                        var option = "<option value='" + customer.id + "'>" + customer.name + "</option>";
                        $select.append(option);
                    }
                }
            }).fail(function () {
                alert("服务器异常")
            });
        });

        $("#newSales").click(function () {
            $("#newModal").modal({
                show: true,
                backdrop: 'static',
                keyboard: false
            });
        });
        $("#salesBtn").click(function () {
            $("#salesForm").submit();
        });

        var start = moment().subtract(29, 'days');
        var end = moment();

        function cb(start, end) {
            $('#reportrange span').html(start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD'));
        }

        $('#reportrange').daterangepicker({
            format: "YYYY-MM-DD",
            separator: "~",
            startDate: start,
            endDate: end,
            ranges: {
                '今天': [moment(), moment()],
                '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                '过去7天': [moment().subtract(6, 'days'), moment()],
                '过去30天': [moment().subtract(29, 'days'), moment()],
                '当月': [moment().startOf('month'), moment().endOf('month')],
                '上个月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            },
            locale: {
                applyLabel: '确定',
                cancelLabel: '取消',
                fromLabel: '起始时间',
                toLabel: '结束时间',
                customRangeLabel: '自定义',
                weekLable: '周',
                daysOfWeek: ['日', '一', '二', '三', '四', '五', '六'],
                monthNames: ['一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月'],
                firstDay: 1
            }
        }, cb);
        cb(start, end);
        $('#reportrange').on('apply.daterangepicker', function (ev, picker) {
            console.log(picker.startDate.format('YYYY-MM-DD HH:mm'));
            console.log(picker.endDate.format('YYYY-MM-DD HH:mm'));
            var startDate = picker.startDate.format('YYYY-MM-DD');
            var endDate = picker.endDate.format('YYYY-MM-DD');
            document.getElementById("search_startDate").value = startDate;
            document.getElementById("search_endDate").value = endDate;
        });
        $("#searchBtn").click(function(){
            dateTable.ajax.reload();
        });
    });
</script>
</body>
</html>


