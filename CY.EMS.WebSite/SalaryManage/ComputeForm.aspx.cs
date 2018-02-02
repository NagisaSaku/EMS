using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace CYHRMS.SalaryManage
{
    public partial class ComputeForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string myForbidString = Session["MyForbid"].ToString();
            if (myForbidString.IndexOf("C1") > 1)
            {
                Server.Transfer("~/SystemManage/AllErrorHelp.aspx");
            }
            string MyInfo = "一旦发放当月该部门工资，就不能再进行修改！是否确定发放工资？";
            this.Button3.OnClientClick = "return confirm('" + MyInfo + "')";
        }
        protected void Button1_Click(object sender, EventArgs e)
        {//查询部门员工工资信息        
            String MySQLConnectionString = ConfigurationManager.ConnectionStrings["MyPersonnelDBConnectionString"].ConnectionString;
            SqlConnection MyConnection = new SqlConnection(MySQLConnectionString);
            MyConnection.Open();
            string MySQL = "SELECT * FROM [工资核算表] WHERE ([员工编号] IN (Select 员工编号 FROM 在职员工视图 WHERE 所属部门='" + this.DropDownList1.SelectedValue.ToString() + "'))";
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
                    float My基本工资 = (float)Convert.ToDouble(MyRow[18].ToString());
                    MySQL = "INSERT INTO 工资核算表([员工编号], [员工姓名], [基本工资]) VALUES (@员工编号, @员工姓名, @基本工资)";
                    MyConnection = new SqlConnection(MySQLConnectionString);
                    MyConnection.Open();
                    SqlCommand MyCommand = MyConnection.CreateCommand();
                    MyCommand.CommandText = MySQL;
                    MyCommand.Parameters.Add(new SqlParameter("@员工编号", SqlDbType.VarChar));
                    MyCommand.Parameters.Add(new SqlParameter("@员工姓名", SqlDbType.VarChar));
                    MyCommand.Parameters.Add(new SqlParameter("@基本工资", SqlDbType.Float));
                    MyCommand.Parameters["@员工编号"].Value = My员工编号;
                    MyCommand.Parameters["@员工姓名"].Value = My员工姓名;
                    MyCommand.Parameters["@基本工资"].Value = My基本工资;
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
        {//打印月度部门员工工资核算信息
            Server.Transfer("~/SalaryManage/ComputePrint.aspx");
        }
        public string MyPrintSQL
        {//设置要传递到打印页的数据
            get
            {
                return "SELECT * FROM [工资核算表] WHERE ([员工编号] IN (Select 员工编号 FROM 在职员工视图 WHERE 所属部门='" + this.DropDownList1.SelectedValue.ToString() + "'))";
            }
        }
        public String MyPrintDate
        {//设置要传递到打印页的数据
            get
            {
                return "日期：" + this.DropDownList2.SelectedValue.ToString() + "年" + this.DropDownList3.SelectedValue.ToString() + "月";
            }
        }
        public String MyPrintTitle
        {//设置要传递到打印页的数据
            get
            {
                return Session["MyCompanyName"].ToString() + this.DropDownList1.SelectedValue.ToString() + "员工工资核算表";
            }
        }
        protected void Button3_Click(object sender, EventArgs e)
        {//发工资
            int My年份 = Convert.ToInt16(this.DropDownList2.SelectedValue.ToString());
            int My月份 = Convert.ToInt16(this.DropDownList3.SelectedValue.ToString());
            String MySQLConnectionString = ConfigurationManager.ConnectionStrings["MyPersonnelDBConnectionString"].ConnectionString;
            SqlConnection MyConnection = new SqlConnection(MySQLConnectionString);
            MyConnection.Open();
            string My发放年份 = this.DropDownList2.SelectedValue.ToString();
            string My发放月份 = this.DropDownList3.SelectedValue.ToString();
            string MySQL = "Select * From 工资发放表 Where (发放年份=" + My发放年份 + ") AND (发放月份=" + My发放月份 + ") AND ([员工编号] IN (Select 员工编号 FROM 在职员工视图 WHERE 所属部门='" + this.DropDownList1.SelectedValue.ToString() + "'))";
            SqlCommand MyQueryCommand = new SqlCommand(MySQL, MyConnection);
            if (MyQueryCommand.ExecuteScalar() == null)
            {
                MySQL = "SELECT * FROM [工资核算表] WHERE ([员工编号] IN (Select 员工编号 FROM 在职员工视图 WHERE 所属部门='" + this.DropDownList1.SelectedValue.ToString() + "'))";
                SqlDataAdapter MyAdapter = new SqlDataAdapter(MySQL, MySQLConnectionString);
                DataTable MyTable = new DataTable();
                MyAdapter.Fill(MyTable);
                foreach (DataRow MyRow in MyTable.Rows)
                {
                    string My员工编号 = MyRow[1].ToString();
                    System.Data.DataTable MyQueryTable = new System.Data.DataTable();
                    MySQL = "Select 银行账号,养老保险账号,医疗保险账号,住房基金账号,身份证号码 From 基本档案 WHERE 员工编号='" + My员工编号 + "'";
                    SqlDataAdapter MyDataAdapter = new SqlDataAdapter(MySQL, MyConnection);
                    MyDataAdapter.Fill(MyQueryTable);
                    string My银行账号 = MyQueryTable.Rows[0][0].ToString();
                    string My养老保险账号 = MyQueryTable.Rows[0][1].ToString();
                    string My医疗保险账号 = MyQueryTable.Rows[0][2].ToString();
                    string My住房基金账号 = MyQueryTable.Rows[0][3].ToString();
                    string My身份证号码 = MyQueryTable.Rows[0][4].ToString();
                    MySQL = "INSERT INTO 工资发放表([员工编号], [员工姓名], [基本工资],[津贴] ,[奖金], [工龄工资], [岗位工资],[其他应增项] ,[所得税], [养老险],[医疗险] ,[住房基金], [其他应减项], [银行账号],[养老保险账号] ,[医疗保险账号], [住房基金账号], [身份证号码],[发放年份] ,[发放月份], [补充说明]) VALUES (@员工编号,@员工姓名,@基本工资,@津贴 ,@奖金,@工龄工资,@岗位工资,@其他应增项 ,@所得税,@养老险,@医疗险 ,@住房基金,@其他应减项,@银行账号,@养老保险账号 ,@医疗保险账号,@住房基金账号,@身份证号码,@发放年份 ,@发放月份,@补充说明)";
                    SqlCommand MyCommand = new SqlCommand(MySQLConnectionString);
                    MyCommand = MyConnection.CreateCommand();
                    MyCommand.CommandText = MySQL;
                    MyCommand.Parameters.Add(new SqlParameter("@员工编号", SqlDbType.VarChar));
                    MyCommand.Parameters.Add(new SqlParameter("@员工姓名", SqlDbType.VarChar));
                    MyCommand.Parameters.Add(new SqlParameter("@基本工资", SqlDbType.Float));
                    MyCommand.Parameters.Add(new SqlParameter("@津贴", SqlDbType.Float));
                    MyCommand.Parameters.Add(new SqlParameter("@奖金", SqlDbType.Float));
                    MyCommand.Parameters.Add(new SqlParameter("@工龄工资", SqlDbType.Float));
                    MyCommand.Parameters.Add(new SqlParameter("@岗位工资", SqlDbType.Float));
                    MyCommand.Parameters.Add(new SqlParameter("@其他应增项", SqlDbType.Float));
                    MyCommand.Parameters.Add(new SqlParameter("@所得税", SqlDbType.Float));
                    MyCommand.Parameters.Add(new SqlParameter("@养老险", SqlDbType.Float));
                    MyCommand.Parameters.Add(new SqlParameter("@医疗险", SqlDbType.Float));
                    MyCommand.Parameters.Add(new SqlParameter("@住房基金", SqlDbType.Float));
                    MyCommand.Parameters.Add(new SqlParameter("@其他应减项", SqlDbType.Float));
                    MyCommand.Parameters.Add(new SqlParameter("@银行账号", SqlDbType.VarChar));
                    MyCommand.Parameters.Add(new SqlParameter("@养老保险账号", SqlDbType.VarChar));
                    MyCommand.Parameters.Add(new SqlParameter("@医疗保险账号", SqlDbType.VarChar));
                    MyCommand.Parameters.Add(new SqlParameter("@住房基金账号", SqlDbType.VarChar));
                    MyCommand.Parameters.Add(new SqlParameter("@身份证号码", SqlDbType.VarChar));
                    MyCommand.Parameters.Add(new SqlParameter("@发放年份", SqlDbType.Int));
                    MyCommand.Parameters.Add(new SqlParameter("@发放月份", SqlDbType.Int));
                    MyCommand.Parameters.Add(new SqlParameter("@补充说明", SqlDbType.VarChar));

                    MyCommand.Parameters["@员工编号"].Value = My员工编号;
                    MyCommand.Parameters["@员工姓名"].Value = MyRow[2].ToString();
                    MyCommand.Parameters["@基本工资"].Value = MyRow[3];
                    MyCommand.Parameters["@津贴"].Value = MyRow[4];
                    MyCommand.Parameters["@奖金"].Value = MyRow[5];
                    MyCommand.Parameters["@工龄工资"].Value = MyRow[6];
                    MyCommand.Parameters["@岗位工资"].Value = MyRow[7];
                    MyCommand.Parameters["@其他应增项"].Value = MyRow[8];
                    MyCommand.Parameters["@所得税"].Value = MyRow[9];
                    MyCommand.Parameters["@养老险"].Value = MyRow[10];
                    MyCommand.Parameters["@医疗险"].Value = MyRow[11];
                    MyCommand.Parameters["@住房基金"].Value = MyRow[12];
                    MyCommand.Parameters["@其他应减项"].Value = MyRow[13];
                    MyCommand.Parameters["@银行账号"].Value = My银行账号;
                    MyCommand.Parameters["@养老保险账号"].Value = My养老保险账号;
                    MyCommand.Parameters["@医疗保险账号"].Value = My医疗保险账号;
                    MyCommand.Parameters["@住房基金账号"].Value = My住房基金账号;
                    MyCommand.Parameters["@身份证号码"].Value = My身份证号码;
                    MyCommand.Parameters["@发放年份"].Value = My发放年份;
                    MyCommand.Parameters["@发放月份"].Value = My发放月份;
                    MyCommand.Parameters["@补充说明"].Value = MyRow[14];
                    MyCommand.ExecuteNonQuery();
                }
                this.Page.RegisterStartupScript("msgonlyAlert", "<script language='javascript'>alert('发放部门工资操作成功')</script>");
            }
            else
            {
                this.Label1.Text = "<script language='javascript'>alert('发放部门工资操作失败！不能重复发放工资！')</script>";
            }
            if (MyConnection.State == ConnectionState.Open)
            {
                MyConnection.Close();
            }
        }
    }
}