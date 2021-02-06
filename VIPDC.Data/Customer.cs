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
    
    public partial class Customer
    {
        public Customer()
        {
            this.ConfirmationLetters = new HashSet<ConfirmationLetter>();
            this.ConfirmationLetters1 = new HashSet<ConfirmationLetter>();
        }
    
        public int ID { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string CustomerType { get; set; }
        public Nullable<System.DateTime> DateOfBirth { get; set; }
        public string Gender { get; set; }
        public Nullable<int> JobPositionId { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string ZipCode { get; set; }
        public string CellPhone1 { get; set; }
        public string CellPhone2 { get; set; }
        public string Website { get; set; }
        public string SocialMediaNetwork1 { get; set; }
        public string SocialMediaNetwork2 { get; set; }
        public string ContactPersonName { get; set; }
        public string ContactPersonTitle { get; set; }
        public string InformationSource { get; set; }
        public Nullable<System.DateTime> CreatedWhen { get; set; }
        public string CreatedWho { get; set; }
        public Nullable<System.DateTime> ChangedWhen { get; set; }
        public string ChangedWho { get; set; }
        public string WorkPhone1 { get; set; }
        public string WorkPhone2 { get; set; }
    
        public virtual JobPosition JobPosition { get; set; }
        public virtual ICollection<ConfirmationLetter> ConfirmationLetters { get; set; }
        public virtual ICollection<ConfirmationLetter> ConfirmationLetters1 { get; set; }
    }
}