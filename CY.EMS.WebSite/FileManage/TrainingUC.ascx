<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TrainingUC.ascx.cs"
    Inherits="CY.EMS.WebSite.FileManage.TrainingUC" %>
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
            <dx:ASPxLabel ID="lblFromDate1" runat="server" Text="培训开始日期：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxDateEdit ID="datFromDate" runat="server">
            </dx:ASPxDateEdit>
        </td>
        <td>
            <dx:ASPxLabel ID="lblToDate1" runat="server" Text="培训结束日期：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxDateEdit ID="datToDate" runat="server">
            </dx:ASPxDateEdit>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxLabel ID="lblTrainUnit1" runat="server" Text="培训单位：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtTrainUnit" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
        <td>
            <dx:ASPxLabel ID="lblAddress1" runat="server" Text="培训地址：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtAddress" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxLabel ID="lblTrainContent1" runat="server" Text="培训内容：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtTrainContent" runat="server" Width="170px">
            </dx:ASPxTextBox>
        </td>
        <td>
            <dx:ASPxLabel ID="lblPrice1" runat="server" Text="培训花费：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxSpinEdit ID="spnPrice" runat="server" Number="0">
            </dx:ASPxSpinEdit>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxLabel ID="lblCertificate1" runat="server" Text="获得证书：">
            </dx:ASPxLabel>
        </td>
        <td>
            <dx:ASPxTextBox ID="txtCertificate" runat="server" Width="170px">
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
