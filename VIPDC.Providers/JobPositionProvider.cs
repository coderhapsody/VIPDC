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
    public class JobPositionProvider : BaseProvider
    {
        public JobPositionProvider(IRepository repository, IPrincipal principal)
            : base(repository, principal)
        {
        }


        #region Job Position
        public void AddOrUpdateJobPosition(int id, string name)
        {
            var JobPosition = id == 0 ? new JobPosition() : repository.Single<JobPosition>(jp => jp.ID == id);
            if (JobPosition != null)
            {
                JobPosition.Name = name;
                repository.AddOrUpdate(id, JobPosition, CurrentUserName);
                repository.UnitOfWork.SaveChanges();
            }
        }

        public IEnumerable<JobPosition> GetActiveJobPositions()
        {
            return repository.GetQuery<JobPosition>();
        }

        public JobPosition GetJobPosition(int id)
        {
            return repository.Single<JobPosition>(jp => jp.ID == id);
        }

        public void DeleteJobPositions(int[] arrayOfID)
        {
            arrayOfID.ToList().ForEach(id => repository.Delete<JobPosition>(jp => jp.ID == id));
            repository.UnitOfWork.SaveChanges();
        }

        public bool CanDeleteJobPositions(int[] arrayOfID)
        {
            // TODO: add logic to validate whether a class type can be safely deleted or not
            return true;
        }
        #endregion

    }
}
