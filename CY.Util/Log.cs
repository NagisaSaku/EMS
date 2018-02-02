using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CY.Util
{
    public class Log
    {
        public static void WriteLine(string msg)
        {
            string path = GetLogFile();
            if (!string.IsNullOrEmpty(path))
            {
                using (System.IO.StreamWriter sw = new System.IO.StreamWriter(path, true))
                { sw.WriteLine(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss ") + msg); }
            }
        }

        /// <summary>从配置文件读取日志文件路径</summary>
        private static string GetLogFile()
        {
            CY.Util.Config cfg = CY.Util.Config.Load();
            if (cfg.Locate("Log"))
            {
                string path = cfg.getAttributeValue("path");
                if (!System.IO.Directory.Exists(path))
                    System.IO.Directory.CreateDirectory(path);

                if (cfg.getAttributeValue("autoCreateFile").Equals("true"))
                {
                    if (cfg.getAttributeValue("autoCreateBy").Equals("month"))
                    {
                        string fileName = DateTime.Now.ToString("yyyy-MM") + ".txt";
                        return path + "\\" + fileName;
                    }
                }
                else
                    return path + "\\log.txt";
            }
            return null;
        }
    }
}
