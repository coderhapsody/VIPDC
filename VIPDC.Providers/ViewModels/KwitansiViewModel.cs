using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VIPDC.Providers.ViewModels
{
    public class KwitansiViewModel
    {
        public string SudahTerimaDari { get; set; }
        public string UntukPembayaran { get; set; }
        public decimal Nominal { get; set; }
        public string Terbilang { get; set; }
        public DateTime Tanggal { get; set; }
        public string KwitansiNo { get; set; }
        public string Bank { get; set; }
        public string BankAccountNo { get; set; }
    }
}
