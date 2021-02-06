using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common.CommandTrees.ExpressionBuilder;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ninject;
using Telerik.Web.UI;
using VIPDC.Providers;
using VIPDC.Providers.ViewModels;
using VIPDC.Web.Base;
using VIPDC.Web.Helpers;

namespace VIPDC.Web
{
    public partial class MasterRole : BaseForm
    {
        [Inject]
        public SecurityProvider SecurityService { get; set; }        

        public MenuPrivilege Privilege { get { return SecurityService.GetPrivilege(CurrentPageName); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
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

        protected void lnbAddNew_Click(object sender, EventArgs e)
        {
            mvwForm.SetActiveView(viwAddEdit);
            txtName.Text = String.Empty;
            chkIsActive.Checked = true;            
            txtName.Focus();
        }

        protected void lnbDelete_Click(object sender, EventArgs e)
        {
            try
            {
                int[] arrayOfID = RadHelper.GetRowIdForDeletion(RadGrid1);
                if (SecurityService.CanDeleteRoles(arrayOfID))
                {
                    SecurityService.DeleteRoles(arrayOfID);
                    btnCancel_Click(sender, e);
                }
            }
            catch (Exception ex)
            {
                WebFormHelper.SetLabelTextForException(lblStatus, ex, LabelStyleNames.ErrorMessage);
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
                SecurityService.AddOrUpdateRole(RowID, txtName.Text, chkIsActive.Checked);
                btnCancel_Click(sender, e);
            }
            catch (Exception ex)
            {
                WebFormHelper.SetLabelTextWithCssClass(lblStatusAddEdit, ex.Message, LabelStyleNames.ErrorMessage);
            }
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "EditRow")
            {
                mvwForm.SetActiveView(viwAddEdit);
                RowID = Convert.ToInt32(e.CommandArgument);
                var role = SecurityService.GetRole(RowID);
                txtName.Text = role.Name;
                chkIsActive.Checked = role.IsActive;
                txtName.Focus();
            }
        }

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.AlternatingItem || e.Item.ItemType == GridItemType.Item)
            {
                var dataRow = e.Item.DataItem as DataRowView;
                if (dataRow != null)
                {
                    if (Convert.ToString(dataRow["Name"]) == "Administrator")
                    {
                        (e.Item.FindControl("chkDelete") as CheckBox).Visible = false;
                        (e.Item.FindControl("imbEdit") as ImageButton).Visible = false;
                    }
                }
            }
        }
    }
}