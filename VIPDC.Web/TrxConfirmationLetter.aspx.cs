using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ninject;
using Telerik.Web.UI;
using VIPDC.Data;
using VIPDC.Providers;
using VIPDC.Providers.Extensions;
using VIPDC.Providers.ViewModels;
using VIPDC.Web.Base;
using VIPDC.Web.Helpers;

namespace VIPDC.Web
{
    public partial class TrxConfirmationLetter : BaseForm
    {
        [Inject]
        public ConfirmationLetterProvider ConfirmationLetterService { get; set; }

        [Inject]
        public TrainingProvider TrainingService { get; set; }

        [Inject]
        public EmployeeProvider EmployeeService { get; set; }

        [Inject]
        public BankProvider BankService { get; set; }

        [Inject]
        public SecurityProvider SecurityService { get; set; }

        public MenuPrivilege Privilege { get { return SecurityService.GetPrivilege(CurrentPageName); } }

        public List<DateTime> TrainingDates
        {
            get
            {
                if (ViewState["TrainingDates"] == null)
                    ViewState["TrainingDates"] = new List<DateTime>();
                return ViewState["TrainingDates"] as List<DateTime>;                
            }
            set
            {
                ViewState["TrainingDates"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                mvwForm.SetActiveView(viwRead);                
                RadHelper.SetUpGrid(RadGrid1);
            }
        }

        private void FillDropDown()
        {
            cboAccountManager.DataSource = EmployeeService.GetAccountManagers();
            cboAccountManager.DataTextField = "Name";
            cboAccountManager.DataValueField = "ID";
            cboAccountManager.DataBind();

            ddlClassType.DataSource = TrainingService.GetClassTypes();
            ddlClassType.DataTextField = "Name";
            ddlClassType.DataValueField = "ID";
            ddlClassType.DataBind();

            ddlTopic.DataSource = TrainingService.GetTopics();
            ddlTopic.DataTextField = "Name";
            ddlTopic.DataValueField = "ID";
            ddlTopic.DataBind();

            cblModule.DataSource = TrainingService.GetModules(RowID == 0);
            cblModule.DataTextField = "Name";
            cblModule.DataValueField = "ID";
            cblModule.DataBind();

            ddlBank.DataSource = BankService.GetBanksDetail();
            ddlBank.DataTextField = "Value";
            ddlBank.DataValueField = "Key";
            ddlBank.DataBind();
        }

        protected override void OnLoadComplete(EventArgs e)
        {
            if (mvwForm.GetActiveView() == viwRead)
            {
                //lnbDelete.Enabled = Privilege.AllowDelete;
                if (RowID == 0)
                    lnbAddNew.Enabled = Privilege.AllowAddNew;
            }
            else
            {
                btnSave.Enabled = RowID == 0 ? Privilege.AllowAddNew : Privilege.AllowUpdate;
            }
        }       

        protected void lnbAddNew_Click(object sender, EventArgs e)
        {
            mvwForm.SetActiveView(viwAddEdit);
            FillDropDown();
            ntbPrice.Text = "0";
            ntbTax.Text = "0";
            ntbPPH.Text = "0";
            ntbTotalPrice.Text = "0";
            ntbDiscount.Text = "0";
            //dtpTrainingDate.SelectedDate = DateTime.Today;
            cboAccountManager.SelectedIndex = -1;
            ntbTotalParticipants.Value = 1;
            hypCLRef.Attributes.Add("onclick", "showPromptPopUp('PromptConfirmationLetter.aspx?CLNo=ctl00_cphMainContent_txtCLRef&CurrentCLNo=', null, 550, 1000);");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ReloadCurrentPage();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Page.Validate(WebFormHelper.AddEditValidationGroup);

            if (!Page.IsValid) return;

            try
            {
                if (TrainingDates.Count == 0)
                {
                    WebFormHelper.SetLabelTextWithCssClass(lblStatusAddEdit, "One or more Training Date must be specified", LabelStyleNames.ErrorMessage);
                    return;
                }
                ConfirmationLetterService.AddOrUpdateConfirmationLetter(RowID, DateTime.Today, 
                    Convert.ToInt32(cboAccountManager.SelectedValue),
                    hidCustomerCode.Value,
                    TrainingDates,
                    txtTrainingLocation.Text,
                    txtDescription.Text,
                    Convert.ToInt32(ddlClassType.SelectedValue),
                    Convert.ToInt32(ddlTopic.SelectedValue),
                    Convert.ToDecimal(ntbPrice.Value.GetValueOrDefault()),
                    Convert.ToDecimal(ntbTax.Value.GetValueOrDefault()),
                    Convert.ToDecimal(ntbPPH.Value.GetValueOrDefault()),
                    Convert.ToDecimal(ntbDiscount.Value.GetValueOrDefault()),
                    Convert.ToInt32(ddlBank.SelectedValue),
                    dtpPaymentDueDate.SelectedDate.GetValueOrDefault(),
                    txtCLRef.Text,
                    Convert.ToInt32(ntbTotalParticipants.Value),
                    cblModule.Items.Cast<ListItem>().Where(item => item.Selected).Select(item => Convert.ToInt32(item.Value)).ToArray()
                    );
                btnCancel_Click(sender, e);
            }
            catch (Exception ex)
            {
                WebFormHelper.SetLabelTextWithCssClass(lblStatusAddEdit, ex.Message, LabelStyleNames.ErrorMessage);
            }
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "EditRow")
            {
                mvwForm.SetActiveView(viwAddEdit);
                FillDropDown();
                RowID = Convert.ToInt32(e.CommandArgument);

                var letter = ConfirmationLetterService.GetConfirmationLetter(RowID);
                var customer = letter.Customer;
                var refLetter = letter.ConfirmationLetter2;

                lblConfirmationLetterNo.Text = letter.LetterNo;
                cboAccountManager.SelectedValue = letter.AccountManagerID.ToString();
                txtCustomerName.Text = customer.Name;
                hidCustomerCode.Value = customer.Code;                
                txtTrainingLocation.Text = letter.TrainingLocation;
                txtDescription.Text = letter.Description;
                ddlClassType.SelectedValue = letter.ClassTypeID.ToString();
                ddlTopic.SelectedValue = letter.TopicID.ToString();
                txtCLRef.Text = refLetter == null ? String.Empty : refLetter.LetterNo;
                ntbPrice.Value = Convert.ToDouble(letter.Price);
                ntbTax.Value = Convert.ToDouble(letter.Tax);
                ntbPPH.Value = Convert.ToDouble(letter.PPH);
                ntbDiscount.Value = Convert.ToDouble(letter.Discount);
                ntbTotalPrice.Value = Convert.ToDouble(letter.TotalPrice);
                ddlBank.SelectedValue = Convert.ToString(letter.TransferToBankID.GetValueOrDefault());
                dtpPaymentDueDate.SelectedDate = letter.PaymentDueDate;
                ntbTotalParticipants.Value = letter.TotalParticipants;
                letter.Modules.ForEach(module => cblModule.Items.Cast<ListItem>().SingleOrDefault(item => item.Value == module.ID.ToString(CultureInfo.InvariantCulture)).Selected = true);

                hypCLRef.Attributes.Add("onclick", "window.open('PromptConfirmationLetter.aspx?CLNo=ctl00_cphMainContent_txtCLRef&CurrentCLNo="+ letter.LetterNo+"', null, 550, 1000);");

                cboAccountManager.Focus();

                if (letter.VoidDate.HasValue)
                {
                    btnSave.Enabled = false;
                    WebFormHelper.SetLabelTextWithCssClass(lblStatusAddEdit, "This letter has been marked as void", LabelStyleNames.ErrorMessage);
                }

                TrainingDates = ConfirmationLetterService.GetTrainingDates(RowID).Select(date => date.Date).ToList();
                LoadTrainingDates();
                //txtName.Focus();
            }
        }

        private void LoadTrainingDates()
        {
            grdTrainingDates.DataSource = TrainingDates.OrderBy(d => d);
            grdTrainingDates.DataBind();            
        }

        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@LetterNo"].Value = txtFindCLNo.Text;
            e.Command.Parameters["@Customer"].Value = txtFindCustomer.Text;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataBind();
        }

        protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                var hypPrintInvoice = e.Item.FindControl("hypPrintInvoice") as HyperLink;
                var dataRow = e.Item.DataItem as DataRowView;

                if (dataRow == null) return;

                hypPrintInvoice.Attributes.Add("onclick", String.Format("showSimplePopUp('ReportPreview.aspx?ReportName={0}&LetterNo={1}')", "ConfirmationLetter", dataRow["LetterNo"]));
            }
        }

        protected void btnAddTrainingDate_Click(object sender, EventArgs e)
        {
            if (TrainingDates.Any(date => date == dtpTrainingDate.SelectedDate.GetValueOrDefault()))
            {
                dtpTrainingDate.Clear();
                return;
            }
                
            
            TrainingDates.Add(dtpTrainingDate.SelectedDate.GetValueOrDefault());
            LoadTrainingDates();

            dtpTrainingDate.Clear();
        }

        protected void grdTrainingDates_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "DeleteTrainingDate")
            {
                try
                {
                    DateTime date = Convert.ToDateTime(e.CommandArgument);
                    TrainingDates.Remove(date);
                    LoadTrainingDates();
                }
                catch(Exception ex)
                {
                    WebFormHelper.SetLabelTextForException(lblStatusAddEdit, ex, LabelStyleNames.ErrorMessage);
                }
            }
        }
    }
}