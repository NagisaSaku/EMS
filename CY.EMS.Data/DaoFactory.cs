using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CY.Base.DB;

namespace CY.EMS.Data
{
    public class DaoFactory
    {
        public static string ConnectStr
        { set { DbHelperSQLServer.ConnectStr = value; } }

        public static IDao GetDao(string daoName)
        {
            IDao dao = new BaseDao();

            switch (daoName)
            {
                case "DaoSysCmpInf":
                    dao.SelectPrc = "P_SYS_Get_CmpInf";
                    break;
                case "DaoSysMenu":
                    dao = new DaoSysMenu();
                    break;
                case "DaoSysUser":
                    dao.SelectPrc = "P_Sys_Get_User";
                    dao.InsertPrc = "P_Sys_Oper_User";
                    dao.UpdatePrc = "P_Sys_Oper_User";
                    dao.DeletePrc = "P_Sys_Oper_User";
                    dao.PKField = "UserName";
                    break;
                case "DaoSysPrivilege":
                    dao.SelectPrc = "P_Sys_Get_Privilege";
                    dao.InsertPrc = "P_Sys_Oper_Privilege";
                    break;
                case "DaoBasDept":
                    dao.SelectPrc = "P_Bas_Get_Dept";
                    dao.InsertPrc = "P_Bas_Oper_Dept";
                    dao.UpdatePrc = "P_Bas_Oper_Dept";
                    dao.DeletePrc = "P_Bas_Oper_Dept";
                    dao.PKField = "Code";
                    break;
                case "DaoBasEmployee":
                    dao.SelectPrc = "P_BAS_Get_Employee";
                    dao.InsertPrc = "P_Bas_Oper_Employee";
                    dao.UpdatePrc = "P_Bas_Oper_Employee";
                    dao.DeletePrc = "P_Bas_Oper_Employee";
                    dao.PKField = "Code";
                    break;
                case "DaoCommon":
                    dao.SelectPrc = "P_COM_Get_Codes";
                    break;
                case "DaoBizFile":
                    dao.SelectPrc = "P_Biz_Get_File";
                    dao.InsertPrc = "P_Biz_Oper_File";
                    dao.UpdatePrc = "P_Biz_Oper_File";
                    dao.DeletePrc = "P_Biz_Oper_File";
                    break;
                case "DaoBizContract":
                    dao.SelectPrc = "P_Biz_Get_Contract";
                    dao.InsertPrc = "P_Biz_Oper_Contract";
                    dao.UpdatePrc = "P_Biz_Oper_Contract";
                    dao.DeletePrc = "P_Biz_Oper_Contract";
                    dao.PKField = "Code";
                    break;
                case "DaoBizFamily":
                    dao.SelectPrc = "P_Biz_Get_Family";
                    dao.InsertPrc = "P_Biz_Oper_Family";
                    dao.UpdatePrc = "P_Biz_Oper_Family";
                    dao.DeletePrc = "P_Biz_Oper_Family";
                    dao.PKField = "ID";
                    break;
                case "DaoBizResume":
                    dao.SelectPrc = "P_Biz_Get_Resume";
                    dao.InsertPrc = "P_Biz_Oper_Resume";
                    dao.UpdatePrc = "P_Biz_Oper_Resume";
                    dao.DeletePrc = "P_Biz_Oper_Resume";
                    dao.PKField = "ID";
                    break;
                case "DaoBizPerformance":
                    dao.SelectPrc = "P_Biz_Get_Performance";
                    dao.InsertPrc = "P_Biz_Oper_Performance";
                    dao.UpdatePrc = "P_Biz_Oper_Performance";
                    dao.DeletePrc = "P_Biz_Oper_Performance";
                    dao.PKField = "ID";
                    break;
                case "DaoBizRwdAndPnh":
                    dao.SelectPrc = "P_Biz_Get_RwdAndPnh";
                    dao.InsertPrc = "P_Biz_Oper_RwdAndPnh";
                    dao.UpdatePrc = "P_Biz_Oper_RwdAndPnh";
                    dao.DeletePrc = "P_Biz_Oper_RwdAndPnh";
                    dao.PKField = "ID";
                    break;
                case "DaoBizTraining":
                    dao.SelectPrc = "P_Biz_Get_Training";
                    dao.InsertPrc = "P_Biz_Oper_Training";
                    dao.UpdatePrc = "P_Biz_Oper_Training";
                    dao.DeletePrc = "P_Biz_Oper_Training";
                    dao.PKField = "ID";
                    break;
                case "DaoBizTransfer":
                    dao.SelectPrc = "P_Biz_Get_Transfer";
                    dao.InsertPrc = "P_Biz_Oper_Transfer";
                    dao.UpdatePrc = "P_Biz_Oper_Transfer";
                    dao.DeletePrc = "P_Biz_Oper_Transfer";
                    dao.PKField = "ID";
                    break;
                case "DaoBizLeave":
                    dao.SelectPrc = "P_Biz_Get_Leave";
                    dao.InsertPrc = "P_Biz_Oper_Leave";
                    dao.UpdatePrc = "P_Biz_Oper_Leave";
                    dao.DeletePrc = "P_Biz_Oper_Leave";
                    dao.PKField = "ID";
                    break;

                case "RepDckEmpDate":
                    dao.SelectPrc = "P_Rep_DckEmpDate";
                    break;
            }

            return dao;
        }
    }
}
