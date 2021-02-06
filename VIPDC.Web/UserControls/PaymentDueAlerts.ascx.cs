using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ninject;
using VIPDC.Providers;

namespace VIPDC.Web.UserControls
{
    public partial class PaymentDueAlerts : System.Web.UI.UserControl
    {
        [Inject]
        public ConfigurationProvider ConfigurationService { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }        

        protected void sdsAlert_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            int daysBefore = 0;
            Int32.TryParse(ConfigurationService["PaymentDueAlertDaysBefore"], out daysBefore);

            if (daysBefore == 0)
                daysBefore = 2;

            e.Command.Parameters["@DaysBefore"].Value = daysBefore;
            lblMessage.Text = String.Format(@"<h4>Outstanding Invoices</h4>");
        }
    }
}