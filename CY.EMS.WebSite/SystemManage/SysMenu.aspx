<%@ Page Title="当前位置：菜单管理" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="SysMenu.aspx.cs" Inherits="CY.EMS.WebSite.SystemManage.SysMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        // TreeView切换焦点时，刷新右侧菜单信息
        function TV_NodeClick(s, e) {
            cbPanel.PerformCallback(e.node.name);
        }
        // Menu菜单单击
        function Menu1_ItemClick(s, e) {
            if (e.item.name == 'mAdd') {
                e.processOnServer = false;
                return;
            }
            if (treeView.GetSelectedNode() == null) {
                alert('请选择菜单！');
                e.processOnServer = false;
            } else
                e.processOnServer = true;
        }
    </script>
    <div>
        <dx:ASPxMenu ID="ASPxMenu1" runat="server" ClientInstanceName="Menu1" OnItemClick="ASPxMenu1_ItemClick">
            <ClientSideEvents ItemClick="function(s, e) {Menu1_ItemClick(s, e);}" />
            <Items>
                <dx:MenuItem Name="mAdd" Text="新增" Image-IconID="actions_add_16x16">
                    <Items>
                        <dx:MenuItem Name="mAddDept" Text="平级菜单" Image-IconID="actions_additem_16x16" />
                        <dx:MenuItem Name="mAddSubDept" Text="子菜单" Image-IconID="actions_additem_16x16" />
                    </Items>
                </dx:MenuItem>
                <dx:MenuItem Name="mDel" Text="删除" Image-IconID="actions_remove_16x16" />
                <dx:MenuItem Name="mSave" Text="保存" Image-IconID="save_save_16x16" />
                <dx:MenuItem BeginGroup="True" Name="mUp" Text="上移" Image-IconID="arrows_moveup_16x16" />
                <dx:MenuItem Name="mDown" Text="下移" Image-IconID="arrows_movedown_16x16" />
            </Items>
        </dx:ASPxMenu>
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
                <td valign="top" style="width: 20%">
                    <dx:ASPxTreeView ID="ASPxTreeView1" runat="server" ClientInstanceName="treeView"
                        AllowSelectNode="True">
                        <ClientSideEvents NodeClick="function(s, e) {TV_NodeClick(s, e);}" />
                    </dx:ASPxTreeView>
                </td>
                <td valign="top" style="width: 80%">
                    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="300px" ClientInstanceName="cbPanel"
                        OnCallback="ASPxCallbackPanel1_Callback">
                        <PanelCollection>
                            <dx:PanelContent ID="PanelContent1" runat="server">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="ID：" />
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtID" runat="server" Width="170px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="名称：" />
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtName" runat="server" Width="170px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="图标：" />
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtIconID" runat="server" Width="170px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="内容：" />
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtContent" runat="server" Width="170px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="启用：" />
                                        </td>
                                        <td>
                                            <dx:ASPxCheckBox ID="cbxActive" runat="server" Checked="True" />
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
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
