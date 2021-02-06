using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VIPDC.Providers
{
    public class EntityProvider
    {
        private readonly DbContext context;

        public EntityProvider(DbContext context)
        {
            this.context = context;
        }

        public string GetConnectionString()
        {
            return context.Database.Connection.ConnectionString;
        }
    }
}
