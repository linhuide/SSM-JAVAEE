<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>角色管理页面</title>
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
                角色管理
                <small>角色列表</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="${pageContext.request.contextPath}/login/main.do"><i class="fa fa-dashboard"></i>首页</a></li>
                <li><a href="#">角色管理</a></li>
                <li class="active">角色列表</li>
            </ol>
        </section>
        <!-- 内容头部 /-->
        <!-- 正文区域 -->
        <section class="content">
            <!-- .box-body -->
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">角色列表</h3>
                </div>
                <div class="box-body">
                    <!-- 数据表格 -->
                    <div class="table-box">
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

                        <!--数据列表-->
                        <table id="dataList" class="table table-bordered table-striped table-hover dataTable">
                            <thead>
                            <tr>
                                <th class="" style="padding-right:0px;">
                                    <input id="selall" type="checkbox" class="icheckbox_square-blue">
                                </th>
                                <th class="text-center">角色编号</th>
                                <th class="text-center">角色描述</th>
                                <th class="text-center">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageInfo.list}" var="role">
                                <tr>
                                    <td><input name="ids" type="checkbox"></td>
                                    <td>${role.roleid}</td>
                                    <td>${role.roleDesc}</td>

                                    <td class="text-center">
                                        <button type="button" class="btn bg-olive btn-xs"
                                                onclick="delete1('${pageContext.request.contextPath}/role',${role.id})">删除</button>
                                        <button class="btn btn-primary btn-xs" data-toggle="modal" data-target="#updateDialog"
                                                onclick="findById1('${pageContext.request.contextPath}/role',${role.id})">修改</button>
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
                    <h4 class="modal-title" id="myModalLabel">新建角色信息</h4>
                </div>

                <div class="modal-body">
                    <form class="form-horizontal" id="insertform">

                        <div class="form-group">
                            <label class="col-sm-2 control-label">角色名字</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="角色名字" name="roleid" id="roleid1">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">角色描述</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" rows="3" placeholder="角色描述" name="roleDesc" id="roleDesc1"></textarea>
                            </div>
                        </div>


                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary"
                            onclick="create1('${pageContext.request.contextPath}/role')">创建角色信息
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
                    <h4 class="modal-title" id="myModalLabe2">修改角色信息</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="updateform">
                        <input type="hidden"name="id" id="id2">

                        <div class="form-group">
                            <label class="col-sm-2 control-label">角色名字</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="角色名字" name="roleid" id="roleid2">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">角色描述</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" rows="3" placeholder="角色描述" name="roleDesc" id="roleDesc2"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary"
                            onclick="update1('${pageContext.request.contextPath}/role')">修改角色信息
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
            $("#roleid1").val("");
            $("#roleDesc1").val("");
        }

        // 通过id获取修改的信息
        function findById1(url, id) {
            $.post(url+"/findById.do", {"id": id}, function (data) {
                $("#id2").val(data.id);
                $("#roleid2").val(data.roleid);
                $("#roleDesc2").val(data.roleDesc);
            });
        }

    </script>
</body>
</html>
