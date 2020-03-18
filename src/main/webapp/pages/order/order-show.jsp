<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>订单详细页面</title>
    <meta content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" name="viewport">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/iCheck/square/blue.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/morris/morris.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/datepicker/datepicker3.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/datatables/dataTables.bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/treeTable/jquery.treetable.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/treeTable/jquery.treetable.theme.default.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/select2/select2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/colorpicker/bootstrap-colorpicker.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/bootstrap-markdown/css/bootstrap-markdown.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/adminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/adminLTE/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/ionslider/ion.rangeSlider.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/ionslider/ion.rangeSlider.skinNice.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/bootstrap-slider/slider.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.css">
    <style>
        .wrap{
            max-width: 270px; /*设置需要固定的宽度*/
            white-space: nowrap; /*不换行*/
            text-overflow: ellipsis; /*超出部分用....代替*/
            overflow: hidden; /*超出隐藏*/
        }
    </style>
</head>

<body class="hold-transition skin-purple sidebar-mini">
<div class="wrapper">
    <!-- 页面头部 -->
    <jsp:include page="../header.jsp"></jsp:include>
    <!-- 导航侧栏 -->
    <jsp:include page="../aside.jsp"></jsp:include>
    <!-- 内容区域 -->
    <div class="content-wrapper">
        <!-- 内容头部 -->
        <section class="content-header">
            <h1>
                订单详细查看
            </h1>
            <ol class="breadcrumb">
                <li><a href="${pageContext.request.contextPath}/login/main.do"><i class="fa fa-dashboard"></i>首页</a>
                </li>
                <li><a href="#">订单管理</a></li>
                <li class="active">订单详细查看</li>
            </ol>
        </section>
        <!-- 内容头部 /-->
        <!-- 正文区域 -->
        <section class="content">
            <!-- .box-body -->
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">订单列表</h3>
                </div>
                <div class="box-body">
                    <!-- 数据表格 -->
                    <div class="table-box">
                        <!--数据列表-->
                        <table id="dataList" class="table table-bordered table-striped table-hover dataTable">
                            <thead>
                            <tr>
                                <th class="text-center">订单编号</th>
                                <th class="text-center">缴费人</th>
                                <th class="text-center">缴费日期</th>
                                <th class="text-center">到期日期</th>
                                <th class="text-center">费用</th>
                                <th class="text-center">缴费类型</th>
                                <th class="text-center">经办人</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${order.orderNum }</td>
                                <td>${order.customer.username}</td>
                                <td>${order.orderTimeStr}</td>
                                <c:if test="${fn:length(order.maturityTimeStr)==19}">
                                    <td>${order.maturityTimeStr}</td>
                                </c:if>
                                <c:if test="${fn:length(order.maturityTimeStr)>19}">
                                    <td style="color: red">${order.maturityTimeStr}</td>
                                </c:if>
                                <td>${order.money}</td>
                                <td>${order.orderStatusStr}</td>
                                <td>${order.user.username}</td>
                            </tr>
                            </tbody>
                        </table>
                        <!--数据列表/-->
                        <!-- /.box-body -->
                    </div>
                </div>
            </div>

            <%--顾客息--%>
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">顾客信息</h3>
                </div>
                <div class="box-body">
                    <!-- 数据表格 -->
                    <div class="table-box">
                        <!--数据列表-->
                        <table id="dataList2" class="table table-bordered table-striped table-hover dataTable">
                            <thead>
                            <tr>
                                <th class="text-center">ID</th>
                                <th class="text-center">名字</th>
                                <th class="text-center">性别</th>
                                <th class="text-center">联系方式</th>
                                <th class="text-center">邮件</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${order.customer.id }</td>
                                <td>${order.customer.username }</td>
                                <td>${order.customer.sex }</td>
                                <td>${order.customer.phone}</td>
                                <td>${order.customer.email}</td>
                            </tr>
                            </tbody>
                        </table>
                        <!--数据列表/-->
                        <!-- /.box-body -->
                    </div>
                </div>
            </div>
            <%--员工信息--%>
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">员工信息</h3>
                </div>
                <div class="box-body">
                    <!-- 数据表格 -->
                    <div class="table-box">
                        <!--数据列表-->
                        <table id="dataList3" class="table table-bordered table-striped table-hover dataTable">
                            <thead>
                            <tr>
                                <th class="text-center">名字</th>
                                <th class="text-center">联系方式</th>
                                <th class="text-center">邮件</th>
                                <th class="text-center">状态</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${order.user.username }</td>
                                <td>${order.user.phone}</td>
                                <td>${order.user.email}</td>
                                <td>${order.user.statusStr}</td>
                            </tr>
                            </tbody>
                        </table>
                        <!--数据列表/-->
                        <!-- /.box-body -->
                    </div>
                </div>
            </div>

        </section>
    </div>

    <!-- 底部导航 -->
    <jsp:include page="../foot.jsp"></jsp:include>

    <script>

        $(document).ready(function () {
            $('#orderTime1').datetimepicker({
                format: "yyyy-mm-dd hh",
                autoclose: true,
                todayBtn: true,
                language: "zh-CN"
            });

        });

    </script>
</body>
</html>
