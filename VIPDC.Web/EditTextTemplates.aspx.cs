using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VIPDC.Web
{
    public partial class EditTextTemplates : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadTemplates();
            }
        }

        private void LoadTemplates()
        {
            string terms = File.ReadAllText(Server.MapPath("~/TextTemplates/Terms.txt"));
            redTerms.Content = terms;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string terms = redTerms.Content;
                File.WriteAllText(Server.MapPath("~/TextTemplates/Terms.txt"), terms);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "template", "alert('Text template has been saved.');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "template", "alert('"+ ex.Message +"');", true);
            }
        }
    }
}