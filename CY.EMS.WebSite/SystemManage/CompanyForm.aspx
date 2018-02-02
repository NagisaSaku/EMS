<%@ Page Title="当前位置：公司信息设置" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="CompanyForm.aspx.cs" Inherits="CY.EMS.WebSite.SystemManage.CompanyForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            <td colspan="1" style="font-size: 0.8em; width: 76px; font-family: 宋体;" rowspan="3">
            </td>
            <td colspan="3" style="font-size: 0.8em; font-family: 宋体; height: 21px; width: 412px;">
                <asp:Label ID="Label1" runat="server" Text="请输入公司名称："></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" Width="161px">公司</asp:TextBox>
                <asp:Button ID="Button1" runat="server" Text="查询公司信息" Width="122px" />
            </td>
            <td colspan="1" style="font-size: 0.8em; width: 50px; font-family: 宋体;" rowspan="2">
            </td>
        </tr>
        <tr>
            <td colspan="3" style="width: 412px; height: 202px;">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CYHRMS %>"
                    DeleteCommand="DELETE FROM [公司信息] WHERE [公司名称] = @公司名称" InsertCommand="INSERT INTO [公司信息] ([公司名称], [法人代表], [公司地址], [邮政编码], [服务电话], [电子信箱], [公司网站], [首页图像], [标志图标], [系统名称], [优先级]) VALUES (@公司名称, @法人代表, @公司地址, @邮政编码, @服务电话, @电子信箱, @公司网站, @首页图像, @标志图标, @系统名称, @优先级)"
                    SelectCommand="EXEC P_Sys_Get_CmpInf 1" UpdateCommand="UPDATE [公司信息] SET [法人代表] = @法人代表, [公司地址] = @公司地址, [邮政编码] = @邮政编码, [服务电话] = @服务电话, [电子信箱] = @电子信箱, [公司网站] = @公司网站, [首页图像] = @首页图像, [标志图标] = @标志图标, [系统名称] = @系统名称, [优先级] = @优先级 WHERE [公司名称] = @公司名称">
                    <DeleteParameters>
                        <asp:Parameter Name="公司名称" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="法人代表" Type="String" />
                        <asp:Parameter Name="公司地址" Type="String" />
                        <asp:Parameter Name="邮政编码" Type="String" />
                        <asp:Parameter Name="服务电话" Type="String" />
                        <asp:Parameter Name="电子信箱" Type="String" />
                        <asp:Parameter Name="公司网站" Type="String" />
                        <asp:Parameter Name="首页图像" Type="String" />
                        <asp:Parameter Name="标志图标" Type="String" />
                        <asp:Parameter Name="系统名称" Type="String" />
                        <asp:Parameter Name="优先级" Type="Int32" />
                        <asp:Parameter Name="公司名称" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="TextBox1" Name="公司名称" PropertyName="Text" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="公司名称" Type="String" />
                        <asp:Parameter Name="法人代表" Type="String" />
                        <asp:Parameter Name="公司地址" Type="String" />
                        <asp:Parameter Name="邮政编码" Type="String" />
                        <asp:Parameter Name="服务电话" Type="String" />
                        <asp:Parameter Name="电子信箱" Type="String" />
                        <asp:Parameter Name="公司网站" Type="String" />
                        <asp:Parameter Name="首页图像" Type="String" />
                        <asp:Parameter Name="标志图标" Type="String" />
                        <asp:Parameter Name="系统名称" Type="String" />
                        <asp:Parameter Name="优先级" Type="Int32" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" AutoGenerateRows="False"
                    BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px"
                    CellPadding="3" DataKeyNames="Name" DataSourceID="SqlDataSource1" Font-Names="宋体"
                    Font-Size="Small" GridLines="Vertical" Height="50px" Width="408px">
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <EditRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <Fields>
                        <asp:BoundField DataField="Name" HeaderText="公司名称" ReadOnly="True" SortExpression="Name" />
                        <asp:BoundField DataField="LegalPerson" HeaderText="法人代表" SortExpression="LegalPerson" />
                        <asp:BoundField DataField="Address" HeaderText="公司地址" SortExpression="Address" />
                        <asp:BoundField DataField="Zip" HeaderText="邮政编码" SortExpression="Zip" />
                        <asp:BoundField DataField="Phone" HeaderText="服务电话" SortExpression="Phone" />
                        <asp:BoundField DataField="EMail" HeaderText="电子信箱" SortExpression="EMail" />
                        <asp:BoundField DataField="WebSite" HeaderText="公司网站" SortExpression="WebSite" />
                        <asp:BoundField DataField="Image" HeaderText="首页图像" SortExpression="Image" />
                        <asp:BoundField DataField="Logo" HeaderText="标志图标" SortExpression="Logo" />
                        <asp:BoundField DataField="SysName" HeaderText="系统名称" SortExpression="SysName" />
                        <asp:BoundField DataField="ShowSequence" HeaderText="优先级" SortExpression="ShowSequence" />
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                    </Fields>
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="Gainsboro" />
                </asp:DetailsView>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="width: 412px; height: 17px;">
                <asp:FileUpload ID="FileUpload1" runat="server" Width="275px" />&nbsp;<asp:Button
                    ID="btnUpload" runat="server" Text="上传图像文件" Width="127px" OnClick="btnUpload_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
