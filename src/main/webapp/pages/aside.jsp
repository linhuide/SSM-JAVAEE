<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<aside class="main-sidebar" style="background-color: #CCCCFF">
    <%--  侧边栏--%>
    <section class="sidebar" >
        <!-- 头 -->
        <div class="user-panel" style="height: 100px;">
            <div class="pull-left info" style="color: #000000;">
                <p>
                    <security:authentication property="principal" var="authentication"/>
                    ${authentication.username}
                </p>
                <p>
                    <security:authentication property="principal.authorities[1]"></security:authentication>
                </p>
                <a href="#" style="color: #000000;"><i class="fa fa-circle text-success"></i>在线</a>
            </div>
        </div>

        <!-- 菜单栏 -->
        <ul class="sidebar-menu" >
            <li class="header" style="color: #ffffff;">菜单</li>
            <%--系统管理 --%>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cogs"></i>
                    <span style="color: #ffffff">系统管理</span>
                    <span class="pull-right-container"><i class="fa fa-angle-left pull-right"></i></span>
                </a>
                <%--  下拉的--%>
                <ul class="treeview-menu">
                    <security:authorize access="hasRole('ADMIN')">
                    <li id="system-setting">
                        <a href="${pageContext.request.contextPath}/user/findAll.do">
                            <i class="fa fa-circle-o"></i>用户管理
                        </a>
                    </li>
                    <li id="system-setting">
                        <a href="${pageContext.request.contextPath}/role/findAll.do">
                            <i class="fa fa-circle-o"></i>员工管理
                        </a>
                    </li>
                    </security:authorize>
                    <li id="system-setting">
                        <a href="${pageContext.request.contextPath}/user/findstaff.do?username=<security:authentication property="principal.username" />">
                            <i class="fa fa-circle-o"></i>个人管理
                        </a>
                    </li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#"> <i class="fa fa-cube"></i>
                    <span style="color: #ffffff">销售管理</span>
                    <span class="pull-right-container">
                    <i class="fa fa-angle-left pull-right"></i>
				</span>
                </a>
                <%--    顾客表，产品表，订单表，销售量表，--%>
                <ul class="treeview-menu">
                    <li id="system-setting">
                        <a href="${pageContext.request.contextPath}/customer/findAll.do?page=1&size=4">
                            <i class="fa fa-circle-o"></i>客户管理
                        </a>
                    </li>
                    <li id="system-setting">
                        <a href="${pageContext.request.contextPath}/order/findAll.do?page=1&size=4">
                            <i class="fa fa-circle-o"></i>订单管理
                        </a>
                    </li>

                </ul>
            </li>
        </ul>
    </section>
</aside>