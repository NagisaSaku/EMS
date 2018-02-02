<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PersonnelUC.ascx.cs"
    Inherits="CY.EMS.WebSite.FileManage.PersonnelUC" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridLookup" TagPrefix="dx" %>
<style type="text/css">
    .auto-style2 {
        width: 59px;
    }
    .auto-style3 {
        width: 64px;
    }
    .auto-style4 {
        width: 76px;
    }
    .auto-style5 {
        width: 71px;
    }
</style>
<script type="text/javascript">
    //当文件开始上传
    function Uploader_OnFileUploadStart() {

    }

    //当文件上传结束关闭pcProgress
    function Uploader_OnFileUploadComplete(e) {

    }

    //当所有文件上传完毕后更新UploadButton并隐藏进度条
    function Uploader_OnFilesUploadComplete(e) {
        UpdateUploadButton();
        pageControl.PerformCallback('');

    }

    //将文件添加到文件容器内
    function AddFileToContainer(callbackData) {
        var data = callbackData.split('|');
        var file = data[0];
        var url = data[1];
        var link = document.createElement('A');
        _aspxSetAttribute(link, "target", "_blank");
        _aspxSetAttribute(link, "href", url);
        link.innerHTML = file;
        _aspxSetAttribute(link, "onclick", "return DXDemo.ShowScreenshotWindow(event, this);");
        var fileContainer = _aspxGetElementById("fileContainer");
        fileContainer.appendChild(link);
        fileContainer.appendChild(document.createElement('BR'));
    }

    //上传和更新按钮的函数
    function UpdateUploadButton() {
        btnUpload.SetEnabled(uploader.GetText(0) != "");
    }

    // 删除证件照按钮事件
    function btnDeleteImage_Click(s, e) {
        var it = imageSlider.GetActiveItem();
        if (it != undefined) {
            var imageUrl = it.imageUrl;
            //            imageUrl = encodeURI(imageUrl);
            pageControl.PerformCallback(imageUrl); // 通过PageControl的Callback把图片路径发回Server
        }
    }
</script>
<dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="1" ClientInstanceName="pageControl"
    Height="500px" Width="100%" OnCallback="ASPxPageControl1_Callback">
    <%--OnCallback="ASPxPageControl1_Callback--%>
    <TabPages>
        <dx:TabPage Name="tabDeptInfo" Text="员工基本信息" ActiveTabImage-IconID="page_editpagehf_16x16gray">
            <ActiveTabImage IconID="page_editpagehf_16x16gray">
            </ActiveTabImage>
            <ContentCollection>
                <dx:ContentControl ID="ContentControl1" runat="server">
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lblCode1" runat="server" Text="员工编号：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtCode" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblDeptCode1" runat="server" Text="所属部门：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxComboBox ID="cbbDeptCode" runat="server" ValueType="System.String" ValueField="@Dept"
                                        IncrementalFilteringMode="Contains">
                                    </dx:ASPxComboBox>
                                </td>
                                <td colspan="2" rowspan="5" align="center">
                                    <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" runat="server" Width="120px" OnCallback="ASPxCallbackPanel1_Callback"
                                        ClientInstanceName="CallbackPanel">
                                        <PanelCollection>
                                            <dx:PanelContent ID="PanelContent1" runat="server">
                                                <dx:ASPxHiddenField ID="hidCode" runat="server" />
                                                <dx:ASPxBinaryImage ID="ASPxBinaryImage1" runat="server" Height="150px" Width="99px">
                                                    <EmptyImage AlternateText="选择照片...">
                                                    </EmptyImage>
                                                </dx:ASPxBinaryImage>
                                                <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" Width="99px" ClientInstanceName="UploadControl"
                                                    OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete">
                                                    <ValidationSettings AllowedFileExtensions=".jpeg, .jpg, .gif" MaxFileSize="1048576"
                                                        MaxFileSizeErrorText="文件大小不得超过1MB!">
                                                    </ValidationSettings>
                                                    <ClientSideEvents TextChanged="function(s, e) { UploadControl.UploadFile();}" FileUploadComplete="function(s, e) { if(e.callbackData != undefined) CallbackPanel.PerformCallback(''); else alert(e.callbackData);}" />
                                                    <BrowseButton Text="选择">
                                                    </BrowseButton>
                                                </dx:ASPxUploadControl>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                        <Border BorderColor="#999999" BorderStyle="Dashed" BorderWidth="1px" />
                                    </dx:ASPxCallbackPanel>
                                </td>
                                <%--//上传照片组件模块--%>
                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lblName1" runat="server" Text="姓名：" />
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtName" runat="server" Width="170px" />
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblSex1" runat="server" Text="性别：" />
                                </td>
                                <td>
                                    <dx:ASPxComboBox ID="cbbSexCode" runat="server" ValueType="System.String" ValueField="BAS_SEX" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lblNativePlace1" runat="server" Text="籍贯：" />
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtNativePlace" runat="server" Width="170px" />
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblBirthDay1" runat="server" Text="民族：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxComboBox ID="cbbNationCode" runat="server" ValueType="System.String" ValueField="BAS_NATION">
                                    </dx:ASPxComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lblIDNumber1" runat="server" Text="身份证号码：" />
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtIDNumber" runat="server" Width="170px" />
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblBirthday2" runat="server" Text="出生日期：" />
                                </td>
                                <td>
                                    <dx:ASPxDateEdit ID="datBirthday" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lblPoliticalStatus1" runat="server" Text="政治面貌：" />
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtPoliticalStatus" runat="server" Width="170px" />
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblMaritalStatus1" runat="server" Text="婚姻状况：" />
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtMaritalStatus" runat="server" Width="170px" />
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 36px">
                                    <dx:ASPxLabel ID="lblEducationCode1" runat="server" Text="文化程度：">
                                    </dx:ASPxLabel>
                                </td>
                                <td style="height: 36px">
                                    <dx:ASPxComboBox ID="cbbEducationCode" runat="server" ValueType="System.String" ValueField="BAS_EDU">
                                    </dx:ASPxComboBox>
                                </td>
                                <td style="height: 36px">
                                    <dx:ASPxLabel ID="lblSchool1" runat="server" Text="毕业院校：">
                                    </dx:ASPxLabel>
                                </td>
                                <td style="height: 36px">
                                    <dx:ASPxTextBox ID="txtSchool" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                                <td style="height: 36px">
                                    <dx:ASPxLabel ID="lblMajor1" runat="server" Text="专业：">
                                    </dx:ASPxLabel>
                                </td>
                                <td style="height: 36px">
                                    <dx:ASPxTextBox ID="txtMajor" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr style="height: 36px">
                                <td>
                                    <dx:ASPxLabel ID="lblPhone1" runat="server" Text="联系电话：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtPhone" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblCellphone1" runat="server" Text="手机号码：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtCellphone" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblEMail1" runat="server" Text="电子邮箱：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtEMail" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr style="height: 36px">
                                <td>
                                    <dx:ASPxLabel ID="lblAddress1" runat="server" Text="家庭住址：">
                                    </dx:ASPxLabel>
                                </td>
                                <td colspan="3">
                                    <dx:ASPxTextBox ID="txtAddress" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblZip1" runat="server" Text="邮编：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtZip" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr style="height: 36px">
                                <td>
                                    <dx:ASPxLabel ID="lblMemo1" runat="server" Text="补充说明：">
                                    </dx:ASPxLabel>
                                </td>
                                <td colspan="3">
                                    <dx:ASPxTextBox ID="txtMemo" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
        <%--第二个Page页<员工公司信息>--%>
        <dx:TabPage Name="tabEmployee" Text="员工公司信息" ActiveTabImage-IconID="page_editpagehf_16x16gray">
            <ActiveTabImage IconID="page_editpagehf_16x16gray">
            </ActiveTabImage>
            <ContentCollection>
                <dx:ContentControl ID="ContentControl2" runat="server">
                    <div style="height: 215px">
                        <table style="height: 118px; width: 722px;">
                            <tr style="height: 36px">
                                <td class="auto-style4">
                                    <dx:ASPxLabel ID="lblJobTitle1" runat="server" Text="职称：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtJobTitle" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="auto-style3">
                                    <dx:ASPxLabel ID="lblJob1" runat="server" Text="工作岗位：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtJob" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="auto-style5">
                                    <dx:ASPxLabel ID="lblJoblevel1" runat="server" Text="岗位级别：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtJobLevel" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr style="height: 36px">
                                <td class="auto-style4">
                                    <dx:ASPxLabel ID="lblConTypName1" runat="server" Text="合同种类：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtConTypName" runat="server" Width="170px" ReadOnly="True">
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="auto-style3">
                                    <dx:ASPxLabel ID="lblConLenName1" runat="server" Text="合同年限：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtConLenName" runat="server" Width="170px" ReadOnly="True">
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="auto-style5">
                                    <dx:ASPxLabel ID="lblConStatusName1" runat="server" Text="合同状态：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtConStatusName" runat="server" Width="170px" ReadOnly="True">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr style="height: 36px">
                                <td class="auto-style4">
                                    <dx:ASPxLabel ID="lblBeginDate1" runat="server" Text="入职日期：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxDateEdit ID="datBeginDate" runat="server">
                                    </dx:ASPxDateEdit>
                                </td>
                                <td class="auto-style3">
                                    <dx:ASPxLabel ID="lblTurnDate1" runat="server" Text="转正日期：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxDateEdit ID="datTurnDate" runat="server">
                                    </dx:ASPxDateEdit>
                                </td>
                                <td class="auto-style5">
                                    <dx:ASPxLabel ID="lblConCode1" runat="server" Text="合同编码：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtConCode" runat="server" Width="170px" ReadOnly="True">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr style="height: 36px">
                                <td class="auto-style4">
                                    <dx:ASPxLabel ID="lblBankAccount1" runat="server" Text="银行帐号：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtBankAccount" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="auto-style3">
                                    <dx:ASPxLabel ID="lblPersionInsurance1" runat="server" Text="社保帐号：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtPersionInsurance" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="auto-style5">
                                    <dx:ASPxLabel ID="lblHousingFund1" runat="server" Text="住房公积金帐号：">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtHousingFund" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                              
                        </table>
                    </div>
                </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
        <%--第三个Page页<员工照片展示>--%>
        <dx:TabPage Name="tabEmployeeImages" Text="员工照片相关证件展示" ActiveTabImage-IconID="page_editpagehf_16x16gray">
            <ActiveTabImage IconID="page_editpagehf_16x16gray">
            </ActiveTabImage>
            <ContentCollection>
                <dx:ContentControl ID="ContentControl3" runat="server">
                    <%--一个照片的陈列ImageSlider--%>
                    <dx:ASPxImageSlider ID="imageSlider" runat="server" ClientInstanceName="imageSlider">
                        <SettingsAutoGeneratedImages ImageHeight="440px"></SettingsAutoGeneratedImages>
                    </dx:ASPxImageSlider>
                    <%--上传控制控件UpLoadControl--%>
                    <%-- 删除Button--%>
                    <dx:ASPxButton ID="btnDeleteImage" runat="server" Text="选中图片进行删除" AutoPostBack="False">
                        <ClientSideEvents Click="function(s, e) {btnDeleteImage_Click(s,e);}" />
                    </dx:ASPxButton>
                    &nbsp;<div>
                        <dx:ASPxLabel ID="lblSelectMultipleFiles" runat="server" Text="选择一个或多个图片文件上传:">
                        </dx:ASPxLabel>
                    </div>
                    <table>
                        <tr>
                            <td>
                                <dx:ASPxUploadControl ID="ASPxUploadControl2" runat="server" ClientInstanceName="uploader"
                                    Width="550px" NullText="请点击这里浏览文件夹...." UploadMode="Advanced" OnFileUploadComplete="UploadControl_FileUploadComplete"
                                    ShowProgressPanel="True">
                                    <BrowseButton Text="浏览...">
                                    </BrowseButton>
                                    <AdvancedModeSettings EnableMultiSelect="True" />
                                    <%-- 主要采用这三个函数 FileUploadStart、FileUploadComplete、UploadingProgressChanged--%>
                                    <ClientSideEvents FileUploadStart="function(s, e) { Uploader_OnFileUploadStart(); }"
                                        FileUploadComplete="function(s, e) { Uploader_OnFileUploadComplete(e); }" FilesUploadComplete="function(s, e) { Uploader_OnFilesUploadComplete(e); }"
                                        TextChanged="function(s, e) { UpdateUploadButton(); }" />
                                    <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg,.jpeg,.jpe,.gif,.png">
                                    </ValidationSettings>
                                </dx:ASPxUploadControl>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnUpload" runat="server" AutoPostBack="False" Text="上传" ClientInstanceName="btnUpload"
                                    CssClass="AlignCenter" Width="100px" ClientEnabled="False">
                                    <ClientSideEvents Click="function(s, e) { uploader.Upload(); }" />
                                </dx:ASPxButton>
                            </td>
                            <%--只需要上传到指定的文件路径即可--%>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="温馨提示：需在保存员工资料完毕后方可上传员工照片">
                                </dx:ASPxLabel>
                            </td>
                        </tr>
                    </table>
                </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
    </TabPages>
</dx:ASPxPageControl>
