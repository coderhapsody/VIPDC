using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
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
    public partial class TrxPayment : BaseForm
    {
        [Inject]
        public InvoiceProvider InvoiceService { get; set; }

        [Inject]
        public SecurityProvider SecurityService { get; set; }

        public MenuPrivilege Privilege { get { return SecurityService.GetPrivilege(CurrentPageName); } }

        public List<PaymentViewModel> PaymentDetail
        {
            get
            {
                if (ViewState["Payment"] == null)
                    ViewState["Payment"] = new List<PaymentViewModel>();
                return ViewState["Payment"] as List<PaymentViewModel>;
            }
            set
            {                
                ViewState["Payment"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                mvwForm.SetActiveView(viwRead);
                RadHelper.SetUpGrid(RadGrid1);
                mypFindInvoice.SelectedDate = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);                
            }
        }

        protected override void OnLoadComplete(EventArgs e)
        {
            //if (mvwForm.GetActiveView() == viwRead)
            //{
            //    btnVoid.Enabled = Privilege.AllowDelete;
            //    if (RowID == 0)
            //        lnbAddNew.Enabled = Privilege.AllowAddNew;
            //}
            //else
            //{
            //    if (btnSave.Enabled)
            //        btnSave.Enabled = RowID == 0 ? Privilege.AllowAddNew : Privilege.AllowUpdate;
            //}
        }


        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@InvoiceMonth"].Value =
                mypFindInvoice.SelectedDate.GetValueOrDefault(DateTime.Today).Month;
            e.Command.Parameters["@InvoiceYear"].Value =
                mypFindInvoice.SelectedDate.GetValueOrDefault(DateTime.Today).Year;
            e.Command.Parameters["@Customer"].Value = txtFindCustomer.Text;
            e.Command.Parameters["@OnlyOutstandingInvoices"].Value = chkActiveOnly.Checked;

        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "EditRow")
            {
                mvwForm.SetActiveView(viwAddEdit);
                RowID = Convert.ToInt32(e.CommandArgument);
                var invoice = InvoiceService.GetInvoice(RowID);
                InvoiceDetail1.LoadInvoice(invoice.InvoiceNo);
                PaymentDetail = InvoiceService.GetPaymentDetail(invoice.InvoiceNo).ToList();
                LoadPaymentDetail();
                
            }
        }

        private void LoadPaymentDetail()
        {         
            RadGridPayment.DataSource = PaymentDetail;
            RadGridPayment.DataBind();

            lblTotalPayment.Text = PaymentDetail.Where(pvm => !pvm.Void).Sum(pvm => pvm.Amount).ToString("N");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataBind();
        }

        protected void btnAddPayment_Click(object sender, EventArgs e)
        {
            var pvm = new PaymentViewModel
                      {
                          ID = PaymentDetail.Count == 0 ? 1 : PaymentDetail.Max(pay => pay.ID) + 1,
                          PaymentType = ddlPaymentType.SelectedValue,
                          PaymentDate = DateTime.Today,
                          Amount = Convert.ToDecimal(ntbAmount.Value),
                          Notes = txtPaymentNotes.Text,
                          ApprovalCode = txtApprovalCode.Text,
                          IsNew = true
                      };            
            PaymentDetail.Add(pvm);
            LoadPaymentDetail();
            ddlPaymentType.SelectedIndex = -1;
            txtApprovalCode.Text = txtPaymentNotes.Text = String.Empty;
            ntbAmount.Value = 0;
            ddlPaymentType.Focus();
        }

        protected void RadGridPayment_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                PaymentDetail.Remove(PaymentDetail.Single(pvm => pvm.ID == id));
                LoadPaymentDetail();
            }
            else
            {
                int id = Convert.ToInt32(e.CommandArgument);                
            }
        }

        protected void RadGridPayment_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.AlternatingItem || e.Item.ItemType == GridItemType.Item)
            {
                var dataRow = e.Item.DataItem as PaymentViewModel;

                if (dataRow.Void)
                {
                    e.Item.BackColor = Color.LightCoral;
                }

                var lnbAction = e.Item.FindControl("lnbAction") as LinkButton;
                if (lnbAction != null)
                {
                    if (dataRow.IsNew)
                    {
                        lnbAction.Text = "Delete";
                        lnbAction.CommandName = "DeleteRow";
                        lnbAction.OnClientClick = "return confirm('Delete current payment ?')";
                        lnbAction.CommandArgument = dataRow.ID.ToString(CultureInfo.InvariantCulture);
                    }
                    else
                    {
                        if (dataRow.Void)
                            lnbAction.Visible = false;
                        else
                        {
                            lnbAction.Visible = true;
                            lnbAction.Text = "Void";
                            lnbAction.OnClientClick =
                                String.Format("ConfirmVoid({0}, '{1}', '{2}', '{3}'); return false;",
                                    dataRow.ID,
                                    dataRow.PaymentType,
                                    dataRow.Amount.ToString("N"),
                                    dataRow.Notes);
                        }
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            InvoiceService.UpdatePayment(RowID, PaymentDetail);
            ReloadCurrentPage();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ReloadCurrentPage();
        }

        protected void btnProcessVoid_Click(object sender, EventArgs e)
        {
            int paymentID = Convert.ToInt32(hidPaymentID.Value);
            string reason = txtVoidReason.Text;

            var paymentDetail = PaymentDetail.Single(pay => pay.ID == paymentID);
            paymentDetail.Void = true;
            paymentDetail.VoidReason = reason;

            LoadPaymentDetail();
        }
    }
}