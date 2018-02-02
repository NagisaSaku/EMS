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
    /// <summary>
    /// 说明：合同明细
    /// 作者：吴小超
    /// 日期：2015-06-08
    /// </summary>
    public partial class ContractUC : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 每次请求时，在服务端是不保持状态的，所以每次重新添加监听
            if (Context.Handler is FrmBase)
            {
                (Context.Handler as FrmBase).dialogButtonClickHandler += onDialogButtonClick;
                (Context.Handler as FrmBase).dialogShowHandler += onDialogShow;

                txtCode.ReadOnly = true;
            }

            if (!IsPostBack)
                FrmUtil.FillCodes(this);
        }

        private void onDialogShow(object sender, DialogShowEventArgs e)
        {
            if (e.Action.Equals("add")) // 新增
            {
                clearInput();
            }
            else
            {
                IDao dao = DaoFactory.GetDao("DaoBizContract");
                DataTable dt = dao.SelectByPK(e.Id);
                if (null != dt && dt.Rows.Count > 0)
                {
                    if (e.Action.Equals("edit")) // 编辑
                    {
                        hidID["ID"] = e.Id;
                        FrmUtil.FillData(dt, this);
                        setReadOnly(true);
                    }
                    else if (e.Action.Equals("renew"))
                    {
                        if (hidID.Contains("ID"))
                            hidID.Remove("ID");
                        FrmUtil.FillData(dt, this);
                        renew();
                        setReadOnly(false);
                    }
                }
                else
                {
                    clearInput();
                }
            }
        }

        private void onDialogButtonClick(object sender, DialogButtonClickEventArgs e)
        {
            IDao dao = DaoFactory.GetDao("DaoBizContract");
            FrmUtil.GetData(this, dao.Params);
            dao.Params["Oper"] = Session["MyUserName"].ToString();

            string msg;
            int rtn;
            if (!hidID.Contains("ID"))
                rtn = dao.Insert(out msg);
            else
                rtn = dao.Update(out msg);

            e.Msg = msg;
        }

        #region util

        private void clearInput()
        {
            if (hidID.Contains("ID"))
                hidID.Remove("ID");
            FrmUtil.ClearData(this);
            setReadOnly(false);
        }

        private void renew()
        {
            txtCode.Text = "";
            cbbConStatus.Value = "00";
            datFmDate.Value = DateTime.Now;
            string len = cbbConLenCode.Value.ToString();
            if (string.IsNullOrEmpty(len))
                return;
            else if (len.Equals("oneyear"))
                datToDate.Value = datFmDate.Date.AddYears(1).AddDays(-1);
            else if (len.Equals("twoyears"))
                datToDate.Value = datFmDate.Date.AddYears(2).AddDays(-1);
            else if (len.Equals("threeyears"))
                datToDate.Value = datFmDate.Date.AddYears(3).AddDays(-1);
            else if (len.Equals("fouryears"))
                datToDate.Value = datFmDate.Date.AddYears(4).AddDays(-1);
            else if (len.Equals("fiveyears"))
                datToDate.Value = datFmDate.Date.AddYears(5).AddDays(-1);
            else if (len.Equals("notsureyears"))
                datToDate.Value = DateTime.Parse("2099-12-31");
        }

        private void setReadOnly(bool isEdit)
        {
            txtCode.ReadOnly = isEdit;
        }
        #endregion
    }
}