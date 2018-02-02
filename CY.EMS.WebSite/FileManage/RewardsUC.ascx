<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RewardsUC.ascx.cs" Inherits="CY.EMS.WebSite.FileManage.RewardsUC" %>
<table id="Table2" runat="server" align="center">
    <tr>
        <td>
            <dx:ASPxLabel ID="lblID1" runat="server" Text="自编号：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtID" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
        <td>
            <dx:ASPxLabel ID="lblEmpcaode1" runat="server" Text="员工编号：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxComboBox ID="cbbEmpCode" runat="server" ValueType="System.String" ValueField="@Employee">
            </dx:ASPxComboBox>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxLabel ID="lblValidDate1" runat="server" Text="奖惩日期：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxDateEdit ID="datValidDate" runat="server">
            </dx:ASPxDateEdit>
        </td>
        <td>
            <dx:ASPxLabel ID="lblType1" runat="server" Text="奖惩类型：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtType" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxLabel ID="lblReason1" runat="server" Text="奖惩原因：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtReason" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
        <td>
            <dx:ASPxLabel ID="lblDept1" runat="server" Text="所在部门：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtDept" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxLabel ID="lblInvalidDate1" runat="server" Text="解除日期：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxDateEdit ID="datInvalidDate" runat="server">
            </dx:ASPxDateEdit>
        </td>
        <td>
            <dx:ASPxLabel ID="lblMemo1" runat="server" Text="补充说明：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtMemo" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxHiddenField ID="hidID" runat="server" />
        </td>
    </tr>
</table>
