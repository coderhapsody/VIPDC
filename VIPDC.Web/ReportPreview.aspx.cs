using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.IO;
using Ninject;
using VIPDC.Providers;
using VIPDC.Web.Helpers;

namespace VIPDC.Web
{
    public partial class ReportPreview : Page
    {
        [Inject]
        public ReportProvider ReportService { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptReport.InteractivityPostBackMode = InteractivityPostBackMode.AlwaysAsynchronous;
                string reportName = Request.QueryString["ReportName"];
                var keys = Request.QueryString.AllKeys.Where(param => param != "ReportName");

                var parameters = keys.ToDictionary(key => key, key => Request.QueryString[key]);


                var action =
                    Action<string, Dictionary<string, string>>.CreateDelegate(
                        typeof (Action<string, Dictionary<string, string>>),
                        this,
                        reportName);

                action.DynamicInvoke(reportName, parameters);

                //ShowReport(reportName, parameters);
            }
        }

        public void ListInvoice(string reportName, Dictionary<string, string> parameters)
        {
            rptReport.LocalReport.ReportPath = String.Format(@"{0}/{1}", ConfigurationManager.AppSettings[ApplicationSettingKeys.ReportFolder], reportName + ".rdlc");
            DateTime fromDate = Convert.ToDateTime(parameters["FromDate"]);
            DateTime toDate = Convert.ToDateTime(parameters["ToDate"]);
            var reportData = ReportService.LoadInvoices(fromDate, toDate);
            var rds = new ReportDataSource("Invoice", reportData);

            var reportParameters = new List<ReportParameter>();            
            reportParameters.Add(new ReportParameter("FromDate", fromDate.ToString("dddd, dd MMMM yyyy")));
            reportParameters.Add(new ReportParameter("ToDate", toDate.ToString("dddd, dd MMMM yyyy")));

            rptReport.LocalReport.DataSources.Add(rds);
            rptReport.LocalReport.SetParameters(reportParameters);
            rptReport.LocalReport.Refresh();
        }

        public void ListConfirmationLetter(string reportName, Dictionary<string, string> parameters)
        {
            rptReport.LocalReport.ReportPath = String.Format(@"{0}/{1}", ConfigurationManager.AppSettings[ApplicationSettingKeys.ReportFolder], reportName + ".rdlc");
            DateTime fromDate = Convert.ToDateTime(parameters["FromDate"]);
            DateTime toDate = Convert.ToDateTime(parameters["ToDate"]);
            var reportData = ReportService.LoadConfirmationLetters(fromDate, toDate);
            var rds = new ReportDataSource("ConfirmationLetter", reportData);

            var reportParameters = new List<ReportParameter>();
            reportParameters.Add(new ReportParameter("FromDate", fromDate.ToString("dddd, dd MMMM yyyy")));
            reportParameters.Add(new ReportParameter("ToDate", toDate.ToString("dddd, dd MMMM yyyy")));

            rptReport.LocalReport.DataSources.Add(rds);
            rptReport.LocalReport.SetParameters(reportParameters);
            rptReport.LocalReport.Refresh();
        }

        public void Invoice(string reportName, Dictionary<string, string> parameters)
        {            
            rptReport.LocalReport.ReportPath = String.Format(@"{0}/{1}", ConfigurationManager.AppSettings[ApplicationSettingKeys.ReportFolder], reportName + ".rdlc");
            var companyInfo = ReportService.LoadCompanyInformation();
            var reportData = ReportService.LoadInvoiceInfo(parameters["InvoiceNo"]);
            var rds = new ReportDataSource(reportName, reportData);
            var rds2 = new ReportDataSource("CompanyInformation", companyInfo);
            rptReport.LocalReport.DataSources.Add(rds);
            rptReport.LocalReport.DataSources.Add(rds2);
            rptReport.LocalReport.Refresh();
        }

        public void Kwitansi(string reportName, Dictionary<string, string> parameters)
        {
            rptReport.LocalReport.ReportPath = String.Format(@"{0}/{1}", ConfigurationManager.AppSettings[ApplicationSettingKeys.ReportFolder], reportName + ".rdlc");            
            var reportData = ReportService.LoadKwitansi(parameters["InvoiceNo"]);
            var rds = new ReportDataSource(reportName, reportData);            
            rptReport.LocalReport.DataSources.Add(rds);            
            rptReport.LocalReport.Refresh();
        }

        public void ConfirmationLetter(string reportName, Dictionary<string, string> parameters)
        {
            rptReport.LocalReport.ReportPath = String.Format(@"{0}/{1}", ConfigurationManager.AppSettings[ApplicationSettingKeys.ReportFolder], reportName + ".rdlc");
            var reportData = ReportService.LoadConfirmationLetterInfo(parameters["LetterNo"]);

            var letter = reportData.SingleOrDefault();
            if (letter != null)
            {
                var companyInfo = ReportService.LoadCompanyInformation();
                var rds1 = new ReportDataSource(reportName, reportData.ToList());
                var rds2 = new ReportDataSource("CompanyInformation", companyInfo);
                string terms = File.ReadAllText(Server.MapPath("~/TextTemplates/Terms.txt"));

                terms = terms
                    .Replace("[PaymentDueDate]", letter.PaymentDueDate.ToString("dddd, dd MMMM yyyy"))
                    .Replace("[BankName]", letter.BankName)
                    .Replace("[AccountName]", letter.AccountName)
                    .Replace("[AccountNumber]", letter.AccountNo);

                rptReport.LocalReport.SetParameters(new ReportParameter("Terms", terms));
                rptReport.LocalReport.DataSources.Add(rds1);
                rptReport.LocalReport.DataSources.Add(rds2);
                rptReport.LocalReport.Refresh();
            }


        }

        //public void ShowReport(string reportName, List<ReportParameter> parameters)
        //{
        //    rptReport.ServerReport.ReportPath = String.Format(@"{0}/{1}", ConfigurationManager.AppSettings[ApplicationSettingKeys.ReportFolder], reportName);
        //    rptReport.ServerReport.SetParameters(parameters);
        //    rptReport.ServerReport.Refresh();
        //}
    }
}