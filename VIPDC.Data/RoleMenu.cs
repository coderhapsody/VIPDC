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
    
    public partial class RoleMenu
    {
        public int RoleID { get; set; }
        public int MenuID { get; set; }
        public Nullable<bool> AllowUpdate { get; set; }
        public Nullable<bool> AllowAddNew { get; set; }
        public Nullable<bool> AllowDelete { get; set; }
        public System.DateTime CreatedWhen { get; set; }
        public string CreatedWho { get; set; }
    
        public virtual Menu Menu { get; set; }
        public virtual Role Role { get; set; }
    }
}
