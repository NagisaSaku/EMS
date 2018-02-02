<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LeaveUC.ascx.cs" Inherits="CY.EMS.WebSite.FileManage.LeaveUC" %>
<link rel="Stylesheet" type="text/css" href="../CSS/ManageFrm.css" id="style" runat="server"
    visible="false" />
<script type="text/javascript">
    function cbbDeptCode_SelectedIndexChanged(s, e) {
        // 选择部门时，过滤员工
        cbbEmpCode.PerformCallback(s.lastSuccessValue);
    }
</script>
<div class="EditPanel500" style="height:160px">
    <div>
        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="自编号：" CssClass="EditLabelBegin" />
        <dx:ASPxTextBox ID="txtID" runat="server" CssClass="EditInput" ReadOnly="True" />
        <dx:ASPxHiddenField ID="hidID" runat="server" />
    </div>
    <div>
        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="部门：" CssClass="EditLabelBegin" />
        <dx:ASPxComboBox ID="cbbDeptCode" runat="server" CssClass="EditInput" ValueType="System.String"
            ValueField="@Dept" ClientInstanceName="cbbDeptCode">
            <ClientSideEvents SelectedIndexChanged="function(s, e) { cbbDeptCode_SelectedIndexChanged(s, e); }" />
        </dx:ASPxComboBox>
        <dx:ASPxLabel ID="lblEmpCode_1" runat="server" Text="员工：" CssClass="EditLabel" />
        <dx:ASPxComboBox ID="cbbEmpCode" runat="server" CssClass="EditInput" ValueType="System.String"
            ValueField="@EmployeeAll" ClientInstanceName="cbbEmpCode" OnCallback="cbbEmpCode_Callback" />
    </div>
    <div>
        <dx:ASPxLabel ID="lblLeaveDate_1" runat="server" Text="离职类型：" CssClass="EditLabelBegin" />
        <dx:ASPxComboBox ID="cbbLevTypCode" runat="server" CssClass="EditInput" ValueType="System.String"
            ValueField="LEV_TYP" />
        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="离职日期：" CssClass="EditLabel" />
        <dx:ASPxDateEdit ID="datLeaveDate" runat="server" CssClass="EditInput" />
    </div>
    <div>
        <dx:ASPxLabel ID="lblReason1" runat="server" Text="离职原因：" CssClass="EditLabelBegin" />
        <dx:ASPxMemo ID="mmoReason" runat="server" CssClass="EditMemo" Width="170px" />
    </div>
</div>
