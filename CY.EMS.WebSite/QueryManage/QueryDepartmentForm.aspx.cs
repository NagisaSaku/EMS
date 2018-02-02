using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.EMS.Form;

namespace CYHRMS.QueryManage
{
    public partial class QueryDepartmentForm : FrmBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }

        protected void onButtonClick(object sender, EventArgs e)
        {
            //打印部门员工基本人事档案信息
            getParameters().add("DeptCode", cbbDept.Value);
            Server.Transfer("~/QueryManage/QueryDepartmentPrint.aspx");
        }
    }
}