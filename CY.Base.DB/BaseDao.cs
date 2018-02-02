using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using CY.Util;
using System.Collections;

namespace CY.Base.DB
{
    public class BaseDao : IDao
    {
        protected string _SelectPrc = "";
        string IDao.SelectPrc
        { set { _SelectPrc = value; } }
        protected string _InsertPrc = "";
        string IDao.InsertPrc
        { set { _InsertPrc = value; } }
        protected string _UpdatePrc = "";
        string IDao.UpdatePrc
        { set { _UpdatePrc = value; } }
        protected string _DeletePrc = "";
        string IDao.DeletePrc
        { set { _DeletePrc = value; } }

        protected string _SelectSQL = "";
        string IDao.SelectSQL
        { set { _SelectSQL = value; } }
        protected string _InsertSQL = "";
        string IDao.InsertSQL
        { set { _InsertSQL = value; } }
        protected string _UpdateSQL = "";
        string IDao.UpdateSQL
        { set { _UpdateSQL = value; } }
        protected string _DeleteSQL = "";
        string IDao.DeleteSQL
        { set { _DeleteSQL = value; } }

        protected string _PKField = "";
        string IDao.PKField
        { set { _PKField = value; } }

        protected Hashtable _Params = new Hashtable();
        Hashtable IDao.Params
        { get { return _Params; } }

        public DataTable SelectByPK(string pk)
        {
            if (string.IsNullOrEmpty(_PKField) || string.IsNullOrEmpty(_SelectPrc))
                return null;

            _Params.Clear();
            _Params.Add(_PKField, pk);
            return Select();
        }

        public DataTable Select()
        {
            if (!string.IsNullOrEmpty(_SelectPrc))
            {
                List<SqlParameter> parms = new List<SqlParameter>();
                foreach (string key in _Params.Keys)
                    parms.Add(DbHelperSQLServer.newSqlParameter("@" + key, _Params[key]));

                DataSet ds = DbHelperSQLServer.Get_DataSet_By_StoredProc(_SelectPrc, parms.ToArray());

                if (null != ds && ds.Tables.Count > 0)
                    return ds.Tables[0];
            }
            else if (!string.IsNullOrEmpty(_SelectSQL))
            {
                DataSet ds;
                if (_Params.Count > 0)
                    ds = DbHelperSQLServer.Get_DataSet_By_Sql(_SelectSQL, _Params);
                else
                    ds = DbHelperSQLServer.Get_DataSet_By_Sql(_SelectSQL);
                if (ds != null && ds.Tables.Count > 0)
                    return ds.Tables[0];
            }
            return null;
        }

        public int Insert(out string msg)
        {
            if (string.IsNullOrEmpty(_InsertPrc))
            {
                msg = null;
                return 0;
            }

            return Oper(_InsertPrc, "insert", out msg);
        }

        public int Update(out string msg)
        {
            if (string.IsNullOrEmpty(_UpdatePrc))
            {
                msg = null;
                return 0;
            }

            return Oper(_UpdatePrc, "update", out msg);
        }

        public int Delete(string pk, out string msg)
        {
            if (string.IsNullOrEmpty(_DeletePrc) || string.IsNullOrEmpty(_PKField))
            {
                msg = null;
                return 0;
            }

            _Params.Add(_PKField, pk);
            return Oper(_DeletePrc, "delete", out msg);
        }

        public int Oper(string proc, string action, out string msg)
        {
            List<SqlParameter> parms = new List<SqlParameter>();
            parms.Add(DbHelperSQLServer.newSqlParameter("@Action", action));

            foreach (string key in _Params.Keys)
                parms.Add(DbHelperSQLServer.newSqlParameter("@" + key, _Params[key]));

            SqlParameter pMsg = DbHelperSQLServer.newSqlParameter("@Msg",
                SqlDbType.VarChar, ParameterDirection.Output);
            parms.Add(pMsg);
            SqlParameter pReturn = DbHelperSQLServer.newSqlParameter("@returnValue",
                SqlDbType.Int, ParameterDirection.ReturnValue);
            parms.Add(pReturn);

            DbHelperSQLServer.Exec_StoredProc_NonQuery(proc, parms.ToArray());
            msg = null == pMsg.Value ? "" : pMsg.Value.ToString();
            return (int)pReturn.Value;
        }
    }
}
