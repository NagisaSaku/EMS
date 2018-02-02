<%@ Page Title="当前位置：系统帮助信息" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="AllErrorHelp.aspx.cs" Inherits="CY.EMS.WebSite.SystemManage.AllErrorHelp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 100%; height: 247px">
        <tr>
            <td style="width: 103px;" rowspan="6">
            </td>
            <td align="center" style="font-weight: bold; font-size: 1.2em; color: black; font-family: 宋体;
                height: 10px; background-color: lightgrey">
                系统帮助信息
            </td>
            <td style="width: 100px;" rowspan="6">
            </td>
        </tr>
        <tr>
            <td style="font-size: 0.8em; font-family: 宋体; background-color: #cccccc; height: 10px;">
                &nbsp;&nbsp; 当显示此页面时，此网站可能已经发生下列问题：
            </td>
        </tr>
        <tr>
            <td style="font-size: 0.8em; width: 442px; background-color: cornsilk;">
                <label id="Label1" runat="server" text="Label" title="1.您未经合法授权访问不该访问的页面。在这种情况下,您只需要与网站管理员联系，取得相关权限后即可访问目标页面。" />
            </td>
        </tr>
        <tr>
            <td style="font-size: 0.8em; width: 442px; background-color: lavender;">
                <label id="Label2" runat="server" text="Label" title="2.数据类型或格式输入发生错误，数据表的关键字重复。在这种情况下，您需要检查您是否试图输入的是一条相同的记录，是否在需要输入数字的地方输入了字符。" />
            </td>
        </tr>
        <tr>
            <td style="font-size: 0.8em; width: 442px; background-color: palegoldenrod">
                <label id="Label3" runat="server" text="Label" title="3.未按照系统所要求的商业逻辑进行操作。在这种情况下，您需要仔细阅读配套图书的说明进行操作。" />
            </td>
        </tr>
        <tr>
            <td style="font-size: 0.8em; width: 442px; height: 33px; background-color: gainsboro">
                <label id="Label4" runat="server" text="Label" title="4.网站出现事先未能预料的错误。在这种情况下，您需要与网站设计人员联系，以便能够及时解决此问题。" />
            </td>
        </tr>
    </table>
</asp:Content>
