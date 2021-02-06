using System.Configuration;
using System.Security.Cryptography;
using System.Web.Security;
using Ninject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VIPDC.Providers;
using VIPDC.Providers.Helpers;
using VIPDC.Web.Helpers;

namespace VIPDC.Web
{
    public partial class UserLogin : System.Web.UI.Page
    {
        [Inject]
        public SecurityProvider SecurityService { get; set; }

        private readonly string cryptographyKey = ConfigurationManager.AppSettings[ApplicationSettingKeys.CryptographyKey];

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtUserName.Focus();                
            }

            //Response.Write();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {            
            bool canLogin = SecurityService.ValidateUser(txtUserName.Text, txtPassword.Text, cryptographyKey);
            if (!canLogin)
            {
                WebFormHelper.SetLabelTextWithCssClass(lblStatus, "Invalid User Name or Password", LabelStyleNames.ErrorMessage);
                txtUserName.Focus();
            }
            else
            {                
                FormsAuthentication.SetAuthCookie(txtUserName.Text, false);
                Response.Redirect(FormsAuthentication.DefaultUrl);
            }
        }
    }
}