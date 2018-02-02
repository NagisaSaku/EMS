<%@ Page Title="当前位置：员工工作业绩" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="Performance.aspx.cs" Inherits="CY.EMS.WebSite.FileManage.Performance" %>

<%@ Register Src="~/FileManage/PerformanceUC.ascx" TagName="EdtPerformance" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            //            alert(values[0]);
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
                            <dx:ASPxLabel ID="lblID" runat="server" Text="自编号">
                            </dx:ASPxLabel>
                        </td>
                        <td style="width: 120px">
                            <dx:ASPxTextBox ID="txtID" runat="server" Width="100%" />
                            <%--注意这里的ID 要和数据库存储过程中get_Family中的参数一致现在只支持操作这两个数据的查询和传递
                            --%>
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
                                <%--Click触发调出一个窗口--%>
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
                        <dx:GridViewDataTextColumn Caption="自编号" VisibleIndex="0" FieldName="ID">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="员工编号" VisibleIndex="1" FieldName="EmpCode">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="专业特长" VisibleIndex="2" FieldName="Speciality">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="员工表现" VisibleIndex="3" FieldName="Performance">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="补充说明" VisibleIndex="4" FieldName="Memo">
                        </dx:GridViewDataTextColumn>
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
            </td>
        </tr>
        <%--PopControl控件，实现点击新增以及查看可以调用XXXXUC控件页面实现代码的复用--%>
        <tr>
            <td>
                <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" HeaderText="员工工作业绩" ClientInstanceName="popEdt"
                    Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
                    Width="700px" OnWindowCallback="ASPxPopupControl1_WindowCallback" CloseAction="CloseButton"
                    AllowDragging="True">
                    <%--这里要注意ClientInstanceName（就是指这个popup被赋予一个id名为popEdt）是popEdt！然后还要注意有个OnWindowCallback的事件！--%>
                    <ContentCollection>
                        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                            <%--这个组件的作用是让PopupControl悬浮在其余的组件之上！--%>
                            <div>
                                <uc:EdtPerformance ID="ucPerformance" runat="server"></uc:EdtPerformance>
                                <%--由于头文件引用了PersonnelUC这个页面并给出了uc代号，这里是在这个div中展示我需要的那个页面--%>
                                <%--EdtResume是引用的ResumeUC的代号，而ucResume是在这个页面的这个EdtResume用户自定义组件的一个ID！！！--%>
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
