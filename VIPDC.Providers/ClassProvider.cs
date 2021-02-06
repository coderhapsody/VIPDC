using System;
using System.Collections.Generic;
using System.Data.Common.CommandTrees.ExpressionBuilder;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using VIPDC.Providers.Extensions;
using VIPDC.Data;
using VIPDC.Providers.Base;
using VIPDC.Providers.Helpers;

namespace VIPDC.Providers
{
    public class ClassProvider : BaseProvider
    {
        public ClassProvider(IRepository repository, IPrincipal principal) : base(repository, principal)
        {
        }


        #region Class Type
        public void AddOrUpdateClassType(int id, string name, bool isTaxed)
        {
            var classType = id == 0 ? new ClassType() : repository.Single<ClassType>(ct => ct.ID == id);
            if (classType != null)
            {
                classType.Name = name;
                classType.Tax = isTaxed;
                repository.AddOrUpdate(id, classType, CurrentUserName);
                repository.UnitOfWork.SaveChanges();
            }
        }

        public ClassType GetClassType(int id)
        {
            return repository.Single<ClassType>(classType => classType.ID == id);
        }

        public void DeleteClassTypes(int[] arrayOfID)
        {
            arrayOfID.ToList().ForEach(id => repository.Delete<ClassType>(ct => ct.ID == id));            
            repository.UnitOfWork.SaveChanges();
        }

        public bool CanDeleteClassTypes(int[] arrayOfID)
        {
            // TODO: add logic to validate whether a class type can be safely deleted or not
            return true;
        }
        #endregion

    }
}
