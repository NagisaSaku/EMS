using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Mail;
using System.Net;

namespace CY.Util
{
    public class Mail
    {
        private string DefaultHost = "smtp.exmail.qq.com";
        private string DefaultFMAddress = "cywlzx@cywlzx.cn";
        private string DefaultName = "常运物流中心";
        private string DefaultPassword = "cywl0519";
        private string DefaultSubject = "系统邮件";
        private MailMessage MMsg;
        private NetworkCredential NC;

        public Mail()
        {
            MMsg = new MailMessage();
            MMsg.From = new MailAddress(DefaultFMAddress, DefaultName);
            MMsg.Subject = DefaultSubject;
            MMsg.Priority = MailPriority.Normal;
            MMsg.DeliveryNotificationOptions = DeliveryNotificationOptions.OnSuccess;

            NC = new NetworkCredential();
            NC.UserName = DefaultFMAddress;
            NC.Password = DefaultPassword;
        }

        /// <summary>设置发件人</summary>
        /// <param name="fmAddress">发件人邮箱</param>
        /// <param name="fmName">发件人别名</param>
        public void setFrom(string fmAddress, string fmName)
        { MMsg.From = new MailAddress(fmAddress, fmName); }

        /// <summary>添加收件人</summary>
        /// <param name="toAddress">收件人地址</param>
        public void AddTo(string toAddress)
        {
            string[] adds = toAddress.Split(',');
            foreach (string add in adds)
                if (!string.IsNullOrEmpty(add))
                    MMsg.To.Add(add);
        }

        /// <summary>添加抄送人</summary>
        /// <param name="ccAddress">抄送人地址</param>
        public void AddCC(string ccAddress)
        {
            if (!string.IsNullOrEmpty(ccAddress))
                MMsg.CC.Add(ccAddress);
        }

        /// <summary>邮件主题</summary>
        public string Subject
        { set { MMsg.Subject = value; } }

        /// <summary>邮件内容</summary>
        public string Content
        {
            set
            {
                MMsg.Body = value;
                MMsg.BodyEncoding = System.Text.Encoding.UTF8;
                MMsg.IsBodyHtml = true;
            }
        }

        /// <summary>添加附件：文件名UTF8编码不得超过41字节，否则附件无法打开</summary>
        /// <param name="path">附件的物理路径</param>
        public void AddAttchment(string path)
        {
            if (!string.IsNullOrEmpty(path))
            {
                string[] atts = path.Split(',');
                foreach (string att in atts)
                {
                    if (!System.IO.File.Exists(att))
                        throw new Exception("找不到附件：" + att);
                    else
                        MMsg.Attachments.Add(new Attachment(att));
                }
            }
        }

        /// <summary>发送级别</summary>
        public MailPriority Priority
        { set { MMsg.Priority = value; } }

        /// <summary>发送邮件</summary>
        public void Send()
        {
            SmtpClient sc = new SmtpClient();
            sc.UseDefaultCredentials = true;
            sc.DeliveryMethod = SmtpDeliveryMethod.Network;
            sc.Credentials = NC;
            sc.Host = DefaultHost;
            sc.Send(MMsg);

            MMsg.Dispose(); // 发送邮件后释放对象
        }
    }
}
