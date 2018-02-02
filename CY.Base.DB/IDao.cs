using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.Data;

namespace CY.Base.DB
{
    public interface IDao
    {
        /// <summary>存储过程：查询</summary>
        string SelectPrc { set; }
        /// <summary>存储过程：插入</summary>
        string InsertPrc { set; }
        /// <summary>存储过程：更新</summary>
        string UpdatePrc { set; }
        /// <summary>存储过程：删除</summary>
        string DeletePrc { set; }

        string SelectSQL { set; }
        string InsertSQL { set; }
        string UpdateSQL { set; }
        string DeleteSQL { set; }

        /// <summary>主键</summary>
        string PKField { set; }

        Hashtable Params { get; }

        DataTable SelectByPK(string pk);
        DataTable Select();
        int Insert(out string msg);
        int Update(out string msg);
        int Delete(string pk, out string msg);
        int Oper(string proc, string action, out string msg);
    }
}
