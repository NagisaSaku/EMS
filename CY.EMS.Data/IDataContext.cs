using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;

namespace CY.EMS.Data
{
    public interface IDataContext : IDisposable
    {
        /// <summary>
        /// 存储过程或者查询语句的输入参数
        /// </summary>
        IDictionary InputParams { get; }

        /// <summary>
        /// Get DbSet
        /// </summary>
        /// <typeparam name="TEntity">Entity type</typeparam>
        /// <returns>DbSet</returns>
        IDbSet<TEntity> Set<TEntity>() where TEntity : BaseEntity;

        /// <summary>
        /// Save changes
        /// </summary>
        /// <returns></returns>
        int SaveChanges();

        /// <summary>
        /// 调用存储过程执行查询
        /// </summary>
        /// <typeparam name="TEntity">实体类型</typeparam>
        /// <returns>IList</returns>
        IList<TEntity> SelectBySP<TEntity>() where TEntity : BaseEntity, new();

        //int Insert<TEntity>(out string msg);

        //int Update(out string msg);

        //int Delete(string pk, out string msg);

        //int Oper(string proc, string action, out string msg);
    }
}
