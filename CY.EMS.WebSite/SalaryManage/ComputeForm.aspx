<%@ Page Title="当前位置：月度工资核算" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="ComputeForm.aspx.cs" Inherits="CY.EMS.WebSite.SalaryManage.ComputeForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 556px; height: 161px">
        <tr>
            <td align="left" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 16px;
                background-color: teal">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MyPersonnelDBConnectionString %>"
                    SelectCommand="SELECT * FROM [公司部门]"></asp:SqlDataSource>
                &nbsp;<asp:Label ID="Label1" runat="server" Width="1px"></asp:Label>部门:<asp:DropDownList
                    ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                    DataTextField="部门名称" DataValueField="部门名称" Width="80px">
                </asp:DropDownList>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="查询" Width="70px" />
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="打印" Width="70px" />
                年份：<asp:DropDownList ID="DropDownList2" runat="server">
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
                月份：<asp:DropDownList ID="DropDownList3" runat="server">
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
                <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="发工资" Width="80px" />
            </td>
        </tr>
        <tr>
            <td style="width: 2232px; height: 100px; background-color: gainsboro">
                <asp:Panel ID="Panel1" runat="server" Height="220px" ScrollBars="Auto" Width="553px">
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MyPersonnelDBConnectionString %>"
                        SelectCommand="SELECT * FROM [工资核算表] WHERE ([员工编号] IN (Select 员工编号 FROM 在职员工视图 WHERE 所属部门=@所属部门))"
                        UpdateCommand="UPDATE [工资核算表] SET  [基本工资] = @基本工资, [津贴] = @津贴, [奖金] = @奖金, [工龄工资] = @工龄工资, [岗位工资] = @岗位工资, [其他应增项] = @其他应增项, [所得税] = @所得税, [养老险] = @养老险, [医疗险] = @医疗险, [住房基金] = @住房基金, [其他应减项] = @其他应减项, [补充说明] = @补充说明 WHERE [自编号] = @自编号">
                        <DeleteParameters>
                            <asp:Parameter Name="自编号" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="基本工资" Type="Double" />
                            <asp:Parameter Name="津贴" Type="Double" />
                            <asp:Parameter Name="奖金" Type="Double" />
                            <asp:Parameter Name="工龄工资" Type="Double" />
                            <asp:Parameter Name="岗位工资" Type="Double" />
                            <asp:Parameter Name="其他应增项" Type="Double" />
                            <asp:Parameter Name="所得税" Type="Double" />
                            <asp:Parameter Name="养老险" Type="Double" />
                            <asp:Parameter Name="医疗险" Type="Double" />
                            <asp:Parameter Name="住房基金" Type="Double" />
                            <asp:Parameter Name="其他应减项" Type="Double" />
                            <asp:Parameter Name="补充说明" Type="String" />
                            <asp:Parameter Name="自编号" Type="Int32" />
                        </UpdateParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="所属部门" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="自编号"
                        DataSourceID="SqlDataSource2" Font-Names="宋体" Font-Size="Small" GridLines="Vertical"
                        Width="1150px">
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <Columns>
                            <asp:CommandField ButtonType="Button" HeaderText="编辑" ShowEditButton="True" />
                            <asp:BoundField DataField="自编号" HeaderText="自编号" InsertVisible="False" ReadOnly="True"
                                SortExpression="自编号" Visible="False" />
                            <asp:BoundField DataField="员工编号" HeaderText="员工编号" ReadOnly="True" SortExpression="员工编号"
                                Visible="False" />
                            <asp:BoundField DataField="员工姓名" HeaderText="员工姓名" ReadOnly="True" SortExpression="员工姓名" />
                            <asp:BoundField DataField="基本工资" HeaderText="基本工资" SortExpression="基本工资" />
                            <asp:BoundField DataField="津贴" HeaderText="津贴" SortExpression="津贴" />
                            <asp:BoundField DataField="奖金" HeaderText="奖金" SortExpression="奖金" />
                            <asp:BoundField DataField="工龄工资" HeaderText="工龄工资" SortExpression="工龄工资" />
                            <asp:BoundField DataField="岗位工资" HeaderText="岗位工资" SortExpression="岗位工资" />
                            <asp:BoundField DataField="其他应增项" HeaderText="其他应增项" SortExpression="其他应增项" />
                            <asp:BoundField DataField="所得税" HeaderText="所得税" SortExpression="所得税" />
                            <asp:BoundField DataField="养老险" HeaderText="养老险" SortExpression="养老险" />
                            <asp:BoundField DataField="医疗险" HeaderText="医疗险" SortExpression="医疗险" />
                            <asp:BoundField DataField="住房基金" HeaderText="住房基金" SortExpression="住房基金" />
                            <asp:BoundField DataField="其他应减项" HeaderText="其他应减项" SortExpression="其他应减项" />
                            <asp:BoundField DataField="补充说明" HeaderText="补充说明" SortExpression="补充说明" />
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
