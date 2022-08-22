using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace EmployeeDataAccessLayer
{
    //Business object to hold employee related data
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
    public class EmployeeDataAccess
    {
        //Method to return all employees
        public static List<Employee> GetEmployees(string sortColumn)
        {
            List<Employee> listEmployees = new List<Employee>();

            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("spGetEmployees", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Employee employee = new Employee();
                    employee.EmployeeId=Convert.ToInt32(rdr["EmployeeId"]);
                    employee.EmailAddress = rdr["Email"].ToString();
                    employee.CountryId = rdr["Country"].ToString();
                    employee.StateId = rdr["State"].ToString();
                    employee.CityId = rdr["City"].ToString();
                    employee.PanNumber = rdr["PanNo"].ToString();
                    employee.PassportNumber = rdr["PassportNo"].ToString();
                    employee.Gender = rdr["Gender"].ToString();
                    employee.IsActive = Convert.ToInt32(rdr["IsActive"]);
                    employee.ProfileImage = rdr["ProfileImage"].ToString();

                    listEmployees.Add(employee);
                }
            }
            return listEmployees;
        }

        public static void DeleteEmployee(int EmployeeId)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("Update EmployeeMaster Set IsDeleted='True', DeletedDate= getdate() where EmployeeId = @EmployeeId", con);
                SqlParameter param = new SqlParameter("@EmployeeId", EmployeeId);
                cmd.Parameters.Add(param);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public static void UpdateEmployee(string EmailAddress,string PanNumber, string PassportNumber, string Gender, string ProfileImage, int EmployeeId)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                string updateQuery = "Update EmployeeMaster SET EmailAddress = @EmailAddress, " +
                    "PanNumber = @PanNumber,PassportNumber = @PassportNumber,Gender=@Gender, ProfileImage=@ProfileImage,UpdatedDate=getDate() WHERE EmployeeId = @EmployeeId ";
                SqlCommand cmd = new SqlCommand(updateQuery, con);
                
                SqlParameter paramEmailAddress = new SqlParameter("@EmailAddress", EmailAddress);
                cmd.Parameters.Add(paramEmailAddress);                
                //SqlParameter paramCountryId = new SqlParameter("@CountryId", CountryId);
                //cmd.Parameters.Add(paramCountryId);
                //SqlParameter paramStateId = new SqlParameter("@StateId", StateId);
                //cmd.Parameters.Add(paramStateId);
                //SqlParameter paramCity = new SqlParameter("@CityId", CityId);
                //cmd.Parameters.Add(paramCity);
                SqlParameter paramPanNumber = new SqlParameter("@PanNumber", PanNumber);
                cmd.Parameters.Add(paramPanNumber);
                SqlParameter paramPassportNumber = new SqlParameter("@PassportNumber", PassportNumber);
                cmd.Parameters.Add(paramPassportNumber);
                SqlParameter paramGender = new SqlParameter("@Gender", Gender);
                cmd.Parameters.Add(paramGender);
                //SqlParameter paramIsActive = new SqlParameter("@IsActive", IsActive);
                //cmd.Parameters.Add(paramIsActive);
                SqlParameter paramProfileImage = new SqlParameter("@ProfileImage", ProfileImage);
                cmd.Parameters.Add(paramProfileImage);
                SqlParameter paramEmployeeId = new SqlParameter("@EmployeeId", EmployeeId);
                cmd.Parameters.Add(paramEmployeeId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}
