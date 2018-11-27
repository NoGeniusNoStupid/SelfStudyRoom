

using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;

namespace SelfStudyRoom.Models
{
    public class DBContextFactory
    {
        /// <summary>
        /// 创建数据库访问对象的实例
        /// </summary>
        /// <returns></returns>
        public static DbContext CreateDbContext()
        {
            //线程槽
            DbContext dbContext = (DbContext)CallContext.GetData("dbContext");
            if(dbContext==null)
            {
                dbContext = new SelfStudyRoomEntities();
                CallContext.SetData("dbContext", dbContext);
            }
            return dbContext;
        }
    }
}
