using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using CY.EMS.Data;
using CY.Base.DB;
using CY.EMS.Form;

namespace CYHRMS.FileManage
{
    public partial class TrainingForm : FrmBase
    {

        //这个子类FileManage_TrainingForm继承自FrmBase这个父类，由于对父类进行了重写，因此可以
        //在子类中方法相同，若是参数不同的话则称为重载！！！！
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            if (!IsCallback && !IsPostBack)
                loadTraining();
        }

        private void loadTraining()
        {
            IDao dao = DaoFactory.GetDao("DaoBizTraining");
            dao.Params["ID"] = txtID.Text;
            dao.Params["EmpCode"] = txtEmpCode.Text;
            DataTable MyTable = dao.Select();

            grdView.DataSource = MyTable;
            grdView.DataBind();
        }



        protected void onButton_Click(object sender, EventArgs e)
        {

            if (sender == btnQry)
                loadTraining();
            else if (sender == btnSave)
            {
                IDao dao = DaoFactory.GetDao("DaoBizTraining");
                FrmUtil.GetData(ucTraining, dao.Params);
                //这里的ucTraining就是之前在aspx、页面中popupControl自定义填充组件的代号！
                dao.Params["Oper"] = Session["MyUserName"].ToString();
                //存储过程中有定义了一个存储过程 里面有oper这个参数 故要有个接收的

                string msg;
                int rtn;
                if (ucTraining.IsAdd())
                    rtn = dao.Insert(out msg);
                else
                    rtn = dao.Update(out msg);
                //这里的lblMsg可表示为一个传递参数的LBL
                if (rtn != 0)
                    lblMsg.Text = "错误：" + msg;
                else
                {
                    lblMsg.Text = "";
                    ASPxPopupControl1.ShowOnPageLoad = false;

                    loadTraining();//成功后刷新列表
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
                IDao dao = DaoFactory.GetDao("DaoBizTraining");
                dao.Params["Oper"] = Session["MyUserName"].ToString();
                int rtn = dao.Delete(id, out msg);
                if (rtn == 0)
                {
                    msg = "操作成功！";
                    loadTraining();
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
            loadTraining();
        }
        protected void ASPxPopupControl1_WindowCallback(object source, DevExpress.Web.ASPxPopupControl.PopupWindowCallbackArgs e)
        {
            // 将员工编号传递给自定义控件，以加载数据和照片
            ucTraining.loadTraining(e.Parameter);

            lblMsg.Text = "";
        }

        protected void grdView_BeforeColumnSortingGrouping(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewBeforeColumnGroupingSortingEventArgs e)
        {
            loadTraining();
        }
    }
}