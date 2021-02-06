using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Infrastructure.Data;
using Ninject;
using VIPDC.Data;
using VIPDC.Providers.Helpers;
using VIPDC.Web.Base;

namespace VIPDC.Web
{
    public partial class Default : BaseForm
    {
        [Inject]
        public IRepository Repository { get; set; }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (!IsPostBack)
            {
                BindData();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            hypAlerts.Visible = !String.IsNullOrEmpty(Request["FromAlert"]);
            if (!Page.IsPostBack)
            {
                RadScheduler1.SelectedDate = DateTime.Today;
            }
        }

        private void BindData()
        {
            var query = (from alert in Repository.GetQuery<Alert>()
                         where alert.Active
                         select new AlertViewModel()
                                {
                                    ID = alert.ID,
                                    Subject =
                                        alert.EmployeeID.HasValue
                                            ? "[" + alert.Employee.Name + "] " + alert.Subject
                                            : alert.Subject,
                                    Description = alert.Description,
                                    Employee = alert.Employee,
                                    StartDate = alert.StartDate,
                                    EndDate = alert.EndDate
                                }).ToList();

            var confirmationLetters = (from letter in Repository.GetQuery<ConfirmationLetter>()
                                        join sched in Repository.GetQuery<ConfirmationLetterSchedule>() on letter.ID equals sched.ConfirmationLetterID
                                       where !letter.VoidDate.HasValue
                                       select new 
                                              {
                                                  ID = letter.ID,
                                                  Subject =
                                                      letter.LetterNo + " - " + letter.Customer.Name + " - " +
                                                      letter.ClassType.Name,
                                                  Description = letter.Description,
                                                  Employee = letter.Employee,                                                  
                                                  StartDate = sched.Date,
                                                  EndDate = sched.Date
                                              }).ToList().OrderByDescending(schedule => schedule.ID).Take(100);

            foreach (var letter in confirmationLetters)
            {
                var model = new AlertViewModel();
                model.Subject = letter.Subject;
                model.Description = letter.Description;
                model.ID = letter.ID;
                model.Employee = letter.Employee;
                model.StartDate = letter.StartDate; //letter.Schedules.OrderBy(date => date.Date).FirstOrDefault().Date;
                model.EndDate = letter.EndDate; //letter.Schedules.OrderByDescending(date => date.Date).FirstOrDefault().Date;
                query.Add(model);
            }

            RadScheduler1.DataSource = query; //Repository.GetQuery<Alert>(alert => alert.Active);
            //RadScheduler1.DataBind();
        }

        protected void RadScheduler1_AppointmentCreated(object sender, Telerik.Web.UI.AppointmentCreatedEventArgs e)
        {

        }

        protected void RadScheduler1_AppointmentInsert(object sender, Telerik.Web.UI.AppointmentInsertEventArgs e)
        {
            var newAlert = new Alert();
            newAlert.Description = e.Appointment.Description;
            newAlert.Subject = e.Appointment.Subject;
            newAlert.StartDate = e.Appointment.Start;
            newAlert.EndDate = e.Appointment.End;
            newAlert.Active = true;
            newAlert.BackColor = -1;
            Repository.SetAuditFieldsForInsert(newAlert, User.Identity.Name);
            Repository.Add(newAlert);         
            Repository.UnitOfWork.SaveChanges();
            BindData();
            //        ReloadCurrentPage();
        }

        protected void RadScheduler1_AppointmentUpdate(object sender, Telerik.Web.UI.AppointmentUpdateEventArgs e)
        {
            int appointmentID = Convert.ToInt32(e.Appointment.ID);
            var modifiedAlert = Repository.FindOne<Alert>(o => o.ID == appointmentID);
            if (modifiedAlert == null) return;
            modifiedAlert.Description = e.ModifiedAppointment.Description;
            modifiedAlert.Subject = e.ModifiedAppointment.Subject;
            modifiedAlert.StartDate = e.ModifiedAppointment.Start;
            modifiedAlert.EndDate = e.ModifiedAppointment.End;
            Repository.Update(modifiedAlert);
            Repository.UnitOfWork.SaveChanges();
            BindData();            
            //          ReloadCurrentPage();
        }

        protected void RadScheduler1_AppointmentDataBound(object sender, Telerik.Web.UI.SchedulerEventArgs e)
        {
            var alert = e.Appointment.DataItem as AlertViewModel;
            if (alert != null)
            {
                e.Appointment.BackColor = alert.Employee != null
                    ? Color.FromArgb(alert.Employee.BackColor.GetValueOrDefault())
                    : Color.White;
            }
        }

        protected void RadScheduler1_AppointmentDelete(object sender, Telerik.Web.UI.AppointmentDeleteEventArgs e)
        {
            int appointmentID = Convert.ToInt32(e.Appointment.ID);
            Repository.Delete<Alert>(alert => alert.ID == appointmentID);
            Repository.UnitOfWork.SaveChanges();
            BindData();
//            ReloadCurrentPage();
        }

        protected void RadScheduler1_AppointmentCommand(object sender, Telerik.Web.UI.AppointmentCommandEventArgs e)
        {
            
        }
    }

    public class AlertViewModel
    {
        public int ID { get; set; }
        public string Subject { get; set; }
        public string Description { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public Employee Employee { get; set; }
    }
}