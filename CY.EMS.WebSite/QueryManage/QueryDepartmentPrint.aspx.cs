using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.Base.DB;
using CY.EMS.Data;
using System.Data;
using CY.EMS.Form;

namespace CYHRMS.QueryManage
{
    public partial class QueryDepartmentPrint : FrmBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            if (!IsCallback && !IsPostBack)
            {
                string deptCode = (Context.Handler as IFrmParams).getParameters().get("DeptCode").ToString();

                //将查询结果输出到Excel文件中
                this.Label1.Text = "部门档案";
                this.Label2.Text = "打印日期：" + DateTime.Now.ToShortDateString();

                IDao dao = DaoFactory.GetDao("DaoBasEmployee");
                dao.Params["DeptCode"] = deptCode;
                DataTable dt = dao.Select();
                if (null != dt)
                {
                    this.DataGrid1.DataSource = dt;
                    this.DataGrid1.DataBind();
                }
                this.Response.ContentType = "application/vnd.ms-excel";
                this.Response.Charset = "";
                //关闭 ViewState
                this.EnableViewState = false;
                System.IO.StringWriter MyWriter;
                System.Web.UI.HtmlTextWriter MyWeb;
                //将信息写入字符串
                MyWriter = new System.IO.StringWriter();
                //在Web窗体页上写出一系列连续的HTML特定字符和文本
                MyWeb = new System.Web.UI.HtmlTextWriter(MyWriter);
                //将DataGrid中的内容输出到HtmlTextWriter对象中
                this.DataGrid1.RenderControl(MyWeb);
                //把HTML写回浏览器
                Response.Write(MyWriter.ToString());
            }
        }
    }
}