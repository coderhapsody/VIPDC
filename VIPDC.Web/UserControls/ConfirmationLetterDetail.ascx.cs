using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VIPDC.Web.UserControls
{
    public partial class ConfirmationLetterDetail : System.Web.UI.UserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void LoadConfirmationLetter(string letterNo)
        {
            ViewState["LetterNo"] = letterNo;
            dtvConfirmationLetter.DataBind();
        }

        protected void sdsDetailInfo_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            if (!String.IsNullOrEmpty(Convert.ToString(ViewState["LetterNo"])))
            {
                e.Command.Parameters["@LetterNo"].Value = Convert.ToString(ViewState["LetterNo"]);
            }
        }
    }
}