using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VIPDC.Providers.ViewModels;
using VIPDC.Web.Base;
using VIPDC.Web.Helpers;
using Ninject;
using VIPDC.Providers;

namespace VIPDC.Web
{
    public partial class MasterJobPosition : BaseForm
    {
        [Inject]
        public JobPositionProvider JobPositionService { get; set; }

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

        protected void gvwMaster_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            WebFormHelper.HideGridViewRowId(e);
            WebFormHelper.ChangeBackgroundColorRowOnHover(e);
        }

        protected void lnbAddNew_Click(object sender, EventArgs e)
        {
            mvwForm.SetActiveView(viwAddEdit);
            txtName.Text = String.Empty;
            txtName.Focus();
        }

        protected void lnbDelete_Click(object sender, EventArgs e)
        {
            try
            {
                int[] arrayOfID = RadHelper.GetRowIdForDeletion(RadGrid1);
                if (JobPositionService.CanDeleteJobPositions(arrayOfID))
                {
                    JobPositionService.DeleteJobPositions(arrayOfID);
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
                JobPositionService.AddOrUpdateJobPosition(RowID, txtName.Text);
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
                RowID = Convert.ToInt32(e.CommandArgument);
                var classType = JobPositionService.GetJobPosition(RowID);
                txtName.Text = classType.Name;
                txtName.Focus();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataBind();
        }

        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@Name"].Value = txtFindName.Text;
        }
    }
}