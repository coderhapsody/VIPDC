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
    public partial class CurrentCredential : System.Web.UI.UserControl
    {
        [Inject]
        public SecurityProvider SecurityService { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblCurrentUserName.Text = String.Format("{0} [{1}]",
                Page.User.Identity.Name,
                SecurityService.GetRoleName(Page.User.Identity.Name));
        }
    }
}