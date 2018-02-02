<%@ Page Title="当前位置：月度工资发放" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="PayForm.aspx.cs" Inherits="CY.EMS.WebSite.SalaryManage.PayForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 556px; height: 161px">
        <tr>
            <td align="left" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 16px;
                background-color: teal">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MyPersonnelDBConnectionString %>"
                    SelectCommand="SELECT * FROM [公司部门]"></asp:SqlDataSource>
                &nbsp;发放年份：<asp:DropDownList ID="DropDownList2" runat="server">
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
                发放月份：<asp:DropDownList ID="DropDownList3" runat="server">
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
                发放部门:<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                    DataTextField="部门名称" DataValueField="部门名称" Width="75px">
                </asp:DropDownList>
                &nbsp;<asp:Button ID="Button1" runat="server" Text="查询" Width="80px" /><asp:Button
                    ID="Button2" runat="server" OnClick="Button2_Click" Text="打印" Width="80px" />
            </td>
        </tr>
        <tr>
            <td style="width: 2232px; height: 100px; background-color: gainsboro">
                <asp:Panel ID="Panel1" runat="server" Height="220px" ScrollBars="Auto" Width="553px">
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MyPersonnelDBConnectionString %>"
                        SelectCommand="SELECT * FROM [工资发放表] WHERE (([发放年份] = @发放年份) AND ([发放月份] = @发放月份) AND ([员工编号] IN (Select 员工编号 FROM 在职员工视图 WHERE 所属部门=@所属部门)))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList2" Name="发放年份" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList3" Name="发放月份" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList1" Name="所属部门" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="自编号"
                        DataSourceID="SqlDataSource2" Font-Names="宋体" Font-Size="Small" GridLines="Vertical"
                        Width="1800px">
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <Columns>
                            <asp:BoundField DataField="自编号" HeaderText="自编号" InsertVisible="False" ReadOnly="True"
                                SortExpression="自编号" Visible="False" />
                            <asp:BoundField DataField="员工编号" HeaderText="员工编号" SortExpression="员工编号" Visible="False" />
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
                            <asp:BoundField DataField="补充说明" HeaderText="补充说明" SortExpression="补充说明" />
                        </Columns>
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                    </asp:GridView>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
