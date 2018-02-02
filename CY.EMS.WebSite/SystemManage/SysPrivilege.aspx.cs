using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxTreeList;
using System.Text;
using System.Data;
using CY.Base.DB;
using CY.EMS.Data;
using CY.EMS.Form;

namespace CYHRMS.SystemManage
{
    public partial class SysPrivilege : FrmBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }

        protected void onButtonClick(object sender, EventArgs e)
        {
            string user = this.cbbUser.Value.ToString();
            if (string.IsNullOrEmpty(user))
                return;

            if (sender == btnQuery)
            {
                foreach (TreeListNode node in ASPxTreeList1.Nodes)
                    setNodeSelected(node);
            }
            else if (sender == btnSave)
            {
                IDao dao = DaoFactory.GetDao("DaoSysPrivilege");
                StringBuilder sb = new StringBuilder();
                foreach (TreeListNode node in ASPxTreeList1.Nodes)
                    getNodeSelected(node, sb);

                dao.Params["User"] = user;
                dao.Params["Oper"] = Session["MyUserName"].ToString();
                dao.Params["PvgData"] = sb.ToString();

                int rtn = -1;
                string msg;
                rtn = dao.Insert(out msg);
                if (rtn != 0)
                {
                    lblMsg.Text = msg;
                    ASPxPopupControl1.ShowOnPageLoad = true;
                }
            }
        }

        private void setNodeSelected(TreeListNode node)
        {
            // 递归设置选中状态
            DataRowView drv = node.DataItem as DataRowView;
            if (drv.Row["Operation"].Equals("Y"))
                node.Selected = true;
            else
                node.Selected = false;

            foreach (TreeListNode n in node.ChildNodes)
                setNodeSelected(n);
        }

        private void getNodeSelected(TreeListNode node, StringBuilder sb)
        {
            // 递归获取选中状态
            if (node.Selected)
            {
                DataRowView drv = node.DataItem as DataRowView;
                sb.Append(",").Append(drv.Row["ID"]);
            }

            foreach (TreeListNode n in node.ChildNodes)
                getNodeSelected(n, sb);
        }
    }
}