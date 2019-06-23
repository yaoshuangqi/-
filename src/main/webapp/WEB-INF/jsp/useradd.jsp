<%--
  Created by IntelliJ IDEA.
  User: ysq
  Date: 2019/05/15
  Time: 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Title</title>
    <script src="<%=application.getContextPath()%>/js/respond.min.js"></script>
    <link href="<%=application.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/slide.css"/>
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/flat-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/jquery.nouislider.css">
</head>
<body>
<div class="form-group">
    <label class="col-xs-4 control-label">${msg}</label>
</div>
<div style="padding: 50px 0;margin-top: 50px;background-color: #fff; text-align: right;width: 420px;margin: 50px auto;">
    <form class="form-horizontal" method="post" action="<%=application.getContextPath()%>/user/adduser">
        <div class="form-group">
            <label for="username" class="col-xs-4 control-label">用户名称：</label>
            <div class="col-xs-5">
                <input type="" class="form-control input-sm duiqi" id="username" value="${username}" name="username" placeholder="请输入用户名称"
                       style="margin-top: 7px;">
            </div>
        </div>
        <div class="form-group">
            <label for="password" class="col-xs-4 control-label">用户密码：</label>
            <div class="col-xs-5">
                <input type="password" class="form-control input-sm duiqi" id="password" value="${password}" name="password" placeholder="请输入用户密码"
                       style="margin-top: 7px;">
            </div>
        </div>
        <div class="form-group">
            <label for="age" class="col-xs-4 control-label">用户年龄：</label>
            <div class="col-xs-5">
                <input type="" class="form-control input-sm duiqi" id="age" value="${age}" name="age" placeholder="请输入用户年龄"
                       style="margin-top: 7px;">
            </div>
        </div>
        <div class="form-group">
            <label for="email" class="col-xs-4 control-label">用户邮箱：</label>

            <div class="col-xs-5">
                <input type="" class="form-control input-sm duiqi" id="email" name="email" value="${email}" placeholder="请输入用户邮箱"
                       style="margin-top: 7px;">
            </div>

        </div>
        <div class="form-group">
            <label for="address" class="col-xs-4 control-label">用户地址：</label>
            <div class="col-xs-5">
                <input type="" class="form-control input-sm duiqi" id="address"  value="${address}" name="address" placeholder="请输入用户地址" style="margin-top: 7px;">
            </div>
        </div>
        <div class="form-group">
            <label for="phone" class="col-xs-4 control-label">用户电话：</label>
            <div class="col-xs-5">
                <input type="phone" class="form-control input-sm duiqi" id="phone" value="${phone}" name="phone" placeholder="请输入用户电话"
                       style="margin-top: 7px;">
            </div>
        </div>
        <div class="form-group">
            <label for="authority" class="col-xs-4 control-label">用户角色：</label>
            <div class="col-xs-5">
                <select name="authority" class="form-control input-sm duiqi" id="authority"  value="${authority}" style="margin-top: 7px;">
                    <option value="0">管理员</option>
                    <option value="1">普通员</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="userstatus" class="col-xs-4 control-label">用户状态：</label>
            <div class="col-xs-5">
                <select name="userstatus" class="form-control input-sm duiqi" id="userstatus"  value="${userstatus}" style="margin-top: 7px;">
                    <option value="正常">正常</option>
                    <option value="冻结">冻结</option>
                </select>
            </div>
        </div>
        <div class="form-group text-right">
            <div class="col-xs-offset-4 col-xs-5" style="margin-left: 169px;">
                <button type="reset" class="btn btn-xs btn-white">取 消</button>
                <button type="submit" class="btn btn-xs btn-green">保存</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
