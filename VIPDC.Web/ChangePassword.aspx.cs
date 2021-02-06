﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ninject;
using VIPDC.Providers;
using VIPDC.Web.Base;

namespace VIPDC.Web
{
    public partial class ChangePassword : BaseForm
    {
        [Inject]
        public SecurityProvider SecurityService { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                mvwForm.ActiveViewIndex = 0;
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            Page.Validate();
            if (Page.IsValid)
            {                
                SecurityService.ChangePassword(User.Identity.Name,
                    txtNewPassword.Text,
                    ConfigurationManager.AppSettings[ApplicationSettingKeys.CryptographyKey]);

                mvwForm.ActiveViewIndex = 1;
            }
        }

        protected void cuvCurrentPassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = SecurityService.IsCurrentPasswordValid(args.Value);
        }
    }
}