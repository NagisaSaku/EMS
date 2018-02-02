<%@ Page Title="查询管理：查询部门档案" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="QueryDepartmentForm.aspx.cs" Inherits="CY.EMS.WebSite.QueryManage.QueryDepartmentForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 100%; height: 161px">
        <tr>
            <td align="left" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 16px;
                background-color: #CED8F6">
                <table>
                    <tr>
                        <td>
                            &nbsp; 请选择需要查询员工的部门:
                        </td>
                        <td>
                            <dx:ASPxComboBox ID="cbbDept" runat="server" ValueType="System.String" ValueField="@Dept"
                                IncrementalFilteringMode="Contains" />
                        </td>
                        <td>
                            <dx:ASPxButton ID="btnQuery" runat="server" Text="查询" />
                        </td>
                        <td>
                            <dx:ASPxButton ID="btnPrint" runat="server" Text="打印" OnClick="onButtonClick" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100%; height: 100px; background-color: gainsboro">
                <asp:SqlDataSource ID="sdsEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:CYHRMS %>"
                    SelectCommand="EXEC P_Bas_Get_Employee @DeptCode=@所属部门">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cbbDept" Name="所属部门" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div style="overflow: auto; width: 100%; height: auto">
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" Width="100%" DataSourceID="sdsEmployee"
                        KeyFieldName="Code" AutoGenerateColumns="False" >
                        <Columns>
                            <dx:GridViewDataTextColumn Caption="员工编号" FieldName="Code" VisibleIndex="0" />
                            <dx:GridViewDataTextColumn Caption="所属部门" FieldName="DeptName" VisibleIndex="1" />
                            <dx:GridViewDataTextColumn Caption="姓名" FieldName="Name" VisibleIndex="2" />
                            <dx:GridViewDataTextColumn Caption="性别" FieldName="SexName" VisibleIndex="3" />
                            <dx:GridViewDataTextColumn Caption="民族" FieldName="NationName" VisibleIndex="4" />
                            <dx:GridViewDataTextColumn Caption="籍贯" FieldName="NativePlace" VisibleIndex="5" />
                            <dx:GridViewDataTimeEditColumn Caption="出生日期" FieldName="Birthday" VisibleIndex="6">
                                <PropertiesTimeEdit DisplayFormatString="yyyy-MM-dd">
                                </PropertiesTimeEdit>
                            </dx:GridViewDataTimeEditColumn>
                            <dx:GridViewDataTextColumn Caption="身份证号码" FieldName="IDNumber" VisibleIndex="7" />
                            <dx:GridViewDataTextColumn Caption="政治面貌" FieldName="PoliticalStatus" VisibleIndex="8" />
                            <dx:GridViewDataTextColumn Caption="婚姻状况" FieldName="MaritalStatus" VisibleIndex="9" />
                            <dx:GridViewDataTextColumn Caption="文化程度" FieldName="EducationName" VisibleIndex="10" />
                            <dx:GridViewDataTextColumn Caption="职称" FieldName="JobTitle" VisibleIndex="11" />
                            <dx:GridViewDataTextColumn Caption="职务" FieldName="Job" VisibleIndex="12" />
                            <dx:GridViewDataTextColumn Caption="专业" FieldName="Major" VisibleIndex="13" />
                            <dx:GridViewDataTextColumn Caption="毕业院校" FieldName="School" VisibleIndex="14" />
                            <dx:GridViewDataTimeEditColumn Caption="进入公司时间" FieldName="BeginDate" VisibleIndex="15">
                                <PropertiesTimeEdit DisplayFormatString="yyyy-MM-dd">
                                </PropertiesTimeEdit>
                            </dx:GridViewDataTimeEditColumn>
                            <dx:GridViewDataTextColumn Caption="基本工资" FieldName="BaseSalary" VisibleIndex="16" />
                            <dx:GridViewDataTextColumn Caption="银行账号" FieldName="BankAccount" VisibleIndex="17" />
                            <dx:GridViewDataTextColumn Caption="养老保险账号" FieldName="PersionInsurance" VisibleIndex="18" />
                            <dx:GridViewDataTextColumn Caption="医疗保险账号" FieldName="MedicalInsurance" VisibleIndex="19" />
                            <dx:GridViewDataTextColumn Caption="住房基金账号" FieldName="HousingFund" VisibleIndex="20" />
                            <dx:GridViewDataTextColumn Caption="联系电话" FieldName="Phone" VisibleIndex="21" />
                            <dx:GridViewDataTextColumn Caption="手机号码" FieldName="Cellphone" VisibleIndex="22" />
                            <dx:GridViewDataTextColumn Caption="电子信箱" FieldName="EMail" VisibleIndex="23" />
                            <dx:GridViewDataTextColumn Caption="家庭住址" FieldName="Address" VisibleIndex="24" />
                            <dx:GridViewDataTextColumn Caption="邮政编码" FieldName="Zip" VisibleIndex="25" />
                            <dx:GridViewDataTextColumn Caption="补充说明" FieldName="Memo" VisibleIndex="26" />
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
