using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VIPDC.Providers.ViewModels
{
    [Serializable]
    public class PaymentViewModel
    {
        public int ID { get; set; }
        public string PaymentType { get; set; }
        public DateTime PaymentDate { get; set; }
        public decimal Amount { get; set; }
        public string ApprovalCode { get; set; }
        public string Notes { get; set; }
        public bool Void { get; set; }
        public string VoidReason { get; set; }
        public bool IsNew { get; set; }
    }
}
