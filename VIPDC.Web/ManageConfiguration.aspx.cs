using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Infrastructure.Data;
using VIPDC.Data;
using VIPDC.Providers;
using VIPDC.Web.Base;
using Ninject;
using VIPDC.Web.Helpers;

namespace VIPDC.Web
{
    public partial class ManageConfiguration : BaseForm
    {
        [Inject]
        public ConfigurationProvider ConfigurationService { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                LoadConfiguration();
        }

        private void LoadConfiguration()
        {
            txtAddress1.Text = ConfigurationService["CompanyAddress1"];
            txtAddress2.Text = ConfigurationService["CompanyAddress2"];
            txtPhone.Text = ConfigurationService["CompanyPhone"];
            txtFax.Text = ConfigurationService["CompanyFax"];
            txtWebsite.Text = ConfigurationService["CompanyWebsite"];

            ntbPPN.Value = Convert.ToDouble(ConfigurationService["RatePPN"]);
            ntbPPH.Value = Convert.ToDouble(ConfigurationService["RatePPH"]);
            ntbAlertInvoice.Value = Convert.ToDouble(ConfigurationService["PaymentDueAlertDaysBefore"]);

            txtSignName.Text = ConfigurationService["InvoicingSignName"];
            txtSignOccupation.Text = ConfigurationService["InvoicingSignOccupation"];
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Page.Validate();
            if (Page.IsValid)
            {
                try
                {
                    ConfigurationService["CompanyAddress1"] = txtAddress1.Text;
                    ConfigurationService["CompanyAddress2"] = txtAddress2.Text;
                    ConfigurationService["CompanyPhone"] = txtPhone.Text;
                    ConfigurationService["CompanyFax"] = txtFax.Text;
                    ConfigurationService["CompanyWebsite"] = txtWebsite.Text;

                    ConfigurationService["RatePPN"] = Convert.ToString(ntbPPN.Value.GetValueOrDefault());
                    ConfigurationService["RatePPH"] = Convert.ToString(ntbPPH.Value.GetValueOrDefault());

                    ConfigurationService["PaymentDueAlertDaysBefore"] = Convert.ToString(ntbAlertInvoice.Value.GetValueOrDefault());

                    ConfigurationService["InvoicingSignName"] = txtSignName.Text;
                    ConfigurationService["InvoicingSignOccupation"] = txtSignOccupation.Text;

                    WebFormHelper.SetLabelTextWithCssClass(lblStatus, "Configuration has been saved", LabelStyleNames.InfoMessage);
                }
                catch (Exception ex)
                {
                    WebFormHelper.SetLabelTextForException(lblStatus, ex, LabelStyleNames.ErrorMessage);
                }
            }
        }
    }
}