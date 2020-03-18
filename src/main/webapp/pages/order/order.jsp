<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>订单管理页面</title>
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
        <%--   表格左右拉  --%>
        .list{
            width:100%;
            position:relative;
        }
        .list table{
            border-collapse:collapse;
        }
        .list table th, .list table td{
            border:1px solid #000;
            padding:5px 15px;
            text-align:center;
            background:#fff;
            white-space:nowrap;
        }
        .table-right{
            overflow-x:auto;
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
                订单管理
                <small>订单列表</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="${pageContext.request.contextPath}/login/main.do"><i class="fa fa-dashboard"></i>首页</a></li>
                <li><a href="#">订单管理</a></li>
                <li class="active">订单列表</li>
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
                        <%--   表格左右移动  --%>
                        <div class="list" id="list">
                            <div class="table-right" id="table-right">
                                <!--工具栏1-->
                                <div class="pull-left">
                                    <div class="form-group form-inline">
                                        <div class="btn-group">
                                            <!--新建-->
                                            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#newDialog" onclick="clear1()">
                                                <i class="fa fa-file-o"></i>新建
                                            </button>
                                            <!--刷新-->
                                            <button type="button" class="btn btn-default" title="刷新" onclick="location.reload();">
                                                <i class="fa fa-refresh"></i>刷新
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <!--工具栏2,查询框-->
                                <div class="pull-right">
                                    <div class="has-feedback">
                                        <form action="${pageContext.request.contextPath}/order/findAll.do" method="post">
                                            <div class="form-group form-inline">

                                                <label>订单编号</label>
                                                <input type="text" class="form-control" value="${orderNum}"
                                                       id="orderNum" name="orderNum"/>

                                                <label>经办人</label>
                                                <select class="form-control" id="userid" name="userid">
                                                    <option value="">--请选择--</option>
                                                    <c:forEach var="user" items="${user2}">
                                                        <option value="${user.id}">
                                                                ${user.username}</option>
                                                    </c:forEach>
                                                </select>

                                                <button type="submit" class="btn btn-primary">搜索</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <!--工具栏/-->

                                <!--数据列表-->
                                <table cellpadding="0" cellspacing="0" id="dataList"
                                       class="table table-bordered table-striped table-hover dataTable">
                                    <thead>
                                    <tr>
                                        <th class="" style="padding-right:0px;">
                                            <input id="selall" type="checkbox" class="icheckbox_square-blue">
                                        </th>
                                        <th class="text-center">订单编号</th>
                                        <th class="text-center">缴费人</th>
                                        <th class="text-center">缴费日期</th>
                                        <th class="text-center">到期日期</th>
                                        <th class="text-center">费用</th>
                                        <th class="text-center">缴费类型</th>
                                        <th class="text-center">经办人</th>
                                        <th class="text-center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${pageInfo.list}" var="order">
                                        <tr>
                                            <td><input name="ids" type="checkbox"></td>
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
                                            <td class="text-center">
                                                <button class="btn btn-primary btn-xs" data-toggle="modal" data-target="#jiaofeiDialog"
                                                        onclick="jiaofei(${order.customer.id},'${order.customer.username}',${order.customer.number})">
                                                    缴费
                                                </button>
                                                <button type="button" class="btn bg-olive btn-xs"
                                                        onclick="location.href='${pageContext.request.contextPath}/order/show.do?id=${order.id}'">
                                                    详细页面
                                                </button>
                                                <button type="button" class="btn bg-olive btn-xs"
                                                        onclick="delete1('${pageContext.request.contextPath}/order',${order.id})">
                                                    删除
                                                </button>
                                                <button class="btn btn-primary btn-xs" data-toggle="modal" data-target="#updateDialog"
                                                        onclick="findById1('${pageContext.request.contextPath}/order',${order.id})">
                                                    修改
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <!--数据列表/-->
                            </div>
                            <!-- 数据表格 /-->
                        </div>
                    </div>
                </div>
                <!-- /.box-body -->
                <!-- 分页 -->
                <jsp:include page="../fenye.jsp"></jsp:include>
            </div>
        </section>
    </div>
    <!-- 新建模态框 -->
    <div class="modal fade" id="newDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">新建订单信息</h4>
                </div>

                <div class="modal-body">
                    <form class="form-horizontal" id="insertform">

                        <div class="form-group">
                            <label class="col-sm-2 control-label">订单编号</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="订单编号" name="orderNum" id="orderNum1">
                                <span id="check"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">缴费人</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="customerid1" name="customerid">
                                    <option value="">--请选择缴费人--</option>
                                    <c:forEach var="customer" items="${customers2}">
                                        <option value="${customer.id}">
                                                ${customer.username}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">缴费类型</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="orderStatus1" name="orderStatus">
                                    <option value="">--请选择--</option>
                                    <option value="1">包月</option>
                                    <option value="2">包年</option>
                                </select>
                                <span id="check2"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">缴费日期</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="缴费日期" name="orderTime" id="orderTime1">
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-2 control-label">费用</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="费用" name="money" id="money1">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">经办人</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="userid1" name="userid">
                                    <option value="">--请选择--</option>
                                    <c:forEach var="user" items="${user2}">
                                        <option value="${user.id}">
                                                ${user.username}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary"
                            onclick="create1('${pageContext.request.contextPath}/order')">创建订单信息
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- 修改模态框 -->
    <div class="modal fade" id="updateDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabe2">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabe2">修改订单信息</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="updateform">
                        <input type="hidden"name="id" id="id2">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">订单编号</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="订单编号" name="orderNum" id="orderNum2">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">缴费人</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="customerid2" name="customerid">
                                    <option value="">--请选择缴费人--</option>
                                    <c:forEach var="customer" items="${customers2}">
                                        <option value="${customer.id}">
                                                ${customer.username}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">缴费类型</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="orderStatus2" name="orderStatus">
                                    <option value="">--请选择--</option>
                                    <option value="1">包月</option>
                                    <option value="2">包年</option>
                                </select>
                                <span id="check3"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">缴费日期</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="缴费日期" name="orderTime" id="orderTime2">
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-2 control-label">费用</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="费用" name="money" id="money2">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">经办人</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="userid2" name="userid">
                                    <option value="">--请选择--</option>
                                    <c:forEach var="user" items="${user2}">
                                        <option value="${user.id}">
                                                ${user.username}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary"
                            onclick="update1('${pageContext.request.contextPath}/order')">修改订单
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- 缴费模态框 -->
    <div class="modal fade" id="jiaofeiDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabe3">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabe3">缴费信息</h4>
                </div>
                <form class="form-horizontal" action="${pageContext.request.contextPath}/order/insertmoney.do" method="post">
                <div class="modal-body">

                        <div class="form-group">
                            <label class="col-sm-2 control-label">用户id</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="用户id" name="id" id="id3">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">用户名字</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="用户id" id="name3">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">原本费用</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="原本费用" id="money3">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">要交的费用</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="要交的费用" name="number" id="money4">
                            </div>
                        </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">缴费</button>
                </div>
                </form>
            </div>
        </div>
    </div>
    <!-- 底部导航 -->
    <jsp:include page="../foot.jsp"></jsp:include>

    <script>
        var jiao="${jiaofei}";
        if(jiao=="缴费成功"){
            alert(jiao)
        }else if(jiao=="缴费失败"){
            alert(jiao)
        }else if(jiao=="金额不能为空"){
            alert(jiao)
        }


        function jiaofei(id,name,money){
            $("#id3").val(id);
            $("#name3").val(name);
            $("#money3").val(money);
        }


        <%--  表格左右移动  --%>
        $(document).ready(function() {
            var List = document.getElementById("list");
            var Listr = document.getElementById("table-right");
            var wList = (List.innerWidth || (List.clientWidth));
            $(window).resize(function() {
                var List = document.getElementById("list");
                var Listr = document.getElementById("table-right");
                var wList = (List.innerWidth || (List.clientWidth));
            });
        });

        $(document).ready(function () {
            $('#orderTime1').datetimepicker({
                format: "yyyy-mm-dd hh:mm:ss",
                autoclose: true,
                todayBtn: true,
                language: "zh-CN"
            });
            $('#orderTime2').datetimepicker({
                format: "yyyy-mm-dd hh:mm:ss",
                autoclose: true,
                todayBtn: true,
                language: "zh-CN"
            });
        });

        //查看**存不存
        //在页面加载完成后
        $(function () {
            //给username绑定blur事件
            $("#orderNum1").blur(function () {
                var orderNum = $(this).val();
                $.get("${pageContext.request.contextPath}/order/findcheck.do",{"orderNum":orderNum},function (data) {
                    //判断userExsit键的值是否是true
                    var span = $("#check");
                    if(data=="OK"){
                        span.css("color","red");
                        span.html("此订单编号已存在,请更换一个");
                        $("#orderNum1").val("");
                    }else{
                        span.css("color","green");
                        span.html("订单编号可用");
                    }
                });
            });

        });

        //清空新建窗口中的数据
        function clear1() {
        	var ID=createRandomId();
            $("#orderNum1").val("");
            $("#check").html("");
            $("#check2").html("");
            $("#customerid1").val("");
            $("#orderTime1").val("");
            $("#maturityTime1").val("");
            $("#money1").val("");
            $("#orderStatus1").val("");
            $("#userid1").val("");
            $("#orderNum1").val(ID);
        }

        //生成随机数
        function createRandomId() {
        	            return (Math.random()*10000000).toString(16).substr(0,4)+'-'+(new Date()).getTime()+'-'+Math.random().toString().substr(2,5);
        }
        	
        // 通过id获取修改的信息
        function findById1(url, id) {
            $.post(url+"/findById.do", {"id": id}, function (data) {
                $("#id2").val(data.id);
                $("#check3").html("");
                $("#orderNum2").val(data.orderNum);
                $("#customerid2").val(data.customerid);
                $("#orderTime2").val(data.orderTimeStr);
                $("#maturityTime2").val(data.maturityTimeStr);
                $("#money2").val(data.money);
                $("#orderStatus2").val(data.orderStatus);
                $("#userid2").val(data.userid);
            });
        }



        //根据缴费类型判断要交的费用
        $("#orderStatus1").change(function () {
            var money= $(this).val()
            var aaa
            if(money == 1)
                aaa=30
                $("#money1").val(aaa)
            if(money == 2)
                aaa=320
                $("#money1").val(aaa)
            var customer=$("#customerid1").val()
            $.get("${pageContext.request.contextPath}/order/findcheckmoney.do",{"money":aaa,"customerid":customer},function (data) {
                //判断userExsit键的值是否是true
                var span = $("#check2");
                if(data=="FAIL"){
                    span.css("color","red");
                    span.html("此客户余额不支持缴费金额,请更换一个服务或去缴费");
                    $("#orderStatus1").val("");
                    $("#money1").val("")
                }
            });
        });
        $("#orderStatus2").change(function () {
            var money= $(this).val()
            var aaa
            if(money == 1)
                aaa=30
            $("#money2").val(aaa)
            if(money == 2)
                aaa=320
            $("#money2").val(aaa)
            var customer=$("#customerid2").val()
            $.get("${pageContext.request.contextPath}/order/findcheckmoney.do",{"money":aaa,"customerid":customer},function (data) {
                //判断userExsit键的值是否是true
                var span = $("#check3");
                if(data=="FAIL"){
                    span.css("color","red");
                    span.html("此客户余额不支持缴费金额,请更换一个服务或去缴费");
                    $("#orderStatus2").val("");
                    $("#money2").val("")
                }
            });
        });

    </script>
</body>
</html>
