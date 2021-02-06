using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
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
    public class InvoiceProvider : BaseProvider
    {
        private readonly RunningNumberProvider runningNumberProvider;

        public InvoiceProvider(IRepository repository, IPrincipal principal) : base(repository, principal)
        {
            this.runningNumberProvider = new RunningNumberProvider(repository, principal);
        }

        public string AddOrUpdateInvoice(int id,
                                         string letterNo,
                                         DateTime date,
                                         string notes,
                                         DateTime paymentDueDate,
                                         decimal price,
                                         decimal tax,
                                         decimal pph,
                                         decimal discount,
                                         int bankID)
        {
            var invoice = id == 0 ? new Invoice() : repository.Single<Invoice>(inv => inv.ID == id);
            var confirmationLetter = repository.FindOne<ConfirmationLetter>(cl => cl.LetterNo == letterNo);
            var employee = repository.FindOne<Employee>(emp => emp.UserName == principal.Identity.Name);

            invoice.EmployeeID = employee.ID;
            if (id == 0)
            {
                invoice.InvoiceNo = runningNumberProvider.GenerateInvoiceNo(confirmationLetter.ID, employee.ID, date);
            }
            invoice.LetterID = confirmationLetter.ID;
            invoice.Date = date;
            invoice.Notes = notes;
            invoice.PaymentDueDate = paymentDueDate;
            invoice.Price = price;
            invoice.Tax = tax;
            invoice.PPH = pph;
            invoice.Discount = discount;
            invoice.TotalPrice = price - discount + tax - pph;
            invoice.TransferToBankID = bankID;
            repository.SetAuditFields(id, invoice, principal.Identity.Name);
            
            if(id == 0)
                repository.Add(invoice);
            else
                repository.Update(invoice);
            repository.UnitOfWork.SaveChanges();

            return invoice.InvoiceNo;
        }

        public void VoidInvoice(string invoiceNo, string reason)
        {
            var invoice = repository.FindOne<Invoice>(inv => inv.InvoiceNo == invoiceNo);
            if (invoice != null)
            {
                invoice.VoidDate = DateTime.Today;
                invoice.VoidReason = reason;

                var letter = invoice.ConfirmationLetter;
                if (letter != null)
                {
                    letter.VoidDate = DateTime.Today;
                    letter.VoidReason = reason;
                }

                //repository.SetAuditFieldsForUpdate(invoice, principal.Identity.Name);
                repository.Update(invoice);
                repository.Update(letter);
                repository.UnitOfWork.SaveChanges();
            }
        }

        public Invoice GetInvoice(string invoiceNo)
        {
            return repository.FindOne<Invoice>(inv => inv.InvoiceNo == invoiceNo);
        }

        public Invoice GetInvoice(int invoiceID)
        {
            return repository.FindOne<Invoice>(inv => inv.ID == invoiceID);
        }

        public IEnumerable<PaymentViewModel> GetPaymentDetail(string invoiceNo)
        {
            var query = from inv in repository.GetQuery<Invoice>()
                        join pay in repository.GetQuery<Payment>() on inv.ID equals pay.InvoiceID
                        where inv.InvoiceNo == invoiceNo
                        select new PaymentViewModel()
                               {
                                   ID = pay.ID,
                                   Amount = pay.Amount,
                                   PaymentDate = pay.Date,
                                   ApprovalCode = pay.ApprovalCode,
                                   Notes = pay.Notes,
                                   PaymentType = pay.PaymentType,
                                   Void = pay.VoidDate.HasValue,
                                   IsNew = false
                               };
            return query;
        }

        public void UpdatePayment(int invoiceID, List<PaymentViewModel> paymentDetail)
        {
            repository.Delete<Payment>(pay => pay.InvoiceID == invoiceID);
            paymentDetail.ForEach(pay =>
            {
                var payment = new Payment
                              {
                                  InvoiceID = invoiceID,
                                  Date = pay.PaymentDate,
                                  Notes = pay.Notes,
                                  ApprovalCode = pay.ApprovalCode,
                                  Amount = pay.Amount,
                                  PaymentType = pay.PaymentType,
                                  CreatedWhen = DateTime.Now,
                                  CreatedWho = principal.Identity.Name,
                                  VoidDate = pay.Void ? DateTime.Today : (DateTime?)null,
                                  VoidReason = pay.Void ? pay.VoidReason : null
                              };
                repository.Add(payment);
            });
            repository.UnitOfWork.SaveChanges();
        }

        public void VoidPayment(int paymentID, string reason)
        {
            var payment = repository.Single<Payment>(pay => pay.ID == paymentID);
            payment.VoidDate = DateTime.Now;
            payment.VoidReason = reason;            
            repository.Update(payment);
            repository.UnitOfWork.SaveChanges();
        }

        public bool HasPayments(string invoiceNo)
        {
            var invoice = GetInvoice(invoiceNo);
            if (invoice != null)
            {
                if (invoice.Payments.Any(pay => !pay.VoidDate.HasValue))
                {
                    return true;
                }
            }

            return false;
        }
    }

}
