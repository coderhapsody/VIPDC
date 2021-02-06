using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
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
    public partial class MasterEmployee : BaseForm
    {
        [Inject]
        public SecurityProvider SecurityService { get; set; }

        [Inject]
        public EmployeeProvider EmployeeService { get; set; }

        public MenuPrivilege Privilege { get { return SecurityService.GetPrivilege(CurrentPageName); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                mvwForm.SetActiveView(viwRead);
                RadHelper.SetUpGrid(RadGrid1);
                FillDropDown();
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

        private void FillDropDown()
        {
            ddlRole.DataSource = SecurityService.GetAllRoles(RowID == 0);
            ddlRole.DataTextField = "Name";
            ddlRole.DataValueField = "ID";
            ddlRole.DataBind();
            
            ddlFindRole.DataSource = SecurityService.GetAllRoles();
            ddlFindRole.DataTextField = "Name";
            ddlFindRole.DataValueField = "ID";
            ddlFindRole.DataBind();
            ddlFindRole.Items.Insert(0, new DropDownListItem("All", "0"));
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Page.Validate("AddEdit");
            if (Page.IsValid)
            {
                try
                {
                    EmployeeService.AddOrUpdateEmployee(RowID,
                    txtCode.Text,
                    txtName.Text,
                    txtInitial.Text,
                    rblGender.SelectedValue,
                    txtEmail.Text,
                    Convert.ToInt32(ddlRole.SelectedValue),
                    chkIsAllowLogin.Checked,
                    chkIsActive.Checked,
                    chkIsAllowBackdate.Checked,
                    new Dictionary<int, string> { { 1, txtCellPhone1.Text }, { 2, txtCellPhone2.Text } },
                    RadColorPicker1.SelectedColor.ToArgb());

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

        protected void lnbAddNew_Click(object sender, EventArgs e)
        {
            mvwForm.SetActiveView(viwAddEdit);
            chkIsActive.Checked = true;
            FillDropDown();
            txtCode.Focus();
        }

        protected void lnbDelete_Click(object sender, EventArgs e)
        {
            try
            {
                int[] arrayOfID = RadHelper.GetRowIdForDeletion(RadGrid1);
                if (EmployeeService.CanDeleteEmployee(arrayOfID))
                {
                    EmployeeService.DeleteEmployee(arrayOfID);
                    btnCancel_Click(sender, e);
                }
            }
            catch (Exception ex)
            {
                WebFormHelper.SetLabelTextForException(lblStatus, ex, LabelStyleNames.ErrorMessage);
            }
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "EditRow")
            {
                RowID = Convert.ToInt32(e.CommandArgument);
                mvwForm.SetActiveView(viwAddEdit);
                FillDropDown();               
                
                var emp = EmployeeService.GetEmployee(RowID);
                if (emp != null)
                {
                    txtCode.Text = emp.UserName;
                    txtInitial.Text = emp.Initial;
                    txtEmail.Text = emp.Email;
                    txtName.Text = emp.Name;
                    txtCellPhone1.Text = emp.CellPhone1;
                    txtCellPhone2.Text = emp.CellPhone2;
                    ddlRole.SelectedValue = Convert.ToString(emp.RoleID);
                    rblGender.SelectedValue = emp.Gender;
                    chkIsActive.Checked = emp.IsActive;
                    chkIsAllowLogin.Checked = emp.IsAllowLogin;
                    chkIsAllowBackdate.Checked = emp.IsAllowBackdate;
                    txtName.ReadOnly = txtName.Text == "Administrator";
                    RadColorPicker1.SelectedColor = Color.FromArgb(emp.BackColor.GetValueOrDefault(-1));
                    txtCode.Focus();
                }
            }
        }

        protected void odsFilterRoleName_ObjectCreating(object sender, ObjectDataSourceEventArgs e)
        {
            e.ObjectInstance = SecurityService;
        }

        protected void odsFilterRoleName_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            e.InputParameters["forAddNew"] = false;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataBind();
        }

        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@UserName"].Value = txtFindCode.Text;
            e.Command.Parameters["@Name"].Value = txtFindName.Text;
            e.Command.Parameters["@RoleID"].Value = String.IsNullOrEmpty(ddlFindRole.SelectedValue) ? 0 : Convert.ToInt32(ddlFindRole.SelectedValue);
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
                    }

                    if (SecurityService.GetRoleName(User.Identity.Name) != "Administrator")
                    {
                        (e.Item.FindControl("imbEdit") as ImageButton).Visible = false;
                    }
                }
            }
        }
    }
}