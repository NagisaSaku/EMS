<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QueryCheckPrint.aspx.cs"
    Inherits="CY.EMS.WebSite.QueryManage.QueryCheckPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>打印公司月度考勤信息</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div>
            <div>
                <div>
                    <table style="width: 570px; height: 58px">
                        <tr>
                            <td align="center" style="font-weight: bold; font-size: 2.4em; width: 104px; font-family: 宋体">
                                <asp:Label ID="Label1" runat="server" Font-Names="宋体" Font-Size="Large" Text="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="font-size: 0.8em; width: 104px; font-family: 宋体">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="font-size: 1em; width: 104px; font-family: 宋体">
                                <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="font-size: 0.8em; width: 104px; font-family: 宋体; height: 21px">
                                <asp:DataGrid ID="DataGrid1" runat="server" Font-Names="宋体" Font-Size="Small" Width="561px">
                                    <HeaderStyle Font-Names="宋体" Font-Size="Small" HorizontalAlign="Center" />
                                </asp:DataGrid>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" style="width: 104px">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
