using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.EMS.Data;
using DevExpress.Web.ASPxTreeView;
using System.Data;
using CY.Base.DB;
using CY.EMS.Form;

namespace CYHRMS.SystemManage
{
    public partial class SysMenu : FrmBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            if (!IsCallback && !IsPostBack)
            {
                loadMenu(null, DaoFactory.GetDao("DaoSysMenu").Select(), -1);
                ASPxTreeView1.SelectedNode = ASPxTreeView1.Nodes[0];
                //ASPxTreeView1.ExpandAll();
            }
        }

        private void loadMenu(TreeViewNode parent, DataTable dt, int selectedID)
        {
            if (null == dt)
                return;

            int parentID = -1;
            if (null != parent)
                parentID = Convert.ToInt16(parent.Name);

            DataRow[] rows = dt.Select("ParentID=" + parentID + "");
            foreach (DataRow row in rows)
            {
                TreeViewNode node = new TreeViewNode(row["ID"].ToString() + " " + row["Name"].ToString(), row["ID"].ToString());
                node.Image.IconID = row["IconID"].ToString();
                if (null == parent)
                    ASPxTreeView1.Nodes.Add(node);
                else
                    parent.Nodes.Add(node);

                // 设置选中
                if (node.Name.Equals(selectedID + ""))
                {
                    ASPxTreeView1.SelectedNode = node;
                    if (null != parent)
                        parent.Expanded = true;
                }
                // 递归加载子部门
                loadMenu(node, dt, selectedID);
            }
        }

        protected void ASPxMenu1_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
        {
            IDao dao = DaoFactory.GetDao("DaoSysMenu");
            dao.Params["Oper"] = Session["MyUserName"].ToString();
            int id = Convert.ToInt16(ASPxTreeView1.SelectedNode.Name);
            string msg = "操作失败！";
            int rtn = -1;

            // 增加平级菜单
            if (e.Item.Name.Equals("mAddDept"))
            {
                dao.Params["ID"] = id;
                rtn = dao.Insert(out msg);
            }
            // 增加子菜单
            else if (e.Item.Name.Equals("mAddSubDept"))
            {
                dao.Params["ParentID"] = id;
                rtn = dao.Oper("P_Sys_Oper_Menu", "insertSub", out msg);
            }
            // 删除部门
            else if (e.Item.Name.Equals("mDel"))
            {
                rtn = dao.Delete(id + "", out msg);
            }
            // 保存部门
            else if (e.Item.Name.Equals("mSave"))
            {
                FrmUtil.GetData(ASPxCallbackPanel1, dao.Params);
                rtn = dao.Update(out msg);
            }
            // 上移
            else if (e.Item.Name.Equals("mUp"))
            {
                dao.Params["ID"] = id;
                rtn = dao.Oper("P_Sys_Oper_Menu", "up", out msg);
            }
            // 下移
            else if (e.Item.Name.Equals("mDown"))
            {
                dao.Params["ID"] = id;
                rtn = dao.Oper("P_Sys_Oper_Menu", "down", out msg);
            }

            if (rtn != 0)
            {
                lblMsg.Text = msg;
                ASPxPopupControl1.ShowOnPageLoad = true;
            }
            else
            {
                ASPxTreeView1.Nodes.Clear();
                dao.Params.Clear();
                loadMenu(null, dao.Select(), id);
                //ASPxTreeView1.ExpandAll();
            }
        }

        protected void ASPxCallbackPanel1_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            // 加载菜单信息
            DaoSysMenu dao = new DaoSysMenu();
            DataTable dt = dao.SelectByPK(e.Parameter);
            if (null != dt)
                FrmUtil.FillData(dt, ASPxCallbackPanel1);
            else
                FrmUtil.ClearData(ASPxCallbackPanel1);
        }
    }
}