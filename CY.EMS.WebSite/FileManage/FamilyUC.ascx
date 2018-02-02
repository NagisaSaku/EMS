<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FamilyUC.ascx.cs" Inherits="CY.EMS.WebSite.FileManage.FamilyUC" %>
<table id="Table2" runat="server" align="center">
    <tr>
        <td align="left" style="font-size: 0.8em; width: 2232px; font-family: 宋体; height: 16px;
            background-color: white">
            <table>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="lblID_1" runat="server" Text="自编号：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtID" runat="server" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                    <td>
                        <dx:ASPxHiddenField ID="hidID" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="lblCode_1" runat="server" Text="员工编号：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxComboBox ID="cbbEmpCode" runat="server" ValueType="System.String" ValueField="@Employee">
                        </dx:ASPxComboBox>
                    </td>
                    <td>
                        <dx:ASPxLabel ID="lblFamName_1" runat="server" Text="家庭成员姓名：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtFamName" runat="server" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="lblRelationShipCode_1" runat="server" Text="与员工关系：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxComboBox ID="cbbRelationShipCode" runat="server" ValueType="System.String"
                            ValueField="BAS_Relation">
                        </dx:ASPxComboBox>
                    </td>
                    <td>
                        <dx:ASPxLabel ID="lblCompany_1" runat="server" Text="工作单位：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtCompany" runat="server" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="lblJob_1" runat="server" Text="担任职务：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtJob" runat="server" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                    <td>
                        <dx:ASPxLabel ID="lblPoliticalStatus_1" runat="server" Text="政治面貌：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtPoliticalStatus" runat="server" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="lblPhone_1" runat="server" Text="联系电话：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtPhone" runat="server" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                    <td>
                        <dx:ASPxLabel ID="lblMemo_1" runat="server" Text="补充说明：">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxTextBox ID="txtMemo" runat="server" Width="170px">
                        </dx:ASPxTextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
