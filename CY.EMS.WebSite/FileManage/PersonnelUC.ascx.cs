using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using CY.Base.DB;
using CY.EMS.Data;
using DevExpress.Web.ASPxUploadControl;
using CY.EMS.Form;

namespace CY.EMS.WebSite.FileManage
{
    public partial class PersonnelUC : System.Web.UI.UserControl
    {
        public bool IsAdd()
        {
            return !hidCode.Contains("Code");
        }

        // 加载页面
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                FrmUtil.FillCodes(this);
        }

        // 按员工编号，加载员工信息和员工照片
        public void loadEmployee(string code)
        {
            ASPxPageControl1.ActiveTabIndex = 0;
            if (string.IsNullOrEmpty(code))
            {
                if (hidCode.Contains("Code"))
                    hidCode.Remove("Code");
                FrmUtil.ClearData(this);
                onEdit(false);
            }
            else
            {
                IDao dao = DaoFactory.GetDao("DaoBasEmployee");
                DataTable dt = dao.SelectByPK(code);
                if (null != dt && dt.Rows.Count > 0)
                {
                    hidCode["Code"] = code;
                    FrmUtil.CreateDirectory("~\\Images\\UpLoadImages", code);//创建员工照片文件夹
                    FrmUtil.FillData(dt, this); // 加载业务数据
                    FrmUtil.GetImage("Employee", code, ASPxBinaryImage1); // 加载员工照片
                    loadImageSlider(code);//加载ImageSlider图片，逐个加载
                    onEdit(true);
                }
                else
                {
                    if (hidCode.Contains("Code"))
                        hidCode.Remove("Code");
                    FrmUtil.ClearData(this);
                    onEdit(false);
                }
            }
        }

        public void loadImageSlider(string code)
        {
            imageSlider.ImageSourceFolder = @"~\\Images\\UpLoadImages\\" + @code;
        }

        /// <summary>update时，设置部分控件无法编辑</summary>
        private void onEdit(bool edit)
        {
            txtCode.ReadOnly = edit;
        }

        /// <summary>保存员工大头照</summary>
        protected void ASPxUploadControl1_FileUploadComplete(object sender, DevExpress.Web.ASPxUploadControl.FileUploadCompleteEventArgs e)
        {
            if (!hidCode.Contains("Code"))
                e.CallbackData = "操作失败：先保存员工档案！";
            else if (e.IsValid)
            {
                int rtn = 0;
                string msg = "";
                // 保存照片
                if (ASPxUploadControl1.UploadedFiles.Length > 0)
                {
                    IDao cdao = DaoFactory.GetDao("DaoBizFile");
                    cdao.Params["Type"] = "Employee";
                    cdao.Params["Code"] = hidCode["Code"];
                    cdao.Params["File"] = ASPxUploadControl1.UploadedFiles[0].FileBytes;
                    cdao.Params["Oper"] = Session["MyUserName"];
                    rtn = cdao.Insert(out msg);
                }
                if (rtn != 0)
                {
                    Response.Write("<script>alert('操作失败：" + msg + "！');</script>");
                    e.CallbackData = "false";
                    return;
                }

                e.CallbackData = "true";
            }
        }

        /// <summary>保存员工证件照</summary>
        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            if (!hidCode.Contains("Code"))
                e.CallbackData = "操作失败：先保存员工档案！";
            else if (e.IsValid)
            {
                string[] arr = e.UploadedFile.FileName.Split('.');
                string Suffix = arr[arr.Length - 1];//获取文件的后缀
                string UploadDirectory = "~\\Images" + "\\" + "UpLoadImages" + "\\" + hidCode["Code"] + "\\";
                string resultFilePath = UploadDirectory + "IMG" + Guid.NewGuid().ToString() + "." + Suffix; //设定文件的上传路径
                e.UploadedFile.SaveAs(MapPath(resultFilePath));
                //按照设定的文件上传路径上传文件

                //UploadingUtils.RemoveFileWithDelay(e.UploadedFile.FileName, MapPath(resultFilePath), 5);

                string file = string.Format("{0} ({1}KB)", e.UploadedFile.FileName, e.UploadedFile.ContentLength / 1024);
                string url = ResolveClientUrl(resultFilePath);
                e.CallbackData = file + "|" + url;
            }
        }

        /// <summary>使用CallBackPanel来刷新员工大头照</summary>
        protected void ASPxCallbackPanel1_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            if (hidCode.Contains("Code"))
                FrmUtil.GetImage("Employee", hidCode["Code"].ToString(), ASPxBinaryImage1);
        }

        /// <summary>使用PageControl的Callback来刷新员工证件照</summary>
        protected void ASPxPageControl1_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            if (!string.IsNullOrEmpty(e.Parameter))
                System.IO.File.Delete(MapPath(e.Parameter)); // 如果Parameter不为空，则是删除当前选中的照片

            imageSlider.ImageSourceFolder = "~\\Images" + "\\" + "UpLoadImages" + "\\" + hidCode["Code"];
        }
    }
}