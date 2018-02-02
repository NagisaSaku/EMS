using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.Base.DB;
using System.Data;
using CY.EMS.Form;
using CY.EMS.Data;
using CY.EMS.Data.Entity;
/// <summary>
/// 说明：LoginForm
/// 作者：
/// 日期：
/// </summary>
/// 2015-7-20 冯缨：添加密码加密

namespace CYHRMS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.Handler is IFrmParams)
            {
                FrmParams p = (Context.Handler as IFrmParams).getParameters();
                if (p.contains("Message"))
                    Response.Write("<script>alert('" + p.get("Message").ToString() + "');</script>");
            }
        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            string userName = Request.Form["txtUserName"];
            string password = Request.Form["txtPassword"];
            if (string.IsNullOrEmpty(userName))
            {
                Response.Write("<script>alert('必须输入用户名！');</script>");
                return;
            }
            if (string.IsNullOrEmpty(password))
            {
                Response.Write("<script>alert('必须输入密码！');</script>");
                return;
            }

            // 密码MD5加密
            password = FrmUtil.CalculateMD5Hash(password);

            using (var context = ContextFactory.CreateContext<User>())
            {
                var user = context.Set<User>()
                    .FirstOrDefault(u => u.UserName == userName && u.Password == password);
                if (user != null)
                {
                    Session["MyUserName"] = userName;
                    Response.Redirect("~/Default.aspx");
                }
                else
                {
                    Response.Write("<script>alert('用户名或密码错误！');</script>");
                }
            }
        }
    }
}