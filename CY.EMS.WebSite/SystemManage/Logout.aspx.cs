using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace CYHRMS.SystemManage
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //关闭浏览器窗口
            this.Button1.Attributes.Add("OnClick", "window.close();");
        }
        protected void Button1_Click(object sender, EventArgs e)
        {//确定按钮
            FormsAuthentication.SignOut();
            Session["MyUserName"] = "";
        }
        protected void Button2_Click(object sender, EventArgs e)
        {//取消按钮
            Server.Transfer("~/Default.aspx");
        }
    }
}