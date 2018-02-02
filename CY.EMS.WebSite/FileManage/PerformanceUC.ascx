<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PerformanceUC.ascx.cs"
    Inherits="CY.EMS.WebSite.FileManage.PerformanceUC" %>
<table id="Table2" runat="server" align="center">
    <tr>
        <td align="left" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 16px;
            background-color: white">
            <table width="700px">
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
                        <dx:ASPxLabel ID="lblSpeciality1" runat="server" Text="专业特长：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtSpeciality" runat="server" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                    <td>
                        <dx:ASPxLabel ID="lblPerformance1" runat="server" Text="员工表现：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtPerformance" runat="server" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="lblMemo1" runat="server" Text="补充说明：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtMemo" runat="server" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                    <td>
                        <dx:ASPxHiddenField ID="hidID" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
