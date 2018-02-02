using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace CYHRMS.CheckManage
{
    public partial class MonthCheckForm : System.Web.UI.Page
    {
        private static string MySQL = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string myForbidString = Session["MyForbid"].ToString();
            if (myForbidString.IndexOf("B1") > 1)
            {
                Server.Transfer("~/SystemManage/AllErrorHelp.aspx");
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {//查询考勤记录信息

            String MySQLConnectionString = ConfigurationManager.ConnectionStrings["MyPersonnelDBConnectionString"].ConnectionString;
            SqlConnection MyConnection = new SqlConnection(MySQLConnectionString);
            MyConnection.Open();
            string MySQL = "SELECT * FROM [考勤记录] WHERE (([考勤年份] ='" + this.DropDownList2.SelectedValue.ToString() + "') AND ([考勤月份] = '" + this.DropDownList3.SelectedValue.ToString() + "')  AND (员工编号 IN (SELECT 员工编号 FROM 在职员工视图 WHERE (所属部门 LIKE '" + this.DropDownList1.SelectedValue.ToString() + "'))))";
            SqlCommand MyQueryCommand = new SqlCommand(MySQL, MyConnection);
            if (MyQueryCommand.ExecuteScalar() == null)
            {
                System.Data.DataTable MyQueryTable = new System.Data.DataTable();
                MySQL = "Select * From 在职员工视图 WHERE 所属部门='" + this.DropDownList1.SelectedValue.ToString() + "'";
                SqlDataAdapter MyAdapter = new SqlDataAdapter(MySQL, MyConnection);
                MyAdapter.Fill(MyQueryTable);
                foreach (DataRow MyRow in MyQueryTable.Rows)
                {
                    string My员工编号 = MyRow[1].ToString();
                    string My员工姓名 = MyRow[3].ToString();
                    int My考勤年份 = Convert.ToInt16(this.DropDownList2.SelectedValue.ToString());
                    int My考勤月份 = Convert.ToInt16(this.DropDownList3.SelectedValue.ToString());
                    MySQL = "INSERT INTO 考勤记录([员工编号], [员工姓名], [考勤年份], [考勤月份]) VALUES (@员工编号, @员工姓名, @考勤年份, @考勤月份)";
                    MyConnection = new SqlConnection(MySQLConnectionString);
                    MyConnection.Open();
                    SqlCommand MyCommand = MyConnection.CreateCommand();
                    MyCommand.CommandText = MySQL;
                    MyCommand.Parameters.Add(new SqlParameter("@员工编号", SqlDbType.VarChar));
                    MyCommand.Parameters.Add(new SqlParameter("@员工姓名", SqlDbType.VarChar));
                    MyCommand.Parameters.Add(new SqlParameter("@考勤年份", SqlDbType.Int));
                    MyCommand.Parameters.Add(new SqlParameter("@考勤月份", SqlDbType.Int));
                    MyCommand.Parameters["@员工编号"].Value = My员工编号;
                    MyCommand.Parameters["@员工姓名"].Value = My员工姓名;
                    MyCommand.Parameters["@考勤年份"].Value = My考勤年份;
                    MyCommand.Parameters["@考勤月份"].Value = My考勤月份;
                    MyCommand.ExecuteNonQuery();
                }
                this.GridView1.DataBind();
            }
            if (MyConnection.State == ConnectionState.Open)
            {
                MyConnection.Close();
            }
        }
        protected void Button2_Click(object sender, EventArgs e)
        {//打印月度部门考勤信息
            Server.Transfer("~/CheckManage/MonthCheckPrint.aspx");
        }
        public string MyPrintSQL
        {//设置要传递到打印页的数据
            get
            {
                return "SELECT * FROM [考勤记录] WHERE (([考勤年份] ='" + this.DropDownList2.SelectedValue.ToString() + "') AND ([考勤月份] = '" + this.DropDownList3.SelectedValue.ToString() + "')  AND (员工编号 IN (SELECT 员工编号 FROM 在职员工视图 WHERE (所属部门 LIKE '" + this.DropDownList1.SelectedValue.ToString() + "'))))";
            }
        }
        public String MyPrintDate
        {//设置要传递到打印页的数据
            get
            {
                return "考勤日期：" + this.DropDownList2.SelectedValue.ToString() + "年" + this.DropDownList3.SelectedValue.ToString() + "月";
            }
        }
        public String MyPrintTitle
        {//设置要传递到打印页的数据
            get
            {
                return Session["MyCompanyName"].ToString() + this.DropDownList1.SelectedValue.ToString() + "月度考勤表";
            }
        }
    }
}