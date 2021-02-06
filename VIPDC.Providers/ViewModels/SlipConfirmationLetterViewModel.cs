using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VIPDC.Providers.ViewModels
{
    public class SlipConfirmationLetterViewModel
    {
        public string LetterNo { get; set; }
        public DateTime LetterDate { get; set; }
        public string CustomerName { get; set; }
        public string Topic { get; set; }        
        public int TotalParticipants { get; set; }
        public string Location { get; set; }
        public decimal Investment { get; set; }
        public decimal Discount { get; set; }
        public decimal PPH { get; set; }
        public decimal Tax { get; set; }
        public decimal TotalInvestment { get; set; }
        public DateTime PaymentDueDate { get; set; }
        public string EmployeeInitial { get; set; }
        public string ClassType { get; set; }
        public string BankName { get; set; }
        public string AccountName { get; set; }
        public string AccountNo { get; set; }
        public string TrainingDescription { get; set; }
        public string Modules { get; set; }
        public List<DateTime> TrainingDates { get; set; }
        public string TrainingDatesString { get; set; }
    }
}
