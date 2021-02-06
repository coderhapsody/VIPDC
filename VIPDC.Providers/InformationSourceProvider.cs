using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using VIPDC.Data;
using VIPDC.Providers.Base;
using VIPDC.Providers.Helpers;

namespace VIPDC.Providers
{
    public class InformationSourceProvider :BaseProvider
    {
        public InformationSourceProvider(IRepository repository, IPrincipal principal) : base(repository, principal)
        {
        }

        public void AddOrUpdateBank(int id, string description)
        {
            var informationSrc = id == 0 ? new InformationSource() : repository.Single<InformationSource>(b => b.ID == id);
            informationSrc.Description = description;
            repository.SetAuditFields(id, informationSrc, principal.Identity.Name);

            if (id == 0)
                repository.Add(informationSrc);
            else
                repository.Update(informationSrc);

            repository.UnitOfWork.SaveChanges();
        }

        public void DeleteInformationSource(int[] arrayOfID)
        {
            arrayOfID.ToList().ForEach(id => repository.Delete<Bank>(bank => bank.ID == id));
            repository.UnitOfWork.SaveChanges();
        }

        public bool CanDeleteInformationSource(int[] arrayOfID)
        {
            //throw new NotImplementedException();
            return true;
        }

        public InformationSource GetInformationSource(int id)
        {
            return repository.Single<InformationSource>(t => t.ID == id);
        }

        public IEnumerable<string> GetInformationSources()
        {
            return repository.GetQuery<InformationSource>().Select(o => o.Description);
        }
    }
}
