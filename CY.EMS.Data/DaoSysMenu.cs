using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using CY.Base.DB;

namespace CY.EMS.Data
{
    public class DaoSysMenu : BaseDao
    {
        public DaoSysMenu()
        {
            _SelectPrc = "P_Sys_Get_Menu";
            _InsertPrc = "P_Sys_Oper_Menu";
            _UpdatePrc = "P_Sys_Oper_Menu";
            _DeletePrc = "P_Sys_Oper_Menu";

            _PKField = "ID";
        }

        /// <summary>读取菜单</summary>
        /// <param name="parentID">父菜单ID</param>
        /// <param name="user">登录用户</param>
        /// <returns>DataTable</returns>
        public DataTable Get_Menu(string parentID, string user)
        {
            _Params["ParentID"] = parentID;
            _Params["Oper"] = user;

            return Select();
        }
    }
}
