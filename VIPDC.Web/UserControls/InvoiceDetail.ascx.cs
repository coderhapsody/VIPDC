using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VIPDC.Data;

namespace VIPDC.Web.UserControls
{
    public partial class InvoiceDetail : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void LoadInvoice(string invoiceNo)
        {
            ViewState["InvoiceNo"] = invoiceNo;
            dtvInvoice.DataBind();
        }

        protected void sdsInvoice_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@InvoiceNo"].Value = Convert.ToString(ViewState["InvoiceNo"]);
        }
    }
}