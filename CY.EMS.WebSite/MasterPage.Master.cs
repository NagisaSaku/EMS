using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxNavBar;
using CY.EMS.Data;
using System.Data;
using System.Web.Security;

namespace CY.EMS.WebSite
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        public string MasterStr;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 登录状态校验
            if (null == Session["MyUserName"]
                || string.IsNullOrEmpty(Session["MyUserName"].ToString()))
            {
                Response.Write("<script languge='javascript'>alert('连接超时，请重新登录！');</script>");
                Response.Write("<script languge='javascript'>window.location.href='../Login.aspx';</script>");
                return;
            }

            if (!IsPostBack)
            {
                //设置网站页头或页尾的信息
                loadSiteInfo();
                // 加载菜单
                loadMenu();
            }
        }

        private void loadSiteInfo()
        {
            if (Session["MyUserName"] != null)
                this.Label3.Text = "当前登录用户："+Session["MyUserName"].ToString();
            else
                this.Label3.Text = "";

            string MyCompanyName = "";
            if (Session["MyCompanyName"] != null)
                MyCompanyName = Session["MyCompanyName"].ToString();
            string MyCompanyAddress = "";
            if (Session["MyCompanyAddress"] != null)
                MyCompanyAddress = Session["MyCompanyAddress"].ToString();

            string MyCompanyPhone = "";
            if (Session["MyCompanyPhone"] != null)
                MyCompanyPhone = Session["MyCompanyPhone"].ToString();

            string MyCompanyLogo = "";
            if (Session["MyCompanyLogo"] != null)
                MyCompanyLogo = "~/Images/" + Session["MyCompanyLogo"].ToString();

            //this.Image1.ImageUrl = MyCompanyLogo;
            //this.Label1.Text = "版权所有：" + MyCompanyName + " " + MyCompanyAddress + " " + MyCompanyPhone;
        }

        private void loadMenu()
        {
            DaoSysMenu dao = new DaoSysMenu();
            DataTable dt = dao.Get_Menu("-1", Session["MyUserName"].ToString());
            if (null != dt && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    NavBarGroup g = ASPxNavBar1.Groups.Add(row["Name"].ToString(), row["ID"].ToString());
                    g.HeaderImage.IconID = row["IconID"].ToString();
                    loadSubMenu(g, g.Name);
                    g.Expanded = false;
                }
            }
        }

        private void loadSubMenu(NavBarGroup group, string parentID)
        {
            DaoSysMenu dao = new DaoSysMenu();
            DataTable dt = dao.Get_Menu(parentID, Session["MyUserName"].ToString());
            if (null != dt && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    NavBarItem it = group.Items.Add(row["Name"].ToString(), row["ID"].ToString());
                    it.Image.IconID = row["IconID"].ToString();
                    it.NavigateUrl = row["Content"].ToString();
                }
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {//确定按钮
            FormsAuthentication.SignOut();
            Session["MyUserName"] = "";
            Response.Redirect("~/Login.aspx");
            //Server.Transfer("~/Login.aspx");
        }
    }

}