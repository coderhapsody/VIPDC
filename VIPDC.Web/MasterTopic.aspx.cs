using System;
using System.Collections.Generic;
using System.Data.Common.CommandTrees.ExpressionBuilder;
using System.IO;
using System.Linq;
using System.Security.AccessControl;
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
    public partial class MasterTopic : BaseForm
    {
        [Inject]
        public TrainingProvider TrainingService { get; set; }

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
            txtCode.Text = txtName.Text = String.Empty;
            chkIsActive.Checked = true;            
            txtCode.Focus();
        }

        protected void lnbDelete_Click(object sender, EventArgs e)
        {
            try
            {
                int[] arrayOfID = RadHelper.GetRowIdForDeletion(RadGrid1);
                if (TrainingService.CanDeleteTopics(arrayOfID))
                {
                    TrainingService.DeleteTopics(arrayOfID);
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
                TrainingService.AddOrUpdateTopic(RowID, txtCode.Text, txtName.Text, chkIsActive.Checked);
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
                var topic = TrainingService.GetTopic(RowID);
                txtCode.Text = topic.Code;
                txtName.Text = topic.Name;
                chkIsActive.Checked = topic.IsActive;
                txtName.Focus();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataBind();
        }

        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@Code"].Value = txtFindCode.Text;
            e.Command.Parameters["@Name"].Value = txtFindName.Text;
        }
    }
}