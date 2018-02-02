<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="QuerySalaryForm.aspx.cs" Inherits="CY.EMS.WebSite.QueryManage.QuerySalaryForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 556px; height: 161px">
        <tr>
            <td align="center" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 16px;
                background-color: teal">
                &nbsp;发放年份：<asp:DropDownList ID="DropDownList1" runat="server" Width="90px">
                    <asp:ListItem>2006</asp:ListItem>
                    <asp:ListItem>2007</asp:ListItem>
                    <asp:ListItem>2008</asp:ListItem>
                    <asp:ListItem>2009</asp:ListItem>
                    <asp:ListItem>2010</asp:ListItem>
                    <asp:ListItem>2011</asp:ListItem>
                    <asp:ListItem>2012</asp:ListItem>
                    <asp:ListItem>2013</asp:ListItem>
                    <asp:ListItem>2014</asp:ListItem>
                    <asp:ListItem>2015</asp:ListItem>
                    <asp:ListItem>2016</asp:ListItem>
                    <asp:ListItem>2017</asp:ListItem>
                    <asp:ListItem>2018</asp:ListItem>
                    <asp:ListItem>2019</asp:ListItem>
                    <asp:ListItem>2020</asp:ListItem>
                </asp:DropDownList>
                发放月份：<asp:DropDownList ID="DropDownList2" runat="server" Width="80px">
                    <asp:ListItem>1</asp:ListItem>
                    <asp:ListItem>2</asp:ListItem>
                    <asp:ListItem>3</asp:ListItem>
                    <asp:ListItem>4</asp:ListItem>
                    <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem>6</asp:ListItem>
                    <asp:ListItem>7</asp:ListItem>
                    <asp:ListItem>8</asp:ListItem>
                    <asp:ListItem>9</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                </asp:DropDownList>
                &nbsp;<asp:Button ID="Button1" runat="server" Text="查询" Width="90px" />
                <asp:Button ID="Button2" runat="server" Text="打印全部工资信息" Width="129px" OnClick="Button2_Click" />
                <asp:Button ID="Button3" runat="server" Text="打印银行入账单" Width="129px" OnClick="Button3_Click" />
                <asp:Button ID="Button4" runat="server" Text="打印养老险入账单" Width="129px" OnClick="Button4_Click" />
                <asp:Button ID="Button5" runat="server" Text="打印医疗险入账单" Width="129px" OnClick="Button5_Click" />
                <asp:Button ID="Button6" runat="server" Text="打印住房基金入账单" Width="141px" OnClick="Button6_Click" />
            </td>
        </tr>
        <tr>
            <td style="width: 2232px; height: 100px; background-color: gainsboro">
                <asp:Panel ID="Panel1" runat="server" Height="220px" ScrollBars="Auto" Width="553px">
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MyPersonnelDBConnectionString %>"
                        SelectCommand="SELECT [员工编号], [员工姓名], [基本工资], [津贴], [奖金], [工龄工资], [岗位工资], [其他应增项], [应发合计], [所得税], [养老险], [医疗险], [住房基金], [其他应减项], [应减合计], [实发金额], [银行账号], [养老保险账号], [医疗保险账号], [住房基金账号], [身份证号码], [发放年份], [发放月份] FROM [工资发放表] WHERE (([发放年份] = @发放年份) AND ([发放月份] = @发放月份))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="发放年份" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList2" Name="发放月份" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource1"
                        Font-Names="宋体" Font-Size="Small" GridLines="Vertical" Width="1800px">
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <Columns>
                            <asp:BoundField DataField="员工编号" HeaderText="员工编号" SortExpression="员工编号" />
                            <asp:BoundField DataField="员工姓名" HeaderText="员工姓名" SortExpression="员工姓名" />
                            <asp:BoundField DataField="基本工资" HeaderText="基本工资" SortExpression="基本工资" />
                            <asp:BoundField DataField="津贴" HeaderText="津贴" SortExpression="津贴" />
                            <asp:BoundField DataField="奖金" HeaderText="奖金" SortExpression="奖金" />
                            <asp:BoundField DataField="工龄工资" HeaderText="工龄工资" SortExpression="工龄工资" />
                            <asp:BoundField DataField="岗位工资" HeaderText="岗位工资" SortExpression="岗位工资" />
                            <asp:BoundField DataField="其他应增项" HeaderText="其他应增项" SortExpression="其他应增项" />
                            <asp:BoundField DataField="应发合计" HeaderText="应发合计" ReadOnly="True" SortExpression="应发合计" />
                            <asp:BoundField DataField="所得税" HeaderText="所得税" SortExpression="所得税" />
                            <asp:BoundField DataField="养老险" HeaderText="养老险" SortExpression="养老险" />
                            <asp:BoundField DataField="医疗险" HeaderText="医疗险" SortExpression="医疗险" />
                            <asp:BoundField DataField="住房基金" HeaderText="住房基金" SortExpression="住房基金" />
                            <asp:BoundField DataField="其他应减项" HeaderText="其他应减项" SortExpression="其他应减项" />
                            <asp:BoundField DataField="应减合计" HeaderText="应减合计" ReadOnly="True" SortExpression="应减合计" />
                            <asp:BoundField DataField="实发金额" HeaderText="实发金额" ReadOnly="True" SortExpression="实发金额" />
                            <asp:BoundField DataField="银行账号" HeaderText="银行账号" SortExpression="银行账号" />
                            <asp:BoundField DataField="养老保险账号" HeaderText="养老保险账号" SortExpression="养老保险账号" />
                            <asp:BoundField DataField="医疗保险账号" HeaderText="医疗保险账号" SortExpression="医疗保险账号" />
                            <asp:BoundField DataField="住房基金账号" HeaderText="住房基金账号" SortExpression="住房基金账号" />
                            <asp:BoundField DataField="身份证号码" HeaderText="身份证号码" SortExpression="身份证号码" />
                            <asp:BoundField DataField="发放年份" HeaderText="发放年份" SortExpression="发放年份" />
                            <asp:BoundField DataField="发放月份" HeaderText="发放月份" SortExpression="发放月份" />
                        </Columns>
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="Gainsboro" />
                    </asp:GridView>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
