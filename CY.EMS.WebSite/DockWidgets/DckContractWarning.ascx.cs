using CY.Base.DB;
using CY.EMS.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CY.EMS.WebSite.DockWidgets
{
    /// <summary>
    /// 说明：合同到期（45天）预警
    /// 作者：吴小超
    /// 日期：2015-06-08
    /// </summary>
    public partial class DckContractWarning : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DateTime date = DateTime.Now.AddDays(45); // 45天之内

                IDao dao = DaoFactory.GetDao("DaoBizContract");
                dao.Params["ConStatus"] = "00";
                dao.Params["TOTODate"] = date.ToShortDateString();
                DataTable dt = dao.Select();

                if (null != dt && dt.Rows.Count > 0)
                {
                    lnkCntContract.Text = "[" + dt.Rows.Count + "]";
                    lnkCntContract.NavigateUrl = "~/FileManage/Contract.aspx?ToToDate="
                        + date.ToShortDateString() + "&&ConStatus=00";
                }
                else
                {
                    lnkCntContract.Text = "0";
                }
            }
        }
    }
}