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
    public partial class ManageUsers : System.Web.UI.Page
    {
        [Inject]
        public SecurityProvider SecurityService { get; set; }

        [Inject]
        public EmployeeProvider EmployeeService { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                RadHelper.SetUpGrid(RadGrid1);
            }
        }


        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "ResetPassword")
            {
                int employeeID = Convert.ToInt32(e.CommandArgument);
                try
                {
                    var emp = EmployeeService.GetEmployee(employeeID);
                    SecurityService.ResetPassword(employeeID);

                    ClientScript.RegisterStartupScript(this.GetType(),
                        "alert",
                        String.Format("alert('Password for user name {0} has been reset to default password.');",
                            emp.UserName),
                        true);
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(),
                        "error",
                        ex.Message,
                        true);
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
    }
}