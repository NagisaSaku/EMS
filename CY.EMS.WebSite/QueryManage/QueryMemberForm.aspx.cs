using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.EMS.Form;

namespace CYHRMS.QueryManage
{
    public partial class QueryMemberForm : FrmBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }

        protected void onButtonClick(object sender, EventArgs e)
        {
            //打印员工个人人事档案
            this.Response.Redirect("~/QueryManage/QueryMemberPrint.aspx?MyID=" + this.cbbEmployee.Value);
        }

        protected void cbbEmployee_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            // 选中部门时，重新填充员工
            FrmUtil.FillCodes(cbbEmployee, e.Parameter);
        }
    }
}