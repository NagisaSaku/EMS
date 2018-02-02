﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.Base.DB;
using CY.EMS.Data;
using System.Data;
using CY.EMS.Form;

namespace CYHRMS.FileManage
{
    public partial class PerformanceUC : System.Web.UI.UserControl
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

        //按照ID加载员工工作简历
        public void loadPerformance(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                if (hidID.Contains("id"))
                    hidID.Remove("id");
                FrmUtil.ClearData(this);
                onEdit(false);
            }
            else
            {
                IDao dao = DaoFactory.GetDao("DaoBizPerformance");
                DataTable dt = dao.SelectByPK(id);
                if (null != dt && dt.Rows.Count > 0)
                {
                    hidID["ID"] = id;
                    FrmUtil.FillData(dt, this); // 加载业务数据

                    onEdit(true);

                }
                else
                {
                    if (hidID.Contains("id"))
                        hidID.Remove("id");
                    FrmUtil.ClearData(this);
                    onEdit(false);
                }
            }
        }

        // update时，设置部分控件无法编辑
        private void onEdit(bool edit)
        {
            txtID.ReadOnly = edit;
        }

        protected void ASPxCallbackPanel1_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            //if (hidID.Contains("ID"))
            //    FrmUtil.GetImage("Family", hidID["id"].ToString(), ASPxBinaryImage1);
        }
    }
}