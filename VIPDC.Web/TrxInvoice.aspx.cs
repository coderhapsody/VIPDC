using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ninject;
using Telerik.Web.UI;
using VIPDC.Data;
using VIPDC.Providers;
using VIPDC.Providers.ViewModels;
using VIPDC.Web.Base;
using VIPDC.Web.Helpers;

namespace VIPDC.Web
{
    public partial class TrxInvoice : BaseForm
    {
        [Inject]
        public BankProvider BankService { get; set; }

        [Inject]
        public InvoiceProvider InvoiceService { get; set; }

        [Inject]
        public EmployeeProvider EmployeeService { get; set; }

        [Inject]
        public SecurityProvider SecurityService { get; set; }

        public MenuPrivilege Privilege { get { return SecurityService.GetPrivilege(CurrentPageName); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                mvwForm.SetActiveView(viwRead);
                RadHelper.SetUpGrid(RadGrid1);
                dtpFindPurchaseDateFrom.SelectedDate = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                dtpFindPurchaseDateTo.SelectedDate = new DateTime(DateTime.Today.Year, DateTime.Today.Month, DateTime.Today.Day);
                FillDropDown();
            }
        }

        private void FillDropDown()
        {
            ddlBank.DataSource = BankService.GetBanksDetail();
            ddlBank.DataTextField = "Value";
            ddlBank.DataValueField = "Key";
            ddlBank.DataBind();
        }

        protected override void OnLoadComplete(EventArgs e)
        {
            if (mvwForm.GetActiveView() == viwRead)
            {
                btnVoid.Enabled = Privilege.AllowDelete;
                if (RowID == 0)
                    lnbAddNew.Enabled = Privilege.AllowAddNew;
            }
            else
            {
                if(btnSave.Enabled)
                    btnSave.Enabled = RowID == 0 ? Privilege.AllowAddNew : Privilege.AllowUpdate;
            }
        }


        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@InvoiceNo"].Value = txtFindInvoiceNo.Text;
            e.Command.Parameters["@PurchaseDateFrom"].Value = dtpFindPurchaseDateFrom.SelectedDate.GetValueOrDefault(SqlDateTime.MinValue.Value);
            e.Command.Parameters["@PurchaseDateTo"].Value = dtpFindPurchaseDateTo.SelectedDate.GetValueOrDefault(SqlDateTime.MaxValue.Value);
            e.Command.Parameters["@Customer"].Value = txtFindCustomer.Text;
            e.Command.Parameters["@ActiveOnly"].Value = chkActiveOnly.Checked;
        }

        protected void lnbAddNew_Click(object sender, EventArgs e)
        {            
            mvwForm.SetActiveView(viwAddEdit);
            ResetControls();
            btnVoid.Enabled = false;
            dtpDate.Enabled = EmployeeService.IsAllowBackdate(User.Identity.Name);
            dtpDate.MaxDate = DateTime.Today;
            txtConfirmationLetterNo.Focus();
        }

        private void ResetControls()
        {            
            txtConfirmationLetterNo.Text = String.Empty;
            ntbPrice.Value = 0;
            ntbTax.Value = 0;
            ntbPPH.Value = 0;
            ntbTotalInvoice.Value = 0;
            ntbDiscount.Text = "0";
            dtpPaymentDueDate.SelectedDate = DateTime.Today;
            lblInvoiceNo.Text = "(Auto)";
            dtpDate.SelectedDate = DateTime.Today;
            //txtConfirmationLetterNo.ReadOnly = false;
            txtNotes.Text = String.Empty;
            hypLookUpCL.Visible = true;
            hypLookUpCL.Attributes.Add("onclick",
                "showPromptPopUp('PromptConfirmationLetterUnInvoice.aspx?CLNo=" + txtConfirmationLetterNo.ClientID +
                "', null, 550, 1000);");
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "EditRow")
            {
                mvwForm.SetActiveView(viwAddEdit);                
                RowID = Convert.ToInt32(e.CommandArgument);
                dtpDate.Enabled = EmployeeService.IsAllowBackdate(User.Identity.Name);
                dtpDate.MaxDate = DateTime.Today;

                var invoice = InvoiceService.GetInvoice(RowID);
                var confirmationLetter = invoice.ConfirmationLetter;

                lblInvoiceNo.Text = invoice.InvoiceNo;
                txtConfirmationLetterNo.Text = confirmationLetter.LetterNo;
                
                dtpDate.SelectedDate = invoice.Date;
                txtNotes.Text = invoice.Notes;
                dtpPaymentDueDate.SelectedDate = invoice.PaymentDueDate;
                ntbPrice.Value = Convert.ToDouble(invoice.Price);
                ntbTax.Value = Convert.ToDouble(invoice.Tax);
                ntbPPH.Value = Convert.ToDouble(invoice.PPH);
                ntbDiscount.Value = Convert.ToDouble(invoice.Discount);
                ntbTotalInvoice.Value = Convert.ToDouble(invoice.TotalPrice);
                hypLookUpCL.Visible = false;
                ddlBank.SelectedValue = Convert.ToString(invoice.TransferToBankID.GetValueOrDefault());
                //txtConfirmationLetterNo.ReadOnly = true;

                if (invoice.VoidDate.HasValue)
                {
                    btnVoid.Enabled = false;
                    btnSave.Enabled = false;
                    WebFormHelper.SetLabelTextWithCssClass(lblStatusAddEdit, "This invoice has been marked as void", LabelStyleNames.ErrorMessage);
                }
            }
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
                InvoiceService.AddOrUpdateInvoice(RowID,
                    txtConfirmationLetterNo.Text,
                    dtpDate.SelectedDate.GetValueOrDefault(DateTime.Today),
                    txtNotes.Text,
                    dtpPaymentDueDate.SelectedDate.GetValueOrDefault(DateTime.Today),
                    Convert.ToDecimal(ntbPrice.Value),
                    Convert.ToDecimal(ntbTax.Value),
                    Convert.ToDecimal(ntbPPH.Value),
                    Convert.ToDecimal(ntbDiscount.Value),
                    Convert.ToInt32(ddlBank.SelectedValue));

                btnCancel_Click(sender, e);
            }
            catch (Exception ex)
            {
                WebFormHelper.SetLabelTextWithCssClass(lblStatusAddEdit, ex.Message, LabelStyleNames.ErrorMessage);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataBind();
        }

        protected void btnProcessVoid_Click(object sender, EventArgs e)
        {
            try
            {
                string invoiceNo = lblInvoiceNo.Text;

                if (InvoiceService.HasPayments(lblInvoiceNo.Text))
                {
                    WebFormHelper.SetLabelTextWithCssClass(lblStatusAddEdit,
                        String.Format("Invoice {0} has active payments. Please void all of the payments first.", invoiceNo),
                        LabelStyleNames.ErrorMessage);
                    return;
                }

                
                InvoiceService.VoidInvoice(invoiceNo, txtVoidReason.Text);
                mvwForm.SetActiveView(viwRead);
                ResetControls();
                WebFormHelper.SetLabelTextWithCssClass(lblStatus,
                    String.Format("Invoice {0} has been marked as void", invoiceNo),
                    LabelStyleNames.InfoMessage);
                RadGrid1.DataBind();
            }
            catch (Exception ex)
            {
                WebFormHelper.SetLabelTextWithCssClass(lblStatus, ex.Message, LabelStyleNames.ErrorMessage);
            }
        }

        protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                var hypPrintInvoice = e.Item.FindControl("hypPrintInvoice") as HyperLink;
                var hypPrintKwitansi= e.Item.FindControl("hypPrintKwitansi") as HyperLink;
                var dataRow = e.Item.DataItem as DataRowView;

                if (dataRow == null) return;

                hypPrintInvoice.Attributes.Add("onclick", String.Format("showSimplePopUp('ReportPreview.aspx?ReportName={0}&InvoiceNo={1}')", "Invoice", dataRow["InvoiceNo"]));
                hypPrintKwitansi.Attributes.Add("onclick", String.Format("showSimplePopUp('ReportPreview.aspx?ReportName={0}&InvoiceNo={1}')", "Kwitansi", dataRow["InvoiceNo"]));
            }
        }
    }
}