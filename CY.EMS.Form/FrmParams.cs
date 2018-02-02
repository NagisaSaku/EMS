using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

namespace CY.EMS.Form
{
    /// <summary>页面参数</summary>
    public class FrmParams
    {
        private Hashtable parms;

        public FrmParams()
        {
            parms = new Hashtable();
        }

        public bool contains(string key)
        {
            return parms.Contains(key);
        }

        public void add(string key, object value)
        {
            parms[key] = value;
        }

        public object get(string key)
        {
            return parms[key];
        }
    }
}
