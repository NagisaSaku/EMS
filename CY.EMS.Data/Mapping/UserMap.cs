using CY.EMS.Data.Entity;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CY.EMS.Data.Mapping
{
    public class UserMap : EntityTypeConfiguration<User>
    {
        public UserMap()
        {
            this.ToTable("T_Sys_User"); // 表名
            this.HasKey(u => u.Id); // 主键
            this.Property(u => u.UserName).IsRequired().HasMaxLength(50).IsUnicode(false); // 非空，最大长度30，VARCHAR
            this.Property(u => u.Name).IsRequired().HasMaxLength(50);
            this.Property(u => u.Password).IsRequired().HasMaxLength(50).IsUnicode(false);
            this.Property(u => u.Memo).HasMaxLength(250);
        }
    }
}
