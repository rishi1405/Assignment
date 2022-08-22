using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EmployeeManagement
{
    public class Employee
    {
        public int EmployeeId { get; set; }
        public string EmailAddress { get; set; }
        public string CountryId { get; set; }
        public string StateId { get; set; }
        public string CityId { get; set; }
        public string PanNumber { get; set; }
        public string PassportNumber { get; set; }
        public string Gender { get; set; }
        public int IsActive { get; set; }
        public string ProfileImage { get; set; }
    }
}