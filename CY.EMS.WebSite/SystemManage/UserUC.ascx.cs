using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CY.Base.DB;
using System.Data;
using CY.EMS.Data;
using CY.EMS.Form;
using System.Text;
using System.Security.Cryptography;
using CY.EMS.Data.Entity;

namespace CY.EMS.WebSite.SystemManage
{
    /// <summary>
    /// 说明：员工信息
    /// 作者：wuxiaochao
    /// 日期：2015-06-05
    /// </summary>
    /// 2015-7-20 冯缨：添加密码加密
    public partial class UserUC : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.CurrentHandler is FrmBase)
            {
                (Context.CurrentHandler as FrmBase).dialogShowHandler += delegate(object x, DialogShowEventArgs y)
                {
                    loadUserInfo(y.Id);
                };
                (Context.CurrentHandler as FrmBase).dialogButtonClickHandler += delegate(object x, DialogButtonClickEventArgs y)
                {
                    y.Msg = saveUserInfo();
                };
            }

            if (!IsPostBack)
                FrmUtil.FillCodes(this);
        }

        #region Util

        /// <summary>
        /// 加载信息
        /// </summary>
        private void loadUserInfo(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                if (hidID.Contains("UserName"))
                    hidID.Remove("UserName");
                FrmUtil.ClearData(this);
                onEdit(false);
            }
            else
            {
                using (var context = ContextFactory.CreateContext<User>())
                {

                    var user = context.Set<User>().FirstOrDefault(u => u.UserName == username);

                    if (null != user)
                    {
                        hidID["UserName"] = username;

                        txtUserName.Text = user.UserName;
                        txtName.Text = user.Name;
                        txtPassword.Text = user.Password;
                        txtMemo.Text = user.Memo;

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
        }

        /// <summary>
        /// 设置新增、修改状态控件是否可用
        /// </summary>
        private void onEdit(bool edit)
        {
            txtUserName.ReadOnly = edit;
        }

        /// <summary>
        /// 保存用户信息
        /// </summary>
        private string saveUserInfo()
        {
            string userName = hidID.Contains("UserName") ? hidID["UserName"].ToString() : "";

            using (var context = ContextFactory.CreateContext<User>())
            {
                User user;
                if (hidID.Contains("UserName"))
                    user = context.Set<User>().FirstOrDefault(u => u.UserName == userName);
                else
                    user = new User();

                user.UserName = txtUserName.Text;
                user.Name = txtName.Text;
                if (!txtPassword.Text.Equals(user.Password))
                    user.Password = FrmUtil.CalculateMD5Hash(txtPassword.Text); // MD5加密
                user.Password = txtPassword.Text;
                user.Memo = txtMemo.Text;

                if (!hidID.Contains("UserName"))
                    context.Set<User>().Add(user);

                int rtn = context.SaveChanges();
                if (rtn != 1)
                    return "保存失败！";
                else
                    return null;
            }
        }

        #endregion
    }
}