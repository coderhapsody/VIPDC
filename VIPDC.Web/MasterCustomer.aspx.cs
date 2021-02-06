using System;
using System.Collections.Generic;
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
    public partial class MasterCustomer : BaseForm
    {
        [Inject]
        public CustomerProvider CustomerService { get; set; }

        [Inject]
        public JobPositionProvider JobPositionService { get; set; }

        [Inject]
        public InformationSourceProvider InformationSourceService { get; set; }

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

        protected void lnbAddNew_Click(object sender, EventArgs e)
        {
            mvwForm.SetActiveView(viwAddEdit);
            lblCustomerCode.Text = "(Auto-Generate)";
            txtName.Text = String.Empty;
            FillDropDown();
            txtName.Focus();
        }

        private void FillDropDown()
        {
            ddlJobPosition.DataSource = JobPositionService.GetActiveJobPositions();
            ddlJobPosition.DataTextField = "Name";
            ddlJobPosition.DataValueField = "ID";
            ddlJobPosition.DataBind();

            ddlInformationSource.DataSource = InformationSourceService.GetInformationSources();
            ddlInformationSource.DataBind();
            ddlInformationSource.Items.Insert(0, new DropDownListItem(String.Empty));
        }

        protected void lnbDelete_Click(object sender, EventArgs e)
        {
            try
            {
                int[] arrayOfID = RadHelper.GetRowIdForDeletion(RadGrid1);
                if (CustomerService.CanDeleteCustomer(arrayOfID))
                {
                    CustomerService.DeleteCustomer(arrayOfID);
                    btnCancel_Click(sender, e);
                }
            }
            catch (Exception ex)
            {                
                WebFormHelper.SetLabelTextWithCssClass(lblStatus, "Cannot delete customer referenced as participants or registered in confirmation letter.", LabelStyleNames.ErrorMessage);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Page.Validate("AddEdit");
            if (Page.IsValid)
            {
                try
                {                    
                    string customerCode = CustomerService.AddOrUpdateCustomer(
                        RowID,
                        txtName.Text,
                        rblCustomerType.SelectedValue,                        
                        dtpBirthDate.SelectedDate,
                        txtContactPersonName.Text,
                        rblGender.SelectedValue,
                        String.IsNullOrEmpty(ddlJobPosition.SelectedValue) ? 0 : Convert.ToInt32(ddlJobPosition.SelectedValue),
                        txtEmail.Text,
                        txtAddress.Text,
                        txtZipCode.Text,
                        txtWebsite.Text,
                        ddlInformationSource.SelectedItem == null ? String.Empty : ddlInformationSource.SelectedItem.Text,
                        new Dictionary<int, string>() {{1, txtCellPhone1.Text}, {2, txtCellPhone2.Text}},
                        new Dictionary<int, string>()
                        {
                            {1, txtSocialMediaNetwork1.Text},
                            {2, txtSocialMediaNetwork2.Text}
                        },
                        new Dictionary<int, string>() { { 1, txtWorkPhone1.Text }, { 2, txtWorkPhone2.Text } });

                    ReloadCurrentPage();
                }
                catch (Exception ex)
                {
                    WebFormHelper.SetLabelTextWithCssClass(lblStatusAddEdit, ex.Message, LabelStyleNames.ErrorMessage);
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ReloadCurrentPage();
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {            
            if (e.CommandName == "EditRow")
            {
                RowID = Convert.ToInt32(e.CommandArgument);
                var customer = CustomerService.GetCustomer(RowID);
                if (customer != null)
                {
                    mvwForm.SetActiveView(viwAddEdit);
                    FillDropDown();

                    lblCustomerCode.Text = customer.Code;
                    txtName.Text = customer.Name;
                    txtEmail.Text = customer.Email;
                    txtAddress.Text = customer.Address;
                    txtZipCode.Text = customer.ZipCode;
                    txtCellPhone1.Text = customer.CellPhone1;
                    txtCellPhone2.Text = customer.CellPhone2;
                    txtSocialMediaNetwork1.Text = customer.SocialMediaNetwork1;
                    txtSocialMediaNetwork2.Text = customer.SocialMediaNetwork2;
                    txtWebsite.Text = customer.Website;
                    txtWorkPhone1.Text = customer.WorkPhone1;
                    txtWorkPhone2.Text = customer.WorkPhone2;
                    ddlJobPosition.SelectedValue = Convert.ToString(customer.JobPositionId.GetValueOrDefault());
                    rblCustomerType.SelectedValue = customer.CustomerType;
                    rblGender.SelectedValue = customer.Gender;
                    dtpBirthDate.SelectedDate = customer.DateOfBirth;
                    ddlInformationSource.SelectedText = customer.InformationSource;
                    txtContactPersonName.Text = customer.ContactPersonName;
                    txtName.Focus();
                }
            }
        }

        protected void odsFilterJobPosition_ObjectCreating(object sender, ObjectDataSourceEventArgs e)
        {
            e.ObjectInstance = JobPositionService;
        }

        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@Name"].Value = txtFindName.Text;
            e.Command.Parameters["@CustomerType"].Value = ddlFindCustomerType.SelectedValue;
            e.Command.Parameters["@Gender"].Value = ddlFindGender.SelectedValue;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataBind();
        }
    }
}