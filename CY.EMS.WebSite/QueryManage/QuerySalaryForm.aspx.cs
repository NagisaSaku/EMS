using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CYHRMS.QueryManage
{
    public partial class QuerySalaryForm : System.Web.UI.Page
    {
        private static string MySQL = "";
        private static string MyTitle = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string myForbidString = Session["MyForbid"].ToString();
            if (myForbidString.IndexOf("D4") > 1)
            {
                Server.Transfer("~/SystemManage/AllErrorHelp.aspx");
            }
        }
        protected void Button3_Click(object sender, EventArgs e)
        {//打印银行入账单
            MyTitle = Session["MyCompanyName"].ToString() + "月度工资银行入账单";
            MySQL = "SELECT [员工姓名], [银行账号],[实发金额] FROM [工资发放表] WHERE (([发放年份] ='" + this.DropDownList1.SelectedValue.ToString() + "') AND ([发放月份] = '" + this.DropDownList2.SelectedValue.ToString() + "'))";
            Server.Transfer("~/QueryManage/QuerySalaryPrint.aspx");
        }
        protected void Button4_Click(object sender, EventArgs e)
        {//打印养老险入账单
            MyTitle = Session["MyCompanyName"].ToString() + "月度养老保险入账单";
            MySQL = "SELECT [员工姓名], [养老保险账号],[养老险] FROM [工资发放表] WHERE (([发放年份] ='" + this.DropDownList1.SelectedValue.ToString() + "') AND ([发放月份] = '" + this.DropDownList2.SelectedValue.ToString() + "'))";
            Server.Transfer("~/QueryManage/QuerySalaryPrint.aspx");
        }
        protected void Button5_Click(object sender, EventArgs e)
        {//打印医疗险入账单
            MyTitle = Session["MyCompanyName"].ToString() + "月度医疗保险入账单";
            MySQL = "SELECT [员工姓名], [医疗保险账号],[医疗险] FROM [工资发放表] WHERE (([发放年份] ='" + this.DropDownList1.SelectedValue.ToString() + "') AND ([发放月份] = '" + this.DropDownList2.SelectedValue.ToString() + "'))";
            Server.Transfer("~/QueryManage/QuerySalaryPrint.aspx");
        }
        protected void Button6_Click(object sender, EventArgs e)
        {//打印住房基金入账单
            MyTitle = Session["MyCompanyName"].ToString() + "月度住房基金入账单";
            MySQL = "SELECT [员工姓名], [住房基金账号],[住房基金] FROM [工资发放表] WHERE (([发放年份] ='" + this.DropDownList1.SelectedValue.ToString() + "') AND ([发放月份] = '" + this.DropDownList2.SelectedValue.ToString() + "'))";
            Server.Transfer("~/QueryManage/QuerySalaryPrint.aspx");
        }
        protected void Button2_Click(object sender, EventArgs e)
        {//打印公司月度工资信息
            MyTitle = Session["MyCompanyName"].ToString() + "月度工资发放信息表";
            MySQL = "SELECT [员工编号], [员工姓名], [基本工资], [津贴], [奖金], [工龄工资], [岗位工资], [其他应增项], [应发合计], [所得税], [养老险], [医疗险], [住房基金], [其他应减项], [应减合计], [实发金额], [银行账号], [养老保险账号], [医疗保险账号], [住房基金账号], [身份证号码], [发放年份], [发放月份] FROM [工资发放表] WHERE (([发放年份] ='" + this.DropDownList1.SelectedValue.ToString() + "') AND ([发放月份] = '" + this.DropDownList2.SelectedValue.ToString() + "'))";
            Server.Transfer("~/QueryManage/QuerySalaryPrint.aspx");
        }
        public string MyPrintSQL
        {//设置要传递到打印页的数据
            get
            {
                return MySQL;
            }
        }
        public String MyPrintDate
        {//设置要传递到打印页的数据
            get
            {
                return "发放日期：" + this.DropDownList1.SelectedValue.ToString() + "年" + this.DropDownList2.SelectedValue.ToString() + "月";
            }
        }
        public String MyPrintTitle
        {//设置要传递到打印页的数据
            get
            {
                return MyTitle;
            }
        }
    }
}