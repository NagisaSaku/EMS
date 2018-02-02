using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.Base.DB;
using CY.EMS.Data;
using System.Data;
using DevExpress.Web.ASPxGridView;
using CY.EMS.Form;
using DevExpress.Web.ASPxPopupControl;
using Newtonsoft.Json.Linq;

namespace CYHRMS.FileManage
{
    /// <summary>
    /// 说明：合同管理
    /// 作者：吴小超
    /// 日期：2015-06-08
    /// </summary>
    public partial class Contract : FrmBase
    {

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            addEventHandler();

            if (!IsCallback && !IsPostBack)
            {
                FrmUtil.FillCodes(this);

                string fmDate = Request.QueryString["ToToDate"];
                if (!string.IsNullOrEmpty(fmDate))
                    datToToDate.Value = Convert.ToDateTime(fmDate);
                string conStatus = Request.QueryString["ConStatus"];
                if (!string.IsNullOrEmpty(conStatus))
                    cbbConStatus.Value = conStatus;

                loadContract(grdView);
            }
        }

        #region Util

        /// <summary>
        /// 给控件添加事件处理
        /// </summary>
        private void addEventHandler()
        {
            // Button
            this.btnQry.Click += delegate
            {
                loadContract(grdView);
            };
            this.btnSave.Click += delegate
            {
                DialogButtonClickEventArgs e = new DialogButtonClickEventArgs();
                base.FireEvent(btnSave, e);
                if (string.IsNullOrEmpty(e.Msg))
                {
                    ASPxPopupControl1.ShowOnPageLoad = false;
                    loadContract(grdView); // 成功后刷新列表
                }
                else
                {
                    lblMsg.Text = e.Msg;
                }
            };

            // GridView
            this.grdView.PageIndexChanged += delegate
            {
                loadContract(grdView); // 分页后刷新
            };
            this.grdView.BeforeColumnSortingGrouping += delegate
            {
                loadContract(grdView); // 排序后刷新
            };
            this.grdView.CustomButtonCallback += delegate(object x, ASPxGridViewCustomButtonCallbackEventArgs y)
            {
                if (y.ButtonID.Equals("btnDelete")) // 表格“删除”
                {
                    string id, msg;
                    id = grdView.GetRowValues(y.VisibleIndex, "Code").ToString();
                    if (deleteContract(id, out msg) == 0)
                    {
                        msg = "操作成功！";
                        loadContract(grdView); // 刷新
                    }
                    else
                        msg = "错误：" + msg;
                    grdView.JSProperties["cpMsg"] = msg;
                }
            };

            // Popup
            this.ASPxPopupControl1.WindowCallback += delegate(object x, PopupWindowCallbackArgs y)
            {
                JObject jo = JObject.Parse(y.Parameter);
                base.FireEvent(null, new DialogShowEventArgs()
                {
                    Action = jo["Action"].ToString(),
                    Id = jo["ID"].ToString(),
                });
                lblMsg.Text = "";
            };
        }

        /// <summary>
        /// 查询数据，绑定到表格
        /// </summary>
        private void loadContract(ASPxGridView gv)
        {
            IDao dao = DaoFactory.GetDao("DaoBizContract");
            dao.Params["ConStatus"] = cbbConStatus.Value;
            dao.Params["Code"] = txtCode.Text;
            dao.Params["EmpNamelike"] = txtEmpName.Text;
            if (null != datToFmDate.Value && !datToFmDate.Value.Equals(DateTime.MinValue))
                dao.Params["TOFMDate"] = datToFmDate.Value;
            if (null != datToToDate.Value && !datToToDate.Value.Equals(DateTime.MinValue))
                dao.Params["TOTODate"] = datToToDate.Value;
            if (chkState.Checked)
                dao.Params["ShowClose"] = "Y";
            DataTable MyTable = dao.Select();

            gv.DataSource = MyTable;
            gv.DataBind();
        }

        /// <summary>
        /// 删除合同
        /// </summary>
        private int deleteContract(string id, out string msg)
        {
            IDao dao = DaoFactory.GetDao("DaoBizContract");
            dao.Params["Oper"] = Session["MyUserName"].ToString();
            int rtn = dao.Delete(id, out msg);
            return rtn;
        }

        #endregion

    }
}