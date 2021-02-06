using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel.Channels;
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
    public partial class ReceiveConfirmationLetter : BaseForm   
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
            }
        }

        protected override void OnLoadComplete(EventArgs e)
        {
            if(btnSave.Enabled)
                btnSave.Enabled = Privilege.AllowUpdate;
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

                    if (letter.LetterReceiveDate.HasValue)
                    {
                        WebFormHelper.SetLabelTextWithCssClass(lblStatus,
                            String.Format("Confirmation Letter {0} has been received at {1}",
                                txtConfirmationLetterNo.Text,
                                letter.LetterReceiveDate.GetValueOrDefault().ToLongDateString()),
                            LabelStyleNames.ErrorMessage);
                        return;
                    }
                }

                txtConfirmationLetterNo.ReadOnly = true;
                ConfirmationLetterDetail1.LoadConfirmationLetter(txtConfirmationLetterNo.Text);
                dtpReceiveDate.SelectedDate = DateTime.Today;
                pnlReceiveDate.Visible = true;
                dtpReceiveDate.Focus();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ReloadCurrentPage();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                ConfirmationLetterService.ReceiveConfirmationLetter(txtConfirmationLetterNo.Text,
                    dtpReceiveDate.SelectedDate.GetValueOrDefault(DateTime.Today));

                WebFormHelper.SetLabelTextWithCssClass(lblStatus,
                    String.Format("Confirmation Letter {0} has been received.", txtConfirmationLetterNo.Text),
                    LabelStyleNames.InfoMessage);

                btnSave.Enabled = btnCancel.Enabled = false;
                dtpReceiveDate.Enabled = false;
                btnRefresh.Enabled = false;
                dtpReceiveDate.DataBind();
            }
            catch (Exception ex)
            {
                WebFormHelper.SetLabelTextWithCssClass(lblStatus, ex.InnerException.Message, LabelStyleNames.ErrorMessage);
            }
        }
    }
}