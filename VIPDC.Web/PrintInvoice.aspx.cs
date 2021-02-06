using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VIPDC.Web
{
    public partial class PrintInvoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string invoiceNo = Request["InvoiceNo"];
            InvoiceDetail1.LoadInvoice(invoiceNo);
        }
    }
}