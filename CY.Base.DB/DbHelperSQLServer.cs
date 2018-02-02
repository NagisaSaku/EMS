using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.Common;
using System.Collections.Generic;
using System.Text;

namespace CY.Base.DB
{
    public abstract class DbHelperSQLServer
    {
        public static string ConnectStr;

        static DbHelperSQLServer() // 静态构造函数，仅执行一次
        {
            // 从Config.xml文件加载数据库连接字符串
            if (string.IsNullOrEmpty(ConnectStr))
            {
                try
                {
                    CY.Util.Config cfg = CY.Util.Config.Load();
                    if (cfg.Locate("ConnectionString"))
                        ConnectStr = cfg.getAttributeValue("value");
                }
                catch (Exception ex) { }
            }
        }

        #region 公用方法
        /// 判断是否存在某表的某个字段

        /// <param name="tableName">表名称</param>
        /// <param name="columnName">列名称</param>
        /// <returns>是否存在</returns>
        public static bool ColumnExists(string tableName, string columnName)
        {
            string sql = "select count(1) from syscolumns where [id]=object_id('" + tableName + "') and [name]='" + columnName + "'";
            object res = GetSingle(sql);
            if (res == null)
            {
                return false;
            }
            return Convert.ToInt32(res) > 0;
        }
        public static int GetMaxID(string FieldName, string TableName)
        {
            string SQL_str = "select max(" + FieldName + ")+1 from " + TableName;
            object obj = GetSingle(SQL_str);
            if (obj == null)
            {
                return 1;
            }
            else
            {
                return int.Parse(obj.ToString());
            }
        }
        public static bool Exists(string SQL_str)
        {
            object obj = GetSingle(SQL_str);
            int cmdresult;
            if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
            {
                cmdresult = 0;
            }
            else
            {
                cmdresult = int.Parse(obj.ToString());
            }
            if (cmdresult == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        /// 表是否存在

        /// <param name="TableName"></param>
        /// <returns></returns>
        public static bool TabExists(string TableName)
        {
            string SQL_str = "select count(*) from sysobjects where id = object_id(N'[" + TableName + "]') and OBJECTPROPERTY(id, N'IsUserTable') = 1";
            //string SQL_str = "SELECT count(*) FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[" + TableName + "]') AND type in (N'U')";
            object obj = GetSingle(SQL_str);
            int cmdresult;
            if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
            {
                cmdresult = 0;
            }
            else
            {
                cmdresult = int.Parse(obj.ToString());
            }
            if (cmdresult == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        public static bool Exists(string SQL_str, params SqlParameter[] cmdParms)
        {
            object obj = GetSingle(SQL_str, cmdParms);
            int cmdresult;
            if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
            {
                cmdresult = 0;
            }
            else
            {
                cmdresult = int.Parse(obj.ToString());
            }
            if (cmdresult == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        public static SqlParameter newSqlParameter(string name, object value)
        {
            if (null == value)
                return new SqlParameter(name, "");
            if (value is string)
            {
                SqlParameter p = new SqlParameter(name, SqlDbType.VarChar, (value as string).Length);
                p.Value = value;
                return p;
            }
            else if (value is byte[])
            {
                SqlParameter p = new SqlParameter(name, SqlDbType.Image);
                p.Value = value;
                return p;
            }

            return new SqlParameter(name, value);
        }

        public static SqlParameter newSqlParameter(string name, SqlDbType type, ParameterDirection pd)
        {
            SqlParameter rtn = new SqlParameter();
            rtn.ParameterName = name;
            rtn.SqlDbType = type;
            if (type == SqlDbType.VarChar)
                rtn.Size = 100;
            rtn.Direction = pd;
            return rtn;
        }
        #endregion

        #region  执行简单SQL语句


        /// 执行SQL语句，返回影响的记录数

        /// <param name="SQL_str">SQL语句</param>
        /// <returns>影响的记录数</returns>
        public static int ExecuteSql(string SQL_str)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                using (SqlCommand cmd = new SqlCommand(SQL_str, connection))
                {
                    try
                    {
                        connection.Open();
                        int rows = cmd.ExecuteNonQuery();
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        connection.Close();
                        throw e;
                    }
                }
            }
        }

        public static int ExecuteSqlByTime(string SQL_str, int Times)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                using (SqlCommand cmd = new SqlCommand(SQL_str, connection))
                {
                    try
                    {
                        connection.Open();
                        cmd.CommandTimeout = Times;
                        int rows = cmd.ExecuteNonQuery();
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        connection.Close();
                        throw e;
                    }
                }
            }
        }

        /// 执行多条SQL语句，实现数据库事务。

        /// <param name="SQL_strList">多条SQL语句</param>		
        public static int ExecuteSqlTran(List<String> SQL_strList)
        {
            using (SqlConnection conn = new SqlConnection(ConnectStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                SqlTransaction tx = conn.BeginTransaction();
                cmd.Transaction = tx;
                try
                {
                    int count = 0;
                    for (int n = 0; n < SQL_strList.Count; n++)
                    {
                        string SQL_str = SQL_strList[n];
                        if (SQL_str.Trim().Length > 1)
                        {
                            cmd.CommandText = SQL_str;
                            count += cmd.ExecuteNonQuery();
                        }
                    }
                    tx.Commit();
                    return count;
                }
                catch
                {
                    tx.Rollback();
                    return 0;
                }
            }
        }

        /// 执行带一个存储过程参数的的SQL语句。

        /// <param name="SQL_str">SQL语句</param>
        /// <param name="content">参数内容,比如一个字段是格式复杂的文章，有特殊符号，可以通过这个方式添加</param>
        /// <returns>影响的记录数</returns>
        public static int ExecuteSql(string SQL_str, string content)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                SqlCommand cmd = new SqlCommand(SQL_str, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter("@content", SqlDbType.NText);
                myParameter.Value = content;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    throw e;
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }

        /// 执行带一个存储过程参数的的SQL语句。

        /// <param name="SQL_str">SQL语句</param>
        /// <param name="content">参数内容,比如一个字段是格式复杂的文章，有特殊符号，可以通过这个方式添加</param>
        /// <returns>影响的记录数</returns>
        public static object ExecuteSqlGet(string SQL_str, string content)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                SqlCommand cmd = new SqlCommand(SQL_str, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter("@content", SqlDbType.NText);
                myParameter.Value = content;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    object obj = cmd.ExecuteScalar();
                    if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                    {
                        return null;
                    }
                    else
                    {
                        return obj;
                    }
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    throw e;
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }

        /// 向数据库里插入图像格式的字段(和上面情况类似的另一种实例)

        /// <param name="SQL_str">SQL语句</param>
        /// <param name="fs">图像字节,数据库的字段类型为image的情况</param>
        /// <returns>影响的记录数</returns>
        public static int ExecuteSqlInsertImg(string SQL_str, byte[] fs)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                SqlCommand cmd = new SqlCommand(SQL_str, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter("@fs", SqlDbType.Image);
                myParameter.Value = fs;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    throw e;
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }


        /// 执行一条计算查询结果语句，返回查询结果（object）。

        /// <param name="SQL_str">计算查询结果语句</param>
        /// <returns>查询结果（object）</returns>
        public static object GetSingle(string SQL_str)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                using (SqlCommand cmd = new SqlCommand(SQL_str, connection))
                {
                    try
                    {
                        connection.Open();
                        object obj = cmd.ExecuteScalar();
                        if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                        {
                            return null;
                        }
                        else
                        {
                            return obj;
                        }
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        connection.Close();
                        throw e;
                    }
                }
            }
        }
        public static object GetSingle(string SQL_str, int Times)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                using (SqlCommand cmd = new SqlCommand(SQL_str, connection))
                {
                    try
                    {
                        connection.Open();
                        cmd.CommandTimeout = Times;
                        object obj = cmd.ExecuteScalar();
                        if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                        {
                            return null;
                        }
                        else
                        {
                            return obj;
                        }
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        connection.Close();
                        throw e;
                    }
                }
            }
        }

        /// 执行查询语句，返回SqlDataReader ( 注意：调用该方法后，一定要对SqlDataReader进行Close )

        /// <param name="SQL_str">查询语句</param>
        /// <returns>SqlDataReader</returns>
        public static SqlDataReader ExecuteReader(string SQL_str)
        {
            SqlConnection connection = new SqlConnection(ConnectStr);
            SqlCommand cmd = new SqlCommand(SQL_str, connection);
            try
            {
                connection.Open();
                SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                return myReader;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                throw e;
            }

        }

        /// 执行查询语句，返回DataSet

        /// <param name="SQL_str">查询语句</param>
        /// <returns>DataSet</returns>
        public static DataSet Query(string SQL_str)
        {

            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(SQL_str, connection);
                    command.Fill(ds, "ds");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                return ds;
            }

        }
        public static DataSet Query(string SQL_str, int Times)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter command = new SqlDataAdapter(SQL_str, connection);
                    command.SelectCommand.CommandTimeout = Times;
                    command.Fill(ds, "ds");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                return ds;
            }
        }



        #endregion

        #region 执行带参数的SQL语句


        /// 执行SQL语句，返回影响的记录数

        /// <param name="SQL_str">SQL语句</param>
        /// <returns>影响的记录数</returns>
        public static int ExecuteSql(string SQL_str, params SqlParameter[] cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        PrepareCommand(cmd, connection, null, SQL_str, cmdParms);
                        int rows = cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        throw e;
                    }
                }
            }
        }

        /// 执行多条SQL语句，实现数据库事务。

        /// <param name="SQL_strList">SQL语句的哈希表（key为sql语句，value是该语句的SqlParameter[]）</param>
        public static void ExecuteSqlTran(Hashtable SQL_strList)
        {
            using (SqlConnection conn = new SqlConnection(ConnectStr))
            {
                conn.Open();
                using (SqlTransaction trans = conn.BeginTransaction())
                {
                    SqlCommand cmd = new SqlCommand();
                    try
                    {
                        //循环
                        foreach (DictionaryEntry myDE in SQL_strList)
                        {
                            string cmdText = myDE.Key.ToString();
                            SqlParameter[] cmdParms = (SqlParameter[])myDE.Value;
                            PrepareCommand(cmd, conn, trans, cmdText, cmdParms);
                            int val = cmd.ExecuteNonQuery();
                            cmd.Parameters.Clear();
                        }
                        trans.Commit();
                    }
                    catch
                    {
                        trans.Rollback();
                        throw;
                    }
                }
            }
        }





        /// 执行多条SQL语句，实现数据库事务。

        /// <param name="SQL_strList">SQL语句的哈希表（key为sql语句，value是该语句的SqlParameter[]）</param>
        public static void ExecuteSqlTranWithIndentity(Hashtable SQL_strList)
        {
            using (SqlConnection conn = new SqlConnection(ConnectStr))
            {
                conn.Open();
                using (SqlTransaction trans = conn.BeginTransaction())
                {
                    SqlCommand cmd = new SqlCommand();
                    try
                    {
                        int indentity = 0;
                        //循环
                        foreach (DictionaryEntry myDE in SQL_strList)
                        {
                            string cmdText = myDE.Key.ToString();
                            SqlParameter[] cmdParms = (SqlParameter[])myDE.Value;
                            foreach (SqlParameter q in cmdParms)
                            {
                                if (q.Direction == ParameterDirection.InputOutput)
                                {
                                    q.Value = indentity;
                                }
                            }
                            PrepareCommand(cmd, conn, trans, cmdText, cmdParms);
                            int val = cmd.ExecuteNonQuery();
                            foreach (SqlParameter q in cmdParms)
                            {
                                if (q.Direction == ParameterDirection.Output)
                                {
                                    indentity = Convert.ToInt32(q.Value);
                                }
                            }
                            cmd.Parameters.Clear();
                        }
                        trans.Commit();
                    }
                    catch
                    {
                        trans.Rollback();
                        throw;
                    }
                }
            }
        }

        /// 执行一条计算查询结果语句，返回查询结果（object）。

        /// <param name="SQL_str">计算查询结果语句</param>
        /// <returns>查询结果（object）</returns>
        public static object GetSingle(string SQL_str, params SqlParameter[] cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        PrepareCommand(cmd, connection, null, SQL_str, cmdParms);
                        object obj = cmd.ExecuteScalar();
                        cmd.Parameters.Clear();
                        if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                        {
                            return null;
                        }
                        else
                        {
                            return obj;
                        }
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        throw e;
                    }
                }
            }
        }


        /// 执行查询语句，返回SqlDataReader ( 注意：调用该方法后，一定要对SqlDataReader进行Close )

        /// <param name="SQL_str">查询语句</param>
        /// <returns>SqlDataReader</returns>
        public static SqlDataReader ExecuteReader(string SQL_str, params SqlParameter[] cmdParms)
        {
            SqlConnection connection = new SqlConnection(ConnectStr);
            SqlCommand cmd = new SqlCommand();
            try
            {
                PrepareCommand(cmd, connection, null, SQL_str, cmdParms);
                SqlDataReader myReader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
                return myReader;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                throw e;
            }
            //			finally
            //			{
            //				cmd.Dispose();
            //				connection.Close();
            //			}	

        }


        /// 执行查询语句，返回DataSet

        /// <param name="SQL_str">查询语句</param>
        /// <returns>DataSet</returns>
        public static DataSet Query(string SQL_str, params SqlParameter[] cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                SqlCommand cmd = new SqlCommand();
                PrepareCommand(cmd, connection, null, SQL_str, cmdParms);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataSet ds = new DataSet();
                    try
                    {
                        da.Fill(ds, "ds");
                        cmd.Parameters.Clear();
                    }
                    catch (System.Data.SqlClient.SqlException ex)
                    {
                        throw new Exception(ex.Message);
                    }
                    return ds;
                }
            }

        }


        private static void PrepareCommand(SqlCommand cmd, SqlConnection conn, SqlTransaction trans, string cmdText, SqlParameter[] cmdParms)
        {
            if (conn.State != ConnectionState.Open)
                conn.Open();
            cmd.Connection = conn;
            cmd.CommandText = cmdText;
            if (trans != null)
                cmd.Transaction = trans;
            cmd.CommandType = CommandType.Text;//cmdType;
            if (cmdParms != null)
            {


                foreach (SqlParameter parameter in cmdParms)
                {
                    if ((parameter.Direction == ParameterDirection.InputOutput || parameter.Direction == ParameterDirection.Input) &&
                        (parameter.Value == null))
                    {
                        parameter.Value = DBNull.Value;
                    }
                    cmd.Parameters.Add(parameter);
                }
            }
        }

        #endregion

        #region 存储过程操作


        /// 执行存储过程，返回SqlDataReader ( 注意：调用该方法后，一定要对SqlDataReader进行Close )

        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <returns>SqlDataReader</returns>
        public static SqlDataReader RunProcedure(string storedProcName, IDataParameter[] parameters)
        {
            SqlConnection connection = new SqlConnection(ConnectStr);
            SqlDataReader returnReader;
            connection.Open();
            SqlCommand command = BuildQueryCommand(connection, storedProcName, parameters);
            command.CommandType = CommandType.StoredProcedure;
            returnReader = command.ExecuteReader(CommandBehavior.CloseConnection);
            return returnReader;

        }



        /// 执行存储过程

        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <param name="tableName">DataSet结果中的表名</param>
        /// <returns>DataSet</returns>
        public static DataSet RunProcedure(string storedProcName, IDataParameter[] parameters, string tableName)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                DataSet dataSet = new DataSet();
                connection.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter();
                sqlDA.SelectCommand = BuildQueryCommand(connection, storedProcName, parameters);
                sqlDA.Fill(dataSet, tableName);
                connection.Close();
                return dataSet;
            }
        }
        public static DataSet RunProcedure(string storedProcName, IDataParameter[] parameters, string tableName, int Times)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                DataSet dataSet = new DataSet();
                connection.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter();
                sqlDA.SelectCommand = BuildQueryCommand(connection, storedProcName, parameters);
                sqlDA.SelectCommand.CommandTimeout = Times;
                sqlDA.Fill(dataSet, tableName);
                connection.Close();
                return dataSet;
            }
        }



        /// 构建 SqlCommand 对象(用来返回一个结果集，而不是一个整数值)

        /// <param name="connection">数据库连接</param>
        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <returns>SqlCommand</returns>
        private static SqlCommand BuildQueryCommand(SqlConnection connection, string storedProcName, IDataParameter[] parameters)
        {
            SqlCommand command = new SqlCommand(storedProcName, connection);
            command.CommandType = CommandType.StoredProcedure;
            foreach (SqlParameter parameter in parameters)
            {
                if (parameter != null)
                {
                    // 检查未分配值的输出参数,将其分配以DBNull.Value.
                    if ((parameter.Direction == ParameterDirection.InputOutput || parameter.Direction == ParameterDirection.Input) &&
                        (parameter.Value == null))
                    {
                        parameter.Value = DBNull.Value;
                    }
                    command.Parameters.Add(parameter);
                }
            }

            return command;
        }


        /// 执行存储过程，返回影响的行数		

        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <param name="rowsAffected">影响的行数</param>
        /// <returns></returns>
        public static int RunProcedure(string storedProcName, IDataParameter[] parameters, out int rowsAffected)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                int result;
                connection.Open();
                SqlCommand command = BuildIntCommand(connection, storedProcName, parameters);
                rowsAffected = command.ExecuteNonQuery();
                result = (int)command.Parameters["ReturnValue"].Value;
                //Connection.Close();
                return result;
            }
        }


        /// 创建 SqlCommand 对象实例(用来返回一个整数值)	

        /// <param name="storedProcName">存储过程名</param>
        /// <param name="parameters">存储过程参数</param>
        /// <returns>SqlCommand 对象实例</returns>
        private static SqlCommand BuildIntCommand(SqlConnection connection, string storedProcName, IDataParameter[] parameters)
        {
            SqlCommand command = BuildQueryCommand(connection, storedProcName, parameters);
            command.Parameters.Add(new SqlParameter("ReturnValue",
                SqlDbType.Int, 4, ParameterDirection.ReturnValue,
                false, 0, 0, string.Empty, DataRowVersion.Default, null));
            return command;
        }
        #endregion

        #region 吴建胜

        #region 数据库

        /// 执行带参数SQL语句的公共函数
        private static void Prepare_Command(SqlCommand cmd, SqlConnection conn, SqlTransaction trans, string cmdText, SqlParameter[] cmdParms)
        {
            if (conn.State != ConnectionState.Open)
                conn.Open();
            cmd.Connection = conn;
            cmd.CommandText = cmdText;
            if (trans != null)
                cmd.Transaction = trans;
            cmd.CommandType = CommandType.Text;//cmdType;
            if (cmdParms != null)
            {
                foreach (SqlParameter parameter in cmdParms)
                {
                    if ((parameter.Direction == ParameterDirection.InputOutput || parameter.Direction == ParameterDirection.Input) &&
                        (parameter.Value == null))
                    {
                        parameter.Value = DBNull.Value;
                    }
                    cmd.Parameters.Add(parameter);
                }
            }
        }

        /// 执行查询语句，返回SqlDataReader
        //public static SqlDataReader Exe_Sql_Query_Reader(string SQL_str)
        public static SqlDataReader Get_DataReader_By_Sql(string SQL_str)
        {
            SqlConnection connection = new SqlConnection(ConnectStr);

            SqlCommand cmd = new SqlCommand(SQL_str, connection);
            SqlDataReader myReader;
            try
            {
                connection.Open();
                myReader = cmd.ExecuteReader();
                return myReader;
            }
            catch (System.Data.SqlClient.SqlException e)
            {
                cmd.Dispose();
                connection.Close();
                throw new Exception(e.Message);
            }
            finally
            {
                //cmd.Dispose();
                //connection.Close();
            }

        }

        /// 执行查询语句，返回DataSet
        //public static DataSet Exe_Sql_Query_DataSet(string SQL_str)
        public static DataSet Get_DataSet_By_Sql(string SQL_str)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter da = new SqlDataAdapter(SQL_str, connection);
                    da.Fill(ds, "DataSet");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                finally
                {
                    connection.Close();
                }
                return ds;
            }
        }

        public static DataSet Get_DataSet_By_Sql(string SQL_str, Hashtable parameters)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                DataSet ds = new DataSet();
                try
                {
                    connection.Open();
                    SqlDataAdapter da = new SqlDataAdapter(Build_SqlCommand(connection, CommandType.Text, SQL_str, parameters));
                    da.Fill(ds, "DataSet");
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                finally
                {
                    connection.Close();
                }
                return ds;
            }
        }

        /// 执行一条操作型SQL语句，成功返回影响的记录数,失败返回错误信息 
        public static int Exec_Sql_Command(string SQL_str)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                using (SqlCommand cmd = new SqlCommand(SQL_str, connection))
                {
                    try
                    {
                        connection.Open();
                        int rows = cmd.ExecuteNonQuery();
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException E)
                    {
                        connection.Close();
                        throw new Exception(E.Message);

                    }
                }
            }
        }

        /// 执行一条操作型SQL语句（用参数形式），成功返回影响的记录数,失败返回错误信息 
        public static int Exec_Sql_Command(string SQL_str, params SqlParameter[] cmdParms)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    try
                    {
                        Prepare_Command(cmd, connection, null, SQL_str, cmdParms);
                        int rows = cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        return rows;
                    }
                    catch (System.Data.SqlClient.SqlException E)
                    {
                        throw new Exception(E.Message);
                    }
                }
            }
        }

        public static int Exec_Sql_Command(string SQL_str, Hashtable parameters)
        {

            using (SqlConnection Conn = new SqlConnection(ConnectStr))
            {
                Conn.Open();
                try
                {
                    SqlCommand cmd = Build_SqlCommand(Conn, CommandType.Text, SQL_str, parameters);
                    cmd.CommandType = CommandType.Text;
                    int rows = cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                    Conn.Close();
                    return rows;

                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    Conn.Close();
                    throw new Exception(E.Message);
                }



            }
        }
        /// 执行多条SQL语句，实现数据库事务，每条语句以“;”分割。
        public static void Execc_Sql_Commands_Use_Tran(string SQL_strList)
        {
            using (SqlConnection conn = new SqlConnection(ConnectStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                SqlTransaction tx = conn.BeginTransaction();
                cmd.Transaction = tx;
                try
                {
                    string[] split = SQL_strList.Split(new Char[] { ';' });
                    foreach (string SQL_str in split)
                    {
                        if (SQL_str.Trim() != "")
                        {
                            cmd.CommandText = SQL_str;
                            cmd.ExecuteNonQuery();
                        }
                    }
                    tx.Commit();
                }
                catch (System.Data.DataException E)
                {
                    tx.Rollback();
                    throw new Exception(E.Message);
                }
            }
        }

        /// 执行带一个参数的的SQL语句。parameter_name为参数名，带@前缀，比如一个字段是格式复杂的文章，有特殊符号，可以通过这个方式添加
        public static int Exec_Sql_Command_One_Parameter(string SQL_str, string parameter_name, string parameter_value)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                SqlCommand cmd = new SqlCommand(SQL_str, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter(parameter_name, SqlDbType.NText);
                myParameter.Value = parameter_value;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    throw new Exception(E.Message);
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }

        /// 向数据库里插入和修改图像等Blob字段的内容。parameter_name为参数名，带@前缀
        public static int Exec_Sql_Command_Blob_Field(string SQL_str, byte[] fs, string parameter_name)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                SqlCommand cmd = new SqlCommand(SQL_str, connection);
                System.Data.SqlClient.SqlParameter myParameter = new System.Data.SqlClient.SqlParameter(parameter_name, SqlDbType.Image);
                myParameter.Value = fs;
                cmd.Parameters.Add(myParameter);
                try
                {
                    connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    throw new Exception(E.Message);
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }

            }
        }

        /// 执行一条查询语句，返回记录数（整数）。
        public static int Get_Query_Row_Count(string SQL_str)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                SqlCommand cmd = new SqlCommand(SQL_str, connection);
                try
                {
                    connection.Open();
                    SqlDataReader result = cmd.ExecuteReader();
                    int i = 0;
                    while (result.Read())
                    {
                        i = result.GetInt32(0);
                    }
                    result.Close();
                    return i;
                }
                catch (System.Data.SqlClient.SqlException e)
                {
                    throw new Exception(e.Message);
                }
                finally
                {
                    cmd.Dispose();
                    connection.Close();
                }
            }
        }

        /// 执行一条查询语句，返回第一行第一列的值（object）。
        public static String Get_First_Field_First_Value(string SQL_str)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                using (SqlCommand cmd = new SqlCommand(SQL_str, connection))
                {
                    try
                    {
                        connection.Open();
                        object obj = cmd.ExecuteScalar();
                        if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
                        {
                            return "";
                        }
                        else
                        {
                            return obj.ToString();
                        }
                    }
                    catch (System.Data.SqlClient.SqlException e)
                    {
                        connection.Close();
                        throw e;
                    }
                }
            }
        }

        public static int Get_Max_ID_Int(string Field_Name, string Table_Name)
        {
            string SQL_str = "select max(" + Field_Name + ") from " + Table_Name;
            string max_value = Get_First_Field_First_Value(SQL_str);
            if (max_value == "")
            {
                return 1;
            }
            else
            {
                return int.Parse(max_value);
            }
        }

        public static string Get_Max_ID_String(string Field_Name, string Table_Name)
        {
            string SQL_str = "select max(" + Field_Name + ") from " + Table_Name;
            string max_value = Get_First_Field_First_Value(SQL_str);
            return max_value;
        }


        public static string Get_New_Bill_Number_String_Format_Is_yyyymmdd0001(string Field_Name, string Table_Name, int number_digit)
        {
            string bill_number_max_str, bill_number_new_str;
            Int32 bill_number_max_int;
            bill_number_max_str = Get_Max_ID_String(Field_Name, Table_Name);
            if (bill_number_max_str != "")
                bill_number_max_int = int.Parse(bill_number_max_str.Substring(bill_number_max_str.Length - number_digit));
            else
                bill_number_max_int = 0;
            bill_number_max_int = bill_number_max_int + 1;
            bill_number_new_str = bill_number_max_int.ToString();
            bill_number_new_str = bill_number_new_str.PadLeft(number_digit, '0');

            DateTime database_time = Get_Server_DateTime();
            bill_number_new_str = database_time.ToString("yyyyMMdd") + bill_number_new_str;

            return bill_number_new_str;
        }

        ///获取服务器上的当前时间，返回日期型
        public static DateTime Get_Server_DateTime()
        {
            string SQL_str = "SELECT  getdate() as now_time";
            object obj = Get_First_Field_First_Value(SQL_str);
            if (obj == null)
            {
                return DateTime.Now;
            }
            else
            {

                return DateTime.Parse(obj.ToString());
            }
        }


        ///获取服务器上的当前时间，返回日期型
        public static string Get_Server_DateTime_Str(bool include_time)
        {
            DateTime database_time = Get_Server_DateTime();
            if (include_time)
            {
                return database_time.ToString("yyyy-MM-dd  HH:mm:ss");
            }
            else
            {

                return database_time.ToString("yyyy-MM-dd");
            }
        }

        ///获取服务器上几天前的日期
        public static DateTime Get_Server_Date_Before_Str(int before_date_count)
        {
            DateTime database_time = Get_Server_DateTime();
            database_time = database_time.AddDays(-before_date_count);
            return database_time;
        }

        /// 表是否存在
        public static bool Check_Table_Exist(string Table_Name)
        {
            string SQL_str = "select count(*) from sysobjects where id = object_id(N'[" + Table_Name + "]') and OBJECTPROPERTY(id, N'IsUserTable') = 1";
            //string SQL_str = "SELECT count(*) FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[" + TableName + "]') AND type in (N'U')";
            object obj = Get_First_Field_First_Value(SQL_str);
            int cmdresult;
            if ((Object.Equals(obj, null)) || (Object.Equals(obj, System.DBNull.Value)))
            {
                cmdresult = 0;
            }
            else
            {
                cmdresult = int.Parse(obj.ToString());
            }
            if (cmdresult == 0)
                return false;
            else
                return true;
        }

        /// 判断是否存在某表的某个字段
        public static bool Check_Field_Exist(string Table_Name, string Field_Name)
        {
            string sql = "select count(1) from syscolumns where [id]=object_id('" + Table_Name + "') and [name]='" + Field_Name + "'";
            object res = Get_First_Field_First_Value(sql);
            if (res == null)
            {
                return false;
            }
            return Convert.ToInt32(res) > 0;
        }


        #region 存储过程操作
        private static SqlCommand Build_SqlCommand(SqlConnection connection, string storedProcName, IDataParameter[] parameters)
        {
            SqlCommand command = new SqlCommand(storedProcName, connection);
            command.CommandType = CommandType.StoredProcedure;
            foreach (SqlParameter parameter in parameters)
            {
                command.Parameters.Add(parameter);
            }
            return command;
        }

        private static SqlCommand Build_SqlCommand(SqlConnection connection, CommandType cmdType, string storedProcName, Hashtable parameters)
        {
            SqlCommand command = new SqlCommand(storedProcName, connection);
            switch (cmdType)
            {
                case CommandType.Text:
                    {
                        command.CommandType = CommandType.Text;

                        foreach (DictionaryEntry dteyParameter in parameters)
                        {
                            SqlParameter parameter;
                            if ((dteyParameter.Value == null) || (dteyParameter.Value.ToString() == ""))
                            {
                                parameter = new SqlParameter(dteyParameter.Key.ToString(), DBNull.Value);
                            }
                            else
                            {
                                parameter = new SqlParameter(dteyParameter.Key.ToString(), dteyParameter.Value);
                            }
                            command.Parameters.Add(parameter);
                        }

                        break;
                    }
                case CommandType.StoredProcedure:
                    {
                        Hashtable hbParams = new Hashtable();
                        foreach (DictionaryEntry deParameter in parameters)
                        {
                            hbParams.Add(deParameter.Key.ToString().ToLower(), deParameter.Value);
                        }
                        command.CommandType = CommandType.StoredProcedure;
                        SqlCommandBuilder.DeriveParameters(command);
                        foreach (SqlParameter parameter in command.Parameters)
                        {
                            if (hbParams.Contains(parameter.ParameterName.ToLower()))
                            {
                                command.Parameters[parameter.ParameterName].Value = hbParams[parameter.ParameterName.ToLower()];
                            }
                        }
                        /*
                      foreach (DictionaryEntry dteyParameter in hhtbParameters)
                      {
                          SqlParameter parameter = new SqlParameter(dteyParameter.Key.ToString(), dteyParameter.Value);
                          command.Parameters.Add(parameter);
                      }
                       * */
                        break;
                    }
            }

            return command;
        }

        private static SqlCommand Build_SqlCommand2(SqlConnection connection, string storedProcName, SqlParameterCollection parameters)
        {
            SqlCommand command = new SqlCommand(storedProcName, connection);
            command.CommandType = CommandType.StoredProcedure;

            foreach (SqlParameter parameter in parameters)
            {
                if (!parameter.ParameterName.Equals("@RETURN_VALUE"))
                {
                    SqlParameter param = new SqlParameter(parameter.ParameterName, parameter.Value);
                    command.Parameters.Add(param);
                }
            }
            return command;
        }

        //public static DataSet Get_DataSet_By_StoredProc(string storedProcName, IDataParameter[] parameters, string tableName)
        //public static DataSet Get_DataSet_By_StoredProc(string storedProcName, SqlParameterCollection parameters)
        public static DataSet Get_DataSet_By_StoredProc(string storedProcName, IDataParameter[] parameters)
        {
            using (SqlConnection connection = new SqlConnection(ConnectStr))
            {
                DataSet ds = new DataSet();
                connection.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter();
                sqlDA.SelectCommand = Build_SqlCommand(connection, storedProcName, parameters);
                //sqlDA.Fill(dataSet, tableName);
                sqlDA.Fill(ds, "DataSet");
                connection.Close();

                return ds;
            }
        }

        public static DataSet Get_DataSet_By_StoredProc(string storedProcName, Hashtable parameters)
        {
            using (SqlConnection Conn = new SqlConnection(ConnectStr))
            {
                DataSet ds = new DataSet();
                Conn.Open();

                SqlCommand SqlCmd = Build_SqlCommand(Conn, CommandType.StoredProcedure, storedProcName, parameters);
                SqlCmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter sqlDA = new SqlDataAdapter();
                sqlDA.SelectCommand = SqlCmd;
                sqlDA.Fill(ds, "DataSet");

                parameters.Clear();
                foreach (SqlParameter parameter in SqlCmd.Parameters)
                {
                    if ((parameter.Direction == ParameterDirection.Output) || (parameter.Direction == ParameterDirection.InputOutput) || (parameter.Direction == ParameterDirection.ReturnValue))
                    {
                        parameters.Add(parameter.ParameterName, parameter.Value);
                    }
                }

                Conn.Close();

                return ds;
            }
        }


        //public static Boolean Exec_StoredProc_NonQuery(string storedProcName, SqlParameterCollection parameters)
        public static Boolean Exec_StoredProc_NonQuery(string storedProcName, IDataParameter[] parameters)
        {
            using (SqlConnection Conn = new SqlConnection(ConnectStr))
            {
                Conn.Open();
                SqlCommand SqlCmd = Build_SqlCommand(Conn, storedProcName, parameters);
                SqlCmd.CommandType = CommandType.StoredProcedure;
                SqlCmd.ExecuteNonQuery();

                Conn.Close();

                return true;
            }
        }

        public static Boolean Exec_StoredProc_NonQuery(string storedProcName, Hashtable parameters)
        {
            using (SqlConnection Conn = new SqlConnection(ConnectStr))
            {
                Conn.Open();
                try
                {
                    SqlCommand SqlCmd = Build_SqlCommand(Conn, CommandType.StoredProcedure, storedProcName, parameters);
                    SqlCmd.CommandType = CommandType.StoredProcedure;
                    SqlCmd.ExecuteNonQuery();

                    parameters.Clear();
                    foreach (SqlParameter parameter in SqlCmd.Parameters)
                    {
                        if ((parameter.Direction == ParameterDirection.Output) || (parameter.Direction == ParameterDirection.InputOutput) || (parameter.Direction == ParameterDirection.ReturnValue))
                        {
                            parameters.Add(parameter.ParameterName, parameter.Value);
                        }
                    }

                    Conn.Close();

                    return true;

                }
                catch (System.Data.SqlClient.SqlException E)
                {
                    Conn.Close();
                    throw new Exception(E.Message);
                }
            }
        }


        public static SqlParameterCollection Get_StoredProc_Parameters(string storedProcName)
        {
            using (SqlConnection Conn = new SqlConnection(ConnectStr))
            {
                Conn.Open();
                SqlCommand SqlCmd = new SqlCommand(storedProcName, Conn);
                SqlCmd.CommandType = CommandType.StoredProcedure;
                SqlCommandBuilder.DeriveParameters(SqlCmd);
                SqlParameterCollection Parameters = SqlCmd.Parameters;
                Conn.Close();
                return Parameters;
            }
        }
        #endregion
        #endregion
        #endregion
    }
}
