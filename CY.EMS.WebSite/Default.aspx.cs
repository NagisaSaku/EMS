using System;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using DevExpress.Web.ASPxImageSlider;
using CY.Base.DB;
using CY.EMS.Data;
using CY.EMS.Form;

namespace CYHRMS
{
    public partial class Default : FrmBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            if (!IsCallback && !IsPostBack)
            {
                //Guid.NewGuid().ToString();
                //ASPxImageSlider1.ImageSourceFolder = "~/Images";
                // 清除图片集合
                //ASPxImageSlider1.Items.Clear();
                // 添加图片
                //ASPxImageSlider1.Items.Add(new ImageSliderItem("~/Images/from.gif"));
                //ASPxImageSlider1.Items.Add(new ImageSliderItem("~/Images/logo.JPG"));

                object user = Session["MyUserName"];
                if (null == user || string.IsNullOrEmpty(user.ToString()))
                    Response.Redirect("~/Login.aspx");

                if (!IsPostBack)
                {
                    this.Page.Title = "当前位置：系统首页";

                    IDao dao = DaoFactory.GetDao("DaoSysCmpInf");
                    dao.Params["Sequence"] = 1;
                    DataTable MyTable = dao.Select();

                    if (MyTable.Rows.Count > 0)
                    {
                        //if (!string.IsNullOrEmpty(MyTable.Rows[0]["Image"].ToString()))
                        //    this.Image1.ImageUrl = "~/Images/" + MyTable.Rows[0]["Image"].ToString();
                        Session["MySystemName"] = MyTable.Rows[0]["SysName"].ToString();
                        Session["MyCompanyWebSite"] = MyTable.Rows[0]["WebSite"].ToString().ToString();
                        Session["MyCompanyName"] = MyTable.Rows[0]["Name"].ToString();
                        Session["MyCompanyAddress"] = MyTable.Rows[0]["Address"].ToString();
                        Session["MyCompanyPhone"] = MyTable.Rows[0]["Phone"].ToString();
                        Session["MyCompanyLogo"] = MyTable.Rows[0]["Logo"].ToString();
                    }
                }
            }
        }
    }
}