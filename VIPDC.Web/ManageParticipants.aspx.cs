using System;
using System.Collections.Generic;
using System.Data;
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
    public partial class ManageParticipants : BaseForm
    {
        [Inject]
        public ConfirmationLetterProvider ConfirmationLetterService { get; set; }

        [Inject]
        public CustomerProvider CustomerService { get; set; }

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

        private void FillDropDown()
        {
            ddlCustJobPosition.DataSource = JobPositionService.GetActiveJobPositions();
            ddlCustJobPosition.DataTextField = "Name";
            ddlCustJobPosition.DataValueField = "ID";
            ddlCustJobPosition.DataBind();
        }

        protected override void OnLoadComplete(EventArgs e)
        {
            if (mvwForm.GetActiveView() == viwRead)
            {
                //lnbDelete.Enabled = Privilege.AllowDelete;
                if (RowID == 0)
                    hypAddExistingCust.Enabled = Privilege.AllowAddNew;
            }
            else
            {
                hypAddExistingCust.Enabled = RowID == 0 ? Privilege.AllowAddNew : Privilege.AllowUpdate;
            }
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
                hidLetterID.Value = Convert.ToString(RowID);
                var letter = ConfirmationLetterService.GetConfirmationLetter(RowID);
                ViewState["LetterNo"] = letter.LetterNo;
                ConfirmationLetterDetail1.LoadConfirmationLetter(letter.LetterNo);
                FillDropDown(); 
            }
        }

        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@LetterNo"].Value = txtFindCLNo.Text;
            e.Command.Parameters["@Customer"].Value = txtFindCustomer.Text;
        }

        protected void sdsParticipants_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@LetterNo"].Value = Convert.ToString(ViewState["LetterNo"]);
        }

        protected void btnCustSave_Click(object sender, EventArgs e)
        {
            CustomerService.AddCustomer(Convert.ToString(ViewState["LetterNo"]),
                txtCustName.Text,
                "I",
                dtpCustBirthDate.SelectedDate,
                rblCustGender.SelectedValue,
                String.IsNullOrEmpty(ddlCustJobPosition.SelectedValue) ? 0 : Convert.ToInt32(ddlCustJobPosition.SelectedValue),
                txtCustEmail.Text,
                txtCustAddress.Text,
                txtCustZipCode.Text,
                txtCustWebsite.Text,
                txtInformationSource.Text,
                new Dictionary<int, string>() {{1, txtCustCellPhone1.Text}, {2, txtCustCellPhone2.Text}},
                new Dictionary<int, string>()
                {
                    {1, txtCustSocialMediaNetwork1.Text},
                    {2, txtCustSocialMediaNetwork2.Text}
                },
                new Dictionary<int, string>() {{1, txtCustWorkPhone1.Text}, {2, txtCustWorkPhone2.Text}});
            ;            
            RadGridParticipants.DataBind();
        }

        protected void btnRefreshParticipant_Click(object sender, EventArgs e)
        {            
            RadGridParticipants.DataBind();
        }

        protected void RadGridParticipants_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "DeleteParticipant")
            {
                string customerCode = Convert.ToString(e.CommandArgument);
                ConfirmationLetterService.RemoveParticipant(RowID, customerCode);
                RadGridParticipants.DataBind();                
            }
        }

        protected void RadGridParticipants_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.AlternatingItem || e.Item.ItemType == GridItemType.Item)
            {
                var lnbDelete = e.Item.FindControl("lnbDelete") as LinkButton;
                lnbDelete.Enabled = Privilege.AllowDelete;                
            }
        }

    }
}