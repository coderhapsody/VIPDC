using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using VIPDC.Data;
using VIPDC.Providers.Base;
using VIPDC.Providers.Extensions;
using VIPDC.Providers.Helpers;

namespace VIPDC.Providers
{
    public class CustomerProvider : BaseProvider
    {
        private readonly RunningNumberProvider runningNumberProvider;

        public CustomerProvider(IRepository repository, IPrincipal principal)
            : base(repository, principal)
        {
            this.runningNumberProvider = new RunningNumberProvider(repository, principal);
        }

        public Customer GetCustomer(int id)
        {
            return repository.Single<Customer>(cust => cust.ID == id);
        }

        public Customer GetCustomer(string code)
        {
            return repository.Single<Customer>(cust => cust.Code == code);
        }

        public void DeleteCustomer(int[] arrayOfID)
        {
            Array.ForEach(arrayOfID, id => repository.Delete<Customer>(cust => cust.ID == id));            
            repository.UnitOfWork.SaveChanges();
        }

        public void DeleteCustomer(int id)
        {
            repository.Delete<Customer>(cust => cust.ID == id);
            repository.UnitOfWork.SaveChanges();
        }

        public string AddOrUpdateCustomer(int id,
                                  string name,
                                  string customerType,
                                  DateTime? dateOfBirth,
                                  string contactPersonName,
                                  string gender,
                                  int jobPositionID,
                                  string email,
                                  string address,
                                  string zipCode,
                                  string website,
                                  string informationSource,
                                  IDictionary<int, string> cellPhones,
                                  IDictionary<int, string> socialMediaNetworks,
                                  IDictionary<int, string> workPhones)
        {
            var customer = id == 0 ? new Customer() : repository.Single<Customer>(cust => cust.ID == id);
            if (id == 0)
            {
                customer.Code = runningNumberProvider.GenerateCustomerCode();
            }
            customer.Name = name;
            customer.CustomerType = customerType;
            customer.ContactPersonName = contactPersonName;
            customer.Gender = gender;
            customer.DateOfBirth = dateOfBirth;
            customer.JobPositionId = jobPositionID == 0 ? (int?) null : jobPositionID;
            customer.Email = email;
            customer.Address = address;
            customer.ZipCode = zipCode;
            customer.Website = website;
            customer.InformationSource = informationSource;
            customer.CellPhone1 = cellPhones[1];
            customer.CellPhone2 = cellPhones[2];
            customer.SocialMediaNetwork1 = socialMediaNetworks[1];
            customer.SocialMediaNetwork2 = socialMediaNetworks[2];
            customer.WorkPhone1 = workPhones[1];
            customer.WorkPhone2 = workPhones[2];
            repository.SetAuditFields(id, customer, principal.Identity.Name);

            if(id == 0)
                repository.Add(customer);
            else
                repository.Update(customer);

            repository.UnitOfWork.SaveChanges();

            return customer.Code;
        }


        public bool CanDeleteCustomer(int[] arrayOfID)
        {
            return true;
        }

        public void AddCustomer(string letterNo, string name,
                                  string customerType,
                                  DateTime? dateOfBirth,
                                  string gender,
                                  int jobPositionID,
                                  string email,
                                  string address,
                                  string zipCode,
                                  string website,
                                  string informationSource,
                                  IDictionary<int, string> cellPhones,
                                  IDictionary<int, string> socialMediaNetworks,
                                  IDictionary<int, string> workPhones)
        {
            var letter = repository.FindOne<ConfirmationLetter>(cl => cl.LetterNo == letterNo);
            

            string customerCode = AddOrUpdateCustomer(0,
                name,
                customerType,
                dateOfBirth,
                String.Empty,
                gender,
                jobPositionID,
                email,
                address,
                zipCode,
                website,
                informationSource,
                cellPhones,
                socialMediaNetworks,
                workPhones);

            var cust = repository.GetQuery<Customer>(customer => customer.Code == customerCode).SingleOrDefault();
            letter.Customers.Add(cust);
            repository.Update(letter);

            repository.UnitOfWork.SaveChanges();
        }
    }
}
