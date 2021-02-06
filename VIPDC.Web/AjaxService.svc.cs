using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using Ninject;
using VIPDC.Data;
using VIPDC.Providers;
using VIPDC.Providers.ViewModels;

namespace VIPDC.Web
{
    [ServiceContract(Namespace = "Service")]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class AjaxService
    {
        [Inject]
        public TrainingProvider TrainingService { get; set; }

        [Inject]
        public ConfirmationLetterProvider ConfirmationLetterService { get; set; }

        // To use HTTP GET, add [WebGet] attribute. (Default ResponseFormat is WebMessageFormat.Json)
        // To create an operation that returns XML,
        //     add [WebGet(ResponseFormat=WebMessageFormat.Xml)],
        //     and include the following line in the operation body:
        //         WebOperationContext.Current.OutgoingResponse.ContentType = "text/xml";
        [OperationContract]        
        public ClassTypeViewModel GetClassTypeInfo(int classTypeID)
        {
            return TrainingService.GetClassTypeAjax(classTypeID);
        }

        [OperationContract]   
        public ConfirmationLetterDto GetConfirmationLetterInfo(string letterNo)
        {
            return ConfirmationLetterService.GetConfirmationLetterAjax(letterNo);
        }

        // Add more operations here and mark them with [OperationContract]
    }
}
