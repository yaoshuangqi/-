<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ysq
  Date: 2019/05/15
  Time: 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="<%=application.getContextPath()%>/js/jquery.min.js"></script>
    <link href="<%=application.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/common.css" />
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/slide.css" />
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/flat-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/jquery.nouislider.css">
</head>
<script type="text/javascript">
    function verify() {
        var file = document.forms[0].tp.value;
        if (file == null||file == ""){
            alert("请选择要上传的图片!");
            return false;
        }
        if (file.lastIndexOf('.')==-1){    //如果不存在"."
            alert("路径不正确!");
            return false;
        }
        var AllImgExt=".jpg|.jpeg|.gif|.bmp|.png|";
        var extName = file.substring(file.lastIndexOf(".")).toLowerCase();//（把路径中的所有字母全部转换为小写）
        if(AllImgExt.indexOf(extName+"|")==-1)
        {
            ErrMsg="该文件类型不允许上传。请上传 "+AllImgExt+" 类型的文件，当前文件类型为"+extName;
            alert(ErrMsg);
            return false;
        }
        document.forms[0].submit();
    }
</script>
<body>
<label class="col-xs-4 control-label">${msg}</label>
<div style="padding: 50px 0;margin-top: 50px;background-color: #fff; text-align: right;width: 420px;margin: 50px auto;">
    <form class="form-horizontal" method="post" action="<%=application.getContextPath()%>/pet/add" enctype="multipart/form-data" onsubmit="return verify()">
        <div class="form-group">
            <label for="categoryId" class="col-xs-4 control-label">宠物类别：</label>
            <div class="col-xs-5">
                <select name="categoryId" class="form-control input-sm duiqi" id="categoryId" style="margin-top: 7px;">
                    <c:forEach var="c" items="${category}">
                        <option value="${c.id}">${c.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label for="name" class="col-xs-4 control-label">宠物名称：</label>
            <div class="col-xs-5">
                <input type="" class="form-control input-sm duiqi" id="name" name="name"  placeholder="请输入宠物名称" style="margin-top: 7px;">
            </div>
        </div>

        <div class="form-group">
            <label for="age" class="col-xs-4 control-label">宠物年龄：</label>
            <div class="col-xs-5">
                <input type="" class="form-control input-sm duiqi" id="age" name="age"  placeholder="请输入宠物年龄" style="margin-top: 7px;">
            </div>
        </div>

        <div class="form-group">
            <label for="sex" class="col-xs-4 control-label">宠物性别：</label>
            <div class="col-xs-5" style="width:160px;margin-top: 7px;">
                <label class="radio-inline">
                    <input type="radio" checked="checked" value="0" name="sex">雄性
                </label>
                <label class="radio-inline">
                    <input type="radio"  value="1" name="sex">雌性
                </label>
            </div>
        </div>

        <div class="form-group">
            <label for="tp" class="col-xs-4 control-label">图片上传：</label>
            <div class="col-xs-5">
                <input type="file" class="form-control duiqi" id="tp" name="tp" style="margin-top: 7px;">
            </div>
        </div>
        <div class="form-group">
            <label for="tags" class="col-xs-4 control-label">宠物标签：</label>
            <div class="col-xs-5">
                <select name="tags" class="form-control input-sm duiqi" id="tags" style="margin-top: 7px;">
                    <c:forEach var="p" items="${tag}">
                        <option value="${p.id}">${p.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="form-group text-right">
            <div class="col-xs-offset-4 col-xs-5" style="margin-left: 169px;">
                <button type="reset" class="btn btn-xs btn-white">取 消</button>
                <button type="submit" class="btn btn-xs btn-green">发布</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
