using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ninject;
using VIPDC.Data;
using VIPDC.Providers;
using VIPDC.Providers.ViewModels;
using VIPDC.Web.Base;
using VIPDC.Web.Helpers;

namespace VIPDC.Web
{
    public partial class MasterBank : BaseForm
    {
        [Inject]
        public BankProvider BankService { get; set; }
        [Inject]
        public SecurityProvider SecurityService { get; set; }

        public MenuPrivilege Privilege { get { return SecurityService.GetPrivilege(CurrentPageName); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                mvwForm.SetActiveView(viwRead);
                RadHelper.SetUpGrid(RadGrid1);                
            }
        }

        protected override void OnLoadComplete(EventArgs e)
        {
            if (mvwForm.GetActiveView() == viwRead)
            {
                lnbDelete.Enabled = Privilege.AllowDelete;
                if (RowID == 0)
                    lnbAddNew.Enabled = Privilege.AllowAddNew;
            }
            else
            {
                btnSave.Enabled = RowID == 0 ? Privilege.AllowAddNew : Privilege.AllowUpdate;
            }
        }  

        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@BankName"].Value = txtFindBankName.Text;
            e.Command.Parameters["@AccountName"].Value = txtFindAccountName.Text;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Page.Validate("AddEdit");
            if (Page.IsValid)
            {
                try
                {
                    BankService.AddOrUpdateBank(RowID, txtName.Text, txtAccountName.Text, txtAccountNumber.Text);
                    ReloadCurrentPage();
                }
                catch (Exception ex)
                {
                    WebFormHelper.SetLabelTextForException(lblStatusAddEdit, ex, LabelStyleNames.ErrorMessage);
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ReloadCurrentPage();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataBind();
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "EditRow")
            {
                mvwForm.SetActiveView(viwAddEdit);
                RowID = Convert.ToInt32(e.CommandArgument);
                var bank = BankService.GetBank(RowID);
                txtName.Text = bank.Name;
                txtAccountName.Text = bank.AccountName;
                txtAccountNumber.Text = bank.AccountNumber;
                txtName.Focus();    
            }
        }

        protected void lnbAddNew_Click(object sender, EventArgs e)
        {
            mvwForm.SetActiveView(viwAddEdit);
            txtName.Focus();
        }

        protected void lnbDelete_Click(object sender, EventArgs e)
        {
            try
            {
                int[] arrayOfID = RadHelper.GetRowIdForDeletion(RadGrid1);
                if (BankService.CanDeleteBank(arrayOfID))
                {
                    BankService.DeleteBank(arrayOfID);
                    btnCancel_Click(sender, e);
                }
            }
            catch (Exception ex)
            {
                WebFormHelper.SetLabelTextForException(lblStatus, ex, LabelStyleNames.ErrorMessage);
            }
        }
    }
}