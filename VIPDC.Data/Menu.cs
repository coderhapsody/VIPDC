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
    
    public partial class Menu
    {
        public Menu()
        {
            this.Menu1 = new HashSet<Menu>();
            this.RoleMenus = new HashSet<RoleMenu>();
        }
    
        public int ID { get; set; }
        public string Title { get; set; }
        public string NavigationTo { get; set; }
        public int Seq { get; set; }
        public Nullable<int> ParentMenuID { get; set; }
        public Nullable<byte> Type { get; set; }
        public bool IsActive { get; set; }
        public System.DateTime CreatedWhen { get; set; }
        public string CreatedWho { get; set; }
        public System.DateTime ChangedWhen { get; set; }
        public string ChangedWho { get; set; }
    
        public virtual ICollection<Menu> Menu1 { get; set; }
        public virtual Menu Menu2 { get; set; }
        public virtual ICollection<RoleMenu> RoleMenus { get; set; }
    }
}