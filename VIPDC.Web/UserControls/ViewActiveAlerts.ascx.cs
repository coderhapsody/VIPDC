using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VIPDC.Web.Helpers;

namespace VIPDC.Web.UserControls
{
    public partial class ViewActiveAlerts : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void sdsAlert_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@Date"].Value = DateTime.Today.ToString("yyyy-MM-dd");
        }
    }
}