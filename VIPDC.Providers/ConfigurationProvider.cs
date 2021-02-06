using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using VIPDC.Data;
using VIPDC.Providers.Base;
using Configuration = VIPDC.Data.Configuration;

namespace VIPDC.Providers
{
    public static class ConfigurationKeys
    {
        public static readonly string CompanyAddress1 = "CompanyAddress1";
        public static readonly string CompanyAddress2 = "CompanyAddress2";
        public static readonly string CompanyFax = "CompanyFax";
        public static readonly string CompanyPhone = "CompanyPhone";
        public static readonly string CompanyWebsite = "CompanyWebsite";
        public static readonly string CompanyName = "CompanyName";        
    }

    public class ConfigurationProvider : BaseProvider
    {
        public ConfigurationProvider(IRepository repository, IPrincipal principal)
            : base(repository, principal)
        {
        }

        public T GetValue<T>(string key)
        {
            var value = this[key];
            return (T) Convert.ChangeType(value, typeof (T));
        }

        public string this[string key]
        {
            get
            {
                var config = repository.FindOne<Configuration>(conf => conf.Key == key);
                return config == null ? String.Empty : config.Value;
            }
            set
            {
                var config = repository.FindOne<Configuration>(conf => conf.Key == key);
                if (config == null)
                {
                    config = new Configuration {Key = key};
                    repository.Add(config);
                }
                else
                {                    
                    repository.Update(config);     
                }
                config.Value = value;
                config.ChangedWhen = DateTime.Now;
                config.ChangedWho = principal.Identity.Name;                
                repository.UnitOfWork.SaveChanges();
            }
        }
    }
}
