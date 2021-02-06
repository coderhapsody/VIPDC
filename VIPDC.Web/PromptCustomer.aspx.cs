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

namespace VIPDC.Web
{
    public partial class PromptCustomer : System.Web.UI.Page
    {
        [Inject]
        public CustomerProvider CustomerService { get; set; }

        [Inject]
        public JobPositionProvider JobPositionService { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void odsFilterJobPosition_ObjectCreating(object sender, ObjectDataSourceEventArgs e)
        {
            e.ObjectInstance = JobPositionService;
        }

        protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                var hypSelect = e.Item.FindControl("hypSelect") as HyperLink;
                if (hypSelect != null)
                {
                    var dataRow = e.Item.DataItem as DataRowView;
                    string script =
                        String.Format(
                            "javascript:window.opener.document.getElementById('{0}').value='{1}'; window.opener.$telerik.findControl(window.opener.document.forms[0],'{2}').set_value('{3}'); window.close(); return false;",
                            Request["Code"],
                            dataRow["Code"],
                            Request["Name"],
                            dataRow["Name"]);
                    hypSelect.Attributes.Add("onclick", script);
                }
            }
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