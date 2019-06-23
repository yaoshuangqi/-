<%--
  Created by IntelliJ IDEA.
  User: ysq
  Date: 2019/05/15
  Time: 14:35
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
    <script src="<%=application.getContextPath()%>/js/html5shiv.min.js"></script>
    <script src="<%=application.getContextPath()%>/js/respond.min.js"></script>
    <![endif]-->
    <link href="<%=application.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/common.css" />
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/slide.css" />
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/flat-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/jquery.nouislider.css">
</head>
<body>
 <div class="check-div form-inline">
                   <div class="col-xs-4">
                       <form action="<%=application.getContextPath()%>/user" method="get" >
                       <input type="text" class="form-control input-sm" name="username" placeholder="输入用户名搜索">
                       <button class="btn btn-white btn-xs " type="submit" >查 询 </button>
                       </form>
                   </div>
                   <div class="col-xs-4">
                       <form>
                       <input type="text" class="form-control input-sm" name="address" placeholder="输入地址搜索">
                       <button class="btn btn-white btn-xs " type="submit">查 询 </button>
                       </form>
                   </div>
                   <div class="col-lg-3 col-lg-offset-2 col-xs-4" style=" padding-right: 40px;text-align: right;">
                       <form>
                        <select>
                            <option value="正常">正常</option>
                            <option value="冻结">冻结</option>
                        </select>
                       <button class="btn btn-white btn-xs " type="submit">查 询 </button>
                       </form>
                   </div>
               </div>

    <div style="width:100%;height: 570px;border-top: 1px solid blue;">
        <table class="table table-striped">
            <tr>
                <th>用户名称</th>
                <th>用户密码</th>
                <th>用户年龄</th>
                <th>用户邮箱</th>
                <th>用户地址</th>
                <th>用户电话</th>
                <th>用户状态</th>
                <th>操作</th>
            </tr>
        <c:forEach var="u" items="${users}" >
            <tr <c:if test="${user.authority == 1 && u.id != user.id}">style="display: none;"</c:if>>
                <td>${u.username}</td>
                <td>*******</td>
                <td>${u.age}</td>
                <td>${u.email}</td>
                <td>${u.address}</td>
                <td>${u.phone}</td>
                <td>${u.userstatus}</td>
                <c:choose>
                    <c:when test="${u.id == user.id}">
                        <td>
                            <button class="btn btn-success btn-xs updateuser" name="${u.id}" data-toggle="modal" data-target="#changeChar">修改</button>
                            <button class="btn btn-danger btn-xs del" data-toggle="modal" name="${u.id}" disabled="disabled" data-target="#deleteChar">删除</button>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${user.authority == 0}">
                                <td>
                                    <button class="btn btn-success btn-xs updateuser" name="${u.id}" data-toggle="modal" <c:if test="${u.authority == 0}">disabled</c:if> data-target="#changeChar">修改</button>
                                    <button class="btn btn-danger btn-xs del" data-toggle="modal" name="${u.id}" <c:if test="${u.authority == 0}">disabled</c:if> data-target="#deleteChar">删除</button>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td>
                                    <button class="btn btn-success btn-xs updateuser" name="${u.id}" data-toggle="modal" disabled data-target="#changeChar">修改</button>
                                    <button class="btn btn-danger btn-xs del" data-toggle="modal" name="${u.id}" disabled data-target="#deleteChar">删除</button>
                                </td>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </tr>
        </c:forEach>
        </table>
    </div>
    <!--浮动div 用于修改当前用户信息-->
    <div class="modal fade" id="changeChar" role="dialog" aria-labelledby="gridSystemModalLabel">
         <div class="modal-dialog" role="document">
             <div class="modal-content">
                 <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                     <h4 class="modal-title" id="gridSystemModalLabel">用户信息修改</h4>
                 </div>
                 <div class="modal-body">
                     <div class="container-fluid">
                         <form class="form-horizontal">
                             <div class="form-group ">
                                 <div style="float: left;">
                                     <label for="username" class="col-xs-3 control-label" style="width: auto;">用户名称：</label>
                                     <div class="col-xs-6 ">
                                         <input type="text" class="form-control input-sm duiqi" id="username" placeholder="请输入用户名称">
                                     </div>
                                 </div>
                                 <div style="float: left;">
                                     <label for="age" class="col-xs-3 control-label" style="width: auto;">用户年龄：</label>
                                     <div class="col-xs-6 ">
                                         <input type="text" class="form-control input-sm duiqi" id="age" placeholder="请输入用户年龄">
                                     </div>
                                 </div>
                                 <div style="float: left;">
                                     <label for="email" class="col-xs-3 control-label" style="width: auto;">用户邮箱：</label>
                                     <div class="col-xs-6 ">
                                         <input type="text" class="form-control input-sm duiqi" id="email" placeholder="请输入用户邮箱">
                                     </div>
                                 </div>
                                 <div style="float: left;">
                                     <label for="address" class="col-xs-3 control-label" style="width: auto;">用户地址：</label>
                                     <div class="col-xs-6 ">
                                         <input type="text" class="form-control input-sm duiqi" id="address" placeholder="请输入用户地址">
                                     </div>
                                 </div>
                                 <div style="float: left;">
                                     <label for="phone" class="col-xs-3 control-label" style="width: auto;">用户电话：</label>
                                     <div class="col-xs-6 ">
                                         <input type="text" class="form-control input-sm duiqi" id="phone" placeholder="请输入用户电话">
                                     </div>
                                 </div>
                                 <div style="float: left;">
                                     <label for="authority" class="col-xs-3 control-label" style="width: auto;">用户角色：</label>
                                     <div class="col-xs-6">
                                         <select name="authority" class="form-control input-sm duiqi" id="authority">
                                             <option value="0">管理员</option>
                                             <option value="1">普通员</option>
                                         </select>
                                     </div>
                                 </div>
                                 <div style="float: left;">
                                     <label for="status" class="col-xs-3 control-label" style="width: auto;">用户状态：</label>
                                     <div class="col-xs-6">
                                         <select type="text" class="form-control input-sm duiqi" id="status">
                                             <option value="正常">正常</option>
                                             <option value="冻结">冻结</option>
                                         </select>
                                     </div>
                                 </div>
                             </div>
                         </form>
                     </div>
                 </div>
                 <div class="modal-footer">
                     <button type="button" id="update" class="btn btn-xs btn-green">保 存</button>
                     <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
                 </div>
             </div>
             <!-- /.modal-content -->
         </div>
         <!-- /.modal-dialog -->
    </div>
</body>
<script>
    $(".del").click(function () {
        if(confirm("是否删除?")){
            $.ajax({
                type:"get",
                url:"<%=application.getContextPath()%>/user/delete/"+$(this).attr("name"),
                dataType: 'json',
                success: function (data) {
                    if(data.code==200){
                        alert("删除成功!");
                        window.location.reload();
                    }else {
                        alert("删除失败!");
                    }
                }
            });
        }
    });
    $(".updateuser").click(function () {
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/user/query/"+$(this).attr("name"),
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    setUservalue(data,${user.authority});
                }else {
                    alert("当前更新有问题,请联系管理员！");
                }
            }
        });
    });
    function setUservalue(user,currentUserAuthority){
        document.getElementById("username").value=user.username;
        document.getElementById("username").readOnly=true;

        document.getElementById("age").value=user.age;
        document.getElementById("email").value=user.email;
        document.getElementById("address").value=user.address;
        document.getElementById("phone").value=user.phone;

        var status = document.getElementById("status");
        for(var i=0; i<status.options.length; i++){
            if(status.options[i].value == user.userstatus){
                status.options[i].selected = true;
                break;
            }
        }

        var authority = document.getElementById("authority");
        for(var i=0; i<authority.options.length; i++){
            if(authority.options[i].value == user.authority){
                authority.options[i].selected = true;
                break;
            }
        }
        //如果当前用户为普通员，则不能修改角色,状态
        if(currentUserAuthority == 1){
            $("#authority").attr("disabled","disabled");
            $("#status").attr("disabled","disabled");
        }
        else {
            $("#authority").removeAttr("disabled");
            $("#status").removeAttr("disabled");
        }

        document.getElementById("update").name=user.id;
    }
    $("#update").click(function () {
        var username = document.getElementById("username").value;
        var age = document.getElementById("age").value;
        var email = document.getElementById("email").value;
        var address = document.getElementById("address").value;
        var phone = document.getElementById("phone").value;
        var statusValue;
        var status = document.getElementById("status");
        for(var i=0; i<status.options.length; i++){
            if(status.options[i].selected){
                statusValue=status.options[i].value;
                break;
            }
        }
        var authorityValue;
        var authority = document.getElementById("authority");
        for(var i=0; i<authority.options.length; i++){
            if(authority.options[i].selected){
                authorityValue=authority.options[i].value;
                break;
            }
        }
        $.ajax({
            type:"post",
            url:"<%=application.getContextPath()%>/user/save/"+$(this).attr("name"),
            dataType: 'json',
            data:{
                username:username,
                age:age,
                email:email,
                address:address,
                phone:phone,
                statusValue:statusValue,
                authorityValue:authorityValue
            },
            success: function (data) {
                if(data.code == 200){
                    alert("保存成功！");
                    window.location.reload();
                }else {
                    alert("保存失败,请联系管理员！");
                }
            }
        });
    });
</script>
</html>
