<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!-- 页面头部 -->
<header class="main-header">
    <!-- Logo -->
    <!-- 侧边栏的迷你徽标迷你50x50像素-->
    <a href="${pageContext.request.contextPath}/pages/main.jsp" class="logo">
        <!-- 常规状态和移动设备的徽标 -->
        <span class="logo-mini"><b>数据</b></span>
        <span class="logo-lg"><b>客户后台管理</b></span>
    </a>
    <!-- 页眉导航栏，Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
        <!-- 边栏切换按钮 ，  Sidebar toggle button-->
        <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">切换导航</span>
        </a>
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
                <li class="dropdown user user-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
<%--                        <img src="${pageContext.request.contextPath}/img/1.jpeg" class="user-image" alt="User Image">--%>
                        <span class="hidden-xs">
                        <%-- 显示用户名字  --%>
							<security:authentication property="principal.username"></security:authentication>
					    </span>
                    </a>
                    <ul class="dropdown-menu">
                        <!-- 用户图像 , User image -->
                        <li class="user-header">
<%--                            <img src="${pageContext.request.contextPath}/img/1.jpeg" class="img-circle" alt="User Image">--%>
                        </li>
                        <!-- 页脚菜单 , Menu Footer-->
                        <li class="user-footer">
                            <div class="pull-left">

                                <a href="${pageContext.request.contextPath}/login/update.do" class="btn btn-default btn-flat">修改密码</a>
                            </div>
                            <div class="pull-right">
                            <%--  在Spring Security里注销  --%>
                                <a href="${pageContext.request.contextPath}/logout.do"
                                   class="btn btn-default btn-flat">注销</a>
                            </div>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>
<!-- 页面头部 /-->