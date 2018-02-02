<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="MonthCheckForm.aspx.cs" Inherits="CYHRMS.CheckManage.MonthCheckForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 556px; height: 161px">
        <tr>
            <td align="left" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 16px;
                background-color: teal">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MyPersonnelDBConnectionString %>"
                    SelectCommand="SELECT * FROM [公司部门]"></asp:SqlDataSource>
                考勤年份：<asp:DropDownList ID="DropDownList2" runat="server">
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
                考勤月份：<asp:DropDownList ID="DropDownList3" runat="server">
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
                考勤部门:<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                    DataTextField="部门名称" DataValueField="部门名称" Width="80px">
                </asp:DropDownList>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="查询" Width="80px" />
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="打印" Width="80px" />
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
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MyPersonnelDBConnectionString %>"
                        SelectCommand="SELECT * FROM [考勤记录] WHERE (([考勤年份] = @考勤年份) AND ([考勤月份] = @考勤月份)  AND (员工编号 IN (SELECT 员工编号 FROM 在职员工视图 WHERE (所属部门 LIKE @所属部门))))"
                        UpdateCommand="UPDATE [考勤记录] SET [C1] = @C1, [C2] = @C2, [C3] = @C3, [C4] = @C4, [C5] = @C5, [C6] = @C6, [C7] = @C7, [C8] = @C8, [C9] = @C9, [C10] = @C10, [C11] = @C11, [C12] = @C12, [C13] = @C13, [C14] = @C14, [C15] = @C15, [C16] = @C16, [C17] = @C17, [C18] = @C18, [C19] = @C19, [C20] = @C20, [C21] = @C21, [C22] = @C22, [C23] = @C23, [C24] = @C24, [C25] = @C25, [C26] = @C26, [C27] = @C27, [C28] = @C28, [C29] = @C29, [C30] = @C30, [C31] = @C31 WHERE [自编号] = @自编号">
                        <DeleteParameters>
                            <asp:Parameter Name="自编号" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="C1" Type="String" />
                            <asp:Parameter Name="C2" Type="String" />
                            <asp:Parameter Name="C3" Type="String" />
                            <asp:Parameter Name="C4" Type="String" />
                            <asp:Parameter Name="C5" Type="String" />
                            <asp:Parameter Name="C6" Type="String" />
                            <asp:Parameter Name="C7" Type="String" />
                            <asp:Parameter Name="C8" Type="String" />
                            <asp:Parameter Name="C9" Type="String" />
                            <asp:Parameter Name="C10" Type="String" />
                            <asp:Parameter Name="C11" Type="String" />
                            <asp:Parameter Name="C12" Type="String" />
                            <asp:Parameter Name="C13" Type="String" />
                            <asp:Parameter Name="C14" Type="String" />
                            <asp:Parameter Name="C15" Type="String" />
                            <asp:Parameter Name="C16" Type="String" />
                            <asp:Parameter Name="C17" Type="String" />
                            <asp:Parameter Name="C18" Type="String" />
                            <asp:Parameter Name="C19" Type="String" />
                            <asp:Parameter Name="C20" Type="String" />
                            <asp:Parameter Name="C21" Type="String" />
                            <asp:Parameter Name="C22" Type="String" />
                            <asp:Parameter Name="C23" Type="String" />
                            <asp:Parameter Name="C24" Type="String" />
                            <asp:Parameter Name="C25" Type="String" />
                            <asp:Parameter Name="C26" Type="String" />
                            <asp:Parameter Name="C27" Type="String" />
                            <asp:Parameter Name="C28" Type="String" />
                            <asp:Parameter Name="C29" Type="String" />
                            <asp:Parameter Name="C30" Type="String" />
                            <asp:Parameter Name="C31" Type="String" />
                            <asp:Parameter Name="自编号" Type="Int32" />
                        </UpdateParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList2" Name="考勤年份" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList3" Name="考勤月份" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList1" Name="所属部门" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="自编号"
                        DataSourceID="SqlDataSource2" Font-Names="宋体" Font-Size="Small" Width="1600px">
                        <Columns>
                            <asp:CommandField ShowEditButton="True" ButtonType="Button" HeaderText="编辑" />
                            <asp:BoundField DataField="自编号" HeaderText="自编号" InsertVisible="False" ReadOnly="True"
                                SortExpression="自编号" Visible="False" />
                            <asp:BoundField DataField="员工编号" HeaderText="员工编号" SortExpression="员工编号" Visible="False" />
                            <asp:BoundField DataField="员工姓名" HeaderText="员工姓名" ReadOnly="True" SortExpression="员工姓名" />
                            <asp:TemplateField HeaderText="C1" SortExpression="C1">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList4" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource2"
                                        DataTextField="C1" DataValueField="C1" SelectedValue='<%# Bind("C1") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("C1") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C2" SortExpression="C2">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList5" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource2"
                                        DataTextField="C2" DataValueField="C2" SelectedValue='<%# Bind("C2") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C2") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C3" SortExpression="C3">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList6" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource2"
                                        DataTextField="C3" DataValueField="C3" SelectedValue='<%# Bind("C3") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C3") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C4" SortExpression="C4">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList7" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource2"
                                        DataTextField="C4" DataValueField="C4" SelectedValue='<%# Bind("C4") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C4") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C5" SortExpression="C5">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList8" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource2"
                                        DataTextField="C5" DataValueField="C5" SelectedValue='<%# Bind("C5") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C5") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C6" SortExpression="C6">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList9" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource2"
                                        DataTextField="C6" DataValueField="C6" SelectedValue='<%# Bind("C6") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C6") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C7" SortExpression="C7">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList10" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C7" DataValueField="C7" SelectedValue='<%# Bind("C7") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C7") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C8" SortExpression="C8">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList11" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C8" DataValueField="C8" SelectedValue='<%# Bind("C8") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C8") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C9" SortExpression="C9">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList12" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C9" DataValueField="C9" SelectedValue='<%# Bind("C9") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C9") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C10" SortExpression="C10">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList13" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C10" DataValueField="C10" SelectedValue='<%# Bind("C10") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C10") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C11" SortExpression="C11">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList14" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C11" DataValueField="C11" SelectedValue='<%# Bind("C11") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C11") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C12" SortExpression="C12">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList15" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C12" DataValueField="C12" SelectedValue='<%# Bind("C12") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C12") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C13" SortExpression="C13">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList16" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C13" DataValueField="C13" SelectedValue='<%# Bind("C13") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C13") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C14" SortExpression="C14">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList17" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C14" DataValueField="C14" SelectedValue='<%# Bind("C14") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C14") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C15" SortExpression="C15">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList18" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C15" DataValueField="C15" SelectedValue='<%# Bind("C15") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C15") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C16" SortExpression="C16">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList19" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C16" DataValueField="C16" SelectedValue='<%# Bind("C16") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C16") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C17" SortExpression="C17">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList20" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C17" DataValueField="C17" SelectedValue='<%# Bind("C17") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C17") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C18" SortExpression="C18">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList21" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C18" DataValueField="C18" SelectedValue='<%# Bind("C18") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C18") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C19" SortExpression="C19">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList22" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C19" DataValueField="C19" SelectedValue='<%# Bind("C19") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C19") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C20" SortExpression="C20">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList23" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C20" DataValueField="C20" SelectedValue='<%# Bind("C20") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C20") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C21" SortExpression="C21">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList24" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C21" DataValueField="C21" SelectedValue='<%# Bind("C21") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C21") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C22" SortExpression="C22">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList25" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C22" DataValueField="C22" SelectedValue='<%# Bind("C22") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C22") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C23" SortExpression="C23">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList26" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C23" DataValueField="C23" SelectedValue='<%# Bind("C23") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C23") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C24" SortExpression="C24">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList27" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C24" DataValueField="C24" SelectedValue='<%# Bind("C24") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C24") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C25" SortExpression="C25">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList28" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C25" DataValueField="C25" SelectedValue='<%# Bind("C25") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C25") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C26" SortExpression="C26">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList29" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C26" DataValueField="C26" SelectedValue='<%# Bind("C26") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C26") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C27" SortExpression="C27">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList30" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C27" DataValueField="C27" SelectedValue='<%# Bind("C27") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C27") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C28" SortExpression="C28">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList31" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C28" DataValueField="C28" SelectedValue='<%# Bind("C28") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C28") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C29" SortExpression="C29">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList32" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C29" DataValueField="C29" SelectedValue='<%# Bind("C29") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C29") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C30" SortExpression="C30">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList33" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C30" DataValueField="C30" SelectedValue='<%# Bind("C30") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C30") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="C31" SortExpression="C31">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList34" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource2" DataTextField="C31" DataValueField="C31" SelectedValue='<%# Bind("C31") %>'>
                                        <asp:ListItem Selected="True">/</asp:ListItem>
                                        <asp:ListItem>&gt;</asp:ListItem>
                                        <asp:ListItem>&lt;</asp:ListItem>
                                        <asp:ListItem>√</asp:ListItem>
                                        <asp:ListItem>#</asp:ListItem>
                                        <asp:ListItem>+</asp:ListItem>
                                        <asp:ListItem>△</asp:ListItem>
                                        <asp:ListItem>&#215;</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("C31") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="考勤年份" HeaderText="考勤年份" ReadOnly="True" SortExpression="考勤年份" />
                            <asp:BoundField DataField="考勤月份" HeaderText="考勤月份" ReadOnly="True" SortExpression="考勤月份" />
                        </Columns>
                        <HeaderStyle HorizontalAlign="Center" />
                    </asp:GridView>
                    &nbsp;</asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
