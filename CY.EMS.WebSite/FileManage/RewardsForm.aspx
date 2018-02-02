<%@ Page Title="当前位置：员工奖惩纪录" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="RewardsForm.aspx.cs" Inherits="CY.EMS.WebSite.FileManage.RewardsForm" %>

<%@ Register Src="~/FileManage/RewardsUC.ascx" TagName="EdtRewards" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function OnGridCustmButtonClick(s, e) {
            if (e.buttonID == 'btnEdit') {
                // 表格“编辑”
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
    <table style="width: 100%; height: 161px">
        <tr>
            <td align="left" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 16px;
                background-color: #CED8F6">
                <table>
                    <tr>
                        <td style="width: 50px" align="center">
                            <dx:ASPxLabel ID="lblID" runat="server" Text="自编号" />
                        </td>
                        <td style="width: 120px">
                            <dx:ASPxTextBox ID="txtID" runat="server" Width="100%" />
                        </td>
                        <td style="width: 50px" align="center">
                            <dx:ASPxLabel ID="lblEmpCode" runat="server" Text="员工编号" />
                        </td>
                        <td style="width: 120px">
                            <dx:ASPxTextBox ID="txtEmpCode" runat="server" Width="100%" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left">
                <table>
                    <tr>
                        <td>
                            <dx:ASPxButton ID="btnQry" runat="server" Text="查询" OnClick="onButton_Click" />
                        </td>
                        <td>
                            <dx:ASPxButton ID="btnAdd" runat="server" Text="新增">
                                <ClientSideEvents Click="function(s, e) {OnButtonAdd(s, e);}" />
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100%; height: 100px; background-color: gainsboro">
                <dx:ASPxGridView ID="grdView" runat="server" AutoGenerateColumns="False" Width="100%"
                    KeyFieldName="ID" ClientInstanceName="grid" OnCustomButtonCallback="grdView_CustomButtonCallback"
                    OnPageIndexChanged="grdView_PageIndexChanged" OnBeforeColumnSortingGrouping="gridview_BeforeColumnSorting">
                    <ClientSideEvents CustomButtonClick="function(s, e) { OnGridCustmButtonClick(s, e); }"
                        EndCallback="function(s, e) {GV_EndCallback(s, e);}" />
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="自编号" VisibleIndex="0" Width="20px" FieldName="ID">
                            <%-- <PropertiesTextEdit ClientInstanceName="colCode">
                            </PropertiesTextEdit>
                            <%--自编号的不可编辑性属性--%>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="所在部门" VisibleIndex="5" Width="20px" FieldName="Dept">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="员工编号" VisibleIndex="1" Width="20px" FieldName="EmpCode">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="奖惩日期" VisibleIndex="2" Width="20px" FieldName="ValidDate">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="奖惩类型" VisibleIndex="3" Width="20px" FieldName="Type">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="奖惩原因" VisibleIndex="4" Width="20px" FieldName="Reason">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="解除处分日期" VisibleIndex="6" Width="20px" FieldName="InvalidDate">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="补充说明" VisibleIndex="7" Width="20px" FieldName="Memo">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewCommandColumn Caption="操作" Width="140px" HeaderStyle-HorizontalAlign="Center"
                            CellStyle-HorizontalAlign="Center" VisibleIndex="8">
                            <CustomButtons>
                                <dx:GridViewCommandColumnCustomButton Text="查看" ID="btnEdit" />
                                <dx:GridViewCommandColumnCustomButton Text="删除" ID="btnDelete" />
                            </CustomButtons>
                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewCommandColumn>
                    </Columns>
                    <SettingsBehavior AllowFocusedRow="True" />
                    <SettingsPager PageSize="15">
                        <Summary Text="第 {0} 页/共 {1} 页 (总 {2} 行)" />
                    </SettingsPager>
                    <SettingsPopup>
                        <EditForm Width="600px" />
                    </SettingsPopup>
                    <SettingsDataSecurity AllowDelete="False" AllowInsert="False" AllowEdit="False" />
                </dx:ASPxGridView>
            </td>
        </tr>
        <%--PopControl控件，实现点击新增以及查看可以调用XXXXUC控件页面实现代码的复用--%>
        <tr>
            <td>
                <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" HeaderText="员工奖惩记录" ClientInstanceName="popEdt"
                    Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                    Width="700px" OnWindowCallback="ASPxPopupControl1_WindowCallback" CloseAction="CloseButton"
                    AllowDragging="True">
                    <ContentCollection>
                        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                            <div>
                                <uc:EdtRewards ID="ucRewards" runat="server"></uc:EdtRewards>
                            </div>
                            <table>
                                <tr>
                                    <td>
                                        <dx:ASPxButton ID="btnSave" runat="server" Text="保存" OnClick="onButton_Click" />
                                    </td>
                                    <td>
                                        <dx:ASPxButton ID="btnCancel" runat="server" Text="关闭">
                                            <ClientSideEvents Click="function(s, e) {popEdt.Hide();e.processOnServer = false;}" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td>
                                        &nbsp;<asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>
            </td>
        </tr>
    </table>
</asp:Content>
