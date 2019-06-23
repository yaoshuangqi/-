<%--
  Created by IntelliJ IDEA.
  User: ysq
  Date: 2019/05/15
  Time: 22:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <script src="<%=application.getContextPath()%>/js/jquery.min.js"></script>
    <script src="<%=application.getContextPath()%>/js/bootstrap.min.js"></script>
    <!--[if lt IE 9]>
    <![endif]-->
    <link href="<%=application.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/flat-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/jquery.nouislider.css">
</head>
<body>
<div class="check-div">
    <div class="col-xs-4">
    <button class="btn btn-yellow btn-xs" data-toggle="modal" data-target="#addChar">添加类别</button>
        </div>
</div>
<div style="overflow-y:auto;width:100%;height: 560px;border-top: 1px solid blue">
    <table class="table table-striped">
        <tr>
            <th>id</th>
            <th>name</th>
            <th>操作</th>
        </tr>
        <c:forEach var="ca" items="${category}">
            <tr>
                <td>${ca.id}</td>
                <td>${ca.name}</td>
                <td>
                    <button class="btn btn-success btn-xs upda" data-toggle="modal" value="${ca.id}" name="${ca.name}" data-target="#changeChar">修改</button>
                    <button class="btn btn-danger btn-xs del" data-toggle="modal" name="${ca.id}" data-target="#deleteChar">删除</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<div class="modal fade" id="addChar" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel">添加类别</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <div class="form-group ">
                            <label for="name" class="col-xs-3 control-label">类别：</label>
                            <div class="col-xs-6 ">
                                <input type="text" class="form-control input-sm duiqi" id="name" placeholder="请输入类别">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
                <button type="button" id="add" class="btn btn-xs btn-green">添 加</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<script>

    $("#add").click(function () {
        $.ajax({
            type:"post",
            url:"<%=application.getContextPath()%>/category/add",
            dataType: 'json'
            ,data:{name:$("#name").val()}
            , success: function (data) {
                if(data.code==200){
                    alert("添加成功");
                    window.location.reload();
                }else {
                    alert("添加失败");
                }
            }
        })
    })
    $(".del").click(function () {
        if(confirm("是否删除?")){
            $.ajax({
                type:"get",
                url:"<%=application.getContextPath()%>/category/del",
                dataType: 'json'
                ,data:{id:$(this).attr("name")}
                , success: function (data) {
                    if(data.code==200){
                        alert("删除成功");
                        window.location.reload();
                    }else {
                        alert("删除失败");
                    }
                }
            })
        }

    })
</script>
</body>
</html>
