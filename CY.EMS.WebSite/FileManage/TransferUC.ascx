<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TransferUC.ascx.cs"
    Inherits="CY.EMS.WebSite.FileManage.TransferUC" %>
<table id="Table2" runat="server" align="center">
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
            <dx:ASPxLabel ID="lblEmpCode_1" runat="server" Text="员工编号：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxComboBox ID="cbbEmpCode" runat="server" ValueType="System.String" ValueField="@Employee">
            </dx:ASPxComboBox>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxLabel ID="lblValidDate_1" runat="server" Text="调度日期：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxDateEdit ID="datValidDate" runat="server">
            </dx:ASPxDateEdit>
        </td>
        <td>
            <dx:ASPxLabel ID="lblReason1" runat="server" Text="调度原因：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtReason" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxLabel ID="lblFmDeptCode1" runat="server" Text="调度前部门：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxComboBox ID="cbbFmDeptCode" runat="server" ValueType="System.String" ValueField="@Dept">
            </dx:ASPxComboBox>
        </td>
        <td>
            <dx:ASPxLabel ID="lblToDeptCode1" runat="server" Text="调度后部门：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxComboBox ID="cbbToDeptCode" runat="server" ValueType="System.String" ValueField="@Dept">
            </dx:ASPxComboBox>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxLabel ID="lblFmJob1" runat="server" Text="调度前岗位级别：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtFmJob" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
        <td>
            <dx:ASPxLabel ID="lblToJob1" runat="server" Text="调度后岗位级别：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtToJob" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxLabel ID="lblFmJobLevel1" runat="server" Text="调度前工作岗位：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtFmJobLevel" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
        <td>
            <dx:ASPxLabel ID="lblToJobLevel1" runat="server" Text="调度后工作岗位：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtToJobLevel" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxHiddenField ID="hidID" runat="server" />
        </td>
    </tr>
</table>
