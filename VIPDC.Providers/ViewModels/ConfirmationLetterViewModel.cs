using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VIPDC.Providers.ViewModels
{
    public class ConfirmationLetterViewModel
    {
        public string LetterNo { get; set; }
        public DateTime LetterDate { get; set; }
        public string CustomerName { get; set; }
        public string AccountManagerName { get; set; }
        public string Topic { get; set; }
        public int TotalParticipants { get; set; }
        public string Location { get; set; }        
        public decimal TotalInvestment { get; set; }
        public DateTime PaymentDueDate { get; set; }        
        public string ClassType { get; set; }        
        public string TrainingDescription { get; set; }
        public string Modules { get; set; }
        public DateTime? CLReceived { get; set; }
        public string Status { get; set; }
        public string InvoiceNo { get; set; }
    }
}
