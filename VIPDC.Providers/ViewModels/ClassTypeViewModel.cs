using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace VIPDC.Providers.ViewModels
{
    [DataContract]
    public class ClassTypeViewModel
    {
        [DataMember]
        public string ClassTypeName { get; set; }

        [DataMember]
        public bool Tax { get; set; }

        [DataMember]
        public decimal RatePPN { get; set; }

        [DataMember]
        public decimal RatePPH { get; set; }
    }
}
