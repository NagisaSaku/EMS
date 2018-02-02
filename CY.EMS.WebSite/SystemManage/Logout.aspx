<%@ Page Title="当前位置：退出系统" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="Logout.aspx.cs" Inherits="CY.EMS.WebSite.SystemManage.Logout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="font-size: 0.8em; width: 557px; font-family: 宋体; height: 51px; position: static;">
        <tr>
            <td colspan="4" rowspan="1" style="height: 37px">
            </td>
        </tr>
        <tr>
            <td rowspan="3" style="width: 140px">
            </td>
            <td align="center" colspan="2" style="font-weight: bold; color: white; background-color: darkblue">
                退出人事工资管理信息系统
            </td>
            <td rowspan="3" style="width: 100px">
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2" style="background-color: gainsboro">
                是否现在立即退出人事工资管理信息系统？
            </td>
        </tr>
        <tr>
            <td align="center" style="background-color: aliceblue" colspan="2">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="确定" Width="90px" />
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="取消" Width="90px" />
            </td>
        </tr>
        <tr>
            <td colspan="4" rowspan="5" style="height: 39px">
            </td>
        </tr>
    </table>
</asp:Content>
