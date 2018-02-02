<%--文件名：Default.aspx--%>

<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="CYHRMS.Default" Title="欢迎使用常运物流人事管理系统" %>

<%@ Register Src="~/DockWidgets/DckEmpDate.ascx" TagName="DckEmpDate" TagPrefix="widget" %>
<%@ Register Src="~/DockWidgets/DckContractWarning.ascx" TagName="DckContractWarning" TagPrefix="widget" %>
<%-- 在此处添加内容控件 --%>
<%-- asp:Image ID="Image1" runat="server" ImageUrl="~/Images/HuaAnHome.JPG" Height="570px" Width="100%" --%>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/DockWidgets.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <dx:ASPxDockZone runat="server" ID="ASPxDockZone1" ZoneUID="LeftZone" CssClass="leftZone"
        Width="300px" PanelSpacing="3">
    </dx:ASPxDockZone>
    <dx:ASPxDockZone runat="server" ID="ASPxDockZone2" ZoneUID="RightZone" CssClass="rightZone"
        Width="300px" PanelSpacing="3">
    </dx:ASPxDockZone>
    <dx:ASPxDockPanel ID="ASPxDockPanel1" runat="server" HeaderText="本月员工变动" Width="230px"
        OwnerZoneUID="LeftZone" Height="100px">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <widget:DckEmpDate ID="DckEmpDate" runat="server" />
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxDockPanel>
    <dx:ASPxDockPanel ID="ASPxDockPanel2" runat="server" HeaderText="合同到期预警" Width="230px"
        OwnerZoneUID="RightZone" Height="100px">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <widget:DckContractWarning ID="DckContractWarning" runat="server" />
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxDockPanel>
</asp:Content>
