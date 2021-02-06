using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace VIPDC.Web
{
    public partial class PromptConfirmationLetter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                var dataRow = e.Item.DataItem as DataRowView;
                
                var hypSelect = e.Item.FindControl("hypSelect") as HyperLink;
                if (hypSelect != null)
                {
                    
                    string script =
                        String.Format(
                            "javascript:window.opener.$telerik.findControl(window.opener.document.forms[0],'{0}').set_value('{1}'); window.close(); return false;",
                            Request["CLNo"],
                            dataRow["LetterNo"]);
                    hypSelect.Attributes.Add("onclick", script);
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataBind();
        }

        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@LetterNo"].Value = txtFindLetterNo.Text;
            e.Command.Parameters["@AccountManager"].Value = txtFindAccountManager.Text;
            e.Command.Parameters["@Customer"].Value = txtFindCustomer.Text;
            e.Command.Parameters["@ExcludeVoid"].Value = !String.IsNullOrEmpty(Request["ExcludeVoid"]);
        }

 }
}