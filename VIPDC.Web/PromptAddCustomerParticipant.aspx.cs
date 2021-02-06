using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ninject;
using VIPDC.Providers;
using VIPDC.Web.Helpers;

namespace VIPDC.Web
{
    public partial class PromptAddCustomerParticipant : System.Web.UI.Page
    {
        [Inject]
        public ConfirmationLetterProvider ConfirmationLetterService { get; set; }

        [Inject]
        public CustomerProvider CustomerService { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!Page.IsPostBack)
            //{
            //    Session["Participants"] = null;
            //}
        }

        protected void btnSelect_Click(object sender, EventArgs e)
        {
            //Session["Participants"] = "test";
            int[] customerIDs = RadHelper.GetRowIdForDeletion(RadGrid1);

            Array.ForEach(customerIDs,
                customerID =>
                {
                    int letterID = Convert.ToInt32(Request["LetterID"]);
                    ConfirmationLetterService.AddParticipant(letterID, customerID);
                });

            string script = "window.opener.document.getElementById('" + Request["Refresh"] + "').click(); window.close();";
            ClientScript.RegisterStartupScript(this.GetType(), "select", script, true);
        }

        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            var letter = ConfirmationLetterService.GetConfirmationLetter(Convert.ToInt32(Request["LetterID"]));
            e.Command.Parameters["@Customer"].Value = txtFindName.Text;
            e.Command.Parameters["@CustomerType"].Value = ddlFindCustomerType.SelectedValue;
            e.Command.Parameters["@Gender"].Value = ddlFindGender.SelectedValue;
            e.Command.Parameters["@LetterNo"].Value = letter.LetterNo;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataBind();
        }
    }
}