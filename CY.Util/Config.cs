using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Collections;

namespace CY.Util
{
    public class Config
    {
        private XmlDocument doc;
        private XmlNode node;

        public Config()
        {
            doc = new XmlDocument();
        }

        /// <summary>加载配置文件</summary>
        /// <param name="path">物理路径</param>
        /// <returns>Config</returns>
        public static Config Load(string path)
        {
            Config cfg = new Config();
            cfg.doc.Load(path);
            return cfg;
        }

        /// <summary>默认加载当前路径下的Config.xml文件</summary>
        /// <returns>Config</returns>
        public static Config Load()
        {
            Config cfg = new Config();
            cfg.doc.Load(System.AppDomain.CurrentDomain.BaseDirectory + "\\Config.xml");
            return cfg;
        }

        /// <summary>定位到节点</summary>
        /// <param name="nodeName"></param>
        /// <returns></returns>
        public bool Locate(string nodeName)
        {
            node = getNode(doc.ChildNodes, nodeName);
            return node != null;
        }

        /// <summary>获取当前节点的属性值</summary>
        /// <param name="attrName">属性名</param>
        /// <returns>string</returns>
        public string getAttributeValue(string attrName)
        {
            if (null != node)
            {
                XmlElement xe = node as XmlElement;
                if (xe.HasAttribute(attrName))
                    return xe.GetAttribute(attrName).ToString();
            }
            return null;
        }

        private XmlNode getNode(XmlNodeList nList, string nodeName)
        {
            foreach (XmlNode n in nList)
            {
                if (n.Name.Equals(nodeName))
                    return n;
                else
                {
                    XmlNode rtn = getNode(n.ChildNodes, nodeName);
                    if (null != rtn)
                        return rtn;
                }
            }
            return null;
        }
    }
}
