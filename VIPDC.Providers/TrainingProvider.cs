using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using VIPDC.Data;
using VIPDC.Providers.Base;
using VIPDC.Providers.Extensions;
using VIPDC.Providers.Helpers;
using VIPDC.Providers.ViewModels;

namespace VIPDC.Providers
{
    public class TrainingProvider : BaseProvider
    {
        private ConfigurationProvider configurationService;

        public TrainingProvider(IRepository repository, IPrincipal principal, ConfigurationProvider configurationService)
            : base(repository, principal)
        {
            this.configurationService = configurationService;
        }

        #region Topic

        public IEnumerable<Topic> GetTopics(bool activeOnly = false)
        {
            return activeOnly ? repository.GetQuery<Topic>(topic => topic.IsActive) : repository.GetAll<Topic>();
        }

        public void AddOrUpdateTopic(int id, string code, string name, bool isActive)
        {
            var topic = id == 0 ? new Topic() : repository.Single<Topic>(t => t.ID == id);
            if (topic != null)
            {
                topic.Code = code;
                topic.Name = name;
                topic.IsActive = isActive;
                repository.AddOrUpdate(id, topic, CurrentUserName);
                repository.UnitOfWork.SaveChanges();
            }
        }

        public void DeleteTopics(int[] arrayOfID)
        {
            arrayOfID.ToList().ForEach(id => repository.Delete<Topic>(topic => topic.ID == id));
            repository.UnitOfWork.SaveChanges();
        }

        public bool CanDeleteTopics(int[] arrayOfID)
        {
            //throw new NotImplementedException();
            return true;
        }

        public Topic GetTopic(int id)
        {
            return repository.Single<Topic>(t => t.ID == id);
        }
        #endregion

        #region Module
        public void AddOrUpdateModule(int id, string name, bool isActive)
        {
            var module = id == 0 ? new Module() : repository.Single<Module>(t => t.ID == id);
            if (module != null)
            {                
                module.Name = name;
                module.IsActive = isActive;
                repository.AddOrUpdate(id, module, CurrentUserName);
                repository.UnitOfWork.SaveChanges();
            }
        }

        public void DeleteModules(int[] arrayOfID)
        {
            arrayOfID.ToList().ForEach(id => repository.Delete<Module>(topic => topic.ID == id));
            repository.UnitOfWork.SaveChanges();
        }

        public bool CanDeleteModules(int[] arrayOfID)
        {
            //throw new NotImplementedException();
            return true;
        }

        public Module GetModule(int id)
        {
            return repository.Single<Module>(t => t.ID == id);
        }

        public IEnumerable<Module> GetModules(bool activeOnly = false)
        {
            return activeOnly ? repository.GetQuery<Module>(mod => mod.IsActive) : repository.GetAll<Module>();
        }

        #endregion

        #region Class Type
        public void AddOrUpdateClassType(int id, string name, bool isTaxed)
        {
            var classType = id == 0 ? new ClassType() : repository.Single<ClassType>(ct => ct.ID == id);
            if (classType != null)
            {
                classType.Name = name;
                classType.Tax = isTaxed;
                repository.AddOrUpdate(id, classType, CurrentUserName);
                repository.UnitOfWork.SaveChanges();
            }
        }

        public ClassTypeViewModel GetClassTypeAjax(int id)
        {
            var classType = GetClassType(id);
            return new ClassTypeViewModel()
                   {
                       ClassTypeName = classType.Name,
                       Tax = classType.Tax,
                       RatePPH = configurationService.GetValue<decimal>("RatePPH"),
                       RatePPN = configurationService.GetValue<decimal>("RatePPN")
                   };
        }

        public ClassType GetClassType(int id)
        {
            return repository.Single<ClassType>(classType => classType.ID == id);
        }

        public void DeleteClassTypes(int[] arrayOfID)
        {
            arrayOfID.ToList().ForEach(id => repository.Delete<ClassType>(ct => ct.ID == id));
            repository.UnitOfWork.SaveChanges();
        }

        public bool CanDeleteClassTypes(int[] arrayOfID)
        {
            // TODO: add logic to validate whether a class type can be safely deleted or not
            return true;
        }

        public IEnumerable<ClassType> GetClassTypes()
        {
            return repository.GetAll<ClassType>();
        }       
        #endregion
    }
}
