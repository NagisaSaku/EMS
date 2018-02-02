using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.EMS.Form;

namespace CYHRMS.SystemManage
{
    public partial class AllErrorHelp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.Handler is IFrmParams)
            {
                FrmParams p = (Context.Handler as IFrmParams).getParameters();
                if (p.contains("Message"))
                    Label1.InnerText = p.get("Message").ToString();
                if (p.contains("ExStackTrace"))
                    Label2.InnerText = p.get("ExStackTrace").ToString();
            }
        }
    }
}