using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CY.EMS.Data.Entity
{
    /// <summary>
    /// 系统登录用户
    /// </summary>
    public class User : BaseEntity
    {
        public string UserName { get; set; }

        public string Name { get; set; }

        public string Password { get; set; }

        public string Memo { get; set; }
    }
}
