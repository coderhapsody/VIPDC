using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using VIPDC.Providers.Helpers;

namespace VIPDC.Providers.Extensions
{
    public static class RepositoryExtension
    {
        public static void AddOrUpdate<TEntity>(this IRepository repository, int rowID, TEntity entity, string userName) where TEntity : class
        {
            if (rowID == 0)
            {
                repository.Add(entity);
                repository.SetAuditFieldsForInsert(entity, userName);
            }
            else
            {
                repository.Update(entity);
                repository.SetAuditFieldsForUpdate(entity, userName);
            }
        }
    }
}
