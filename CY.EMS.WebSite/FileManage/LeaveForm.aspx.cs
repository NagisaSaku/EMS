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

namespace CYHRMS.FileManage
{
    public partial class LeaveForm : FrmBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            if (!IsCallback && !IsPostBack)
            {
                string fmDate = Request.QueryString["FmDate"];
                if (!string.IsNullOrEmpty(fmDate))
                    datFmDate.Value = Convert.ToDateTime(fmDate);
                loadLeave();
            }
        }

        private void loadLeave()
        {
            IDao dao = DaoFactory.GetDao("DaoBizLeave");
            dao.Params["ID"] = txtID.Text;
            dao.Params["EmpNameLike"] = txtEmpName.Text;
            if (null != datFmDate.Value && !datFmDate.Value.Equals(DateTime.MinValue))
                dao.Params["FmDate"] = datFmDate.Value;
            if (null != datToDate.Value && !datToDate.Value.Equals(DateTime.MinValue))
                dao.Params["ToDate"] = datToDate.Value;
            DataTable MyTable = dao.Select();

            grdView.DataSource = MyTable;
            grdView.DataBind();
        }

        protected void onButton_Click(object sender, EventArgs e)
        {
            if (sender == btnQry)
                loadLeave();
            else if (sender == btnSave)
            {
                IDao dao = DaoFactory.GetDao("DaoBizLeave");
                FrmUtil.GetData(ucLeave, dao.Params);
                dao.Params["Oper"] = Session["MyUserName"].ToString();

                string msg;
                int rtn;
                if (ucLeave.IsAdd())
                    rtn = dao.Insert(out msg);
                else
                    rtn = dao.Update(out msg);
                if (rtn != 0)
                    lblMsg.Text = "错误：" + msg;
                else
                {
                    lblMsg.Text = "";
                    ASPxPopupControl1.ShowOnPageLoad = false;

                    loadLeave();//成功后刷新列表
                }
            }
        }

        // GridView的编辑事件，操作中的查看和删除按钮
        protected void grdView_CustomButtonCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            if (e.ButtonID.Equals("btnDelete"))
            {
                // 表格“删除”
                string id, msg;
                id = grdView.GetRowValues(e.VisibleIndex, "ID").ToString();
                IDao dao = DaoFactory.GetDao("DaoBizLeave");
                dao.Params["Oper"] = Session["MyUserName"].ToString();
                int rtn = dao.Delete(id, out msg);
                if (rtn == 0)
                {
                    msg = "操作成功！";
                    loadLeave();
                    //成功后刷新界面
                }
                else
                    msg = "错误：" + msg;
                grdView.JSProperties["cpMsg"] = msg;
            }
        }

        protected void grdView_PageIndexChanged(object sender, EventArgs e)
        {
            // 分页切换时重新查询数据
            loadLeave();
        }

        protected void ASPxPopupControl1_WindowCallback(object source, DevExpress.Web.ASPxPopupControl.PopupWindowCallbackArgs e)
        {
            ucLeave.loadLeave(e.Parameter);
        }

        protected void gridview_BeforeColumnSorting(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewBeforeColumnGroupingSortingEventArgs e)
        {
            loadLeave();
        }
    }
}