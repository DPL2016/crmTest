<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CRM 统计</title>
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
    <div class="content-wrapper" style="background-image: url(/static/dist/img/asanoha-400px.png)">
        <!-- Content Header (Page header) -->
        <section class="content">
            <ol class="breadcrumb" style="background-color: transparent">
                <li><a href="#"><i class="fa fa-dashboard"></i>主页</a></li>
                <li class="active">统计</li>
            </ol>
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">统计区间</h3>
                </div>
                <div class="box-body">
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="info-box">
                        <span class="info-box-icon bg-aqua"><i class="fa fa-plus"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">本月新增客户数量</span>
                            <span class="info-box-number">${newCustomerCount}</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="info-box">
                        <span class="info-box-icon bg-green"><i class="fa fa-flag"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">本月交易次数</span>
                            <span class="info-box-number">${saleCount}</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="info-box">
                        <span class="info-box-icon bg-red"><i class="fa fa-money"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">本月交易额</span>
                            <span class="info-box-number">${saleMoney}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="box box-primary">
                <div class="box-header ">
                    <h3 class="box-title">销售机会统计</h3>

                </div>
                <div class="box-body">
                    <div id="pieChart" style="width: 100%;height: 300px"></div>
                </div>

            </div>
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">员工业绩图</h3>

                </div>
                <div class="box-body">
                    <div id="barChart" style="width: 100%;height: 300px"></div>
                </div>

            </div>

        </section>
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
<script src="/static/plugins/echarts/echarts.min.js"></script>

<script>
    $(function () {
        var pieChart = echarts.init($("#pieChart")[0]);
        var pieOption = {
            tooltip: {
                trigger: 'item',
                formatter: "{a}<br/>{b}:{c} ({d}%)"
            },
            series: [
                {
                    name: '销售机会',
                    type: 'pie',
                    data: [],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        pieChart.setOption(pieOption);
        $.get("/chart/progress/data", function (data) {
            pieChart.setOption({
                series: [{
                    data: data
                }]
            });
        });

        var barChart = echarts.init($("#barChart")[0]);
        var option = {
            tooltip: {},
            xAxis: {
                data: []
            },
            yAxis: {},
            series: [{
                name: '业绩',
                type: 'bar',
                data: []
            }]
        };
        barChart.setOption(option);
        $.get("/chart/user/money", function (data) {
            barChart.setOption({
                xAxis: {
                    data: data.names
                },
                series: [{
                    data: data.values
                }]
            });
        });
    });
</script>
</body>
</html>

