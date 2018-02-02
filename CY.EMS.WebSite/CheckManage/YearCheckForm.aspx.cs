using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CYHRMS.CheckManage
{
    public partial class YearCheckForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string myForbidString = Session["MyForbid"].ToString();
            if (myForbidString.IndexOf("B2") > 1)
            {
                Server.Transfer("~/SystemManage/AllErrorHelp.aspx");
            }
        }
        protected void Button2_Click(object sender, EventArgs e)
        {//打印年度个人考勤信息
            Server.Transfer("~/CheckManage/YearCheckPrint.aspx");
        }
        public string MyPrintSQL
        {//设置要传递到打印页的数据
            get
            {
                return "SELECT * FROM 考勤记录  WHERE (([员工编号] ='" + this.DropDownList2.SelectedValue.ToString() + "' ) AND ([考勤年份] = '" + this.DropDownList3.SelectedValue.ToString() + "'))";
            }
        }
        public String MyPrintDate
        {//设置要传递到打印页的数据
            get
            {
                return "考勤日期：" + this.DropDownList3.SelectedValue.ToString() + "年" + "  部门：" + this.DropDownList1.SelectedValue.ToString() + " 姓名：" + this.DropDownList2.SelectedItem.Text.ToString();
            }
        }
        public String MyPrintTitle
        {//设置要传递到打印页的数据
            get
            {
                return Session["MyCompanyName"].ToString() + "年度个人考勤表";
            }
        }
    }
}