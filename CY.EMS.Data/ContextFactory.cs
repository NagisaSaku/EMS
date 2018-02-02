using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CY.EMS.Data
{
    public class ContextFactory
    {
        public static IDataContext CreateContext<TEntity>() where TEntity:BaseEntity
        {
            var context = new BaseDbContext();

            if (typeof(TEntity) == typeof(Entity.User))
            {
                context._SelectSP = "P_Sys_Get_User";
            }
            return context;
        }
    }
}
