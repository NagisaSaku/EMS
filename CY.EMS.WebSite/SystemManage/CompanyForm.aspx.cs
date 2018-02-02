using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.EMS.Form;

namespace CYHRMS.SystemManage
{
    public partial class CompanyForm : FrmBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //上传图像文件
            string MyFileName = this.FileUpload1.FileName;
            string MyTargetFile = System.IO.Path.Combine(HttpContext.Current.Server.MapPath("~/Images/"), MyFileName);
            this.FileUpload1.PostedFile.SaveAs(MyTargetFile);
        }
    }
}