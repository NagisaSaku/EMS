using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace CYHRMS.QueryManage
{
    public partial class QueryCheckPrint : System.Web.UI.Page
    {
        private QueryCheckForm MyCheckForm;
        protected void Page_Load(object sender, EventArgs e)
        {//将查询结果输出到Excel文件中
            MyCheckForm = (QueryCheckForm)Context.Handler;
            string MySQL = MyCheckForm.MyPrintSQL;
            this.Label1.Text = MyCheckForm.MyPrintTitle;
            this.Label2.Text = MyCheckForm.MyPrintDate + "    考勤符号说明：出勤[/]、迟到[>]、早退[<]、产假[√]、事假[#]、病假[+]、婚假[△]、旷工[×]";
            string MyConnectionString = ConfigurationManager.ConnectionStrings["MyPersonnelDBConnectionString"].ConnectionString; ;
            SqlDataAdapter MyAdapter = new SqlDataAdapter(MySQL, MyConnectionString);
            DataSet MySet = new DataSet();
            MyAdapter.Fill(MySet);
            this.DataGrid1.DataSource = MySet;
            this.DataGrid1.DataBind();
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