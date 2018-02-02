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
using CY.EMS.Data.Entity;
using System.Data.Common;
using System.Data.SqlClient;

namespace CY.EMS.WebSite.SystemManage
{
    /// <summary>
    /// 说明：登录用户管理
    /// 作者：wuxiaochao
    /// 日期：2015-06-05
    /// </summary>
    public partial class UserInfo : FrmBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            addEventHandler();

            if (!IsCallback && !IsPostBack)
                loadUserInfo();
        }

        #region Util

        /// <summary>
        /// 给控件添加事件处理
        /// </summary>
        private void addEventHandler()
        {
            // Button Click事件
            this.btnQry.Click += delegate
            {
                loadUserInfo();
            };
            this.btnSave.Click += delegate
            {
                DialogButtonClickEventArgs e = new DialogButtonClickEventArgs();
                base.FireEvent(btnSave, e);
                if (string.IsNullOrEmpty(e.Msg))
                {
                    ASPxPopupControl1.ShowOnPageLoad = false;
                    loadUserInfo(); // 成功后刷新列表
                }
                else
                {
                    lblMsg.Text = e.Msg;
                }
            };

            // GridView
            this.grdView.CustomButtonCallback += grdView_CustomButtonCallback;
            this.grdView.PageIndexChanged += delegate
            { loadUserInfo(); };

            this.grdView.BeforeColumnSortingGrouping += delegate
            { loadUserInfo(); };

            // PopupControl
            this.ASPxPopupControl1.WindowCallback += delegate(Object sender, DevExpress.Web.ASPxPopupControl.PopupWindowCallbackArgs e)
            {
                base.FireEvent(sender, new DialogShowEventArgs() { Id = e.Parameter });
                lblMsg.Text = "";
            };
        }

        /// <summary>
        /// 加载用户清单到表格
        /// </summary>
        private void loadUserInfo()
        {
            using (var context = ContextFactory.CreateContext<User>())
            {
                context.InputParams["UserNameLike"] = txtQryUserName.Text;
                context.InputParams["NameLike"] = txtQryName.Text;
                var users = context.SelectBySP<User>();

                grdView.DataSource = users;
                grdView.DataBind();
            }
        }

        #endregion

        #region Event Handler

        /// <summary>
        /// GirdView的编辑按钮事件
        /// </summary>
        protected void grdView_CustomButtonCallback(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            if (e.ButtonID.Equals("btnDelete"))
            {
                // 表格“删除”
                string UserName, msg = "";
                UserName = grdView.GetRowValues(e.VisibleIndex, "UserName").ToString();

                using (var context = ContextFactory.CreateContext<User>())
                {
                    var user = context.Set<User>().FirstOrDefault(u => u.UserName == UserName);
                    context.Set<User>().Remove(user);

                    int rtn = context.SaveChanges();
                    if (rtn == 1)
                    {
                        msg = "操作成功！";
                        loadUserInfo();
                    }
                    else
                        msg = "操作失败！";

                    grdView.JSProperties["cpMsg"] = msg;
                }
            }
        }

        #endregion
    }
}