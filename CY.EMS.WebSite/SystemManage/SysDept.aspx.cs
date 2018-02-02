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
    public partial class SysDept : FrmBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            if (!IsCallback && !IsPostBack)
            {
                loadTree(null, DaoFactory.GetDao("DaoBasDept").Select(), null);
                ASPxTreeView1.SelectedNode = ASPxTreeView1.Nodes[0];
                loadDeptInfo(ASPxTreeView1.SelectedNode.Name);
                ASPxTreeView1.ExpandAll();
            }
        }

        private void loadTree(TreeViewNode parent, DataTable dt, string selectedCode)
        {
            if (null == dt)
                return;

            string parentName = "-1";
            if (null != parent)
                parentName = parent.Name;

            DataRow[] rows = dt.Select("ParentCode='" + parentName + "'");
            foreach (DataRow row in rows)
            {
                TreeViewNode node = new TreeViewNode(row["Code"].ToString() + " " + row["Name"].ToString(), row["Code"].ToString());
                if (null == parent)
                    ASPxTreeView1.Nodes.Add(node);
                else
                    parent.Nodes.Add(node);

                // 设置选中
                if (node.Name.Equals(selectedCode))
                {
                    ASPxTreeView1.SelectedNode = node;
                    loadDeptInfo(selectedCode);
                }
                // 递归加载子部门
                loadTree(node, dt, selectedCode);
            }
        }

        protected void ASPxPageControl1_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        { loadDeptInfo(e.Parameter); }

        protected void ASPxMenu1_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
        {
            IDao dao = DaoFactory.GetDao("DaoBasDept");
            dao.Params["Oper"] = Session["MyUserName"].ToString();
            string code = ASPxTreeView1.SelectedNode.Name;
            string msg = "操作失败！";
            int rtn = -1;

            // 增加平级部门
            if (e.Item.Name.Equals("mAddDept"))
            {
                dao.Params["Code"] = code;
                rtn = dao.Insert(out msg);
                code = msg;
            }
            // 增加子部门
            else if (e.Item.Name.Equals("mAddSubDept"))
            {
                dao.Params["ParentCode"] = code;
                rtn = dao.Oper("P_Bas_Oper_Dept", "insertSub", out msg);
                code = msg;
            }
            // 删除部门
            else if (e.Item.Name.Equals("mDel"))
            {
                rtn = dao.Delete(code, out msg);
            }
            // 保存部门
            else if (e.Item.Name.Equals("mSave"))
            {
                FrmUtil.GetData(ASPxPageControl1, dao.Params);
                dao.Params["NewCode"] = dao.Params["Code"];
                dao.Params["Code"] = code;
                rtn = dao.Update(out msg);

                code = txtCode.Text;
            }
            // 上移
            else if (e.Item.Name.Equals("mUp"))
            {
                dao.Params["Code"] = code;
                rtn = dao.Oper("P_Bas_Oper_Dept", "up", out msg);
            }
            // 下移
            else if (e.Item.Name.Equals("mDown"))
            {
                dao.Params["Code"] = code;
                rtn = dao.Oper("P_Bas_Oper_Dept", "down", out msg);
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
                loadTree(null, dao.Select(), code);
                ASPxTreeView1.ExpandAll();
            }
        }

        private void loadDeptInfo(string dept)
        {
            if (ASPxPageControl1.ActiveTabIndex == 0)
            {
                // 加载部门信息
                IDao dao1 = DaoFactory.GetDao("DaoBasDept");
                DataTable dt1 = dao1.SelectByPK(dept);
                if (null != dt1)
                    FrmUtil.FillData(dt1, ASPxPageControl1);
                else
                    FrmUtil.ClearData(ASPxPageControl1);
            }
            else
            {
                // 加载部门员工信息
                IDao dao2 = DaoFactory.GetDao("DaoBasEmployee");
                dao2.Params["DeptCode"] = dept;
                ASPxGridView1.DataSource = dao2.Select();
                ASPxGridView1.DataBind();
            }
        }
    }
}