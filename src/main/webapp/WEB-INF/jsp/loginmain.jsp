<%--
  Created by IntelliJ IDEA.
  User: ysq
  Date: 2019/5/16
  Time: 9:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <meta name="format-detection" content="telephone=no">
        <title>宠物管理系统</title>
        <script src="<%=application.getContextPath()%>/js/jquery.min.js"></script>
        <script src="<%=application.getContextPath()%>/js/bootstrap.min.js"></script>
        <script src="<%=application.getContextPath()%>/js/Clock.js"></script>
        <script>
            $(function() {
                var clock=new Clock();
                clock.display(document.getElementById("clock"));
                //左侧菜单隐藏/显示
                $(".toggle-btn").click(function() {
                    $("#leftMeun").toggleClass("show");
                    $("#rightContent").toggleClass("pd0px");
                });
                //菜单点击后显示选中样式
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
                    attrObj = attrObj.replace("_grey.png", ".png");
                    $(this).find("img").attr("src", attrObj);
                });
            });
            //安全退出
            function logout() {
                if (confirm("您确定要退出登录吗？")) {
                    top.location.href = "<%=application.getContextPath()%>/user/logout";
                    return false;
                }
            }

            //模块刷新(目前只有首页,用户查询，宠物查询，添加宠物需要)
            function refreshContent(iframeid) {
                    document.getElementById(iframeid).contentWindow.location.reload();
            }
            //密码修改
            function upPwd() {
                var userid = $("#userupid").val();
                var pwdold = $("#oldpwd").val();
                if(pwdold =="" || pwdold != $("#useroldpwd").val())
                {
                    alert("您输入的旧密码不正确，请重新输入！");
                    $("#oldpwd").val("");
                    return false;
                }
                var pwdnew0 = $("#newpwd0").val();
                var pwdnew1 = $("#newpwd1").val();
                if(pwdnew0 == "" || pwdnew0 != pwdnew1){
                    alert("您两次输入的新密码不一致，请重新输入！");
                    $("#newpwd0").val("");
                    $("#newpwd1").val("");
                    return false;
                }
                $.ajax({
                    type:"post",
                    url:"<%=application.getContextPath()%>/user/updatepwd/"+userid,
                    dataType: 'json',
                    data:{
                        pwdnew:pwdnew1
                    },
                    success: function (data) {
                        if(data.code == 200){
                            alert("密码修改成功，点击确认将跳转到登陆界面！");
                            top.location.href = "<%=application.getContextPath()%>/user/logout";
                        }else {
                            alert("修改失败,请联系管理员！");
                        }
                    }
                });
            }
        </script>
        <!--[if lt IE 9]>
        <script src="<%=application.getContextPath()%>/js/html5.js"></script>
        <script src="<%=application.getContextPath()%>/js/respond.min.js"></script>
        <![endif]-->
        <link href="<%=application.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/common.css" />
        <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/slide.css" />
        <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/flat-ui.min.css" />
        <link rel="stylesheet" type="text/css" href=".<%=application.getContextPath()%>/css/jquery.nouislider.css">

        <style>
            iframe{
                width:100%;
                height:650px;
            }
        </style>
    </head>

<body>
<div id="wrap">
    <!-- 左侧菜单栏目块 -->
    <div class="leftMeun" id="leftMeun">
        <div id="logoDiv">
            <p id="logoP" href="#notice" onclick="refreshContent('usernotice')" aria-controls="notice" role="tab" data-toggle="tab" style="cursor: pointer;" title="首页公告"><img id="logo" src="../../images/logo.png"/><span>宠物管理系统</span></p>
        </div>
        <div id="personInfor">
            <p><span id="clock"></span></p>
            <p>
                <span>用户角色：</span><span id="userAuthority">
                    <c:choose>
                        <c:when test="${user.authority == 0}">管理员</c:when>
                        <c:otherwise>普通员</c:otherwise>
                    </c:choose>
                </span>
            </p>
            <p><span>在线用户名：</span><span id="userName">${user.username}</span></p>
            <p><span>当前状态：</span><span id="userStatus">在线</span></p>
            <p>
                <span>
                    <a href="#" target="_self" onClick="logout();" style="text-decoration: none;color: #FF191F;">安全退出</a>
                </span>
                &nbsp;&nbsp;&nbsp;
                <span>
                    <a href="#" target="_self" data-toggle="modal" data-target="#changePwd" style="text-decoration: none;color: #22FF31;" >修改密码</a>
                </span>
            </p>
        </div>
        <div style="overflow-y: auto; height: 60%;">
            <div class="meun-title">用户管理</div>
            <div class="meun-item" href="#sour" onclick="refreshContent('useridex')" aria-controls="sour" role="tab" data-toggle="tab"><img src="../../images/icon_source.png">查询用户</div>
            <div class="meun-item" href="#char" <c:if test="${user.authority == 1}">style="display: none;"</c:if> aria-controls="char" role="tab" data-toggle="tab"><img src="../../images/icon_chara_grey.png">添加用户</div>

            <div class="meun-title">宠物管理</div>
            <div class="meun-item" href="#scho" onclick="refreshContent('petindex')" aria-controls="scho" role="tab" data-toggle="tab"><img src="../../images/icon_house_grey.png">查询宠物</div>
            <div class="meun-item" href="#regu" onclick="refreshContent('petadd')" aria-controls="regu" role="tab" data-toggle="tab"><img src="../../images/icon_rule_grey.png">添加宠物</div>
            <div class="meun-item" href="#stud" <c:if test="${user.authority == 1}">style="display: none;"</c:if> aria-controls="stud" role="tab" data-toggle="tab"><img src="../../images/icon_card_grey.png">标签管理</div>
            <div class="meun-item" href="#category" <c:if test="${user.authority == 1}">style="display: none;"</c:if> aria-controls="type" role="tab" data-toggle="tab"><img src="../../images/icon_char_grey.png">类别管理</div>

            <div class="meun-title">留言管理</div>
            <div class="meun-item" href="#querymessage" aria-controls="querymessage" role="tab" data-toggle="tab"><img src="../../images/icon_house_grey.png">查询留言</div>
            <div class="meun-item" href="#mymessage" aria-controls="mymessage" role="tab" data-toggle="tab"><img src="../../images/icon_change_grey.png">我的留言</div>
        </div>

    </div>
    <!-- 右侧具体内容栏目 -->
    <div id="rightContent">
        <!--左侧隐藏按钮-->
        <a class="toggle-btn" id="nimei">
            <i class="glyphicon glyphicon-align-justify"></i>
        </a>
        <!-- Tab panes -->
        <div class="tab-content">

            <!--首页公告信息-->
            <div role="tabpanel" class="tab-pane active" id="notice">
                <iframe id="usernotice" src="<%=application.getContextPath()%>/user/notice"></iframe>
            </div>

            <!--1.用户管理-->
            <!-- 查询用户模块 -->
            <div role="tabpanel" class="tab-pane" id="sour">
                <iframe id="useridex" src="<%=application.getContextPath()%>/user/index"></iframe>
            </div>
            <!-- 添加用户模块 -->
            <div role="tabpanel" class="tab-pane" id="char">
                <iframe id="qjuseradd" src="<%=application.getContextPath()%>/qj/useradd"></iframe>
            </div>

            <!--2.宠物管理-->
            <!--查询宠物模块-->
            <div role="tabpanel" class="tab-pane" id="scho">
                <iframe id="petindex" src="<%=application.getContextPath()%>/pet/index" > </iframe>
                <%--src="/pet/index"--%>
            </div>
            <!--添加宠物模块-->
            <div role="tabpanel" class="tab-pane" id="regu" style="padding-top: 50px;">
                <iframe id="petadd" src="<%=application.getContextPath()%>/pet/petadd"></iframe>
            </div>
            <!--标签管理模块-->
            <div role="tabpanel" class="tab-pane" id="stud">
                <iframe id="tagindex" src="<%=application.getContextPath()%>/tag/index"></iframe>
            </div>
            <!-- 类别管理模块 -->
            <div role="tabpanel" class="tab-pane" id="category">
                <iframe id="categoryindex" src="<%=application.getContextPath()%>/category/index"></iframe>
            </div>

            <!--3.留言管理-->
            <!-- 查询留言模块 -->
            <div role="tabpanel" class="tab-pane" id="querymessage">
                <iframe id="orderindex" src="<%=application.getContextPath()%>/order/index"></iframe>
            </div>
            <!-- 我的留言模块 -->
            <div role="tabpanel" class="tab-pane" id="mymessage">
                <iframe src="<%=application.getContextPath()%>/order/index"></iframe>
            </div>

        </div>
    </div>
</div>
<!--浮动div 用于修改密码信息-->
<div class="modal fade" id="changePwd" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel">密码修改</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form class="form-horizontal">
                        <div class="form-group ">
                            <div style="float: left;">
                                <label for="oldpwd" class="col-xs-3 control-label" style="width: auto;">旧密码：</label>
                                <div class="col-xs-6 ">
                                    <input type="password" class="form-control input-sm duiqi" id="oldpwd" placeholder="请输入旧密码">
                                </div>
                            </div>
                            <div style="float: left;">
                                <label for="newpwd0" class="col-xs-3 control-label" style="width: auto;">新密码：</label>
                                <div class="col-xs-6 ">
                                    <input type="password" class="form-control input-sm duiqi" id="newpwd0" placeholder="请输入新密码">
                                </div>
                            </div>
                            <div style="float: left;">
                                <label for="newpwd1" class="col-xs-3 control-label" style="width: auto;">确认新密码：</label>
                                <div class="col-xs-6 ">
                                    <input type="password" class="form-control input-sm duiqi" id="newpwd1" placeholder="请再次输入新密码">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="userupid" value="${user.id}">
                <input type="hidden" id="useroldpwd" value="${user.password}">
                <button type="button" id="updatepwd" onclick="upPwd();" class="btn btn-xs btn-green">保 存</button>
                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
