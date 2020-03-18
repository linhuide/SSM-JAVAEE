<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>个人管理页面</title>
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
                个人管理
                <small>个人列表</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="${pageContext.request.contextPath}/login/main.do"><i class="fa fa-dashboard"></i>首页</a></li>
                <li><a href="#">个人管理</a></li>
                <li class="active">个人列表</li>
            </ol>
        </section>
        <!-- 内容头部 /-->
        <!-- 正文区域 -->
        <section class="content">

            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">个人列表</h3>
                </div>
                <div class="box-body">
                    <!-- 数据表格 -->
                    <div class="table-box">
                        <!--工具栏1-->
                        <div class="pull-left">
                            <div class="form-group form-inline">
                                <div class="btn-group">
                                    <!--新建-->
                                    <button type="button" class="btn btn-default" data-toggle="modal" data-target="#updateDialog"
                                            onclick="findById1('${pageContext.request.contextPath}/user',${user.id})">修改</button>
                                    </button>
                                    <!--刷新-->
                                    <button type="button" class="btn btn-default" title="刷新" onclick="location.reload();">
                                        <i class="fa fa-refresh"></i>刷新
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!--数据列表-->
                        <table id="dataList" class="table table-bordered table-striped table-hover dataTable">
                            <tr>
                                <th class="text-center">个人id</th>
                                <td>${user.id}</td>
                                <th class="text-center">个人名字</th>
                                <td>${user.username}</td>
                            </tr>
                            <tr>
                                <th class="text-center">联系方式</th>
                                <td>${user.phone}</td>
                                <th class="text-center">邮件</th>
                                <td>${user.email}</td>
                            </tr>
                            <tr>
                                <th class="text-center">用户状态</th>
                                <td>${user.statusStr}</td>
                                <th class="text-center">角色id</th>
                                <td>${user.roles.roleid}</td>
                            </tr>
                            <tr>
                                <th class="text-center">角色描述</th>
                                <td>${user.roles.roleDesc}</td>

                            </tr>
                        </table>
                        <!--数据列表/-->
                    </div>
                    <!-- 数据表格 /-->
                </div>

            </div>
        </section>
    </div>

    <!-- 修改模态框 -->
    <div class="modal fade" id="updateDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabe2">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabe2">修改用户信息</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="updateform">
                        <input type="hidden"name="id" id="id2">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">名字</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="名字" name="username" id="username2">
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
						 <security:authorize access="hasRole('ADMIN')">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">用户状态</label>
                            <div class="col-sm-10">
                                <select class="form-control" id="status2" name="status">
                                    <option value="">--请选择--</option>
                                    <option value="0">正常使用</option>
                                    <option value="1">异常中</option>
                                </select>
                            </div>
                        </div>
                        </security:authorize>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary"
                            onclick="update1('${pageContext.request.contextPath}/user')">修改用户
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- 底部导航 -->
    <jsp:include page="../foot.jsp"></jsp:include>

    <script>
        // 通过id获取修改的信息
        function findById1(url, id) {
            $.post(url+"/findById.do", {"id": id}, function (data) {
                $("#id2").val(data.id);
                $("#username2").val(data.username);
                $("#phone2").val(data.phone);
                $("#email2").val(data.email);
                $("#status2").val(data.status);
            });
        }

    </script>
</body>
</html>
