using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using VIPDC.Data;
using VIPDC.Providers.Base;
using VIPDC.Providers.Helpers;

namespace VIPDC.Providers
{
    public class RunningNumberProvider  : BaseProvider
    {
        public const string CUSTOMER_ENTITY = "CUST";
        public const string CONFIRMATION_LETTER_ENTITY = "CONL";
        public const string INVOICE_ENTITY = "INV";

        public RunningNumberProvider(IRepository repository, IPrincipal principal)
            : base(repository, principal)
        {
        }

        private RunningNumber CreateCustomerRunningNumber()
        {
            var runNo = new RunningNumber();
            runNo.Month = DateTime.Today.Month;
            runNo.Year = DateTime.Today.Year;
            runNo.EntityCode = CUSTOMER_ENTITY;
            runNo.Prefix = "CUS";
            runNo.CurrentNo = 1;
            runNo.ChangedWhen = DateTime.Now;
            runNo.ChangedWho = principal.Identity.Name;
            repository.Add(runNo);
            return runNo;
        }

        private RunningNumber CreateConfirmationLetterNo()
        {
            var runNo = new RunningNumber();
            runNo.Month = 0;
            runNo.Year = DateTime.Today.Year;
            runNo.EntityCode = CONFIRMATION_LETTER_ENTITY;
            runNo.Prefix = "COL";
            runNo.CurrentNo = 1;
            runNo.ChangedWhen = DateTime.Now;
            runNo.ChangedWho = principal.Identity.Name;
            repository.Add(runNo);
            return runNo;
        }

        private RunningNumber CreateInvoiceNo()
        {
            var runNo = new RunningNumber();
            runNo.Month = 0;
            runNo.Year = DateTime.Today.Year;
            runNo.EntityCode = INVOICE_ENTITY;
            runNo.Prefix = "INV";
            runNo.CurrentNo = 1;
            runNo.ChangedWhen = DateTime.Now;
            runNo.ChangedWho = principal.Identity.Name;
            repository.Add(runNo);
            return runNo;
        }

        public string GenerateInvoiceNo(int letterID, int employeeID, DateTime date)
        {
            var employee = repository.FindOne<Employee>(emp => emp.ID == employeeID);
            var letter = repository.FindOne<ConfirmationLetter>(lt => lt.ID == letterID);
            if (employee != null && letter != null)
            {
                var letterNo = letter.LetterNo;
                var runningNumber =
                    repository.FindOne<RunningNumber>(
                        rn =>
                            rn.EntityCode == INVOICE_ENTITY && rn.Year == DateTime.Today.Year && rn.Month == 0) ??
                    CreateInvoiceNo();

                string confirmationLetterNo = String.Format("{0}/{1}/{2}/{3}/{4}",
                    runningNumber.CurrentNo.ToString("000"),
                    letterNo.Split('/')[1],
                    runningNumber.Prefix,
                    DateTime.Today.Month.ToString("00"),
                    DateTime.Today.Year.ToString(CultureInfo.InvariantCulture));

                runningNumber.CurrentNo++;
                repository.Update(runningNumber);
                return confirmationLetterNo;
            }

            return null;
        }

        public string GenerateConfirmationLetterNo(int employeeID, DateTime date)
        {
            Employee employee = repository.Single<Employee>(emp => emp.ID == employeeID);
            if (employee != null)
            {
                var runningNumber =
                    repository.FindOne<RunningNumber>(
                        rn =>
                            rn.EntityCode == CONFIRMATION_LETTER_ENTITY && rn.Year == DateTime.Today.Year && rn.Month == 0) ??
                    CreateConfirmationLetterNo();

                string confirmationLetterNo = String.Format("{0}/{1}/{2}/{3}/{4}",
                    runningNumber.CurrentNo.ToString("000"),
                    employee.Initial,
                    runningNumber.Prefix,
                    DateTime.Today.Month.ToString("00"),
                    DateTime.Today.Year.ToString(CultureInfo.InvariantCulture));

                runningNumber.CurrentNo++;
                repository.Update(runningNumber);
                return confirmationLetterNo;
            }

            return null;
        }

        public string GenerateCustomerCode()
        {
            var runningNumber =
                repository.FindOne<RunningNumber>(
                    rn =>
                        rn.EntityCode == CUSTOMER_ENTITY && rn.Year == DateTime.Today.Year &&
                        rn.Month == DateTime.Today.Month) ??
                CreateCustomerRunningNumber();

            string customerCode = String.Format("{0}{1}{2}{3}",
                Convert.ToString(runningNumber.Prefix),
                DateTime.Today.Year,
                DateTime.Today.Month.ToString("00"),
                runningNumber.CurrentNo.ToString("0000"));

            runningNumber.CurrentNo++;
            repository.Update(runningNumber);
            return customerCode;
        }

    }
}
