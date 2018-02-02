<%@ Page Title="当前位置：员工家庭成员" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="Contract.aspx.cs" Inherits="CY.EMS.WebSite.FileManage.Contract" %>

<%@ Register Src="~/FileManage/ContractUC.ascx" TagName="EdtContract" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../CSS/ManageFrm.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        var action;
        function OnGridCustmButtonClick(s, e) {
            if (e.buttonID == 'btnEdit') {
                // 表格“查看”
                action = 'edit';
                grid.GetRowValues(grid.GetFocusedRowIndex(), 'Code;EmpCode', OnGetRowValues);
            }
            if (e.buttonID == 'btnRenew') {
                // 表格“续约”
                action = 'renew';
                grid.GetRowValues(grid.GetFocusedRowIndex(), 'Code;EmpCode', OnGetRowValues);
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

        // 弹出窗口显示员工档案
        function OnGetRowValues(values) {
            var jobj = { 'Action': action, 'ID': values[0] };
            popEdt.PerformCallback(JSON.stringify(jobj));
            popEdt.Show();
        }

        //弹出查看窗口
        function OnButtonAdd(s, e) {
            var jobj = { 'Action': 'add', 'ID': '' };
            popEdt.PerformCallback(JSON.stringify(jobj));
            popEdt.Show();
            e.processOnServer = false;
        }
    </script>
    <div class="QueryPanel" style="height: 60px">
        <%--查询条件--%>
        <dx:ASPxLabel ID="lblCode" runat="server" Text="合同编号" CssClass="QueryLabelBegin" />
        <dx:ASPxTextBox ID="txtCode" runat="server" CssClass="QueryInput" />
        <dx:ASPxLabel ID="lblID" runat="server" Text="合同状态" CssClass="QueryLabel" />
        <dx:ASPxComboBox ID="cbbConStatus" runat="server" CssClass="QueryInput" ValueType="System.String" ValueField="CON_STS" />
        <dx:ASPxLabel ID="lblEmpName" runat="server" Text="员工姓名" CssClass="QueryLabel" />
        <dx:ASPxTextBox ID="txtEmpName" runat="server" CssClass="QueryInput" />

        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="终止日期从" CssClass="QueryLabelBegin" />
        <dx:ASPxDateEdit ID="datToFmDate" runat="server" CssClass="QueryInput" />
        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text=" 到" CssClass="QueryLabel" />
        <dx:ASPxDateEdit ID="datToToDate" runat="server" CssClass="QueryInput" />

        <dx:ASPxCheckBox ID="chkState" runat="server" Text="显示失效合同" CssClass="QueryInput" />
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
            KeyFieldName="Code" ClientInstanceName="grid">
            <ClientSideEvents CustomButtonClick="function(s, e) { OnGridCustmButtonClick(s, e); }"
                EndCallback="function(s, e) {GV_EndCallback(s, e);}" />
            <Columns>
                <dx:GridViewDataTextColumn Caption="合同编号" VisibleIndex="1" FieldName="Code">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="员工编号" VisibleIndex="2" FieldName="EmpCode">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="员工姓名" VisibleIndex="3" FieldName="EmpName">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="合同类型" VisibleIndex="4" FieldName="ConTypName">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="合同状态" VisibleIndex="5" FieldName="ConStatusName">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="合同开始日期" VisibleIndex="6" FieldName="FmDate">
                    <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn Caption="合同终止日期" VisibleIndex="7" FieldName="ToDate">
                    <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="合同年限" VisibleIndex="8" FieldName="ConLenName">
                </dx:GridViewDataTextColumn>
                <dx:GridViewCommandColumn Caption="操作" VisibleIndex="9" Width="140px" HeaderStyle-HorizontalAlign="Center"
                    CellStyle-HorizontalAlign="Center">
                    <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton Text="查看" ID="btnEdit" />
                        <dx:GridViewCommandColumnCustomButton Text="续约" ID="btnRenew" />
                        <dx:GridViewCommandColumnCustomButton Text="删除" ID="btnDelete" />
                    </CustomButtons>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewCommandColumn>
            </Columns>
            <SettingsBehavior AllowFocusedRow="True" />
            <SettingsPager PageSize="17">
                <Summary Text="第 {0} 页/共 {1} 页 (总 {2} 行)" />
            </SettingsPager>
            <SettingsDataSecurity AllowDelete="False" AllowInsert="False" AllowEdit="False" />
            <Styles>
                <BatchEditCell BackColor="#CED8F6">
                </BatchEditCell>
            </Styles>
            <StylesPager>
                <Button BackColor="#CED8F6">
                </Button>
            </StylesPager>
            <StylesPopup>
                <Common>
                    <Header BackColor="#CED8F6">
                    </Header>
                </Common>
            </StylesPopup>
            <StylesContextMenu>
                <Column>
                    <Item BackColor="#CED8F6">
                        <Border BorderStyle="Ridge" />
                    </Item>
                </Column>
            </StylesContextMenu>
            <Border BorderColor="#CED8F6" BorderStyle="Ridge"></Border>
            <BorderTop BorderColor="#CED8F6" />
            <BorderBottom BorderStyle="Dotted" />
        </dx:ASPxGridView>
    </div>
    <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" HeaderText="员工合同管理" ClientInstanceName="popEdt"
        Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        Width="600px" CloseAction="CloseButton"
        AllowDragging="True">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <uc:EdtContract ID="ucContract" runat="server"></uc:EdtContract>
                <div class="EditActionPanel500">
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
