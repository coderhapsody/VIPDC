using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VIPDC.Providers.ViewModels
{
    public class SlipInvoiceViewModel
    {
        public string InvoiceNo { get; set; }
        public DateTime InvoiceDate { get; set; }
        public string CustomerName { get; set; }
        public string LetterNo { get; set; }        
        public string AccountManagerName { get; set; }        
        public DateTime PaymentDueDate { get; set; }
        public string Topic { get; set; }
        public decimal Discount { get; set; }
        public decimal Price { get; set; }
        public decimal Tax { get; set; }
        public decimal PPH { get; set; }
        public decimal TotalPrice { get; set; }
        public string Terbilang { get; set; }

        public string BankName { get; set; }
        public string BankAccountName { get; set; }
        public string BankAccountNo { get; set; }

        public string SignName { get; set; }
        public string SignOccupation { get; set; }

        public string TrainingDatesString { get; set; }
        public string CompanyName { get; set; }
    }
}
