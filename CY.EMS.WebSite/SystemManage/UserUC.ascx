<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserUC.ascx.cs" Inherits="CY.EMS.WebSite.SystemManage.UserUC" %>
<link rel="Stylesheet" type="text/css" href="../CSS/ManageFrm.css" id="style" runat="server"
    visible="false" />
<div class="EditPanel250" style="height:160px">
    <div>
        <dx:ASPxHiddenField ID="hidID" runat="server" />
    </div>
    <div>
        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="用户名称" CssClass="EditLabelBegin" />
        <dx:ASPxTextBox ID="txtUserName" runat="server" CssClass="EditInput">
        </dx:ASPxTextBox>
    </div>
    <div>
        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="用户姓名" CssClass="EditLabelBegin" />
        <dx:ASPxTextBox ID="txtName" runat="server" CssClass="EditInput">
        </dx:ASPxTextBox>
    </div>
    <div>
        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="密码" CssClass="EditLabelBegin" />
        <dx:ASPxTextBox ID="txtPassword" runat="server" CssClass="EditInput">
        </dx:ASPxTextBox>
    </div>
    <div>
        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="补充说明" CssClass="EditLabelBegin" />
        <dx:ASPxTextBox ID="txtMemo" runat="server" CssClass="EditInput" Height="60px">
        </dx:ASPxTextBox>
    </div>
</div>
