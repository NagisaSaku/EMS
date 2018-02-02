<%@ Page Title="当前位置：查询个人档案" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="QueryMemberForm.aspx.cs" Inherits="CY.EMS.WebSite.QueryManage.QueryMemberForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function cbbDept_SelectedIndexChanged(s, e) {
            // 选择部门时，过滤员工
            cbbEmployee.PerformCallback(s.lastSuccessValue);
        }
    </script>
    <table style="width: 1200px; height: 161px">
        <tr>
            <td align="left" style="font-size: 0.8em; width: 100%; font-family: 宋体; height: 16px;
                background-color: #CED8F6">
                <table>
                    <tr>
                        <td>
                            &nbsp;所在部门:
                        </td>
                        <td>
                            <dx:ASPxComboBox ID="cbbDept" runat="server" ValueField="@Dept" IncrementalFilteringMode="Contains"
                                ClientInstanceName="cbbDept">
                                <ClientSideEvents SelectedIndexChanged="function(s, e) { cbbDept_SelectedIndexChanged(s, e); }" />
                            </dx:ASPxComboBox>
                        </td>
                        <td>
                            &nbsp;员工姓名:
                        </td>
                        <td>
                            <dx:ASPxComboBox ID="cbbEmployee" runat="server" ValueType="System.String" ValueField="@Employee"
                                IncrementalFilteringMode="Contains" ClientInstanceName="cbbEmployee" OnCallback="cbbEmployee_Callback" />
                        </td>
                        <td>
                            <dx:ASPxButton ID="btnQuery" runat="server" Text="查询">
                            </dx:ASPxButton>
                        </td>
                        <td>
                            <dx:ASPxButton ID="btnPrint" runat="server" Text="打印" OnClick="onButtonClick">
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left" style="font-size: 0.8em; font-family: 宋体; height: 60px;">
                &nbsp;员工基本档案
                <asp:SqlDataSource ID="sdsEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:CYHRMS %>"
                    SelectCommand="exec P_Bas_Get_Employee @Code=@员工编号">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cbbEmployee" Name="员工编号" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div style="overflow: auto; width: 1200px; height: auto">
                    <dx:ASPxGridView ID="GV_Emp" runat="server" DataSourceID="sdsEmployee" KeyFieldName="Code"
                        AutoGenerateColumns="False">
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
                            <dx:GridViewDataTextColumn Caption="基本工资" FieldName="BaseSalary" VisibleIndex="17" />
                            <dx:GridViewDataTextColumn Caption="银行账号" FieldName="BankAccount" VisibleIndex="18" />
                            <dx:GridViewDataTextColumn Caption="养老保险账号" FieldName="PersionInsurance" VisibleIndex="19" />
                            <dx:GridViewDataTextColumn Caption="医疗保险账号" FieldName="MedicalInsurance" VisibleIndex="20" />
                            <dx:GridViewDataTextColumn Caption="住房基金账号" FieldName="HousingFund" VisibleIndex="21" />
                            <dx:GridViewDataTextColumn Caption="联系电话" FieldName="Phone" VisibleIndex="22" />
                            <dx:GridViewDataTextColumn Caption="手机号码" FieldName="Cellphone" VisibleIndex="23" />
                            <dx:GridViewDataTextColumn Caption="电子信箱" FieldName="EMail" VisibleIndex="24" />
                            <dx:GridViewDataTextColumn Caption="家庭住址" FieldName="Address" VisibleIndex="25" />
                            <dx:GridViewDataTextColumn Caption="邮政编码" FieldName="Zip" VisibleIndex="26" />
                            <dx:GridViewDataTextColumn Caption="补充说明" FieldName="Memo" VisibleIndex="27" />
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </td>
        </tr>
        <tr>
            <td align="left" style="font-size: 0.8em; font-family: 宋体; height: 60px;">
                &nbsp;员工家庭成员
                <asp:SqlDataSource ID="sdsFamily" runat="server" ConnectionString="<%$ ConnectionStrings:CYHRMS %>"
                    SelectCommand="EXEC P_Biz_Get_Family @EmpCode = @员工编号">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cbbEmployee" Name="员工编号" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div style="overflow: auto; width: 1200px; height: auto">
                    <dx:ASPxGridView ID="GV_Family" runat="server" DataSourceID="sdsFamily" KeyFieldName="ID"
                        AutoGenerateColumns="False" Width="100%">
                        <Columns>
                            <dx:GridViewDataTextColumn Caption="自编号" FieldName="ID" VisibleIndex="0" />
                            <dx:GridViewDataTextColumn Caption="家庭成员姓名" FieldName="FamName" VisibleIndex="1" />
                            <dx:GridViewDataTextColumn Caption="与员工关系" FieldName="RelationShip" VisibleIndex="2" />
                            <dx:GridViewDataTextColumn Caption="工作单位" FieldName="Company" VisibleIndex="3" />
                            <dx:GridViewDataTextColumn Caption="担任职务" FieldName="Job" VisibleIndex="4" />
                            <dx:GridViewDataTextColumn Caption="政治面貌" FieldName="PoliticalStatus" VisibleIndex="5" />
                            <dx:GridViewDataTextColumn Caption="联系电话" FieldName="Phone" VisibleIndex="6" />
                            <dx:GridViewDataTextColumn Caption="补充说明" FieldName="Memo" VisibleIndex="7" />
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </td>
        </tr>
        <tr>
            <td align="left" style="font-size: 0.8em; font-family: 宋体; height: 60px;">
                &nbsp;员工工作简历
                <asp:SqlDataSource ID="sdsResume" runat="server" ConnectionString="<%$ ConnectionStrings:CYHRMS %>"
                    SelectCommand="EXEC P_Biz_Get_Resume @EmpCode = @员工编号">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cbbEmployee" Name="员工编号" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div style="overflow: auto; width: 1200px; height: auto">
                    <dx:ASPxGridView ID="GV_Resume" runat="server" DataSourceID="sdsResume" KeyFieldName="ID"
                        AutoGenerateColumns="False" Width="100%">
                        <Columns>
                            <dx:GridViewDataTextColumn Caption="自编号" FieldName="ID" VisibleIndex="0" />
                            <dx:GridViewDataTimeEditColumn Caption="开始日期" FieldName="FromDate" VisibleIndex="1">
                                <PropertiesTimeEdit DisplayFormatString="yyyy-MM-dd">
                                </PropertiesTimeEdit>
                            </dx:GridViewDataTimeEditColumn>
                            <dx:GridViewDataTimeEditColumn Caption="结束日期" FieldName="ToDate" VisibleIndex="2">
                                <PropertiesTimeEdit DisplayFormatString="yyyy-MM-dd">
                                </PropertiesTimeEdit>
                            </dx:GridViewDataTimeEditColumn>
                            <dx:GridViewDataTextColumn Caption="单位名称" FieldName="Company" VisibleIndex="3" />
                            <dx:GridViewDataTextColumn Caption="所在部门" FieldName="Dept" VisibleIndex="4" />
                            <dx:GridViewDataTextColumn Caption="担任职务" FieldName="Job" VisibleIndex="5" />
                            <dx:GridViewDataTextColumn Caption="补充说明" FieldName="Memo" VisibleIndex="6" />
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </td>
        </tr>
        <tr>
            <td align="left" style="font-size: 0.8em; font-family: 宋体; height: 60px;">
                &nbsp;员工培训记录
                <asp:SqlDataSource ID="sdsTraining" runat="server" ConnectionString="<%$ ConnectionStrings:CYHRMS %>"
                    SelectCommand="EXEC P_Biz_Get_Training @EmpCode = @员工编号">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cbbEmployee" Name="员工编号" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div style="overflow: auto; width: 1200px; height: auto">
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="sdsTraining" KeyFieldName="ID"
                        AutoGenerateColumns="False" Width="100%">
                        <Columns>
                            <dx:GridViewDataTextColumn Caption="自编号" FieldName="ID" VisibleIndex="0" />
                            <dx:GridViewDataTimeEditColumn Caption="开始日期" FieldName="FromDate" VisibleIndex="1">
                                <PropertiesTimeEdit DisplayFormatString="yyyy-MM-dd">
                                </PropertiesTimeEdit>
                            </dx:GridViewDataTimeEditColumn>
                            <dx:GridViewDataTimeEditColumn Caption="结束日期" FieldName="ToDate" VisibleIndex="2">
                                <PropertiesTimeEdit DisplayFormatString="yyyy-MM-dd">
                                </PropertiesTimeEdit>
                            </dx:GridViewDataTimeEditColumn>
                            <dx:GridViewDataTextColumn Caption="培训单位" FieldName="TrainUnit" VisibleIndex="3" />
                            <dx:GridViewDataTextColumn Caption="培训地点" FieldName="Address" VisibleIndex="4" />
                            <dx:GridViewDataTextColumn Caption="培训内容" FieldName="TrainContent" VisibleIndex="5" />
                            <dx:GridViewDataSpinEditColumn Caption="培训经费" FieldName="Price" VisibleIndex="7">
                                <PropertiesSpinEdit DisplayFormatString="0.00">
                                </PropertiesSpinEdit>
                            </dx:GridViewDataSpinEditColumn>
                            <dx:GridViewDataTextColumn Caption="证书名称" FieldName="Certificate" VisibleIndex="8" />
                            <dx:GridViewDataTextColumn Caption="补充说明" FieldName="Memo" VisibleIndex="9" />
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </td>
        </tr>
        <tr>
            <td align="left" style="font-size: 0.8em; font-family: 宋体; height: 60px;">
                &nbsp;员工奖惩记录
                <asp:SqlDataSource ID="sdsRwdAndPnh" runat="server" ConnectionString="<%$ ConnectionStrings:CYHRMS %>"
                    SelectCommand="EXEC P_Biz_Get_RwdAndPnh @EmpCode = @员工编号">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cbbEmployee" Name="员工编号" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div style="overflow: auto; width: 1200px; height: auto">
                    <dx:ASPxGridView ID="GV_RwdAndPnh" runat="server" DataSourceID="sdsRwdAndPnh" KeyFieldName="ID"
                        AutoGenerateColumns="False" Width="100%">
                        <Columns>
                            <dx:GridViewDataTextColumn Caption="自编号" FieldName="ID" VisibleIndex="0" />
                            <dx:GridViewDataTimeEditColumn Caption="奖惩日期" FieldName="ValidDate" VisibleIndex="1">
                                <PropertiesTimeEdit DisplayFormatString="yyyy-MM-dd">
                                </PropertiesTimeEdit>
                            </dx:GridViewDataTimeEditColumn>
                            <dx:GridViewDataTextColumn Caption="奖惩类型" FieldName="Type" VisibleIndex="2" />
                            <dx:GridViewDataTextColumn Caption="奖惩原因" FieldName="Reason" VisibleIndex="3" />
                            <dx:GridViewDataTextColumn Caption="奖惩批准单位" FieldName="Dept" VisibleIndex="4" />
                            <dx:GridViewDataTimeEditColumn Caption="解除处分日期" FieldName="InvalidDate" VisibleIndex="5">
                                <PropertiesTimeEdit DisplayFormatString="yyyy-MM-dd">
                                </PropertiesTimeEdit>
                            </dx:GridViewDataTimeEditColumn>
                            <dx:GridViewDataTextColumn Caption="补充说明" FieldName="Memo" VisibleIndex="6" />
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </td>
        </tr>
        <tr>
            <td align="left" style="font-size: 0.8em; font-family: 宋体; height: 60px;">
                &nbsp;员工工作业绩
                <asp:SqlDataSource ID="sdsPerformance" runat="server" ConnectionString="<%$ ConnectionStrings:CYHRMS %>"
                    SelectCommand="EXEC P_Biz_Get_Performance @EmpCode = @员工编号">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cbbEmployee" Name="员工编号" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div style="overflow: auto; width: 1200px; height: auto">
                    <dx:ASPxGridView ID="GV_Performance" runat="server" DataSourceID="sdsPerformance"
                        KeyFieldName="ID" AutoGenerateColumns="False" Width="100%">
                        <Columns>
                            <dx:GridViewDataTextColumn Caption="自编号" FieldName="ID" VisibleIndex="0" />
                            <dx:GridViewDataTextColumn Caption="专长描述" FieldName="Speciality" VisibleIndex="1" />
                            <dx:GridViewDataTextColumn Caption="工作业绩" FieldName="Performance" VisibleIndex="2" />
                            <dx:GridViewDataTextColumn Caption="补充说明" FieldName="Memo" VisibleIndex="3" />
                        </Columns>
                    </dx:ASPxGridView>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
