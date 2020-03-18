<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!--分页开始-->
    <div class="box-footer">
        <div class="pull-left">
            <div class="form-group form-inline">
                总共${pageInfo.pages}页，共${pageInfo.total}条数据。 每页
                <select class="form-control" id="changePageSize" onchange="changePageSize()">
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
                    <option>6</option>
                    <option>7</option>
                </select> 条
            </div>
        </div>
        <div class="box-tools pull-right">
            <ul class="pagination">
                <li>
                    <span onclick="ShouYe(${pageInfo.pageSize})" aria-label="Previous">首页</span>
                </li>
                <li>
                    <span onclick="Shangyie(${pageInfo.pageNum-1},${pageInfo.pageSize})">上一页</span>
                </li>
                <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
                    <li>
                        <span onclick="zhongjianxunhuan(${pageNum},${pageInfo.pageSize})">${pageNum}</span>
                    </li>
                </c:forEach>
                <li>
                    <span onclick="xiayiye(${pageInfo.pageNum+1},${pageInfo.pageSize})">下一页</span>
                </li>
                <li>
                    <span onclick="weiye(${pageInfo.pages},${pageInfo.pageSize})" aria-label="Next">尾页</span>
                </li>
            </ul>
        </div>
    </div>
    <!--分页结束-->
