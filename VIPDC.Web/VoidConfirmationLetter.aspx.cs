using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ninject;
using VIPDC.Providers;
using VIPDC.Providers.ViewModels;
using VIPDC.Web.Base;
using VIPDC.Web.Helpers;

namespace VIPDC.Web
{
    public partial class VoidConfirmationLetter : BaseForm
    {
        [Inject]
        public ConfirmationLetterProvider ConfirmationLetterService { get; set; }

        [Inject]
        public SecurityProvider SecurityService { get; set; }

        public MenuPrivilege Privilege { get { return SecurityService.GetPrivilege(CurrentPageName); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                pnlReceiveDate.Visible = false;
                hypCLRef.Attributes.Add("onclick", "showPromptPopUp('PromptConfirmationLetter.aspx?ExcludeVoid=1&CLNo=" + txtConfirmationLetterNo.ClientID + "&CurrentCLNo=', null, 550, 1000);");
            }
        }

        protected override void OnLoadComplete(EventArgs e)
        {
            if(btnVoid.Enabled)
                btnVoid.Enabled = Privilege.AllowUpdate;
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            Page.Validate("Search");
            if (Page.IsValid)
            {
                var letter = ConfirmationLetterService.GetConfirmationLetter(txtConfirmationLetterNo.Text);
                if (letter == null)
                {
                    WebFormHelper.SetLabelTextWithCssClass(lblStatus,
                        String.Format("Cannot find Confirmation Letter {0}", txtConfirmationLetterNo.Text),
                        LabelStyleNames.ErrorMessage);
                    return;
                }
                else
                {
                    if (letter.VoidDate.HasValue)
                    {
                        WebFormHelper.SetLabelTextWithCssClass(lblStatus,
                            String.Format("Confirmation Letter {0} has been marked as void.",
                                txtConfirmationLetterNo.Text),
                            LabelStyleNames.ErrorMessage);
                        return;
                    }
                }

                txtConfirmationLetterNo.ReadOnly = true;
                ConfirmationLetterDetail1.LoadConfirmationLetter(txtConfirmationLetterNo.Text);
                pnlReceiveDate.Visible = true;
                txtReason.Focus();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ReloadCurrentPage();
        }

        protected void btnVoid_Click(object sender, EventArgs e)
        {
            try
            {
                if (ConfirmationLetterService.HasInvoiceOrPayment(txtConfirmationLetterNo.Text))
                {
                    WebFormHelper.SetLabelTextWithCssClass(lblStatus,
                        String.Format("Confirmation Letter {0} has active either invoice or payment. Please void invoice and payment first.", txtConfirmationLetterNo.Text),
                        LabelStyleNames.ErrorMessage);
                    return;
                }

                ConfirmationLetterService.VoidConfirmationLetter(txtConfirmationLetterNo.Text, txtReason.Text);                    

                WebFormHelper.SetLabelTextWithCssClass(lblStatus,
                    String.Format("Confirmation Letter {0} has been marked as void.", txtConfirmationLetterNo.Text),
                    LabelStyleNames.InfoMessage);

                btnVoid.Enabled = btnCancel.Enabled = false;
                txtReason.Enabled = false;
                btnRefresh.Enabled = false;
                hypCLRef.Visible = false;
            }
            catch (Exception ex)
            {
                WebFormHelper.SetLabelTextWithCssClass(lblStatus, ex.InnerException.Message, LabelStyleNames.ErrorMessage);
            }
        }

        
    }
}