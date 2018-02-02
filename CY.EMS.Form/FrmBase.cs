using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CY.EMS.Form
{
    public class FrmBase : System.Web.UI.Page, IFrmParams
    {
        #region 事件

        public event DialogButtonClickHandler dialogButtonClickHandler;
        public event DialogShowHandler dialogShowHandler;

        /// <summary>
        /// 发送事件
        /// </summary>
        public void FireEvent(object sender, EventArgs e)
        {
            if (e is DialogButtonClickEventArgs)
            {
                if (null != dialogButtonClickHandler)
                    dialogButtonClickHandler(sender, e as DialogButtonClickEventArgs);
            }
            else if(e is DialogShowEventArgs)
                if (null != dialogShowHandler)
                    dialogShowHandler(sender, e as DialogShowEventArgs);
        }
       
        #endregion

        private FrmParams parms;
        public FrmParams getParameters()
        {
            if (null == parms)
                parms = new FrmParams();
            return parms;
        }

        protected virtual void Page_Load(object sender, EventArgs e)
        {
            if (IsCallback || IsPostBack)
                return;

            parms = new FrmParams();

            // 登录状态校验
            if (null == Session["MyUserName"]
                || string.IsNullOrEmpty(Session["MyUserName"].ToString()))
            {
                //parms.add("Message", "连接超时，请重新登录！");
                //Server.Transfer("~/Login.aspx");
                Response.Write("<script languge='javascript'>alert('连接超时，请重新登录！');</script>");
                Response.Write("<script languge='javascript'>window.location.href='../Login.aspx';</script>");
            }

            // 填充基础数据
            FrmUtil.FillCodes(Page);
        }

        protected void Page_Error(object sender, EventArgs e)
        {
            // 通用异常处理，转到异常页面
            Exception ex = Server.GetLastError();
            FrmUtil.GotoErrorPage(this, ex);
        }
    }
}
