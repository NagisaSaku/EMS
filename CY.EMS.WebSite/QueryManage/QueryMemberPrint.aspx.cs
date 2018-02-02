using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.Base.DB;
using System.Data;
using CY.EMS.Data;
using CY.EMS.Form;

namespace CYHRMS.QueryManage
{
    public partial class QueryMemberPrint : FrmBase
{
        protected override void Page_Load(object sender, EventArgs e)
        {
            if (!IsCallback && !IsPostBack)
            {
                //显示员工个人人事档案
                string MyID = this.Request.Params["MyID"].ToString();
                if (Session["MyCompanyName"] != null)
                    this.Label1.Text = Session["MyCompanyName"].ToString() + "员工人事档案卡";
                this.Label2.Text = "打印日期：" + DateTime.Now.ToShortDateString();

                IDao dao1 = DaoFactory.GetDao("DaoBasEmployee");
                DataTable dt1 = dao1.SelectByPK(MyID);
                if (null != dt1 && dt1.Rows.Count > 0)
                {
                    this.Label3.Text = "员工编号：" + MyID;
                    this.Label4.Text = "部门：" + dt1.Rows[0]["DeptName"].ToString();
                    this.Label5.Text = "姓名：" + dt1.Rows[0]["Name"].ToString();
                    this.Label6.Text = "性别：" + dt1.Rows[0]["SexName"].ToString();
                    this.Label7.Text = "民族：" + dt1.Rows[0]["NationName"].ToString();
                    this.Label8.Text = "籍贯：" + dt1.Rows[0]["NativePlace"].ToString();
                    this.Label9.Text = "出生日期：" + dt1.Rows[0]["Birthday"].ToString().TrimEnd(new char[2] { ':', '0' });
                    this.Label10.Text = "身份证号码：" + dt1.Rows[0]["IDNumber"].ToString();
                    this.Label11.Text = "政治面貌：" + dt1.Rows[0]["PoliticalStatus"].ToString();
                    this.Label12.Text = "婚姻状况：" + dt1.Rows[0]["MaritalStatus"].ToString();
                    this.Label13.Text = "文化程度：" + dt1.Rows[0]["EducationName"].ToString();
                    this.Label14.Text = "职称：" + dt1.Rows[0]["JobTitle"].ToString();
                    this.Label15.Text = "职务：" + dt1.Rows[0]["Job"].ToString();
                    this.Label16.Text = "专业：" + dt1.Rows[0]["Major"].ToString();
                    this.Label17.Text = "毕业院校：" + dt1.Rows[0]["School"].ToString();
                    this.Label18.Text = "进入公司时间：" + dt1.Rows[0]["BeginDate"].ToString().TrimEnd(new char[2] { ':', '0' });
                    this.Label19.Text = "合同服务年限：";// +dt1.Rows[0]["ContractName"].ToString();
                    this.Label20.Text = "基本工资：" + dt1.Rows[0]["BaseSalary"].ToString();
                    this.Label21.Text = "银行账号：" + dt1.Rows[0]["BankAccount"].ToString();
                    this.Label22.Text = "养老保险账号：" + dt1.Rows[0]["PersionInsurance"].ToString();
                    this.Label23.Text = "医疗保险账号：" + dt1.Rows[0]["MedicalInsurance"].ToString();
                    this.Label24.Text = "住房基金账号：" + dt1.Rows[0]["HousingFund"].ToString();
                    this.Label25.Text = "联系电话：" + dt1.Rows[0]["Phone"].ToString();
                    this.Label26.Text = "手机号码：" + dt1.Rows[0]["Cellphone"].ToString();
                    this.Label27.Text = "电子信箱：" + dt1.Rows[0]["EMail"].ToString();
                    this.Label28.Text = "家庭地址：" + dt1.Rows[0]["Address"].ToString();
                    this.Label29.Text = "邮政编码：" + dt1.Rows[0]["Zip"].ToString();
                    this.Label30.Text = "补充说明：" + dt1.Rows[0]["Memo"].ToString();
                }

                // 家庭成员
                IDao dao2 = DaoFactory.GetDao("DaoBizFamily");
                dao2.Params["EmpCode"] = MyID;
                DataTable dt2 = dao2.Select();
                if (null != dt2 && dt2.Rows.Count > 0)
                {
                    this.GridView1.DataSource = dt2;
                    this.GridView1.DataBind();
                }

                // 简历
                IDao dao3 = DaoFactory.GetDao("DaoBizResume");
                dao3.Params["EmpCode"] = MyID;
                DataTable dt3 = dao3.Select();
                if (null != dt3 && dt3.Rows.Count > 0)
                {
                    this.GridView2.DataSource = dt3;
                    this.GridView2.DataBind();
                }

                // 培训
                IDao dao4 = DaoFactory.GetDao("DaoBizTraining");
                dao4.Params["EmpCode"] = MyID;
                DataTable dt4 = dao4.Select();
                if (null != dt4 && dt4.Rows.Count > 0)
                {
                    this.GridView3.DataSource = dt4;
                    this.GridView3.DataBind();
                }

                // 奖惩
                IDao dao5 = DaoFactory.GetDao("DaoBizRwdAndPnh");
                dao5.Params["EmpCode"] = MyID;
                DataTable dt5 = dao5.Select();
                if (null != dt5 && dt5.Rows.Count > 0)
                {
                    this.GridView4.DataSource = dt5;
                    this.GridView4.DataBind();
                }

                // 工作业绩
                IDao dao6 = DaoFactory.GetDao("DaoBizPerformance");
                dao6.Params["EmpCode"] = MyID;
                DataTable dt6 = dao6.Select();
                if (null != dt6 && dt6.Rows.Count > 0)
                {
                    this.GridView5.DataSource = dt6;
                    this.GridView5.DataBind();
                }

                if (Session["MyUserName"] != null)
                    this.Label31.Text = "人事专员：" + Session["MyUserName"].ToString();
            }
        }
    }
}