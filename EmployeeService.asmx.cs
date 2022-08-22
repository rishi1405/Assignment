using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace EmployeeManagement
{
    /// <summary>
    /// Summary description for EmployeeService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class EmployeeService : System.Web.Services.WebService
    {

        [WebMethod]
        public void GetEmployees()
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            List<Employee> employees = new List<Employee>();
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spGetEmployees", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Employee employee = new Employee();
                    employee.EmployeeId =Convert.ToInt32(rdr["EmployeeId"]);
                    employee.EmailAddress = rdr["Email"].ToString();
                    employee.CountryId = rdr["Country"].ToString();
                    employee.StateId = rdr["State"].ToString();
                    employee.CityId = rdr["City"].ToString();
                    employee.PanNumber = rdr["PanNo"].ToString();
                    employee.PassportNumber = rdr["PassportNo"].ToString();
                    employee.Gender = rdr["Gender"].ToString();
                    employee.IsActive = Convert.ToInt32(rdr["IsActive"]);
                    employee.ProfileImage = rdr["ProfileImage"].ToString();
                    employees.Add(employee);
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(employees));
        }
    }
}
