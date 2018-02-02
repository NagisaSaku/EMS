using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.Base.DB;
using System.Data;
using CY.EMS.Data;
using DevExpress.Web.ASPxGridView;
using CY.EMS.Form;

namespace CY.EMS.WebSite.FileManage
{
    public partial class PersonnelQryFrm : FrmBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            this.Title = "当前位置：员工基本档案";

            if (!IsCallback && !IsPostBack)
            {
                loadEmployee();
            }
        }

        // load员工列表
        private void loadEmployee()
        {
            IDao dao = DaoFactory.GetDao("DaoBasEmployee");
            dao.Params["CodeLike"] = txtCode.Text;
            dao.Params["NameLike"] = txtName.Text;
            DataTable MyTable = dao.Select();


            grdView.DataSource = MyTable;
            grdView.DataBind();
        }

        // 页面button事件
        protected void onButton_Click(object sender, EventArgs e)
        {
            if (sender == btnQry)
                loadEmployee();
            else if (sender == btnSave)
            {
                IDao dao = DaoFactory.GetDao("DaoBasEmployee");
                FrmUtil.GetData(ucPersonnel, dao.Params);
                dao.Params["Oper"] = Session["MyUserName"].ToString();

                string msg;
                int rtn;
                if (ucPersonnel.IsAdd())
                    rtn = dao.Insert(out msg);
                else
                    rtn = dao.Update(out msg);

                if (rtn != 0)
                    lblMsg.Text = "错误：" + msg;
                else
                {
                    lblMsg.Text = "";
                    ASPxPopupControl1.ShowOnPageLoad = false;

                    loadEmployee(); // 成功后刷新列表
                }
            }
        }

        // GridView的编辑事件
        protected void grdView_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            if (e.ButtonID.Equals("btnDelete"))
            {
                // 表格“删除”
                string code, msg;
                code = grdView.GetRowValues(e.VisibleIndex, "Code").ToString();
                IDao dao = DaoFactory.GetDao("DaoBasEmployee");
                dao.Params["Oper"] = Session["MyUserName"].ToString();
                int rtn = dao.Delete(code, out msg);
                if (rtn == 0)
                {
                    msg = "操作成功！";
                    loadEmployee(); // 成功后刷新列表
                }
                else
                    msg = "错误：" + msg;
                grdView.JSProperties["cpMsg"] = msg;
            }
        }

        // GridView切换分页事件
        protected void grdView_PageIndexChanged(object sender, EventArgs e)
        {
            loadEmployee();
        }

        // PopupControl的Callback事件
        protected void ASPxPopupControl1_WindowCallback(object source, DevExpress.Web.ASPxPopupControl.PopupWindowCallbackArgs e)
        {
            // 将员工编号传递给自定义控件，以加载数据和照片
            ucPersonnel.loadEmployee(e.Parameter);
            lblMsg.Text = "";
        }

        protected void gridview_BeforeColumnSorting(object sender, ASPxGridViewBeforeColumnGroupingSortingEventArgs e)
        {
            loadEmployee();
        }
    }
}