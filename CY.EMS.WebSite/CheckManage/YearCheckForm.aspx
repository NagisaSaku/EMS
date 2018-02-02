<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="YearCheckForm.aspx.cs" Inherits="CYHRMS.CheckManage.YearCheckForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 556px; height: 161px">
        <tr>
            <td align="left" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 16px;
                background-color: teal">
                &nbsp;所在部门:<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True"
                    DataSourceID="SqlDataSource1" DataTextField="部门名称" DataValueField="部门名称" Width="70px">
                </asp:DropDownList>
                员工姓名:<asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2"
                    DataTextField="姓名" DataValueField="员工编号" Width="70px">
                </asp:DropDownList>
                考勤年份：<asp:DropDownList ID="DropDownList3" runat="server">
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
                <asp:Button ID="Button1" runat="server" Text="查询" Width="70px" />
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="打印" Width="70px" />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MyPersonnelDBConnectionString %>"
                    SelectCommand="SELECT * FROM [公司部门]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MyPersonnelDBConnectionString %>"
                    SelectCommand="SELECT * FROM [在职员工视图] WHERE ([所属部门] = @所属部门)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="所属部门" PropertyName="SelectedValue"
                            Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="center" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 27px;
                background-color: mediumturquoise">
                考勤符号：出勤[/] 迟到[&gt;] 早退[&lt;] 产假[√] 事假[#] 病假[+] 婚假[△] 旷工[×]
            </td>
        </tr>
        <tr>
            <td style="width: 2232px; height: 100px; background-color: gainsboro">
                <asp:Panel ID="Panel1" runat="server" Height="220px" ScrollBars="Auto" Width="553px">
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MyPersonnelDBConnectionString %>"
                        SelectCommand="SELECT * FROM [考勤记录] WHERE (([员工编号] = @员工编号) AND ([考勤年份] = @考勤年份)) ">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList2" Name="员工编号" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="DropDownList3" Name="考勤年份" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="自编号"
                        DataSourceID="SqlDataSource3" Font-Names="宋体" Font-Size="Small" GridLines="Vertical"
                        Width="1100px">
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <Columns>
                            <asp:BoundField DataField="考勤年份" HeaderText="考勤年份" SortExpression="考勤年份" />
                            <asp:BoundField DataField="考勤月份" HeaderText="考勤月份" SortExpression="考勤月份" />
                            <asp:BoundField DataField="自编号" HeaderText="自编号" InsertVisible="False" ReadOnly="True"
                                SortExpression="自编号" Visible="False" />
                            <asp:BoundField DataField="员工编号" HeaderText="员工编号" SortExpression="员工编号" Visible="False" />
                            <asp:BoundField DataField="员工姓名" HeaderText="员工姓名" SortExpression="员工姓名" Visible="False" />
                            <asp:BoundField DataField="C1" HeaderText="C1" SortExpression="C1" />
                            <asp:BoundField DataField="C2" HeaderText="C2" SortExpression="C2" />
                            <asp:BoundField DataField="C3" HeaderText="C3" SortExpression="C3" />
                            <asp:BoundField DataField="C4" HeaderText="C4" SortExpression="C4" />
                            <asp:BoundField DataField="C5" HeaderText="C5" SortExpression="C5" />
                            <asp:BoundField DataField="C6" HeaderText="C6" SortExpression="C6" />
                            <asp:BoundField DataField="C7" HeaderText="C7" SortExpression="C7" />
                            <asp:BoundField DataField="C8" HeaderText="C8" SortExpression="C8" />
                            <asp:BoundField DataField="C9" HeaderText="C9" SortExpression="C9" />
                            <asp:BoundField DataField="C10" HeaderText="C10" SortExpression="C10" />
                            <asp:BoundField DataField="C11" HeaderText="C11" SortExpression="C11" />
                            <asp:BoundField DataField="C12" HeaderText="C12" SortExpression="C12" />
                            <asp:BoundField DataField="C13" HeaderText="C13" SortExpression="C13" />
                            <asp:BoundField DataField="C14" HeaderText="C14" SortExpression="C14" />
                            <asp:BoundField DataField="C15" HeaderText="C15" SortExpression="C15" />
                            <asp:BoundField DataField="C16" HeaderText="C16" SortExpression="C16" />
                            <asp:BoundField DataField="C17" HeaderText="C17" SortExpression="C17" />
                            <asp:BoundField DataField="C18" HeaderText="C18" SortExpression="C18" />
                            <asp:BoundField DataField="C19" HeaderText="C19" SortExpression="C19" />
                            <asp:BoundField DataField="C20" HeaderText="C20" SortExpression="C20" />
                            <asp:BoundField DataField="C21" HeaderText="C21" SortExpression="C21" />
                            <asp:BoundField DataField="C22" HeaderText="C22" SortExpression="C22" />
                            <asp:BoundField DataField="C23" HeaderText="C23" SortExpression="C23" />
                            <asp:BoundField DataField="C24" HeaderText="C24" SortExpression="C24" />
                            <asp:BoundField DataField="C25" HeaderText="C25" SortExpression="C25" />
                            <asp:BoundField DataField="C26" HeaderText="C26" SortExpression="C26" />
                            <asp:BoundField DataField="C27" HeaderText="C27" SortExpression="C27" />
                            <asp:BoundField DataField="C28" HeaderText="C28" SortExpression="C28" />
                            <asp:BoundField DataField="C29" HeaderText="C29" SortExpression="C29" />
                            <asp:BoundField DataField="C30" HeaderText="C30" SortExpression="C30" />
                            <asp:BoundField DataField="C31" HeaderText="C31" SortExpression="C31" />
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
