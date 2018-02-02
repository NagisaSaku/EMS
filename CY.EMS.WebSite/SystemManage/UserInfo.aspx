<%@ Page Title="当前位置：登录用户管理" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="UserInfo.aspx.cs" Inherits="CY.EMS.WebSite.SystemManage.UserInfo" %>

<%@ Register Src="~/SystemManage/UserUC.ascx" TagName="EdtUser" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/ManageFrm.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function OnGridCustmButtonClick(s, e) {
            if (e.buttonID == 'btnEdit') {
                // 表格“查看”
                grid.GetRowValues(grid.GetFocusedRowIndex(), 'UserName;Passward', OnGetRowValues);
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

        // 修改
        function OnGetRowValues(values) {
            popEdt.PerformCallback(values[0]);
            popEdt.Show();
        }

        // 新增
        function OnButtonAdd(s, e) {
            popEdt.PerformCallback('');
            popEdt.Show();
            e.processOnServer = false;
        }
    </script>
    <div class="QueryPanel" style="height: 30px">
        <%--查询条件--%>
        <dx:ASPxLabel ID="lblUserName" runat="server" Text="用户名称" CssClass="QueryLabelBegin" />
        <dx:ASPxTextBox ID="txtQryUserName" runat="server" CssClass="QueryInput" />
        <dx:ASPxLabel ID="lblPassword" runat="server" Text="用户姓名" CssClass="QueryLabel" />
        <dx:ASPxTextBox ID="txtQryName" runat="server" CssClass="QueryInput" />
    </div>
    <div>
        <dx:ASPxButton ID="btnQry" runat="server" Text="查询" CssClass="Action">
            <Image IconID="find_find_16x16" />
        </dx:ASPxButton>
        <dx:ASPxButton ID="btnAdd" runat="server" Text="新增" CssClass="Action">
            <ClientSideEvents Click="function(s, e) {OnButtonAdd(s, e);}" />
            <Image IconID="actions_addfile_16x16" />
        </dx:ASPxButton>
    </div>
    <div>
        <dx:ASPxGridView ID="grdView" runat="server" AutoGenerateColumns="False" Width="100%"
            KeyFieldName="UserName" ClientInstanceName="grid">
            <ClientSideEvents CustomButtonClick="function(s, e) { OnGridCustmButtonClick(s, e); }"
                EndCallback="function(s, e) {GV_EndCallback(s, e);}" />
            <Columns>
                <dx:GridViewDataTextColumn Caption="用户名称" VisibleIndex="0" FieldName="UserName">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="用户姓名" VisibleIndex="1" FieldName="Name">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="用户密码" VisibleIndex="2" FieldName="Password">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="补充说明" VisibleIndex="3" FieldName="Memo">
                </dx:GridViewDataTextColumn>
                <dx:GridViewCommandColumn Caption="操作" Width="140px" HeaderStyle-HorizontalAlign="Center"
                    CellStyle-HorizontalAlign="Center">
                    <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton Text="查看" ID="btnEdit" />
                        <dx:GridViewCommandColumnCustomButton Text="删除" ID="btnDelete" />
                    </CustomButtons>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <CellStyle HorizontalAlign="Center">
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
    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" HeaderText="修改用户信息" ClientInstanceName="popEdt"
        Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        Width="360px" AllowDragging="True">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <uc:EdtUser ID="ucUser" runat="server"></uc:EdtUser>
                <div class="EditActionPanel250">
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                    <dx:ASPxButton ID="btnSave" runat="server" Text="保存">
                        <Image IconID="save_save_16x16" />
                    </dx:ASPxButton>
                    <dx:ASPxButton ID="btnCancel" runat="server" Text="关闭">
                        <ClientSideEvents Click="function(s, e) {popEdt.Hide();e.processOnServer = false;}" />
                        <Image IconID="actions_close_16x16" />
                    </dx:ASPxButton>
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
