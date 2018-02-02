<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="PersonnelQryFrm.aspx.cs" Inherits="CY.EMS.WebSite.FileManage.PersonnelQryFrm" %>

<%@ Register Src="~/FileManage/PersonnelUC.ascx" TagName="EdtPersonnel" TagPrefix="uc" %>
<%@ MasterType TypeName="CY.EMS.WebSite.MasterPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        //在GirdView中查看方法
        function OnGridCustmButtonClick(s, e) {
            if (e.buttonID == 'btnEdit') {
                // 表格“查看”
                grid.GetRowValues(grid.GetFocusedRowIndex(), 'Code;Name', OnGetRowValues); //'Code；Name'是GridView中列的FieldName即在数据库中的列名，通过这两个键锁定是哪一行然后用grid类中的GetRowValue方法获得一行的数据
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
            popEdt.PerformCallback(values[0]);
            popEdt.Show();
        }
        // 点击“新增”按钮
        function OnButtonAdd(s, e) {
            popEdt.PerformCallback('');
            popEdt.Show();
            e.processOnServer = false;
        }
        // GridView服务端处理结束后
        function GV_EndCallback(s, e) {
            if (s.cpMsg != undefined)
                alert(s.cpMsg);
        }
    </script>
    <table style="width: 100%; height: 161px">
        <tr>
            <td align="left" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 16px;
                background-color: #CED8F6">
                <table>
                    <tr>
                        <td style="width: 50px" align="center">
                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="员工编号" />
                        </td>
                        <td style="width: 120px">
                            <dx:ASPxTextBox ID="txtCode" runat="server" Width="100%" />
                        </td>
                        <td style="width: 50px" align="center">
                            <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="姓名" />
                        </td>
                        <td style="width: 120px">
                            <dx:ASPxTextBox ID="txtName" runat="server" Width="100%" />
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
            <td style="width: 2232px; height: 100px; background-color: gainsboro">
                <dx:ASPxGridView ID="grdView" runat="server" Width="100%" AutoGenerateColumns="False"
                    ClientInstanceName="grid" OnPageIndexChanged="grdView_PageIndexChanged" OnCustomButtonCallback="grdView_CustomButtonCallback"
                    KeyFieldName="Code" Styles-GroupButtonWidth="17" OnBeforeColumnSortingGrouping="gridview_BeforeColumnSorting">
                    <%--通过这个组件来实现鼠标定位到行--%>
                    <ClientSideEvents CustomButtonClick="function(s, e) { OnGridCustmButtonClick(s, e); }"
                        EndCallback="function(s, e) {GV_EndCallback(s, e);}" />
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="员工编号" FieldName="Code" VisibleIndex="1" PropertiesTextEdit-ClientInstanceName="colCode">
                            <PropertiesTextEdit ClientInstanceName="colCode">
                            </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="姓名" FieldName="Name" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="所属部门" FieldName="DeptName" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="性别" FieldName="SexName" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="岗位级别" FieldName="JobLevel" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="入职日期" FieldName="BeginDate" VisibleIndex="6">
                            <PropertiesDateEdit DisplayFormatString="yyyy-MM-dd">
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="联系电话" FieldName="Phone" VisibleIndex="7">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="手机号码" FieldName="Cellphone" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="序号" FieldName="RowNumber" VisibleIndex="0" Width="20px">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewCommandColumn Caption="操作" Width="100px" HeaderStyle-HorizontalAlign="Center"
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
                    <SettingsPager PageSize="19">
                        <Summary Text="第 {0} 页/共 {1} 页 (总 {2} 行)" />
                    </SettingsPager>
                    <SettingsDataSecurity AllowDelete="False" AllowInsert="False" AllowEdit="False" />
                </dx:ASPxGridView>
            </td>
        </tr>
        <%--PopControl控件，实现点击新增以及查看可以调用XXXXUC控件页面实现代码的复用--%>
        <tr>
            <td>
                <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" HeaderText="员工基本档案" ClientInstanceName="popEdt"
                    Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                    Width="950px" OnWindowCallback="ASPxPopupControl1_WindowCallback" CloseAction="CloseButton"
                    AllowDragging="True">
                    <%--这里要注意ClientInstanceName是popEdt！然后还要注意有个OnWindowCallback的事件！--%>
                    <ContentCollection>
                        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                            <%--这个组件的作用是让PopupControl悬浮在其余的组件之上！--%>
                            <div>
                                <uc:EdtPersonnel ID="ucPersonnel" runat="server"></uc:EdtPersonnel>
                                <%--由于头文件引用了PersonnelUC这个页面并给出了uc代号，这里是在这个div中展示我需要的那个页面--%>
                                <%--   引用的页面必须放在div里？不能放table里？--%>
                            </div>
                            <table>
                                <%--定义了这个popupControl页面应该有个保存和关闭Button进行数据的上传--%>
                                <%--可能只需要保存？因为页面自带关闭功能--%>
                                <tr>
                                    <td>
                                        <dx:ASPxButton ID="btnSave" runat="server" Text="保存" OnClick="onButton_Click" />
                                    </td>
                                    <td>
                                        <dx:ASPxButton ID="btnCancel" runat="server" Text="关闭">
                                            <ClientSideEvents Click="function(s, e) {popEdt.Hide();e.processOnServer = false;}" />
                                            <%--这里的关闭时调用Hide（）函数让这个popEdit界面隐藏，不显示，并且关闭popEdit进程--%>
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
