using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace VIPDC.Providers.ViewModels
{
    [DataContract]
    public class ConfirmationLetterDto
    {
        [DataMember]
        public string ConfirmationLetterNo { get; set; }
        
        [DataMember]
        public decimal Price { get; set; }

        [DataMember]
        public decimal Tax { get; set; }

        [DataMember]
        public decimal PPH { get; set; }

        [DataMember]
        public decimal RatePPN { get; set; }

        [DataMember]
        public decimal RatePPH { get; set; }

        [DataMember]
        public decimal TotalPrice { get; set; }

        [DataMember]
        public bool IsTaxed { get; set; }

        [DataMember]
        public DateTime PaymentDueDate { get; set; }

        [DataMember]
        public decimal Discount { get; set; }

        [DataMember]
        public int BankID { get; set; }
    }
}
