using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VIPDC.Providers.ViewModels
{
    public class InvoiceViewModel
    {
        public string InvoiceNo { get; set; }
        public DateTime InvoiceDate { get; set; }
        public string CustomerName { get; set; }
        public string LetterNo { get; set; }
        public string AccountManagerName { get; set; }
        public DateTime PaymentDueDate { get; set; }
        public string Topic { get; set; }
        public decimal Price { get; set; }
        public decimal Tax { get; set; }
        public decimal PPH { get; set; }
        public decimal TotalPrice { get; set; }        
        public decimal TotalPayment { get; set; }
        public string Status { get; set; }
    }
}
