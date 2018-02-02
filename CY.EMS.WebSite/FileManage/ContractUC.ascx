<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContractUC.ascx.cs"
    Inherits="CY.EMS.WebSite.FileManage.ContractUC" %>
<link rel="Stylesheet" type="text/css" href="../CSS/ManageFrm.css" id="style" runat="server"
    visible="false" />
<div class="EditPanel500" style="height: 160px">
    <div>
        <dx:ASPxLabel ID="lblCode_1" runat="server" Text="合同编号：" CssClass="EditLabelBegin" />
        <dx:ASPxTextBox ID="txtCode" runat="server" CssClass="EditInput" />

        <dx:ASPxLabel ID="lblEmpCode_1" runat="server" Text="员工编号：" CssClass="EditLabel" />
        <dx:ASPxComboBox ID="cbbEmpCode" runat="server" ValueType="System.String" ValueField="@Employee" CssClass="EditInput" IncrementalFilteringMode="Contains" />
    </div>
    <div>
        <dx:ASPxLabel ID="lblConTypCode_1" runat="server" Text="合同种类：" CssClass="EditLabelBegin" />
        <dx:ASPxComboBox ID="cbbConTypCode" runat="server" ValueType="System.String" ValueField="CON_TYP" CssClass="EditInput" />

        <dx:ASPxLabel ID="lblConLenCode_1" runat="server" Text="合同年限：" CssClass="EditLabel" />
        <dx:ASPxComboBox ID="cbbConLenCode" runat="server" ValueType="System.String" ValueField="CON_LEN" CssClass="EditInput" />
    </div>
    <div>
        <dx:ASPxLabel ID="lblConStatus_1" runat="server" Text="合同状态：" CssClass="EditLabelBegin" />
        <dx:ASPxComboBox ID="cbbConStatus" runat="server" ValueType="System.String" ValueField="CON_STS" CssClass="EditInput" />

        <dx:ASPxLabel ID="lblFmDate_1" runat="server" Text="合同签订日期：" CssClass="EditLabel" />
        <dx:ASPxDateEdit ID="datFmDate" runat="server" CssClass="EditInput" />
    </div>
    <div>
        <dx:ASPxLabel ID="lblToDate_1" runat="server" Text="合同终止日期：" CssClass="EditLabelBegin" />

        <dx:ASPxDateEdit ID="datToDate" runat="server" CssClass="EditInput" />
        <dx:ASPxHiddenField ID="hidID" runat="server" />
    </div>
    <%--<td>
                        <dx:ASPxLabel ID="lblMemo_1" runat="server" Text="补充说明：" >
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtMemo" runat="server" Width="170px" >
                        </dx:ASPxTextBox>
                    </td>--%>
</div>
