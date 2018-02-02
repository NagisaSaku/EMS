using System;
using System.Data;
using System.Collections;
using System.Web.UI;
using CY.EMS.Data;
using CY.Base.DB;
using System.Text;
using System.Security.Cryptography;

namespace CY.EMS.Form
{
    public class FrmUtil
    {
        #region 异常处理
        private static string ErrorPage = "~/SystemManage/AllErrorHelp.aspx";

        /// <summary>转到错误页面</summary>
        /// <param name="owner">FrmBase</param>
        /// <param name="message">string</param>
        public static void GotoErrorPage(FrmBase owner, string message)
        {
            owner.getParameters().add("Message", message);
            owner.Server.Transfer(ErrorPage);
        }

        /// <summary>转到错误页面</summary>
        /// <param name="owner">FrmBase</param>
        /// <param name="ex">Exception</param>
        public static void GotoErrorPage(FrmBase owner, Exception ex)
        {
            owner.getParameters().add("Message", ex.Message);
            owner.getParameters().add("ExStackTrace", ex.StackTrace);
            owner.Server.Transfer(ErrorPage);
        }
        #endregion

        #region 页面数据填充和收集
        /// <summary>
        /// 页面加载时，填充下拉控件的选项
        /// 基础数据ID：ASPxComboBox通过ValueField获取
        /// </summary>
        /// <param name="parent">父控件</param>
        public static void FillCodes(Control parent)
        {
            foreach (Control c in parent.Controls)
            {
                if (c is ASPxComboBox)
                {
                    ASPxComboBox cbx = (ASPxComboBox)c;
                    if (!string.IsNullOrEmpty(cbx.ValueField))
                    {
                        cbx.Items.Clear();

                        IDao dao = DaoFactory.GetDao("DaoCommon");
                        dao.Params["CodeId"] = cbx.ValueField;
                        DataTable dt = dao.Select();
                        if (null != dt && dt.Rows.Count > 0)
                        {
                            foreach (DataRow r in dt.Rows)
                                cbx.Items.Add(r["Name"].ToString(), r["Code"].ToString());
                        }
                    }
                }
                else if (c.Controls.Count > 0)
                    FillCodes(c);
            }
        }

        /// <summary>
        /// 填充下拉控件基础数据
        /// </summary>
        /// <param name="ctl">下拉控件</param>
        /// <param name="custom1">自定义参数1</param>
        public static void FillCodes(ASPxComboBox ctl, string custom1)
        {
            if (!string.IsNullOrEmpty(ctl.ValueField))
            {
                ctl.Items.Clear();

                IDao dao = DaoFactory.GetDao("DaoCommon");
                dao.Params["CodeId"] = ctl.ValueField;
                dao.Params["Custom1"] = custom1;
                DataTable dt = dao.Select();
                if (null != dt && dt.Rows.Count > 0)
                {
                    foreach (DataRow r in dt.Rows)
                        ctl.Items.Add(r["Name"].ToString(), r["Code"].ToString());
                }
            }
        }

        /// <summary>
        /// 填充数据到页面
        /// </summary>
        /// <param name="dt">数据表</param>
        /// <param name="parent">父控件</param>
        public static void FillData(DataTable dt, Control parent)
        {
            DataRow row = dt.Rows[0];
            foreach (Control c in parent.Controls)
            {
                if (!string.IsNullOrEmpty(c.ID) && c.ID.Length > 3)
                {
                    string sfield = c.ID.Substring(3);
                    if (dt.Columns.Contains(sfield))
                    {
                        if (c is ASPxTextBox)
                            (c as ASPxTextBox).Text = row[sfield].ToString();
                        else if (c is ASPxComboBox)
                            (c as ASPxComboBox).Value = row[sfield].ToString();
                        else if (c is ASPxDateEdit)
                        {
                            if (!string.IsNullOrEmpty(row[sfield].ToString()))
                                (c as ASPxDateEdit).Value = Convert.ToDateTime(row[sfield].ToString());
                            else
                                (c as ASPxDateEdit).Value = null;
                        }
                        else if (c is ASPxSpinEdit)
                            (c as ASPxSpinEdit).Value = Convert.ToDecimal(row[sfield].ToString());
                        else if (c is ASPxLabel)
                            (c as ASPxLabel).Text = row[sfield].ToString();
                        else if (c is ASPxCheckBox)
                            (c as ASPxCheckBox).Checked = "Y".Equals(row[sfield].ToString());
                        else if (c is ASPxHyperLink)
                            (c as ASPxHyperLink).Text = row[sfield].ToString();
                        else if (c is ASPxMemo)
                            (c as ASPxMemo).Text = row[sfield].ToString();
                    }
                }

                if (c.Controls.Count > 0)
                    FillData(dt, c);
            }
        }

        /// <summary>
        /// 收集页面数据
        /// 如果Edit控件ReadOnly、非Enabled或者非ClientEnabled，则跳过
        /// </summary>
        /// <param name="parent">父控件</param>
        /// <param name="dt">Hashtable</param>
        public static void GetData(Control parent, IDictionary dt)
        {
            foreach (Control c in parent.Controls)
            {
                if (c is ASPxEdit)
                {
                    ASPxEdit ae = c as ASPxEdit;
                    if (ae.ReadOnly || !ae.Enabled || !ae.ClientEnabled)
                        continue;
                }

                if (c is ASPxTextBox)
                    dt.Add(c.ID.Substring(3), (c as ASPxTextBox).Text);
                else if (c is ASPxComboBox)
                    dt.Add(c.ID.Substring(3), (c as ASPxComboBox).Value);
                else if (c is ASPxDateEdit && null != (c as ASPxDateEdit).Value)
                    dt.Add(c.ID.Substring(3), (c as ASPxDateEdit).Text);
                else if (c is ASPxSpinEdit)
                    dt.Add(c.ID.Substring(3), Convert.ToDecimal((c as ASPxSpinEdit).Value));
                else if (c is ASPxCheckBox)
                    dt.Add(c.ID.Substring(3), (c as ASPxCheckBox).Checked ? "Y" : "N");
                else if (c is ASPxMemo)
                    dt.Add(c.ID.Substring(3), (c as ASPxMemo).Text);
                else
                {
                    if (c is ASPxGridView)
                        continue;
                    if (c.Controls.Count > 0)
                        GetData(c, dt);
                }
            }
        }

        /// <summary>清除界面数据</summary>
        /// <param name="parent"></param>
        public static void ClearData(Control parent)
        {
            foreach (Control c in parent.Controls)
            {
                if (c is ASPxTextBox)
                    (c as ASPxTextBox).Text = "";
                else if (c is ASPxComboBox)
                    (c as ASPxComboBox).Value = null;
                else if (c is ASPxDateEdit)
                    (c as ASPxDateEdit).Value = null;
                else if (c is ASPxSpinEdit)
                    (c as ASPxSpinEdit).Value = 0;
                else if (c is ASPxCheckBox)
                    (c as ASPxCheckBox).Checked = false;
                else if (c.Controls.Count > 0)
                    ClearData(c);
            }
        }

        /// <summary>加载图片</summary>
        /// <param name="type">类型</param>
        /// <param name="code">编码</param>
        /// <param name="img">图片控件</param>
        public static void GetImage(string type, string code, ASPxBinaryImage img)
        {
            IDao dao = DaoFactory.GetDao("DaoBizFile");
            dao.Params["Type"] = type;
            dao.Params["Code"] = code;
            DataTable dt = dao.Select();
            if (null != dt && dt.Rows.Count > 0)
            {
                if (null != dt.Rows[0]["Contents"])
                {
                    byte[] bytes = (byte[])dt.Rows[0]["Contents"];
                    if (null != bytes)
                        img.ContentBytes = bytes;
                }
            }
        }

        /// <summary>在服务器上创建文件夹</summary>
        /// <param name="url">当前路径</param>
        /// <param name="code">文件夹名</param>
        public static void CreateDirectory(string url, string code)
        {
            string UploadDirectory = System.Web.HttpContext.Current.Server.MapPath(url) + "\\" + code;
            System.IO.Directory.CreateDirectory(UploadDirectory);
        }

        /// <summary>将登陆密码转化为MD5码</summary>
        /// <param name="inpit">需转换参数</param>
        public static string CalculateMD5Hash(string input)
        {
            MD5 md5 = System.Security.Cryptography.MD5.Create();
            byte[] inputBytes = System.Text.Encoding.UTF8.GetBytes(input);
            byte[] hash = md5.ComputeHash(inputBytes);

            // step 2, convert byte array to hex string  
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }
            return sb.ToString();
        }

        #endregion
    }
}