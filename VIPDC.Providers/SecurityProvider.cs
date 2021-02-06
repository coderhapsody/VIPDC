using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using VIPDC.Data;
using VIPDC.Providers.Base;
using VIPDC.Providers.Helpers;
using VIPDC.Providers.Extensions;
using VIPDC.Providers.ViewModels;

namespace VIPDC.Providers
{
    public class SecurityProvider : BaseProvider
    {        
        public SecurityProvider(IRepository repository, IPrincipal principal) : base(repository, principal)
        {
            
        }

        #region Authentication
        public bool ValidateUser(string userName, string password, string cryptographyKey)
        {

            var employee = repository.FindOne<Employee>(emp => emp.UserName == userName && emp.IsAllowLogin);
            if (employee != null)
            {
                var clearPassword = RijndaelHelper.Decrypt(employee.Password, cryptographyKey);
                return clearPassword == password;
            }
            return false;
        }

        public void ChangePassword(string userName, string newPassword, string cryptographyKey)
        {
            var employee = repository.FindOne<Employee>(emp => emp.UserName == userName);
            if (employee != null)
            {
                employee.Password = RijndaelHelper.Encrypt(newPassword, cryptographyKey);
                repository.SetAuditFieldsForUpdate(employee, userName);
            }
            repository.UnitOfWork.SaveChanges();
        }
        #endregion

        #region Role
        public bool CanDeleteRoles(int[] arrayOfID)
        {
            // TODO: add logic to validate whether a role can be safely deleted or not
            return true;
        }

        public void AddOrUpdateRole(int id, string roleName, bool isActive)
        {
            var role = id == 0 ? new Role() : repository.Single<Role>(r => r.ID == id);
            if (role != null)
            {
                role.Name = roleName;
                role.IsActive = isActive;
                repository.AddOrUpdate(id, role, CurrentUserName);
                repository.UnitOfWork.SaveChanges();
            }
        }

        public void DeleteRoles(int[] arrayOfID)
        {
            arrayOfID.ToList().ForEach(id => repository.Delete<Role>(role => role.ID == id));            
            repository.UnitOfWork.SaveChanges();            
        }

        public int GetRoleID()
        {
            var employee = repository.Single<Employee>(emp => emp.UserName == CurrentUserName);
            return employee != null ? employee.RoleID : 0;
        }

        public Role GetRole(string userName)
        {
            var employee = repository.GetQuery<Employee>(emp => emp.UserName == userName).Include(emp => emp.Role).Single();
            return employee.Role;
        }

        public string GetRoleName(string userName)
        {
            var role = GetRole(userName);
            if (role == null)
                return String.Empty;

            return role.Name;
        }

        public Role GetRole(int id)
        {
            var role = repository.Single<Role>(r => r.ID == id);
            return role;
        }

        #endregion

        #region Menus

        public MenuPrivilege GetPrivilege(string pageName)
        {
            var currentMenu = repository.FindOne<Menu>(menu => menu.NavigationTo == pageName);
            if (currentMenu != null)
            {
                int roleID = GetRoleID();
                var roleMenu = GetRolePrivilege(currentMenu.ID, roleID);
                if (roleMenu != null)
                {
                    return new MenuPrivilege(pageName, roleMenu);
                }
            }

            return new MenuPrivilege(pageName);
        }
        
        public IEnumerable<Menu> GetAllMenus(int? parentMenuID)
        {
            int roleID = GetRoleID();

            if (parentMenuID.HasValue)
                return from menu in repository.GetQuery<Menu>()
                       join roleMenu in repository.GetQuery<RoleMenu>().Where(rm => rm.RoleID == roleID) on menu.ID equals roleMenu.MenuID
                       where menu.IsActive && menu.ParentMenuID.Value == parentMenuID.Value
                       orderby menu.Seq
                       select menu;

            return from menu in repository.GetQuery<Menu>()
                   join roleMenu in repository.GetQuery<RoleMenu>().Where(rm => rm.RoleID == roleID) on menu.ID equals roleMenu.MenuID
                   where menu.IsActive && !menu.ParentMenuID.HasValue
                   orderby menu.Seq
                   select menu;
        }


        #endregion

        public RoleMenu GetRolePrivilege(int menuID, int roleID)
        {
            return repository.Single<RoleMenu>(rm => rm.RoleID == roleID && rm.MenuID == menuID);
        }

        public void SetRolePrivilege(int menuID, int roleID, bool allowAddNew, bool allowUpdate, bool allowDelete)
        {
            var roleMenu = GetRolePrivilege(menuID, roleID);
            if (roleMenu != null)
            {
                roleMenu.AllowAddNew = allowAddNew;
                roleMenu.AllowUpdate = allowUpdate;
                roleMenu.AllowDelete = allowDelete;
                repository.Update(roleMenu);
                repository.UnitOfWork.SaveChanges();                
            }            
        }

        public IEnumerable<Menu> GetAllMenusForRole(int roleID, int? parentMenuID)
        {            
            if (parentMenuID.HasValue)
                return from menu in repository.GetQuery<Menu>()
                       join roleMenu in repository.GetQuery<RoleMenu>().Where(rm => rm.RoleID == roleID) on menu.ID equals roleMenu.MenuID
                       where menu.IsActive && menu.ParentMenuID.Value == parentMenuID.Value 
                       orderby menu.Seq
                       select menu;

            return from menu in repository.GetQuery<Menu>()
                   join roleMenu in repository.GetQuery<RoleMenu>().Where(rm => rm.RoleID == roleID) on menu.ID equals roleMenu.MenuID
                   where menu.IsActive && !menu.ParentMenuID.HasValue 
                   orderby menu.Seq
                   select menu;
        }

        public IEnumerable<Menu> GetAllMenusIgnoringRole(int? parentMenuID)
        {
            if (parentMenuID.HasValue)
                return from menu in repository.GetQuery<Menu>()
                       where menu.IsActive && menu.ParentMenuID.Value == parentMenuID.Value
                       orderby menu.Seq
                       select menu;

            return from menu in repository.GetQuery<Menu>()
                   where menu.IsActive && !menu.ParentMenuID.HasValue
                   orderby menu.Seq
                   select menu;
        }

        public IEnumerable<int> GetRolesForMenu(int menuID)
        {
            return repository.GetQuery<RoleMenu>().Where(rm => rm.MenuID == menuID)
                .Select(rm => rm.RoleID);
        }

        public IEnumerable<Role> GetAllRoles(bool forAddNew = false)
        {
            return forAddNew ? repository.GetQuery<Role>(role => role.IsActive) : repository.GetAll<Role>();
        }

        public void UpdateRoleMenu(int menuID, int[] roles)
        {
            repository.Delete<RoleMenu>(rm => rm.MenuID == menuID);
            foreach (var roleID in roles)
            {
                var rm = new RoleMenu {MenuID = menuID, RoleID = roleID};
                rm.CreatedWhen = DateTime.Now;
                rm.CreatedWho = CurrentUserName;
                repository.Add(rm);
            }
            repository.UnitOfWork.SaveChanges();
        }

        public void ResetPassword(int employeeID)
        {
            var employee = repository.Single<Employee>(emp => emp.ID == employeeID);
            employee.Password = RijndaelHelper.Encrypt(ConfigurationManager.AppSettings[ApplicationSettingKeys.DefaultPassword],
                ConfigurationManager.AppSettings[ApplicationSettingKeys.CryptographyKey]);
            repository.SetAuditFieldsForUpdate(employee, principal.Identity.Name);
            repository.UnitOfWork.SaveChanges();
        }

        public bool IsCurrentPasswordValid(string currentPassword)
        {
            return ValidateUser(principal.Identity.Name, currentPassword, cryptographyKey);
        }
    }
}
