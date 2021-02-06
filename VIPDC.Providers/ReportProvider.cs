using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Linq.Expressions;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using VIPDC.Data;
using VIPDC.Providers.Base;
using VIPDC.Providers.Extensions;
using VIPDC.Providers.Helpers;
using VIPDC.Providers.ViewModels;

namespace VIPDC.Providers
{
    public class ReportProvider
    {
        public IPrincipal Principal { get; set; }


        public IEnumerable<KwitansiViewModel> LoadKwitansi(string invoiceNo)
        {
            var model = new KwitansiViewModel();
            using (var ctx = new VIPDCEntities())
            {
                var invoice = ctx.Invoices.SingleOrDefault(inv => inv.InvoiceNo == invoiceNo);                

                if (invoice != null)
                {
                    var letter = invoice.ConfirmationLetter;
                    if (letter != null)
                    {
                        model.KwitansiNo = invoiceNo;
                        model.Terbilang = NumericHelper.Terbilang(invoice.TotalPrice);
                        model.Nominal = invoice.TotalPrice;
                        model.SudahTerimaDari = invoice.ConfirmationLetter.Customer.Name;
                        model.Tanggal = invoice.Date;
                        model.UntukPembayaran = letter.Topic.Name;

                        model.Bank = letter.Bank.Name;
                        model.BankAccountNo = letter.Bank.AccountNumber;                        
                    }
                }
            }

            yield return model;
        }

        public IEnumerable<SlipInvoiceViewModel> LoadInvoiceInfo(string invoiceNo)    
        {
            var model = new SlipInvoiceViewModel();
            using (var ctx = new VIPDCEntities())
            {
                var invoice = ctx.Invoices.SingleOrDefault(inv => inv.InvoiceNo == invoiceNo);
                if (invoice != null)
                {
                    var confirmationLetter = invoice.ConfirmationLetter;
                    var customer = confirmationLetter.Customer;

                    model.InvoiceNo = invoice.InvoiceNo;
                    model.InvoiceDate = invoice.Date;
                    model.LetterNo = confirmationLetter.LetterNo;
                    model.PaymentDueDate = invoice.PaymentDueDate;
                    model.TrainingDatesString = String.Empty;
                    
                    foreach (var date in confirmationLetter.ConfirmationLetterSchedules.Select(d => d.Date))
                        model.TrainingDatesString += @"<li>" + date.ToLongDateString() + "</li>";
                    model.TrainingDatesString = @"<ol>" + model.TrainingDatesString + @"</ol>";

                    model.AccountManagerName = confirmationLetter.Employee.Name;
                    model.CustomerName = customer.Name;
                    model.InvoiceDate = invoice.Date;
                    model.Price = invoice.Price;
                    model.Discount = invoice.Discount;
                    model.Tax = invoice.Tax;
                    model.PPH = invoice.PPH;
                    model.TotalPrice = invoice.TotalPrice;
                    model.Terbilang = NumericHelper.Terbilang(model.TotalPrice);

                    var configuration = ctx.Configurations.SingleOrDefault(config => config.Key == "InvoicingSignName");
                    if (configuration != null)
                        model.SignName = configuration.Value;

                    configuration = ctx.Configurations.SingleOrDefault(config => config.Key == "InvoicingSignOccupation");
                    if (configuration != null)
                        model.SignOccupation = configuration.Value;

                    configuration = ctx.Configurations.SingleOrDefault(config => config.Key == "CompanyName");
                    if (configuration != null)
                        model.CompanyName = configuration.Value;

                    if (confirmationLetter.Bank != null)
                    {
                        model.BankName = confirmationLetter.Bank.Name;
                        model.BankAccountNo = confirmationLetter.Bank.AccountNumber;
                        model.BankAccountName = confirmationLetter.Bank.AccountName;
                    }
                }
            }
            yield return model;
        }

        public IEnumerable<SlipConfirmationLetterViewModel> LoadConfirmationLetterInfo(string letterNo)
        {
            var model = new SlipConfirmationLetterViewModel();
            using (var ctx = new VIPDCEntities())
            {
                var confirmationLetter = ctx.ConfirmationLetters.SingleOrDefault(lt => lt.LetterNo == letterNo);
                var customer = confirmationLetter.Customer;
                model.LetterNo = confirmationLetter.LetterNo;
                model.LetterDate = confirmationLetter.Date;
                model.CustomerName = customer.Name;
                model.EmployeeInitial = confirmationLetter.Employee.Initial;
                model.Investment = confirmationLetter.Price;
                model.Location = confirmationLetter.TrainingLocation;
                model.PaymentDueDate = confirmationLetter.PaymentDueDate.GetValueOrDefault();                
                model.TrainingDates =
                    confirmationLetter.ConfirmationLetterSchedules.Select(schedule => schedule.Date).ToList();
                model.ClassType = confirmationLetter.ClassType.Name;
                model.Discount = confirmationLetter.Discount;
                model.PPH = confirmationLetter.PPH;
                model.Tax = confirmationLetter.Tax;
                model.Topic = confirmationLetter.Topic.Name;
                model.TotalInvestment = confirmationLetter.TotalPrice;
                model.TotalParticipants = confirmationLetter.TotalParticipants;
                model.Modules = String.Empty;
                model.TrainingDescription = confirmationLetter.Description;
                model.Modules = String.Join(", ", confirmationLetter.Modules.Select(modul => modul.Name).ToArray());
                
                model.TrainingDatesString = String.Empty;
                foreach (var date in model.TrainingDates)
                    model.TrainingDatesString += @"<li>" + date.ToLongDateString() + "</li>";
                model.TrainingDatesString = @"<ol>" + model.TrainingDatesString + @"</ol>";

                if (confirmationLetter.Bank != null)
                {
                    model.BankName = confirmationLetter.Bank.Name;
                    model.AccountName = confirmationLetter.Bank.AccountName;
                    model.AccountNo = confirmationLetter.Bank.AccountNumber;
                }

            }
            yield return model;
        }

        public IEnumerable<CompanyInformationViewModel> LoadCompanyInformation()
        {
            var model = new CompanyInformationViewModel();
            using (var ctx = new VIPDCEntities())
            {
                model.CompanyAddress1 = ctx.Configurations.Single(config => config.Key == ConfigurationKeys.CompanyAddress1).Value;
                model.CompanyAddress2 = ctx.Configurations.Single(config => config.Key == ConfigurationKeys.CompanyAddress2).Value;
                model.CompanyWebsite = ctx.Configurations.Single(config => config.Key == ConfigurationKeys.CompanyWebsite).Value;
                model.Fax = ctx.Configurations.Single(config => config.Key == ConfigurationKeys.CompanyFax).Value;
                model.Phone = ctx.Configurations.Single(config => config.Key == ConfigurationKeys.CompanyPhone).Value;
                model.CompanyName = ctx.Configurations.Single(config => config.Key == ConfigurationKeys.CompanyName).Value;
            }
            yield return model;
        }

        public IEnumerable<InvoiceViewModel> LoadInvoices(DateTime fromDate, DateTime toDate)
        {            
            using (var ctx = new VIPDCEntities())
            {
                var invoices = ctx.Invoices.Where(inv => inv.Date >= fromDate && inv.Date <= toDate);
                foreach(var invoice in invoices)
                {
                    var model = new InvoiceViewModel();

                    var confirmationLetter = invoice.ConfirmationLetter;
                    var customer = confirmationLetter.Customer;

                    model.InvoiceNo = invoice.InvoiceNo;                    
                    model.InvoiceDate = invoice.Date;
                    model.LetterNo = confirmationLetter.LetterNo;
                    model.PaymentDueDate = invoice.PaymentDueDate;                    
                    model.AccountManagerName = confirmationLetter.Employee.Name;
                    model.CustomerName = customer.Name;
                    model.InvoiceDate = invoice.Date;
                    model.Price = invoice.Price;
                    model.Tax = invoice.Tax;
                    model.PPH = invoice.PPH;
                    model.TotalPrice = invoice.TotalPrice;
                    model.TotalPayment = invoice.Payments.Where(pay => !pay.VoidDate.HasValue).Sum(pay => pay.Amount);
                    if (invoice.VoidDate.HasValue)
                        model.Status = "Void";
                    else
                        model.Status = invoice.TotalPrice == model.TotalPayment ? "Full Paid" : "Outstanding";
                    
                    yield return model;
                }
            }
            
        }

        public IEnumerable<ConfirmationLetterViewModel> LoadConfirmationLetters(DateTime fromDate, DateTime toDate)
        {            
            var list = new List<ConfirmationLetterViewModel>();
            using (var ctx = new VIPDCEntities())
            {
                var confirmationLetters = ctx.ConfirmationLetters.Where(lt => lt.Date >= fromDate && lt.Date <= toDate);
                foreach (var confirmationLetter in confirmationLetters)
                {
                    var model = new ConfirmationLetterViewModel();
                    var customer = confirmationLetter.Customer;
                    model.LetterNo = confirmationLetter.LetterNo;
                    model.LetterDate = confirmationLetter.Date;
                    model.CustomerName = customer.Name;
                    model.Location = confirmationLetter.TrainingLocation;
                    model.PaymentDueDate = confirmationLetter.PaymentDueDate.GetValueOrDefault();
                    model.ClassType = confirmationLetter.ClassType.Name;
                    model.Topic = confirmationLetter.Topic.Name;
                    model.TotalInvestment = confirmationLetter.TotalPrice;
                    model.TotalParticipants = confirmationLetter.TotalParticipants;
                    model.Modules = String.Empty;
                    model.TrainingDescription = confirmationLetter.Description;
                    model.Modules = String.Join(", ", confirmationLetter.Modules.Select(modul => modul.Name).ToArray());
                    model.Status = confirmationLetter.VoidDate.HasValue ? "Void" : "Active";

                    if (confirmationLetter.Invoices != null && confirmationLetter.Invoices.Count > 0)
                    {
                        var invoice = confirmationLetter.Invoices.FirstOrDefault(lt => !lt.VoidDate.HasValue);
                        if (invoice != null)
                            model.InvoiceNo = invoice.InvoiceNo;
                    }

                    model.CLReceived = confirmationLetter.LetterReceiveDate;

                    //list.Add(model);

                    yield return model;
                }

            }
            //return list;
        }

    }
}
