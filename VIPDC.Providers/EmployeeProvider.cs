using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using VIPDC.Data;
using VIPDC.Providers.Base;
using VIPDC.Providers.Extensions;
using VIPDC.Providers.Helpers;

namespace VIPDC.Providers
{
    public class EmployeeProvider : BaseProvider
    {       
        public EmployeeProvider(IRepository repository, IPrincipal principal)
            : base(repository, principal)
        {            
        }

        public Employee GetEmployee(int id)
        {
            return repository.Single<Employee>(emp => emp.ID == id);
        }

        public Employee GetEmployee(string userName)
        {
            return repository.Single<Employee>(emp => emp.UserName == userName);
        }

        public IEnumerable<Employee> GetAccountManagers()
        {
            return repository.GetAll<Employee>();
        }

        public void AddOrUpdateEmployee(int id,
                                        string userName,
                                        string name,
                                        string initial,
                                        string gender,
                                        string email,
                                        int roleID,
                                        bool isAllowLogin,
                                        bool isActive,
                                        bool isAllowBackdate,
                                        IDictionary<int, string> cellPhones,
                                        int backColor)
        {
            var employee = id == 0 ? new Employee() : repository.Single<Employee>(emp => emp.ID == id);
            employee.UserName = userName;
            employee.RoleID = roleID;
            employee.Name = name;
            employee.Initial = initial;
            employee.Gender = gender;
            employee.Email = email;
            employee.IsAllowLogin = isAllowLogin;
            employee.IsActive = isActive;
            employee.IsAllowBackdate = isAllowBackdate;
            employee.CellPhone1 = cellPhones[1];
            employee.CellPhone2 = cellPhones[2];
            employee.BackColor = backColor;
            if(id == 0)
                repository.Add(employee);
            else
                repository.Update(employee);
            repository.SetAuditFields(id, employee, principal.Identity.Name);

            if (String.IsNullOrEmpty(employee.Password))
                employee.Password = isAllowLogin
                    ? RijndaelHelper.Encrypt(ConfigurationManager.AppSettings[ApplicationSettingKeys.DefaultPassword],
                        cryptographyKey)
                    : String.Empty;

            repository.UnitOfWork.SaveChanges();
        }



        public bool CanDeleteEmployee(int[] arrayOfID)
        {
            return true;
        }

        public void DeleteEmployee(int[] arrayOfID)
        {
            Array.ForEach(arrayOfID, id => repository.Delete<Employee>(emp => emp.ID == id));
            repository.UnitOfWork.SaveChanges();
        }

        public bool IsAllowBackdate(string userName)
        {
            return repository.Single<Employee>(emp => emp.UserName == userName).IsAllowBackdate;
        }

        public IEnumerable<Employee> GetAllPIC()
        {
            return repository.GetQuery<Employee>();
        }
    }
}
