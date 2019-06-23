<%--
  Created by IntelliJ IDEA.
  User: ysq
  Date: 2019/05/15
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title><script src="<%=application.getContextPath()%>/js/jquery.min.js"></script>
    <script src="<%=application.getContextPath()%>/js/bootstrap.min.js"></script>
    <script>
        $(function() {
            $(".meun-item").click(function() {
                $(".meun-item").removeClass("meun-item-active");
                $(this).addClass("meun-item-active");
                var itmeObj = $(".meun-item").find("img");
                itmeObj.each(function() {
                    var items = $(this).attr("src");
                    items = items.replace("_grey.png", ".png");
                    items = items.replace(".png", "_grey.png")
                    $(this).attr("src", items);
                });
                var attrObj = $(this).find("img").attr("src");
                ;
                attrObj = attrObj.replace("_grey.png", ".png");
                $(this).find("img").attr("src", attrObj);
            });
            $(".toggle-btn").click(function() {
                $("#leftMeun").toggleClass("show");
                $("#rightContent").toggleClass("pd0px");
            })
        });
    </script>
    <script src="<%=application.getContextPath()%>/js/jquery.min.js"></script>
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
            <input type="text" class="form-control input-sm" name="username" placeholder="输入宠物名称搜索">
            <button class="btn btn-white btn-xs " type="submit" >查 询 </button>
        </form>
    </div>
    <div class="col-xs-4">
        <form>
            <select>
                <c:forEach var="c" items="${category}">
                    <option value="${c.id}">${c.name}</option>
                </c:forEach>
            </select>
            <button class="btn btn-white btn-xs " type="submit">查 询 </button>
        </form>
    </div>
    <div class="col-lg-3 col-lg-offset-2 col-xs-4" style=" padding-right: 40px;text-align: right;">
        <form>
            <select>
                <option value="已领养">已领养</option>
                <option value="未领养">未领养</option>
                <option value="已认领">已领养</option>
                <option value="未认领">未领养</option>
                <option value="已寄养">已寄养</option>
                <option value="未寄养">未寄养</option>
            </select>
            <button class="btn btn-white btn-xs " type="submit">查 询 </button>
        </form>
    </div>
</div>

<div  style="overflow-y:auto;width:100%;height: 560px;border-top: 1px solid blue;">
    <table class="table table-striped">
        <tr>
            <th>编号</th>
            <th>宠物名称</th>
            <th>宠物年龄</th>
            <th>宠物性别</th>
            <th>宠物类别</th>
            <th>宠物照片</th>
            <th>宠物标签</th>
            <th>认领|领养|寄养</th>
            <th>操作</th>
        </tr>
        <c:forEach var="p" items="${pet}" >
            <tr>
                <td>${p.id}</td>
                <td>${p.name}</td>
                <td>${p.age}&nbsp;岁</td>
                <td>
                    <c:if test="${p.sex==1}">雌性</c:if>
                    <c:if test="${p.sex==0}">雄性</c:if>
                </td>
                <td>
                    <c:forEach var="c" items="${category}" >
                        <c:if test="${c.id == p.categoryId}">
                            ${c.name}
                        </c:if>
                    </c:forEach>
                </td>
                <td><img src="<%=application.getContextPath()%>/${p.photourls}" width="70px" height="70px"/></td>
                <td>
                    <c:forEach var="t" items="${tag}" >
                        <c:if test="${t.id == p.tags}">
                            ${t.name}
                        </c:if>
                    </c:forEach>
                </td>
                <td>${p.status}</td>
                <td>

                    <c:if test="${p.userId == user.id}">
                        <c:choose>
                            <c:when test="${p.status == '待认领' || p.status == '待领养'|| p.status == '待寄养'}">
                                <button class="btn btn-success btn-xs confirmclaiming" data-toggle="modal"
                                        data-target="#confirmclaiming" name="${p.adoptId}|${p.id}|${p.status}" >是否同意</button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-success btn-xs update" data-toggle="modal"
                                        <c:if test="${p.status == '已认领' || p.status == '已领养'|| p.status == '已寄养'}">disabled</c:if>
                                        data-target="#updatePet" name="${p.id}" >发布修改</button>
                            </c:otherwise>
                        </c:choose>
                    </c:if>

                    <c:if test="${p.userId != user.id}">
                        <%--认领模块--%>
                        <c:if test="${p.status == '已认领'}">
                            <button class="btn btn-success btn-xs finishclaim" name="${p.userId}" data-toggle="modal" data-target="#claimDetail">查看详情</button>
                        </c:if>
                        <c:if test="${p.status == '待认领'}">
                            <button class="btn btn-success btn-xs claiming" name="${p.userId}" data-toggle="modal" data-target="#claiming">待认领中</button>
                        </c:if>
                        <c:if test="${p.status == '未认领'}">
                            <button class="btn btn-success btn-xs unclaim" name="${p.userId}|${p.id}" data-toggle="modal" data-target="#unClaim">确认认领</button>
                        </c:if>

                        <%--领养模块--%>
                        <c:if test="${p.status == '已领养'}">
                            <button class="btn btn-success btn-xs finishadopt" name="${p.userId}" data-toggle="modal" data-target="#adoptDetail">查看详情</button>
                        </c:if>
                        <c:if test="${p.status == '待领养'}">
                            <button class="btn btn-success btn-xs adopting" name="${p.userId}" data-toggle="modal" data-target="#adopting">待领养中</button>
                        </c:if>
                        <c:if test="${p.status == '未领养'}">
                            <button class="btn btn-success btn-xs unadopt" name="${p.userId}|${p.id}" data-toggle="modal" data-target="#unAdopt">确认领养</button>
                        </c:if>

                        <%--寄养模块--%>
                        <c:if test="${p.status == '已寄养'}">
                            <button class="btn btn-success btn-xs finishfoster" name="${p.userId}" data-toggle="modal" data-target="#fosterDetail">查看详情</button>
                        </c:if>
                        <c:if test="${p.status == '待寄养'}">
                            <button class="btn btn-success btn-xs fostering" name="${p.userId}" data-toggle="modal" data-target="#fostering">待寄养中</button>
                        </c:if>
                        <c:if test="${p.status == '未寄养'}">
                            <button class="btn btn-success btn-xs unfoster" name="${p.userId}|${p.id}" data-toggle="modal" data-target="#unFoster">确认寄养</button>
                        </c:if>
                    </c:if>
                    <%--只能删除自己发布的信息--%>
                    <button class="btn btn-danger btn-xs del" name="${p.id}" data-toggle="modal"
                            <c:if test="${p.userId != user.id}">disabled</c:if>
                            data-target="#deleteChar">删除</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<!--浮动div 用于修改宠物信息-->
<div class="modal fade" id="updatePet" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel">宠物信息修改</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
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
                                    <input type="radio" value="0" name="sex" id="sex0">雄性
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" value="1" name="sex" id="sex1">雌性
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="tp" class="col-xs-4 control-label">图片上传：</label>
                            <div class="col-xs-5">
                                <input type="file" disabled="disabled" class="form-control duiqi" id="tp" name="tp" style="margin-top: 7px;">
                                <input type="hidden" id="fileurl">
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
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="save" class="btn btn-xs btn-green">保 存</button>
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>


<!--浮动div 用于claimDetail认领详情查看信息-->
<div class="modal fade" id="claimDetail" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">认领详细信息</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label>
                                &nbsp;&nbsp;发布人已同意本次认领，请及时与发布人进行联系！
                            </label>
                            <br>
                            <label>
                                &nbsp;&nbsp;发布人：<label id="faburenname" style="color: red;"/>
                            </label>
                            <br>
                            <label style="color: red; font-weight: bold; width: 400px; text-align: center;">
                                发布人联系方式：<label id="faburenphone"/>
                            </label>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!--浮动div 用于claiming待认领查看信息-->
<div class="modal fade" id="claiming" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">待认领详情信息</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label>
                                &nbsp;&nbsp;您已向发布者发送认领信息了，请耐心等待...
                            </label>
                            <br>
                            <label>
                                &nbsp;&nbsp;发布者：<label id="pubusernameing" style="color: red;"/>
                            </label>
                            <br>
                            <label style="color: red; font-weight: bold; width: 400px; text-align: center;">
                                发布者联系方式：<label id="pubuserphoneing"/>
                            </label>

                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!--浮动div 用于unClaim确认认领查看信息-->
<div class="modal fade" id="unClaim" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">确认认领信息</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <input type="hidden" id="currentPet"/>
                        <div class="form-group">
                            <label>
                                &nbsp;&nbsp;该条信息发布者：<label id="pubusername" style="color: red;"/>;
                            </label>
                            <br>
                            <label>
                                &nbsp;&nbsp;联系电话：<label id="pubuserphone" style="color: red;"/>,
                            </label>
                            <br>
                            <label style="color: red; font-weight: bold; width: 400px; text-align: center;">
                                当前状态，在认领后不可更改！
                            </label>

                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="claimSave" class="btn btn-xs btn-green">确 认</button>
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!--浮动div 用于confirmclaiming发布者认领(领养)确认-->
<div class="modal fade" id="confirmclaiming" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">是否同意认领|领养|寄养信息</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <input type="hidden" id="currentclaimPet"/>
                            <input type="hidden" id="currentStatus"/>
                            <label>
                                &nbsp;&nbsp;您发布的认领(领养、寄养)信息，已被认领(领养、寄养)...,<br>请确认是否同意认领(领养、寄养)？
                            </label>
                            <br>
                            <label>
                                &nbsp;&nbsp;认领(领养、寄养)人：<label id="renlingusernameing" style="color: red;"/>
                            </label>
                            <br>
                            <label style="color: red; font-weight: bold; width: 400px; text-align: center;">
                                认领(领养、寄养)者联系方式：<label id="renlinguserphoneing"/>
                            </label>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="claimok" class="btn btn-xs btn-green">同 意</button>
                <button type="button" id="claimno" class="btn btn-xs btn-green">不同意</button>
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>


<!--浮动div 用于adoptDetail领养详情查看信息-->
<div class="modal fade" id="adoptDetail" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">领养详情信息</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label>
                                &nbsp;&nbsp;发布人已同意本次领养，请及时与发布人进行联系！
                            </label>
                            <br>
                            <label>
                                &nbsp;&nbsp;发布人：<label id="adoptfaburenname" style="color: red;"/>
                            </label>
                            <br>
                            <label style="color: red; font-weight: bold; width: 400px; text-align: center;">
                                发布人联系方式：<label id="adoptfaburenphone"/>
                            </label>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">关 闭</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!--浮动div 用于adopting待领养查看信息-->
<div class="modal fade" id="adopting" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">待领养详情信息</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label>
                                &nbsp;&nbsp;您已向发布者发送领养信息了，请耐心等待...
                            </label>
                            <br>
                            <label>
                                &nbsp;&nbsp;发布者：<label id="adoptpubusernameing" style="color: red;"/>
                            </label>
                            <br>
                            <label style="color: red; font-weight: bold; width: 400px; text-align: center;">
                                发布者联系方式：<label id="adoptpubuserphoneing"/>
                            </label>

                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!--浮动div 用于unAdopt确认领养查看信息-->
<div class="modal fade" id="unAdopt" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">确认领养信息</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <input type="hidden" id="adoptcurrentPet"/>
                        <div class="form-group">
                            <label>
                                &nbsp;&nbsp;该条信息发布者：<label id="adoptpubusername" style="color: red;"/>;
                            </label>
                            <br>
                            <label>
                                &nbsp;&nbsp;联系电话：<label id="adoptpubuserphone" style="color: red;"/>,
                            </label>
                            <br>
                            <label style="color: red; font-weight: bold; width: 400px; text-align: center;">
                                当前状态，在领养后不可更改！
                            </label>

                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="adoptSave" class="btn btn-xs btn-green">确 认</button>
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>


<!--浮动div 用于adoptFoster寄养详情查看信息-->
<div class="modal fade" id="fosterDetail" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">寄养详情信息</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label>
                                &nbsp;&nbsp;发布人已同意本次寄养，请及时与发布人进行联系！
                            </label>
                            <br>
                            <label>
                                &nbsp;&nbsp;发布人：<label id="fosterfaburenname" style="color: red;"/>
                            </label>
                            <br>
                            <label style="color: red; font-weight: bold; width: 400px; text-align: center;">
                                发布人联系方式：<label id="fosterfaburenphone"/>
                            </label>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">关 闭</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!--浮动div 用于fostering待寄养查看信息-->
<div class="modal fade" id="fostering" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">待寄养详情信息</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label>
                                &nbsp;&nbsp;您已向发布者发送寄养信息了，请耐心等待...
                            </label>
                            <br>
                            <label>
                                &nbsp;&nbsp;发布者：<label id="fosterpubusernameing" style="color: red;"/>
                            </label>
                            <br>
                            <label style="color: red; font-weight: bold; width: 400px; text-align: center;">
                                发布者联系方式：<label id="fosterpubuserphoneing"/>
                            </label>

                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!--浮动div 用于unFoster确认寄养查看信息-->
<div class="modal fade" id="unFoster" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">确认寄养信息</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <input type="hidden" id="fostercurrentPet"/>
                        <div class="form-group">
                            <label>
                                &nbsp;&nbsp;该条信息发布者：<label id="fosterpubusername" style="color: red;"/>;
                            </label>
                            <br>
                            <label>
                                &nbsp;&nbsp;联系电话：<label id="fosterpubuserphone" style="color: red;"/>,
                            </label>
                            <br>
                            <label style="color: red; font-weight: bold; width: 400px; text-align: center;">
                                当前状态，在寄养后不可更改！
                            </label>

                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="fosterSave" class="btn btn-xs btn-green">确 认</button>
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(".del").click(function () {
        if(confirm("是否删除您发布的信息?")){
            $.ajax({
                type:"get",
                url:"<%=application.getContextPath()%>/pet/del/"+$(this).attr("name"),
                dataType: 'json',
                success: function (data) {
                    if(data.code==200){
                        alert("您发布的信息已删除成功！");
                        window.location.reload();
                    }else {
                        alert("删除失败,请联系管理员！");
                    }
                }
            })
        }
    });
    $(".update").click(function () {
        //弹出修改窗体，对发布的宠物信息进行修改，获取修改的对象，并赋值
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/pet/query/"+$(this).attr("name"),
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    setValue(data);
                }else {
                    alert("当前更新有问题,请联系管理员！");
                }
            }
        });
    });
    function setValue(pet){
        var select = document.getElementById("categoryId");
        for(var i=0; i<select.options.length; i++){
            if(select.options[i].value == pet.categoryId){
                select.options[i].selected = true;
                break;
            }
        }
        document.getElementById("name").value=pet.name;
        document.getElementById("age").value=pet.age;
        if(pet.sex == 0)
            document.getElementById("sex0").checked="checked";
        else
            document.getElementById("sex1").checked="checked";
        //出于安全考虑，不能直接在js中赋值。
        //var file = document.getElementById("tp").value=pet.photourls;
        document.getElementById("fileurl").value=pet.photourls;

        var tagsselect = document.getElementById("tags");
        for(var i=0; i<tagsselect.options.length; i++){
            if(tagsselect.options[i].value == pet.tags){
                tagsselect.options[i].selected = true;
                break;
            }
        }
        document.getElementById("save").name=pet.id;//绑定宠物id
    }
    $("#save").click(function () {
        //保存修改的信息
        var categoryid=0;
        var select = document.getElementById("categoryId");
        for(var i=0; i<select.options.length; i++){
            if(select.options[i].selected){
                 categoryid=select.options[i].value;
                break;
            }
        }
        var petname = document.getElementById("name").value;
        var petage = document.getElementById("age").value;
        //var sex = 0;
        var sex = $('input:radio[name="sex"]:checked').val();
        var fileurl = "";
        var upfile = document.getElementById("tp").files[0];
        if(upfile != null)
            fileurl = upfile['name'];
        else
            fileurl = document.getElementById("fileurl").value;
        var tagid = 0;
        var tagsselect = document.getElementById("tags");
        for(var i=0; i<tagsselect.options.length; i++){
            if(tagsselect.options[i].selected){
                tagid = tagsselect.options[i].value;
                break;
            }
        }
        $.ajax({
            type:"post",
            url:"<%=application.getContextPath()%>/pet/save/"+$(this).attr("name"),
            dataType: 'json',
            data:{
                categoryid:categoryid,
                petname:petname,
                petage:petage,
                sex:sex,
                fileurl:fileurl,
                tagid:tagid
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
    //遗失--认领
    $(".unclaim").click(function () {
        //确认认领前（发布者id）获取发布者信息
        var pubid = $(this).attr('name');
        document.getElementById("currentPet").value = pubid.split('|')[1];
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/user/query/"+pubid.split('|')[0],
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    document.getElementById("pubusername").innerHTML = data.username;
                    document.getElementById("pubuserphone").innerHTML = data.phone;
                }else {
                    alert("获取发布者信息失败,请联系管理员！");
                }
            }
        });
    });
    $("#claimSave").click(function () {
        //alert("进行确认，将pet状态改为待认领中，同时在pet表中添加认领人id,此后由发布者在待认领中点击确认，即可");
        var currentuserid = ${user.id};//当前登录的人，在这里表示认领的人id
        $.ajax({
            type:"post",
            url:"<%=application.getContextPath()%>/pet/updatuser/"+$("#currentPet").val(),
            dataType: 'json',
            data: {
                adoptid : currentuserid
            },
            success: function (data) {
                if(data.code == 200){
                    alert("您已确认成功,等待发布者确认即可完成认领!");
                    window.location.reload();
                }else {
                    alert("确认认领失败,请联系管理员！");
                }
            }
        });
    });
    $(".finishclaim").click(function () {
        var pubid = $(this).attr('name');
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/user/query/"+pubid,
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    document.getElementById("faburenname").innerHTML = data.username;
                    document.getElementById("faburenphone").innerHTML = data.phone;
                }else {
                    alert("获取发布者信息失败,请联系管理员！");
                }
            }
        });
    });
    $(".claiming").click(function () {
        var pubid = $(this).attr('name');
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/user/query/"+pubid,
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    document.getElementById("pubusernameing").innerHTML = data.username;
                    document.getElementById("pubuserphoneing").innerHTML = data.phone;
                }else {
                    alert("获取发布者信息失败,请联系管理员！");
                }
            }
        });
    });
    $(".confirmclaiming").click(function () {
        var renling = $(this).attr('name');
        document.getElementById("currentclaimPet").value = renling.split('|')[1];
        document.getElementById("currentStatus").value=renling.split('|')[2];
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/user/query/"+renling.split('|')[0],
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    document.getElementById("renlingusernameing").innerHTML = data.username;
                    document.getElementById("renlinguserphoneing").innerHTML = data.phone;
                }else {
                    alert("获取认领(领养、寄养)者信息失败,请联系管理员！");
                }
            }
        });
    });
    $("#claimok").click(function () {
        confirmclaim(1,$("#currentStatus").val());
    });
    $("#claimno").click(function () {
        confirmclaim(0,$("#currentStatus").val());
    });
    function confirmclaim(okorno,status) {
        $.ajax({
            type:"post",
            url:"<%=application.getContextPath()%>/pet/updatestatus/"+$("#currentclaimPet").val(),
            dataType: 'json',
            data:{okorno:okorno,status:status},
            success: function (data) {
                if(data != null){
                    alert("您已确认成功，认领(领养、寄养)人将会联系您，请耐心等待！");
                    window.location.reload();
                }else {
                    alert("确认失败,请联系管理员！");
                }
            }
        });
    }
    //流浪--领养
    $(".unadopt").click(function () {
        var pubid = $(this).attr('name');
        document.getElementById("adoptcurrentPet").value = pubid.split('|')[1];
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/user/query/"+pubid.split('|')[0],
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    document.getElementById("adoptpubusername").innerHTML = data.username;
                    document.getElementById("adoptpubuserphone").innerHTML = data.phone;
                }else {
                    alert("获取发布者信息失败,请联系管理员！");
                }
            }
        });
    });
    $("#adoptSave").click(function () {
        var currentuserid = ${user.id};//当前登录的人，在这里表示认领的人id
        $.ajax({
            type:"post",
            url:"<%=application.getContextPath()%>/pet/adoptupdatuser/"+$("#adoptcurrentPet").val(),
            dataType: 'json',
            data: {
                adoptid : currentuserid
            },
            success: function (data) {
                if(data.code == 200){
                    alert("您已确认成功,等待发布者确认即可完成领养!");
                    window.location.reload();
                }else {
                    alert("确认领养失败,请联系管理员！");
                }
            }
        });
    });
    $(".finishadopt").click(function () {
        var pubid = $(this).attr('name');
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/user/query/"+pubid,
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    document.getElementById("adoptfaburenname").innerHTML = data.username;
                    document.getElementById("adoptfaburenphone").innerHTML = data.phone;
                }else {
                    alert("获取发布者信息失败,请联系管理员！");
                }
            }
        });
    });
    $(".adopting").click(function () {
        var pubid = $(this).attr('name');
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/user/query/"+pubid,
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    document.getElementById("adoptpubusernameing").innerHTML = data.username;
                    document.getElementById("adoptpubuserphoneing").innerHTML = data.phone;
                }else {
                    alert("获取发布者信息失败,请联系管理员！");
                }
            }
        });
    });

    //嘱托--寄养
    $(".unfoster").click(function () {
        var pubid = $(this).attr('name');
        document.getElementById("fostercurrentPet").value = pubid.split('|')[1];
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/user/query/"+pubid.split('|')[0],
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    document.getElementById("fosterpubusername").innerHTML = data.username;
                    document.getElementById("fosterpubuserphone").innerHTML = data.phone;
                }else {
                    alert("获取发布者信息失败,请联系管理员！");
                }
            }
        });
    });
    $("#fosterSave").click(function () {
        var currentuserid = ${user.id};//当前登录的人，在这里表示认领的人id
        $.ajax({
            type:"post",
            url:"<%=application.getContextPath()%>/pet/fosterupdatuser/"+$("#fostercurrentPet").val(),
            dataType: 'json',
            data: {
                fosterid : currentuserid
            },
            success: function (data) {
                if(data.code == 200){
                    alert("您已确认成功,等待发布者确认即可完成寄养!");
                    window.location.reload();
                }else {
                    alert("确认寄养失败,请联系管理员！");
                }
            }
        });
    });
    $(".finishfoster").click(function () {
        var pubid = $(this).attr('name');
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/user/query/"+pubid,
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    document.getElementById("fosterfaburenname").innerHTML = data.username;
                    document.getElementById("fosterfaburenphone").innerHTML = data.phone;
                }else {
                    alert("获取发布者信息失败,请联系管理员！");
                }
            }
        });
    });
    $(".fostering").click(function () {
        var pubid = $(this).attr('name');
        $.ajax({
            type:"get",
            url:"<%=application.getContextPath()%>/user/query/"+pubid,
            dataType: 'json',
            success: function (data) {
                if(data != null){
                    document.getElementById("fosterpubusernameing").innerHTML = data.username;
                    document.getElementById("fosterpubuserphoneing").innerHTML = data.phone;
                }else {
                    alert("获取发布者信息失败,请联系管理员！");
                }
            }
        });
    });
</script>
</html>
