<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CYHRMS.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>常运物流人事管理系统登录界面-www.cy-logistics.cn</title>
    <link href="CSS/alogin.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div class="Middle_Heng"></div>
    <form id="form1" runat="server">


        <div class="Main">
            <ul>
                <li class="top">.</li>
                <li class="top2"></li>
                <li class="topA"></li>
                <li class="topB">
                    <span>
                        <img src="Images/login/logo.gif" alt="" width="245" height="107" style="" />

                    </span>

                </li>
                <li class="topC"></li>
                <li class="topD">
                    <ul class="login">
                        <li>
                            <span class="left">用户名</span> <span style="left">
                                <!--<input id="Text1" type="text" class="txt" />-->
                                 <input type="text" runat="server" class="txt" id="txtUserName" placeholder="用户名"
                                                                     name="txtUserName" tabindex="1" />

                            </span>
                        </li>
                        <li>
                            <span class="left">密 码</span> <span style="left">
                                <!--<input id="Text2" type="text" class="txt" />-->
                                <input type="password" runat="server" class="txt" id="txtPassword" placeholder="密码"
                                                                     name="txtPassword" tabindex="1" />


                            </span>


                        </li>


                    </ul>
                </li>
                <li class="topE"></li>
                <li class="middle_A"></li>
                <li class="middle_B"> </li>
                <li class="middle_C"><span class=""><input id="Button1" type="button" runat="server" class="btn" tabindex="3" value="登 录"
                            onserverclick="ASPxButton1_Click" /><%--<img alt="" runat="server"  onserverclick="ASPxButton1_Click" src="Images/login/btnlogin.gif" />--%></span></li>
                <li class="middle_D"></li>
                <li class="bottom_A"></li>
                <li class="bottom_B">
                    常运物流 www.cy-logistics.cn
                </li>
            </ul>
        </div>
    </form>
</body>
</html>

