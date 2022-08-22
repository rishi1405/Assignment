using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeeManagement
{
    public partial class EmployeeList : System.Web.UI.Page
    {
        int CountryId, StateId, CityId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }            
        }
        [System.Web.Services.WebMethod()]
        [System.Web.Script.Services.ScriptMethod()]
        public static string PopulateCountryId(string countryId)
        {            
            return countryId;
        }
        private int MapCountries()
        {
            string mycountry = ddlCountries.SelectedItem.Text.Trim();             //txtCountryId.Text.Trim();
            switch (mycountry)
            {
                case "India":
                    CountryId = 1;
                    break;
                case "Japan":
                    CountryId = 2;
                    break;
                case "Malaysia":
                    CountryId = 3;
                    break;
            }
            return CountryId;
        }
        private int MapStates()
        {
            string myState = ddlStates.SelectedItem.Text.Trim();           //txtStateId.Text.Trim();
            switch (myState)
            {
                case "Maharashtra":
                    StateId = 1;
                    break;
                case "Tokyo":
                    StateId = 2;
                    break;
                case "Johor":
                    StateId = 3;
                    break;
                case "UP":
                    StateId = 4;
                    break;
                case "Osaka":
                    StateId = 5;
                    break;
                case "Sarawak":
                    StateId = 6;
                    break;
            }
            return StateId;
        }
        private int MapCities()
        {
            string myCity = ddlCities.SelectedItem.Text.Trim();                                  //txtCityId.Text.Trim();
            switch (myCity)
            {
                case "Pune":
                    CityId = 1;
                    break;
                case "Mumbai":
                    CityId = 2;
                    break;
                case "Nashik":
                    CityId = 3;
                    break;
                case "Tokyo":
                    CityId = 4;
                    break;
                case "Yokohama":
                    CityId = 5;
                    break;
                case "Yokoha":
                    CityId = 6;
                    break;
                case "Ipoh":
                    CityId = 7;
                    break;
                case "Sarawak":
                    CityId = 8;
                    break;
                case "Johor":
                    CityId = 9;
                    break;
                case "Kashi":
                    CityId = 10;
                    break;
                case "Banaras":
                    CityId = 11;
                    break;
                case "Yokoham":
                    CityId = 12;
                    break;
                case "Yokohaa":
                    CityId = 13;
                    break;
                case "Perak":
                    CityId = 14;
                    break;
                case "Lumpur":
                    CityId = 15;
                    break;
            }
            return CityId;
        }

        private List<tblCountry> populateCountry()
        {
            try
            {
                // here code for populate state
                List<tblCountry> all = new List<tblCountry>();
                using (Neosoft_RishiEntities dc = new Neosoft_RishiEntities())
                {
                    all = dc.tblCountries.ToList();
                }              
                return all;
            }
            catch (Exception ex)
            {
                // Log the exception                      
                throw ex;
            }
            finally
            {
            }
        }

        //private List<tblState> populateState(int countryId)
        //{
        //    try
        //    {
        //        // here code for populate state
        //        List<tblState> all = new List<tblState>();
        //        using (Neosoft_RishiEntities dc = new Neosoft_RishiEntities())
        //        {
        //            all = dc.tblStates.Where(a => a.CountryId == countryId).ToList();
        //            //all = dc.tblStates.Where(a => a.CountryId.Equals(countryId)).ToList();
        //        }
        //        return all;
        //    }
        //    catch (Exception ex)
        //    {
        //        // Log the exception                      
        //        throw ex;
        //    }
        //    finally
        //    {
        //    }
        //}

        //private List<tblCity> populateCity(int stateID)
        //{
        //    try
        //    {
        //        // here code for populate city based on stateID
        //        List<tblCity> all = new List<tblCity>();
        //        using (Neosoft_RishiEntities dc = new Neosoft_RishiEntities())
        //        {
        //            all = dc.tblCities.Where(a => a.StateId == stateID).ToList();
        //            //all = dc.tblCities.Where(a => a.StateId.Equals(stateID)).ToList();
        //        }
        //        return all;
        //    }
        //    catch (Exception ex)
        //    {
        //        // Log the exception                      
        //        throw ex;
        //    }
        //    finally
        //    {
        //    }
        //}

        //protected void ddlCountries_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        // Populate State
        //        string countryID = ((DropDownList)sender).SelectedValue;
        //        //int rowIndex = GridView1.EditIndex;
        //        //DropDownList ddStateEdit = (DropDownList)GridView1.Rows[rowIndex].FindControl("ddlStates");
        //        if (ddlStates != null)
        //        {
        //            var v = populateState(Convert.ToInt32(countryID));
        //            ddlStates.DataSource = v;
        //            ddlStates.DataBind();
        //            if (ddlStates.Items.Count > 0)
        //            {
        //                ddlStates.SelectedIndex = 0;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // Log the exception                      
        //        throw ex;
        //    }
        //    finally
        //    {
        //    }
        //}

        //protected void ddlStates_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        // Populate city
        //        string stateID = ((DropDownList)sender).SelectedValue;
        //        //int rowIndex = GridView1.EditIndex;
        //        //DropDownList ddCityEdit = (DropDownList)GridView1.Rows[rowIndex].FindControl("ddlcities");
        //        if (ddlCities != null)
        //        {
        //            var v = populateCity(Convert.ToInt32(stateID));
        //            ddlCities.DataSource = v;
        //            ddlCities.DataBind();
        //            if (ddlCities.Items.Count > 0)
        //            {
        //                ddlCities.SelectedIndex = 0;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // Log the exception                      
        //        throw ex;
        //    }
        //    finally
        //    {
        //    }
        //}

        protected void Update(object sender, EventArgs e)
        {            
            CountryId = MapCountries();
            StateId = MapStates();
            CityId = MapCities();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE EmployeeMaster SET EmailAddress=@EmailAddress,CountryId=@CountryId,StateId=@StateId,CityId=@CityId, PanNumber=@PanNumber, " +
                    "PassportNumber=@PassportNumber,Gender=@Gender,IsActive=@IsActive,ProfileImage=@ProfileImage WHERE EmployeeId=@EmployeeId"))
                {
                    cmd.Parameters.AddWithValue("@EmployeeId", txtEmployeeId.Text.Trim());
                    cmd.Parameters.AddWithValue("@EmailAddress", txtEmailAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@CountryId", CountryId);
                    cmd.Parameters.AddWithValue("@StateId", StateId);
                    cmd.Parameters.AddWithValue("@CityId", CityId);
                    cmd.Parameters.AddWithValue("@PanNumber", txtPanNumber.Text.Trim());
                    cmd.Parameters.AddWithValue("@PassportNumber", txtPassportNumber.Text.Trim());
                    cmd.Parameters.AddWithValue("@Gender", txtGender.Text.Trim());
                    cmd.Parameters.AddWithValue("@IsActive", txtIsActive.Text.Trim());
                    cmd.Parameters.AddWithValue("@ProfileImage", txtProfileImage.Text.Trim());
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        protected void Delete(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE EmployeeMaster SET IsDeleted='True',DeletedDate=getdate() WHERE EmployeeId=@EmployeeId"))
                {
                    cmd.Parameters.AddWithValue("@EmployeeId", hndDelete.Value);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

    }
}