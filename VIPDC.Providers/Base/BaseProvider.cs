using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using Infrastructure.Data;
using VIPDC.Data;

namespace VIPDC.Providers.Base
{
    public abstract class BaseProvider
    {
        //protected readonly VIPDCEntities context;
        protected readonly IRepository repository;
        protected readonly IPrincipal principal;

        protected readonly string cryptographyKey = ConfigurationManager.AppSettings[ApplicationSettingKeys.CryptographyKey];

        public string CurrentUserName
        {
            get
            {
                return principal != null ? principal.Identity.Name : String.Empty;
            }
        }

        protected BaseProvider(IRepository repository, IPrincipal principal)
        {
            //this.context = context as VIPDCEntities;
            this.repository = repository;
            this.principal = principal;
        }
    }
}
