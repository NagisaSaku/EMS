<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QueryMemberPrint.aspx.cs"
    Inherits="CY.EMS.WebSite.QueryManage.QueryMemberPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>打印员工个人人事档案</title>
</head>
<body>
    <form id="form1" runat="server">
    <table style="font-size: 10pt; width: 581px; height: 90px">
        <tr>
            <td align="center" colspan="2">
                <asp:Label ID="Label1" runat="server" Font-Names="宋体" Font-Size="X-Large" Text="员工个人档案"
                    Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height: 33px">
                &nbsp;<br />
                &nbsp; 单位公章： &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                <asp:Label ID="Label2" runat="server" Text="打印日期："></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                <asp:Label ID="Label3" runat="server" Text="员工编号："></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height: 44px">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/MyBoldLine.JPG" /><br />
                &nbsp;
                <asp:Label ID="Label4" runat="server" Text="部门："></asp:Label>
                &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;<asp:Label ID="Label5" runat="server" Text="姓名："></asp:Label>
                &nbsp;&nbsp;&nbsp; &nbsp;
                <asp:Label ID="Label6" runat="server" Text="性别："></asp:Label>
                &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;<asp:Label ID="Label7" runat="server" Text="民族："></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp;
                <asp:Label ID="Label8" runat="server" Text="籍贯："></asp:Label>
                &nbsp; &nbsp; &nbsp;&nbsp;<br />
                <asp:Image ID="Image2" runat="server" Height="1px" ImageUrl="~/Images/MyThinLine.JPG"
                    Width="575px" /><br />
                &nbsp;
                <asp:Label ID="Label9" runat="server" Text="出生日期："></asp:Label>
                &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                <asp:Label ID="Label10" runat="server" Text="身份证号码："></asp:Label>
                &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;
                <asp:Label ID="Label11" runat="server" Text="政治面貌："></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br />
                <asp:Image ID="Image3" runat="server" Height="1px" ImageUrl="~/Images/MyThinLine.JPG"
                    Width="575px" /><br />
                &nbsp;
                <asp:Label ID="Label12" runat="server" Text="婚姻状况："></asp:Label>
                &nbsp; &nbsp;&nbsp;
                <asp:Label ID="Label13" runat="server" Text="文化程度："></asp:Label>
                &nbsp; &nbsp;&nbsp;
                <asp:Label ID="Label14" runat="server" Text="职称："></asp:Label>
                &nbsp; &nbsp;&nbsp;
                <asp:Label ID="Label15" runat="server" Text="职务："></asp:Label>
                &nbsp; &nbsp;&nbsp;
                <asp:Label ID="Label16" runat="server" Text="专业："></asp:Label><br />
                <asp:Image ID="Image4" runat="server" Height="1px" ImageUrl="~/Images/MyThinLine.JPG"
                    Width="575px" /><br />
                &nbsp;
                <asp:Label ID="Label17" runat="server" Text="毕业院校："></asp:Label>
                &nbsp; &nbsp;
                <asp:Label ID="Label18" runat="server" Text="进入公司时间："></asp:Label>
                &nbsp; &nbsp;
                <asp:Label ID="Label19" runat="server" Text="合同服务年限："></asp:Label>&nbsp;
                <asp:Label ID="Label20" runat="server" Text="基本工资："></asp:Label><br />
                <asp:Image ID="Image5" runat="server" Height="1px" ImageUrl="~/Images/MyThinLine.JPG"
                    Width="575px" /><br />
                &nbsp;
                <asp:Label ID="Label21" runat="server" Text="银行账号："></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp;
                <asp:Label ID="Label22" runat="server" Text="养老保险账号："></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp;<asp:Label ID="Label23" runat="server" Text="医疗保险账号："></asp:Label><br />
                <asp:Image ID="Image6" runat="server" Height="1px" ImageUrl="~/Images/MyThinLine.JPG"
                    Width="575px" /><br />
                &nbsp;
                <asp:Label ID="Label24" runat="server" Text="住房基金账号："></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp;<asp:Label ID="Label25" runat="server" Text="联系电话："></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp;
                <asp:Label ID="Label26" runat="server" Text="手机号码："></asp:Label>
                &nbsp; &nbsp;&nbsp;
                <br />
                <asp:Image ID="Image7" runat="server" Height="1px" ImageUrl="~/Images/MyThinLine.JPG"
                    Width="575px" /><br />
                &nbsp;&nbsp;
                <asp:Label ID="Label27" runat="server" Text="电子信箱："></asp:Label>&nbsp;
                <asp:Label ID="Label28" runat="server" Text="家庭住址："></asp:Label>&nbsp;
                <asp:Label ID="Label29" runat="server" Text="邮政编码："></asp:Label>&nbsp;<br />
                <asp:Image ID="Image8" runat="server" Height="1px" ImageUrl="~/Images/MyThinLine.JPG"
                    Width="575px" /><br />
                &nbsp;
                <asp:Label ID="Label30" runat="server" Text="补充说明："></asp:Label><asp:Image ID="Image9"
                    runat="server" Height="1px" ImageUrl="~/Images/MyThinLine.JPG" Width="575px" /><br />
                员工家庭成员：<br />
                <asp:GridView ID="GridView1" runat="server" Width="572px" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="自编号" />
                        <asp:BoundField DataField="FamName" HeaderText="家庭成员姓名" />
                        <asp:BoundField DataField="RelationShip" HeaderText="与员工关系" />
                        <asp:BoundField DataField="Company" HeaderText="工作单位" />
                        <asp:BoundField DataField="Job" HeaderText="担任职务" />
                        <asp:BoundField DataField="PoliticalStatus" HeaderText="政治面貌" />
                        <asp:BoundField DataField="Phone" HeaderText="联系电话" />
                        <asp:BoundField DataField="Memo" HeaderText="补充说明" />
                    </Columns>
                </asp:GridView>
                员工工作简历：<br />
                <asp:GridView ID="GridView2" runat="server" Width="572px" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="自编号" />
                        <asp:BoundField DataField="FromDate" HeaderText="开始日期" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="ToDate" HeaderText="结束日期" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Company" HeaderText="单位名称" />
                        <asp:BoundField DataField="Dept" HeaderText="所在部门" />
                        <asp:BoundField DataField="Job" HeaderText="担任职务" />
                        <asp:BoundField DataField="Memo" HeaderText="补充说明" />
                    </Columns>
                </asp:GridView>
                员工培训记录：<br />
                <asp:GridView ID="GridView3" runat="server" Width="572px" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="自编号" />
                        <asp:BoundField DataField="FromDate" HeaderText="开始日期" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="ToDate" HeaderText="结束日期" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="TrainUnit" HeaderText="培训单位" />
                        <asp:BoundField DataField="Address" HeaderText="培训地点" />
                        <asp:BoundField DataField="TrainContent" HeaderText="培训内容" />
                        <asp:BoundField DataField="Price" HeaderText="培训经费" />
                        <asp:BoundField DataField="Certificate" HeaderText="证书名称" />
                        <asp:BoundField DataField="Memo" HeaderText="补充说明" />
                    </Columns>
                </asp:GridView>
                员工奖惩记录：<br />
                <asp:GridView ID="GridView4" runat="server" Width="572px" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="自编号" />
                        <asp:BoundField DataField="ValidDate" HeaderText="奖惩日期" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Type" HeaderText="奖惩类型" />
                        <asp:BoundField DataField="Reason" HeaderText="奖惩原因" />
                        <asp:BoundField DataField="Dept" HeaderText="奖惩批准单位" />
                        <asp:BoundField DataField="InvalidDate" HeaderText="解除处分日期" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Memo" HeaderText="补充说明" />
                    </Columns>
                </asp:GridView>
                员工工作业绩：<br />
                <asp:GridView ID="GridView5" runat="server" Width="572px" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="自编号" />
                        <asp:BoundField DataField="Speciality" HeaderText="专长描述" />
                        <asp:BoundField DataField="Performance" HeaderText="工作业绩" />
                        <asp:BoundField DataField="Memo" HeaderText="补充说明" />
                    </Columns>
                </asp:GridView>
                <asp:Image ID="Image10" runat="server" ImageUrl="~/Images/MyBoldLine.JPG" /><br />
                <asp:Label ID="Label31" runat="server" Text="操作人员:"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
            </td>
        </tr>
    </table>
    <br />
    </form>
</body>
</html>
