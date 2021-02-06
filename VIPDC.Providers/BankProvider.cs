using System;
using System.Collections.Generic;
using System.Data;
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
    public class BankProvider : BaseProvider
    {
        public BankProvider(IRepository repository, IPrincipal principal) : base(repository, principal)
        {
        }

        public void AddOrUpdateBank(int id, string name, string accountName, string accountNo)
        {
            var bank = id == 0 ? new Bank() : repository.Single<Bank>(b => b.ID == id);
            bank.Name = name;
            bank.AccountName = accountName;
            bank.AccountNumber = accountNo;    
            repository.SetAuditFields(id, bank, principal.Identity.Name);
            
            if(id == 0)
                repository.Add(bank);
            else
                repository.Update(bank);

            repository.UnitOfWork.SaveChanges();
        }

        public void DeleteBank(int[] arrayOfID)
        {
            arrayOfID.ToList().ForEach(id => repository.Delete<Bank>(bank => bank.ID == id));
            repository.UnitOfWork.SaveChanges();
        }

        public bool CanDeleteBank(int[] arrayOfID)
        {
            //throw new NotImplementedException();
            return true;
        }

        public Bank GetBank(int id)
        {
            return repository.Single<Bank>(t => t.ID == id);
        }

        public IDictionary<int, string> GetBanksDetail()
        {
            return repository.GetQuery<Bank>()
                             .ToDictionary(bank => bank.ID,
                                 bank =>
                                     String.Format("{0} - {1} - {2}", bank.Name, bank.AccountName, bank.AccountNumber));
        }

        public IEnumerable<Bank> GetBanks()
        {
            return repository.GetAll<Bank>();
        }
    }
}
