<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ResumeUC.ascx.cs" Inherits="CY.EMS.WebSite.FileManage.ResumeUC" %>
<table id="Table2" runat="server" align="center">
    <tr>
        <td align="left" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 16px;
            background-color: white">
            <table>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="lblID_1" runat="server" Text="自编号：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtID" runat="server" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                    <td>
                        <dx:ASPxLabel ID="lblEmpCode1" runat="server" Text="员工编号：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxComboBox ID="cbxEmpCode" runat="server" ValueType="System.String" ValueField="@Employee">
                        </dx:ASPxComboBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="lblFromDate1" runat="server" Text="开始日期：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxDateEdit ID="datFromDate" runat="server">
                        </dx:ASPxDateEdit>
                    </td>
                    <td>
                        <dx:ASPxLabel ID="lblToDate1" runat="server" Text="结束日期：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxDateEdit ID="datToDate" runat="server">
                        </dx:ASPxDateEdit>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="lblCompany1" runat="server" Text="所在公司：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtCompany" runat="server" Width="170px">
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
                        <dx:ASPxLabel ID="lblJob1" runat="server" Text="担任职务：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtJob" runat="server" Width="170px">
                        </dx:ASPxTextBox>
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
        </td>
    </tr>
</table>
