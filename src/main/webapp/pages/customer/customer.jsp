<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>客户管理页面</title>
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
                客户管理
                <small>客户列表</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="${pageContext.request.contextPath}/login/main.do"><i class="fa fa-dashboard"></i>首页</a>
                </li>
                <li><a href="#">客户管理</a></li>
                <li class="active">客户列表</li>
            </ol>
        </section>
        <!-- 内容头部 /-->
        <!-- 正文区域 -->
        <section class="content">
            <!-- .box-body -->
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">客户列表</h3>
                </div>
                <div class="box-body">
                    <!-- 数据表格 -->
                    <div class="table-box">
                        <!--工具栏1-->
                        <div class="pull-left">
                            <div class="form-group form-inline">
                                <div class="btn-group">
                                    <!--新建-->
                                    <button type="button" class="btn btn-default" data-toggle="modal"
                                            data-target="#newDialog" onclick="clear1()">
                                        <i class="fa fa-file-o"></i>新建
                                    </button>
                                    <!--刷新-->
                                    <button type="button" class="btn btn-default" title="刷新"
                                            onclick="location.reload();">
                                        <i class="fa fa-refresh"></i>刷新
                                    </button>
                                </div>
                            </div>
                        </div>
                        <!--工具栏2,查询框-->
                        <div class="pull-right">
                            <div class="has-feedback">
                                <form action="${pageContext.request.contextPath}/customer/findAll.do" method="post">
                                    <div class="form-group form-inline">
                                        <label>名字</label>
                                        <input type="text" class="form-control" value="${username}" id="username"
                                               name="username"/>

                                        <label>客户级别</label>
                                        <select class="form-control" id="level" name="level">
                                            <option value="">--请选择--</option>
                                            <option value="1">包月客户</option>
                                            <option value="2">包年客户</option>
                                        </select>

                                        <button type="submit" class="btn btn-primary">搜索</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <!--工具栏/-->

                        <!--数据列表-->
                        <table id="dataList" class="table table-bordered table-striped table-hover dataTable">
                            <thead>
                            <tr>
                                <th class="" style="padding-right:0px;">
                                    <input id="selall" type="checkbox" class="icheckbox_square-blue">
                                </th>
                                <th class="text-center">ID</th>
                                <th class="text-center">名字</th>
                                <th class="text-center">性别</th>
                                <th class="text-center">联系方式</th>
                                <th class="text-center">邮件</th>
                                <th class="text-center">所在专业</th>
                                <th class="text-center">客户级别</th>
                                <th class="text-center">账户余额</th>
                                <th class="text-center">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageInfo.list}" var="customer">
                                <tr>
                                    <td><input name="ids" type="checkbox"></td>
                                    <td>${customer.id }</td>
                                    <td>${customer.username }</td>
                                    <td>${customer.sex }</td>
                                    <td>${customer.phone}</td>
                                    <td>${customer.email}</td>
                                    <td>${customer.indestry}</td>
                                    <td>${customer.levelStr}</td>
                                    <td>${customer.number}</td>
                                    <td class="text-center">
                                        <button type="button" class="btn bg-olive btn-xs"
                                                onclick="delete1('${pageContext.request.contextPath}/customer',${customer.id},'订单')">
                                            删除
                                        </button>
                                        <button class="btn btn-primary btn-xs" data-toggle="modal"
                                                data-target="#updateDialog"
                                                onclick="findById1('${pageContext.request.contextPath}/customer',${customer.id})">
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
                    <h4 class="modal-title" id="myModalLabel">新建客户信息</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="insertform">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="姓名" name="username" id="username1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">性别</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="sex1" name="sex">
                                    <option value="" selected="selected">--请选择--</option>
                                    <option value="男">男</option>
                                    <option value="女">女</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">联系方式</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="联系方式" name="phone" id="phone1">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">邮件</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="邮件" name="email" id="email1">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">所在专业</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="所在专业" name="indestry" id="indestry1">
                            </div>
                        </div>
                        <input type="hidden" class="form-control" placeholder="客户级别" name="level" value="0">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">账户余额</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="账户余额" name="number" id="number1">
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary"
                            onclick="create1('${pageContext.request.contextPath}/customer')">创建客户
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
                    <h4 class="modal-title" id="myModalLabe2">修改客户信息</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="updateform">
                        <input type="hidden" name="id" id="id2">
                        <div class="form-group">
                            <label for="username2" class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="姓名" name="username" id="username2">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">性别</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="sex2" name="sex">
                                    <option value="" selected="selected">--请选择--</option>
                                    <option value="男">男</option>
                                    <option value="女">女</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">联系方式</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="联系方式" name="phone" id="phone2">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">邮件</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="邮件" name="email" id="email2">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">所在专业</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="所在专业" name="indestry" id="indestry2">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">客户级别</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="level2" name="level">
                                    <option value="">--请选择--</option>
                                    <option value="0">包月客户</option>
                                    <option value="1">包年客户</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">账户余额</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="账户余额" name="number" id="number2">
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary"
                            onclick="update1('${pageContext.request.contextPath}/customer')">修改客户
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- 底部导航 -->
    <jsp:include page="../foot.jsp"></jsp:include>

    <script>
        //清空新建窗口中的数据
        function clear1() {
            $("#username1").val("");
            $("#sex1").val("");
            $("#phone1").val("");
            $("#email1").val("");
            $("#indestry1").val("");
            $("#number1").val("");
        }

        // 通过id获取修改的信息
        function findById1(url, id) {
            $.post(url + "/findById.do", {"id": id}, function (data) {
                $("#id2").val(data.id)
                $("#username2").val(data.username);
                $("#sex2").val(data.sex);
                $("#phone2").val(data.phone);
                $("#email2").val(data.email);
                $("#indestry2").val(data.indestry);
                $("#level2").val(data.level);
                $("#number2").val(data.number);
            });
        }
    </script>
</body>
</html>
