<%--
  Created by IntelliJ IDEA.
  User: ysq
  Date: 2019/5/16
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<body style="height:100%">
<table width="100%" style="height:100%;" border="1" cellpadding="0" cellspacing="0">
    <tr style="height:96%;">
        <td>&nbsp;</td>
        <td width="100%" bgcolor="#F7F8F9">
            <table width="100%" style="height:100%;" border="1" align="center" cellpadding="0" cellspacing="0">
                <tr style="height:4%">
                    <td colspan="3">&nbsp;</td>
                </tr>

                <tr style="height: 48%">
                    <td valign="top" width="47%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="line_table">
                            <tr>
                                <td width="3%"></td>
                                <td width="94%" class="left_bt2"><span style="font-size:17px;font-weight: bold;">温馨提示</span><br><br>

                                    <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        这里是宠物系统管理中的首页信息界面，管理系统中的通知、公告信息、发布宠物的待领养信息、宠物遗失启事、留言通知等将在这里展现出来，如果您有任何疑问请联系管理员！</div>
                                    <br><br><br><br><br>
                                    <div align="center"> <span style="color:#ff17a5;font-size:15px; font-family: '楷体';font-weight: bold;">此系统版本权归个人所有，盗版必究！...</span></div>
                                </td>
                                <td width="3%"></td>
                            </tr>
                        </table>
                    </td>
                    <td width="6%">&nbsp;</td>
                    <td valign="top" width="47%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="line_table">
                            <tr>
                                <td width="3%"></td>
                                <td width="94%" class="left_bt2"><span style="font-size:17px;font-weight: bold;">最新公告</span><br>
                                    <c:if test="${empty list}">
                                        <span style="color:blue; font-size:18px;font-weight: bold; font-family:'楷体';text-indent:2em"><marquee behavior=alternate><p> 感谢您使用 管理系统</p></marquee></span>
                                    </c:if>
                                    <div>
                                        <c:if  test="${!empty list}">
                                            <c:forEach items="${list}" var="v" varStatus="s">
                                                ${s.count}.${v.goodsName}&nbsp;&nbsp;
                                            </c:forEach><br>
                                        </c:if>
                                    </div>
                                </td>
                                <td width="3%"></td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr style="height: 48%">
                    <td valign="top">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="line_table">
                            <tr>
                                <td width="3%"></td>
                                <td width="94%" class="left_bt2"><span style="font-size:17px;font-weight: bold;">宠物展示</span><br><br>

                                    <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        敬请期待...</div>
                                </td>
                                <td width="3%"></td>
                            </tr>
                        </table>
                    </td>
                    <td>&nbsp;</td>
                    <td valign="top">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="line_table">
                            <tr>
                                <td width="3%"></td>
                                <td width="94%" class="left_bt2"><span style="font-size:17px;font-weight: bold;">最新留言</span><br>
                                    <c:if test="${empty list}">
                                        <span style="color:blue; font-size:18px;font-weight: bold; font-family:'楷体';text-indent:2em"><marquee behavior=alternate><p> 感谢您使用 管理系统</p></marquee></span>
                                    </c:if>
                                    <div>
                                        <c:if  test="${!empty list}">
                                            <c:forEach items="${list}" var="v" varStatus="s">
                                                ${s.count}.${v.goodsName}&nbsp;&nbsp;
                                            </c:forEach><br>
                                        </c:if>
                                    </div>
                                </td>
                                <td width="3%"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr style="height:4%;">
        <td>&nbsp;</td>
        <td align="center" valign="middle" style="color: blue; height: 10%;">&nbsp;(C)2019-2025 CHEN PEI PEI.保留所有权利@.&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>
</body>
</html>
