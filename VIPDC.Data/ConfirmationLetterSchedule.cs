//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace VIPDC.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class ConfirmationLetterSchedule
    {
        public int ID { get; set; }
        public int ConfirmationLetterID { get; set; }
        public System.DateTime Date { get; set; }
    
        public virtual ConfirmationLetter ConfirmationLetter { get; set; }
    }
}
