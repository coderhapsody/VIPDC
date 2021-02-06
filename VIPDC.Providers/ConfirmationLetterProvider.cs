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
using VIPDC.Providers.ViewModels;

namespace VIPDC.Providers
{
    public class ConfirmationLetterProvider : BaseProvider
    {
        private readonly RunningNumberProvider runningNumberProvider;
        private readonly ConfigurationProvider configurationService;

        public ConfirmationLetterProvider(IRepository repository, IPrincipal principal, ConfigurationProvider configurationService)
            : base(repository, principal)
        {
            this.runningNumberProvider = new RunningNumberProvider(repository, principal);
            this.configurationService = configurationService;
        }

        //public bool IsValidConfirmationLetter(string letterNo)
        //{
        //    var letter = repository.FindOne<ConfirmationLetter>(cl => cl.LetterNo == letterNo && !cl.VoidDate.HasValue);
        //    return letter != null;
        //}

        public void ReceiveConfirmationLetter(string letterNo, DateTime receiveDate)
        {
            var letter = repository.FindOne<ConfirmationLetter>(cl => cl.LetterNo == letterNo);
            if (letter != null)
            {
                letter.LetterReceiveDate = receiveDate;
                repository.SetAuditFieldsForUpdate(letter, principal.Identity.Name);
                repository.UnitOfWork.SaveChanges();
            }
        }

        public void VoidConfirmationLetter(string letterNo, string reason)
        {
            var letter = repository.FindOne<ConfirmationLetter>(cl => cl.LetterNo == letterNo);
            if (letter != null)
            {
                letter.VoidDate = DateTime.Today;
                letter.VoidReason = reason;
                repository.SetAuditFieldsForUpdate(letter, principal.Identity.Name);
                repository.UnitOfWork.SaveChanges();
            }
        }

        public string AddOrUpdateConfirmationLetter(int id,
                                                    DateTime date,
                                                    int accountManagerID,
                                                    string customerCode,
                                                    List<DateTime> trainingDates,
                                                    string trainingLocation,
                                                    string description,
                                                    int classTypeID,
                                                    int topicID,
                                                    decimal price,
                                                    decimal tax,
                                                    decimal pph,
                                                    decimal discount,
                                                    int bankID,
                                                    DateTime paymentDueDate,
                                                    string refLetterNo,
                                                    int totalParticipants,
                                                    int[] moduleIDs)
        {
            decimal ratePPH = configurationService.GetValue<decimal>("RatePPH") / 100M;
            decimal ratePPN = configurationService.GetValue<decimal>("RatePPN") / 100M;
            var employee = repository.FindOne<Employee>(emp => emp.ID == accountManagerID);
            var cl = id != 0 ? repository.Single<ConfirmationLetter>(letter => letter.ID == id) : new ConfirmationLetter();            
            var classType = repository.Single<ClassType>(ct => ct.ID == classTypeID);
            var customer = repository.Single<Customer>(cust => cust.Code == customerCode);
            var refLetter = String.IsNullOrEmpty(refLetterNo)
                ? null
                : repository.Single<ConfirmationLetter>(letter => letter.LetterNo == refLetterNo);

            if (id == 0)
            {
                cl.LetterNo = runningNumberProvider.GenerateConfirmationLetterNo(employee.ID, date);
            }
            cl.Date = date;
            cl.AccountManagerID = accountManagerID;
            cl.CustomerID = customer.ID;            
            cl.TrainingLocation = trainingLocation;
            cl.Description = description;
            cl.ClassTypeID = classTypeID;
            cl.TopicID = topicID;
            cl.Price = price;
            cl.Tax = classType.Tax ? ratePPN * (price - discount) : 0;
            cl.PPH = classType.Tax ? ratePPH * (price - discount) : 0;
            cl.Discount = discount;
            cl.TotalPrice = cl.Price - cl.Discount + cl.Tax - cl.PPH;
            cl.TransferToBankID = bankID;
            cl.PaymentDueDate = paymentDueDate;
            cl.TotalParticipants = totalParticipants;
            if(refLetter != null)
                cl.RefLetterID = refLetter.ID;
            repository.SetAuditFields(id, cl, principal.Identity.Name);

            cl.Modules.Clear();
            foreach (var moduleID in moduleIDs)
            {
                var module = repository.FindOne<Module>(mod => mod.ID == moduleID);
                if(module != null)
                    cl.Modules.Add(module);
            }

            if (customer.CustomerType == "I")
            {
                if(cl.Customers != null)
                    cl.Customers.Clear();

                cl.Customers.Add(customer);
            }
            
            repository.Delete<ConfirmationLetterSchedule>(schedule => schedule.ConfirmationLetterID == cl.ID);
            foreach (var trainingDate in trainingDates)
            {
                var schedule = new ConfirmationLetterSchedule();
                schedule.ConfirmationLetter = cl;
                schedule.Date = trainingDate;
                cl.ConfirmationLetterSchedules.Add(schedule);
            }

            if(id == 0)
                repository.Add(cl);                
            else
                repository.Update(cl);

            

            repository.UnitOfWork.SaveChanges();

            return cl.LetterNo;
        }

        public ConfirmationLetter GetConfirmationLetter(int confirmationLetterID)
        {
            return repository.FindOne<ConfirmationLetter>(cl => cl.ID == confirmationLetterID);
        }

        public ConfirmationLetter GetConfirmationLetter(string letterNo)
        {
            return repository.FindOne<ConfirmationLetter>(cl => cl.LetterNo == letterNo);
        }        

        public ConfirmationLetterDto GetConfirmationLetterAjax(string letterNo)
        {
            var cl = GetConfirmationLetter(letterNo);
            if (cl != null)
            {
                return new ConfirmationLetterDto()
                       {
                           ConfirmationLetterNo =  cl.LetterNo,
                           PaymentDueDate =  cl.PaymentDueDate.GetValueOrDefault(),
                           Discount = cl.Discount,
                           TotalPrice = cl.TotalPrice,
                           Price = cl.Price,
                           PPH = cl.PPH,
                           Tax = cl.Tax,
                           IsTaxed = cl.Tax > 0,
                           BankID = cl.TransferToBankID.GetValueOrDefault(),
                           RatePPN = configurationService.GetValue<decimal>("RatePPN"),
                           RatePPH = configurationService.GetValue<decimal>("RatePPH")
                       };
            }
            
            return new ConfirmationLetterDto();
        }

        public void AddParticipant(int letterID, int customerID)
        {
            var confirmationLetter = repository.Single<ConfirmationLetter>(letter => letter.ID == letterID);
            var customer = repository.FindOne<Customer>(cust => cust.ID == customerID);
            if (customer != null)
            {
                confirmationLetter.Customers.Add(customer);
                repository.Update(confirmationLetter);
                repository.UnitOfWork.SaveChanges();
            }
        }

        public void RemoveParticipant(int letterID, string customerCode)
        {
            var confirmationLetter = repository.Single<ConfirmationLetter>(letter => letter.ID == letterID);
            var customer = repository.FindOne<Customer>(cust => cust.Code == customerCode);
            if (customer != null)
            {
                confirmationLetter.Customers.Remove(customer);
                repository.Update(confirmationLetter);
                repository.UnitOfWork.SaveChanges();
            }
        }

        public bool HasInvoiceOrPayment(string letterNo)
        {
            var letter = GetConfirmationLetter(letterNo);
            if (letter.Invoices != null)
            {
                if (letter.Invoices.Any(inv => !inv.VoidDate.HasValue))
                {
                    return true;
                }

                if (letter.Invoices.Any(inv => inv.Payments != null && inv.Payments.Any(pay => !pay.VoidDate.HasValue)))
                {
                    return true;
                }
            }
            
            return false;
        }

        public IEnumerable<ConfirmationLetterSchedule> GetTrainingDates(int id)
        {
            return repository.GetQuery<ConfirmationLetterSchedule>(letter => letter.ConfirmationLetterID == id);
        }
    }
}
