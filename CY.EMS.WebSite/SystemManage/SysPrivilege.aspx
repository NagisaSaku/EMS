<%@ Page Title="当前位置：权限管理" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="SysPrivilege.aspx.cs" Inherits="CY.EMS.WebSite.SystemManage.SysPrivilege" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="height: 36px; background-color: #CED8F6">
        <table>
            <tr>
                <td>
                    &nbsp;用户:
                </td>
                <td>
                    <dx:ASPxComboBox ID="cbbUser" runat="server" ValueType="System.String" ValueField="@User"
                        IncrementalFilteringMode="Contains" />
                </td>
                <td>
                    <dx:ASPxButton ID="btnQuery" runat="server" Text="查询" OnClick="onButtonClick" Image-IconID="find_find_16x16" />
                </td>
                <td>
                    <dx:ASPxButton ID="btnSave" runat="server" Text="保存" OnClick="onButtonClick" Image-IconID="save_save_16x16" />
                </td>
            </tr>
        </table>
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
        <asp:SqlDataSource ID="sdsPrivilege" runat="server" ConnectionString="<%$ ConnectionStrings:CYHRMS %>"
            SelectCommand="exec P_Sys_Get_Privilege @Oper=@User">
            <SelectParameters>
                <asp:ControlParameter ControlID="cbbUser" Name="User" PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxTreeList ID="ASPxTreeList1" runat="server" Width="100%" ClientInstanceName="treeList"
            AutoGenerateColumns="False" KeyFieldName="ID" ParentFieldName="ParentID" DataSourceID="sdsPrivilege">
            <Columns>
                <dx:TreeListTextColumn Caption="序号" FieldName="ID" VisibleIndex="0" Width="5%">
                </dx:TreeListTextColumn>
                <dx:TreeListTextColumn Caption="菜单" FieldName="MenuName" VisibleIndex="1" Width="90%">
                </dx:TreeListTextColumn>
                <dx:TreeListTextColumn FieldName="ShowSequence" VisibleIndex="1" Visible="False"
                    SortOrder="Ascending" SortIndex="1">
                </dx:TreeListTextColumn>
            </Columns>
            <SettingsSelection AllowSelectAll="True" Enabled="True" />
        </dx:ASPxTreeList>
    </div>
</asp:Content>
