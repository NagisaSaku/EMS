using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.EMS.Data;
using CY.Base.DB;
using System.Data;
using CY.EMS.Form;

namespace CYHRMS.FileManage
{
    public partial class LeaveUC : System.Web.UI.UserControl
    {
        public bool IsAdd()
        {
            return !hidID.Contains("ID");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                FrmUtil.FillCodes(this);
        }

        //按照员工ID加载员工奖惩纪录
        public void loadLeave(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                if (hidID.Contains("id"))
                    hidID.Remove("id");
                FrmUtil.ClearData(this);
            }
            else
            {
                IDao dao = DaoFactory.GetDao("DaoBizLeave");
                DataTable dt = dao.SelectByPK(id);
                if (null != dt && dt.Rows.Count > 0)
                {
                    hidID["ID"] = id;
                    FrmUtil.FillData(dt, this); // 加载业务数据
                }
                else
                {
                    if (hidID.Contains("id"))
                        hidID.Remove("id");
                    FrmUtil.ClearData(this);
                }
            }
        }

        protected void cbbEmpCode_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            FrmUtil.FillCodes(cbbEmpCode, e.Parameter);
        }
    }
}