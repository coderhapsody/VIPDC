using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using Microsoft.Win32;

namespace VIPDC.Providers.Helpers
{
    public static class EntityHelper
    {
        public static void SetAuditFields(this IRepository repository, int rowID, dynamic entity, string userName)
        {
            try
            {
                if (rowID == 0)
                {
                    entity.CreatedWhen = DateTime.Now;
                    entity.CreatedWho = userName;
                }
                entity.ChangedWhen = DateTime.Now;
                entity.ChangedWho = userName;
            }
            catch (Microsoft.CSharp.RuntimeBinder.RuntimeBinderException) { }
        }

        public static void SetAuditFieldsForInsert(this IRepository repository, dynamic entity, string userName)
        {
            try
            {
                entity.CreatedWhen = DateTime.Now;
                entity.CreatedWho = userName;
                entity.ChangedWhen = DateTime.Now;
                entity.ChangedWho = userName;
            }
            catch (Microsoft.CSharp.RuntimeBinder.RuntimeBinderException) { }
        }

        public static void SetAuditFieldsForUpdate(this IRepository repository, dynamic entity, string userName)
        {
            try
            {
                entity.ChangedWhen = DateTime.Now;
                entity.ChangedWho = userName;
            }
            catch (Microsoft.CSharp.RuntimeBinder.RuntimeBinderException) { }
        }
    }
}
