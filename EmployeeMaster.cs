//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EmployeeManagement
{
    using System;
    using System.Collections.Generic;
    
    public partial class EmployeeMaster
    {
        public int EmployeeId { get; set; }
        public string EmployeeCode { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public Nullable<int> CountryId { get; set; }
        public Nullable<int> StateId { get; set; }
        public Nullable<int> CityId { get; set; }
        public string EmailAddress { get; set; }
        public string MobileNumber { get; set; }
        public string PanNumber { get; set; }
        public string PassportNumber { get; set; }
        public string ProfileImage { get; set; }
        public string Gender { get; set; }
        public bool IsActive { get; set; }
        public System.DateTime DateOfBirth { get; set; }
        public Nullable<System.DateTime> DateOfJoinee { get; set; }
        public System.DateTime CreatedDate { get; set; }
        public Nullable<System.DateTime> UpdatedDate { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<System.DateTime> DeletedDate { get; set; }
    
        public virtual tblCity tblCity { get; set; }
        public virtual tblCity tblCity1 { get; set; }
        public virtual tblCountry tblCountry { get; set; }
        public virtual tblCountry tblCountry1 { get; set; }
        public virtual tblState tblState { get; set; }
        public virtual tblState tblState1 { get; set; }
    }
}
