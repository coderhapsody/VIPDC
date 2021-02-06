using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ninject;
using Telerik.Web.UI;
using VIPDC.Data;
using VIPDC.Providers;
using VIPDC.Providers.Extensions;
using VIPDC.Providers.Helpers;
using VIPDC.Providers.ViewModels;
using VIPDC.Web.Base;
using VIPDC.Web.Helpers;
using System.Drawing;

namespace VIPDC.Web
{
    public partial class ManageAlerts : BaseForm
    {
        #region Template
        public string Sort { get { return ViewState["_Sort"].ToString(); } set { ViewState["_Sort"] = value; } }
        public int RowID { get { return Convert.ToInt32(ViewState["_ID"]); } set { ViewState["_ID"] = value; } }
        #endregion

        [Inject]
        public EmployeeProvider EmployeeService { get; set; }  

        [Inject]
        public SecurityProvider SecurityService { get; set; }  
        public MenuPrivilege Privilege { get { return SecurityService.GetPrivilege(CurrentPageName); } }

        public static Func<Color, string> convertColor = c =>
        {
            if (c.R == 0 && c.G == 0 && c.B == 0)
                c = Color.Transparent;
            return "#" + c.R.ToString("X2") + c.G.ToString("X2") + c.B.ToString("X2");
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mvwForm.SetActiveView(viwRead);
                RadHelper.SetUpGrid(RadGrid1);
                ddlFilter.SelectedIndex = 0;
                FillDropDown();
                Refresh();                
            }

            WebFormHelper.InjectSubmitScript(this, "Save this data ?", "Saving, please wait...", btnSave, true);
        }

        private void FillDropDown()
        {
            ddlPIC.DataSource = EmployeeService.GetAllPIC();
            ddlPIC.DataValueField = "ID";
            ddlPIC.DataTextField = "Name";
            ddlPIC.DataBind();
            ddlPIC.Items.Insert(0, new DropDownListItem(String.Empty));
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

        protected DateTime? SetStartDate(GridItem item)
        {
            return item.OwnerTableView.GetColumn("StartDate").CurrentFilterValue == string.Empty ? new DateTime?() : DateTime.Parse(item.OwnerTableView.GetColumn("StartDate").CurrentFilterValue);
        }

        protected DateTime? SetEndDate(GridItem item)
        {
            return item.OwnerTableView.GetColumn("EndDate").CurrentFilterValue == string.Empty ? new DateTime?() : DateTime.Parse(item.OwnerTableView.GetColumn("EndDate").CurrentFilterValue);
        }

        private void Refresh()
        {
            if (mvwForm.GetActiveView() != viwRead)
                mvwForm.SetActiveView(viwRead);
            RadGrid1.DataBind();            
        }
      
        protected void sdsMaster_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.Parameters["@PageIndex"].Value = RadGrid1.CurrentPageIndex + 1;
            e.Command.Parameters["@PageSize"].Value = RadGrid1.PageSize;
            e.Command.Parameters["@RecordCount"].Value = 0;
            e.Command.Parameters["@ShowOnlyActiveAlerts"].Value = ddlFilter.SelectedValue;
        }

        protected void sdsMaster_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            RadGrid1.VirtualItemCount = Convert.ToInt32(e.Command.Parameters["@RecordCount"].Value);
        }

        protected void gvwMaster_RowCreated(object sender, GridViewRowEventArgs e)
        {
            WebFormHelper.HideGridViewRowId(e);
            WebFormHelper.ChangeBackgroundColorRowOnHover(e);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (this.IsValid)
            {
                if (CalendarPopup1.SelectedDate.GetValueOrDefault() > CalendarPopup2.SelectedDate.GetValueOrDefault())
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "date", "alert('End Date cannot be earlier than Start Date');", true);
                    return;
                }

                try
                {
                    using (var ctx = new VIPDCEntities())
                    {
                        Alert entity = RowID == 0 ? new Alert() : ctx.Alerts.Single(row => row.ID == RowID);
                        entity.Subject = txtSubject.Text;
                        entity.Description = txtDescription.Text;
                        entity.StartDate = CalendarPopup1.SelectedDate.GetValueOrDefault();
                        entity.EndDate = chkInfinite.Checked ? null : CalendarPopup2.SelectedDate;
                        entity.Active = chkActive.Checked;
                        entity.EmployeeID = Convert.ToInt32(ddlPIC.SelectedValue);
                        //entity.BackColor = RadColorPicker1.SelectedColor.ToArgb();                        
                        if (RowID == 0)
                        {
                            entity.CreatedWhen = DateTime.Now;
                            entity.CreatedWho = User.Identity.Name;
                            ctx.Alerts.Add(entity);
                        }
                        entity.ChangedWhen = DateTime.Now;
                        entity.ChangedWho = User.Identity.Name;
                        ctx.SaveChanges();
                    }

                    WebFormHelper.SetLabelTextWithCssClass(lblStatus, "Data has been saved.", LabelStyleNames.InfoMessage);
                }
                catch (Exception ex)
                {
                    WebFormHelper.SetLabelTextWithCssClass(lblStatus, ex.Message, LabelStyleNames.ErrorMessage);
                    //ApplicationLogger.Write(ex);
                }
                finally
                {
                    Refresh();
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Refresh();
        }

        protected void lnbAddNew_Click(object sender, EventArgs e)
        {
            mvwForm.SetActiveView(viwAddEdit);
            RowID = 0;
            CalendarPopup1.SelectedDate = DateTime.Today;
            CalendarPopup2.SelectedDate = DateTime.Today.AddDays(7);
            chkActive.Checked = true;
            chkInfinite.Checked = false;
            txtSubject.Text = txtDescription.Text = String.Empty;
            WebFormHelper.ClearTextBox(txtDescription);
            txtSubject.Focus();
        }

        protected void lnbDelete_Click(object sender, EventArgs e)
        {
            int[] arrayOfID = RadHelper.GetRowIdForDeletion(RadGrid1);

            try
            {
                using (var ctx = new VIPDCEntities())
                {
                    ctx.Alerts.Where(row => arrayOfID.Contains(row.ID)).ForEach(
                        alert => ctx.Alerts.Remove(alert));
                    ctx.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                WebFormHelper.SetLabelTextWithCssClass(lblStatus, ex.Message, LabelStyleNames.ErrorMessage);
                //ApplicationLogger.Write(ex);
            }
            Refresh();
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            Refresh();
        }

        protected void gvwMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName.Equals("EditRow"))
            {
                RowID = Convert.ToInt32(e.CommandArgument);
                mvwForm.SetActiveView(viwAddEdit);
                using (var ctx = new VIPDCEntities())
                {
                    var entity = ctx.Alerts.Single(row => row.ID == RowID);
                    txtSubject.Text = entity.Subject;
                    txtDescription.Text = entity.Description;
                    CalendarPopup1.SelectedDate = entity.StartDate;
                    chkInfinite.Checked = !entity.EndDate.HasValue;
                    CalendarPopup2.SelectedDate = entity.EndDate.HasValue ? entity.EndDate : null;
                    chkActive.Checked = entity.Active;

                    if (entity.EmployeeID.HasValue)
                        ddlPIC.SelectedValue = entity.EmployeeID.GetValueOrDefault().ToString();
                    else
                        ddlPIC.SelectedIndex = 0;
                    //RadColorPicker1.SelectedColor = Color.FromArgb(entity.BackColor.GetValueOrDefault(-1));
                    txtDescription.Focus();
                }
            }
        }

        protected void RadGrid1_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
        {
            RadGrid1.CurrentPageIndex = e.NewPageIndex;
            RadGrid1.DataBind();
        }

    }
}