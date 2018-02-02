<%@ Page Title="当前位置：部门管理" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="SysDept.aspx.cs" Inherits="CY.EMS.WebSite.SystemManage.SysDept" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        // TreeView切换焦点事件：刷新右侧部门信息和部门员工
        function TV_NodeClick(s, e) {
            pageControl.PerformCallback(e.node.name);
        }
        // Menu菜单单击事件
        function Menu1_ItemClick(s, e) {
            if (e.item.name == 'mAdd') {
                e.processOnServer = false;
                return;
            }
            if (treeView.GetSelectedNode() == null) {
                alert('请选择部门！');
                e.processOnServer = false;
            } else
                e.processOnServer = true;
        }
        // PageControl切换Page事件
        function ASPxPageControl1_ActiveTabChanged(s, e) {
            var node = treeView.GetSelectedNode(); // 部门树的选中节点
            if (node != undefined)
                pageControl.PerformCallback(node.name);
        }
    </script>
    <div>
        <%-- 菜单 --%>
        <dx:ASPxMenu ID="ASPxMenu1" runat="server" ClientInstanceName="Menu1" OnItemClick="ASPxMenu1_ItemClick">
            <ClientSideEvents ItemClick="function(s, e) {Menu1_ItemClick(s, e);}" />
            <Items>
                <dx:MenuItem Name="mAdd" Text="新增" Image-IconID="actions_add_16x16">
                    <Items>
                        <dx:MenuItem Name="mAddDept" Text="平级部门" Image-IconID="actions_additem_16x16" />
                        <dx:MenuItem Name="mAddSubDept" Text="子部门" Image-IconID="actions_additem_16x16" />
                    </Items>
                </dx:MenuItem>
                <dx:MenuItem Name="mDel" Text="删除" Image-IconID="actions_remove_16x16" />
                <dx:MenuItem Name="mSave" Text="保存" Image-IconID="save_save_16x16" />
                <dx:MenuItem BeginGroup="True" Name="mUp" Text="上移" Image-IconID="arrows_moveup_16x16" />
                <dx:MenuItem Name="mDown" Text="下移" Image-IconID="arrows_movedown_16x16" />
            </Items>
        </dx:ASPxMenu>
        <%-- 弹出窗口：用于显示提示信息，未使用 --%>
        <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server">
            <ContentCollection>
                <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                    <dx:ASPxLabel ID="lblMsg" runat="server" Text="ASPxLabel">
                    </dx:ASPxLabel>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
    </div>
    <div>
        <table style="width: 100%">
            <tr>
                <%-- 部门树 --%>
                <td valign="top" style="width: 20%">
                    <dx:ASPxTreeView ID="ASPxTreeView1" runat="server" ClientInstanceName="treeView"
                        AllowSelectNode="True">
                        <ClientSideEvents NodeClick="function(s, e) {TV_NodeClick(s, e);}" />
                    </dx:ASPxTreeView>
                </td>
                <%-- 编辑区域 --%>
                <td valign="top" style="width: 80%">
                    <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" ClientInstanceName="pageControl"
                        OnCallback="ASPxPageControl1_Callback" Height="500px" Width="100%">
                        <TabPages>
                            <%-- 编辑部门信息 --%>
                            <dx:TabPage Name="tabDeptInfo" Text="部门信息">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl1" runat="server">
                                        <div>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="部门编码：" />
                                                    </td>
                                                    <td>
                                                        <dx:ASPxTextBox ID="txtCode" runat="server" Width="170px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="部门名称：" />
                                                    </td>
                                                    <td>
                                                        <dx:ASPxTextBox ID="txtName" runat="server" Width="170px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="负责人：" />
                                                    </td>
                                                    <td>
                                                        <dx:ASPxTextBox ID="txtDeptMaster" runat="server" Width="170px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="文员：" />
                                                    </td>
                                                    <td>
                                                        <dx:ASPxTextBox ID="txtDeptContact" runat="server" Width="170px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="联系电话：" />
                                                    </td>
                                                    <td>
                                                        <dx:ASPxTextBox ID="txtPhone" runat="server" Width="170px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="最大人数：" />
                                                    </td>
                                                    <td>
                                                        <dx:ASPxSpinEdit ID="spnMaxEmployee" runat="server" Number="0" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="备注：" />
                                                    </td>
                                                    <td>
                                                        <dx:ASPxTextBox ID="txtMemo" runat="server" Width="170px" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="创建人：" />
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="lblAddWho" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="创建时间：" />
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="lblAddTime" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="修改人：" />
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="lblEditWho" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="修改时间：" />
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="lblEditTime" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            <%-- 部门所属员工 --%>
                            <dx:TabPage Name="tabEmployee" Text="所属员工">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl2" runat="server">
                                        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" KeyFieldName="Code"
                                            SettingsText-EmptyDataRow="无有效数据！">
                                            <Columns>
                                                <dx:GridViewDataTextColumn Caption="员工编码" FieldName="Code" ShowInCustomizationForm="True"
                                                    VisibleIndex="0">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="员工姓名" FieldName="Name" ShowInCustomizationForm="True"
                                                    VisibleIndex="1">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="性别" FieldName="SexName" ShowInCustomizationForm="True"
                                                    VisibleIndex="2">
                                                </dx:GridViewDataTextColumn>
                                            </Columns>
                                            <SettingsBehavior AllowFocusedRow="True" />
                                            <SettingsPager PageSize="15">
                                                <Summary Text="第 {0} 页/共 {1} 页 (总 {2} 行)" />
                                            </SettingsPager>
                                            <SettingsText EmptyDataRow="无有效数据！"></SettingsText>
                                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                        </dx:ASPxGridView>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                        </TabPages>
                        <ClientSideEvents ActiveTabChanged="function(s, e) {ASPxPageControl1_ActiveTabChanged(s, e);}" />
                    </dx:ASPxPageControl>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
