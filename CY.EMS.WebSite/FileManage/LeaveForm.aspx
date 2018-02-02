<%@ Page Title="当前位置：员工离职管理" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="LeaveForm.aspx.cs" Inherits="CY.EMS.WebSite.FileManage.LeaveForm" %>

<%@ Register Src="~/FileManage/LeaveUC.ascx" TagName="EdtLeave" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/ManageFrm.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function OnGridCustmButtonClick(s, e) {
            if (e.buttonID == 'btnEdit') {
                // 表格“查看”
                grid.GetRowValues(grid.GetFocusedRowIndex(), 'ID;EmpCode', OnGetRowValues);
            }
            else if (e.buttonID == 'btnDelete') {
                // 表格“删除”
                if (!confirm('确定要删除吗？'))
                    e.processOnServer = false;
                else
                    e.processOnServer = true;
            } else
                e.processOnServer = false;
        }
        //弹出窗口显示员工简历
        function OnGetRowValues(values) {
            popEdt.PerformCallback(values[0]);
            popEdt.Show();
        }
        //弹出查看窗口
        function OnButtonAdd(s, e) {
            popEdt.PerformCallback('');
            popEdt.Show();
            e.processOnServer = false;
        }
    </script>
    <div class="QueryPanel" style="height: 60px">
        <%--查询条件--%>
        <div>
            <dx:ASPxLabel ID="lblID" runat="server" Text="自编号" CssClass="QueryLabelBegin" />
            <dx:ASPxTextBox ID="txtID" runat="server" CssClass="QueryInput" />
            <dx:ASPxLabel ID="lblEmpName" runat="server" Text="员工姓名" CssClass="QueryLabel" />
            <dx:ASPxTextBox ID="txtEmpName" runat="server" CssClass="QueryInput" />
        </div>
        <div>
            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="离职日期从" CssClass="QueryLabelBegin" />
            <dx:ASPxDateEdit ID="datFmDate" runat="server" CssClass="QueryInput" />
            <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="到" CssClass="QueryLabel" />
            <dx:ASPxDateEdit ID="datToDate" runat="server" CssClass="QueryInput" />
        </div>
    </div>
    <div>
        <dx:ASPxButton ID="btnQry" runat="server" Text="查询" OnClick="onButton_Click" CssClass="Action">
            <Image IconID="find_find_16x16" />
        </dx:ASPxButton>
        <dx:ASPxButton ID="btnAdd" runat="server" Text="新增" CssClass="Action">
            <ClientSideEvents Click="function(s, e) {OnButtonAdd(s, e);}" />
            <Image IconID="actions_addfile_16x16" />
        </dx:ASPxButton>
    </div>
    <div>
        <dx:ASPxGridView ID="grdView" runat="server" AutoGenerateColumns="False" KeyFieldName="ID"
            ClientInstanceName="grid" OnCustomButtonCallback="grdView_CustomButtonCallback"
            OnPageIndexChanged="grdView_PageIndexChanged" CssClass="Grid" OnBeforeColumnSortingGrouping="gridview_BeforeColumnSorting">
            <ClientSideEvents CustomButtonClick="function(s, e) { OnGridCustmButtonClick(s, e); }"
                EndCallback="function(s, e) {GV_EndCallback(s, e);}" />
            <Columns>
                <dx:GridViewDataTextColumn Caption="自编号" Width="20px" VisibleIndex="0" FieldName="ID" />
                <dx:GridViewDataTextColumn Caption="所属部门" VisibleIndex="1" FieldName="DeptName" />
                <dx:GridViewDataTextColumn Caption="员工姓名" VisibleIndex="2" FieldName="EmpName" />
                <dx:GridViewDataDateColumn Caption="离职日期" VisibleIndex="3" FieldName="LeaveDate">
                    <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="离职种类" VisibleIndex="4" FieldName="LevTypName" />
                <dx:GridViewDataTextColumn Caption="离职原因" VisibleIndex="5" FieldName="Reason" />
                <dx:GridViewCommandColumn Caption="操作" Width="140px" HeaderStyle-HorizontalAlign="Center"
                    CellStyle-HorizontalAlign="Center">
                    <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton Text="查看" ID="btnEdit" />
                        <dx:GridViewCommandColumnCustomButton Text="删除" ID="btnDelete" />
                    </CustomButtons>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <CellStyle HorizontalAlign="Center">
                        <%--属性为居中--%>
                    </CellStyle>
                </dx:GridViewCommandColumn>
            </Columns>
            <%--在这里实现分页，有个Summary组件可实现分页--%>
            <SettingsBehavior AllowFocusedRow="True" />
            <SettingsPager PageSize="15">
                <Summary Text="第 {0} 页/共 {1} 页 (总 {2} 行)" />
            </SettingsPager>
            <SettingsDataSecurity AllowDelete="False" AllowInsert="False" AllowEdit="False" />
        </dx:ASPxGridView>
    </div>
    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" HeaderText="员工离职管理" ClientInstanceName="popEdt"
        Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        Width="600px" OnWindowCallback="ASPxPopupControl1_WindowCallback" CloseAction="CloseButton"
        AllowDragging="True">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <uc:EdtLeave ID="ucLeave" runat="server"></uc:EdtLeave>
                <div class="EditActionPanel500">
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red" CssClass="Action" />
                    <dx:ASPxButton ID="btnSave" runat="server" Text="保存" OnClick="onButton_Click" CssClass="Action">
                        <Image IconID="save_save_16x16" />
                    </dx:ASPxButton>
                    <dx:ASPxButton ID="btnCancel" runat="server" Text="关闭" CssClass="Action">
                        <ClientSideEvents Click="function(s, e) {popEdt.Hide();e.processOnServer = false;}" />
                        <Image IconID="actions_close_16x16" />
                    </dx:ASPxButton>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
