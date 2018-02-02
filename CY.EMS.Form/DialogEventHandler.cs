using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CY.EMS.Form
{
    /// <summary>
    /// 窗口按钮事件：保存，关闭
    /// </summary>
    public class DialogButtonClickEventArgs : EventArgs
    {
        public string Msg { set; get; }
    }

    public delegate void DialogButtonClickHandler(object sender, DialogButtonClickEventArgs e);

    /// <summary>
    /// 窗口弹出事件
    /// </summary>
    public class DialogShowEventArgs : EventArgs
    {
        public string Action { get; set; }
        public string Id { set; get; }
    }

    public delegate void DialogShowHandler(object sender, DialogShowEventArgs e);
}