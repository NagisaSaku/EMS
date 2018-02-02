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

namespace CY.EMS.WebSite.DockWidgets
{
    /// <summary>
    /// 说明：首页悬浮本月入职、转正、离职人数
    /// 作者：吴小超
    /// 日期2015-06-08
    /// </summary>
    public partial class DckEmpDate : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IDao dao = DaoFactory.GetDao("RepDckEmpDate");
                DataTable dt = dao.Select();
                FrmUtil.FillData(dt, Page);

                DateTime startMonth = DateTime.Now.AddDays(1 - DateTime.Now.Day); // 月初

                if (!lnkCntLeave.Text.Equals("0"))
                {
                    lnkCntLeave.Text = "[" + lnkCntLeave.Text + "]";
                    lnkCntLeave.NavigateUrl = "~/FileManage/LeaveForm.aspx?FmDate="
                        + startMonth.ToShortDateString();
                }
            }
        }
    }
}