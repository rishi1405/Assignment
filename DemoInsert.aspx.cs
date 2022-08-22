using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeeManagement
{
    public partial class DemoInsert : System.Web.UI.Page
    {
        string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
        SqlConnection con = null;
        SqlCommand cmd = null;
        DataSet DS = null;
        SqlDataAdapter da = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCountryValues();
            }
        }

        private DataSet GetData(string SPName, SqlParameter SPParameter)
        {
            try
            {
                con = new SqlConnection(CS);
                da = new SqlDataAdapter(SPName, con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                if (SPParameter != null)
                {
                    da.SelectCommand.Parameters.Add(SPParameter);
                }
                DS = new DataSet();
                da.Fill(DS);

                return DS;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                da.Dispose();
                DS.Dispose();
            }
        }

        private void BindCountryValues()
        {
            try
            {
                ddlCountrys.DataSource = GetData("spGetCountries", null);
                ddlCountrys.DataBind();

                ListItem liCountry = new ListItem("Select Country", "-1");
                ddlCountrys.Items.Insert(0, liCountry);

                ListItem liState = new ListItem("Select State", "-1");
                ddlStates.Items.Insert(0, liState);

                ListItem liCity = new ListItem("Select City", "-1");
                ddlCitys.Items.Insert(0, liCity);

                ddlStates.Enabled = false;
                ddlCitys.Enabled = false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        private string UploadFile()
        {
            try
            {
                string path = "";
                if (FileUpload1.HasFile)
                {
                    // Get the file size
                    int fileSize = FileUpload1.PostedFile.ContentLength;
                    // If file size is greater than 200 kb
                    if (fileSize > 209715200)
                    {
                    }
                    else
                    {
                        path = @"~/Uploads/Employee/" + FileUpload1.FileName;
                        // Upload the file
                        FileUpload1.SaveAs(Server.MapPath(path));
                        lblmsg.ForeColor = System.Drawing.Color.Green;
                        lblmsg.Text = "File uploaded successfully";
                        return path;
                    }
                }
                else
                {
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                    lblmsg.Text = "Please select a file";
                }
                return path;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }
        private void ClearFormData()
        {
            txtDateOfBirth.Text = "";
            txtDateOfJoinee.Text = "";
            txtEmailAddress.Text = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtMobileNumber.Text = "";
            txtPanNumber.Text = "";
            txtPassportNumber.Text = "";
            ddlCitys.SelectedValue = "-1";
            ddlCountrys.SelectedValue = "-1";
            ddlStates.SelectedValue = "-1";
        }
        private void InsertData()
        {
            try
            {
                string FileName = UploadFile();
                if (FileName == "")
                {
                    lblmsg.Text = "Image Maximum Size is Exceeded.";
                }
                else
                {
                    con = new SqlConnection(CS);
                    cmd = new SqlCommand("stp_Emp_Insert", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("FirstName", txtFirstName.Text);
                    cmd.Parameters.AddWithValue("LastName", txtLastName.Text);
                    cmd.Parameters.AddWithValue("EmailAddress", txtEmailAddress.Text);
                    cmd.Parameters.AddWithValue("MobileNumber", txtMobileNumber.Text);
                    cmd.Parameters.AddWithValue("PanNumber", txtPanNumber.Text);
                    cmd.Parameters.AddWithValue("PassportNumber", txtPassportNumber.Text);
                    cmd.Parameters.AddWithValue("DateOfBirth", Convert.ToDateTime(txtDateOfBirth.Text));
                    cmd.Parameters.AddWithValue("DateOfJoinee", Convert.ToDateTime(txtDateOfJoinee.Text));
                    cmd.Parameters.AddWithValue("CountryId", ddlCountrys.SelectedValue);
                    cmd.Parameters.AddWithValue("StateId", ddlStates.SelectedValue);
                    cmd.Parameters.AddWithValue("CityId", ddlCitys.SelectedValue);
                    cmd.Parameters.AddWithValue("ProfileImage", FileName);
                    cmd.Parameters.AddWithValue("Gender", GenderRadioButtonList.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("IsActive", chkStatus.Checked);
                    cmd.Parameters.AddWithValue("IsDeleted", 0);
                    cmd.Parameters.AddWithValue("CreatedDate", DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));
                    con.Open();
                    int k = cmd.ExecuteNonQuery();
                    if (k != 0)
                    {
                        lblmsg.Text = "Record Inserted Succesfully into the Database";
                        lblmsg.ForeColor = System.Drawing.Color.CornflowerBlue;
                    }

                    HttpCookie userInfo = new HttpCookie("userInfo");
                    userInfo["EmailAddress"] = txtEmailAddress.Text;
                    userInfo["PanNumber"] = txtPanNumber.Text;
                    userInfo["PassportNumber"] = txtPassportNumber.Text;
                    //userInfo.Expires.Add(new TimeSpan(0, 10, 0));
                    Response.Cookies.Add(userInfo);

                    ClearFormData();
                    Session["lblVal"] = "Employee Information Master";
                    Response.Redirect("Demo.aspx");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                cmd.Dispose();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                InsertData();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        protected void txtPanNumber_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(txtPanNumber.Text))
                {
                    con = new SqlConnection(CS);
                    cmd = new SqlCommand("select * from EmployeeMaster where PanNumber=@PanNumber", con);
                    cmd.Parameters.AddWithValue("PanNumber", txtPanNumber.Text);
                    con.Open();
                    SqlDataReader sdr = cmd.ExecuteReader();
                    if (sdr.HasRows)
                    {
                        //checkusername.Visible = true;
                        lblpanmsg.Text = "Pan Number Alrady Exist";
                        lblpanmsg.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        lblpanmsg.Text = "";
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                cmd.Dispose();
            }
        }

        protected void ddlCountrys_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (ddlCountrys.SelectedValue == "-1")
                {
                    ddlStates.SelectedIndex = 0;
                    ddlCitys.SelectedIndex = 0;
                    ddlStates.Enabled = false;
                    ddlCitys.Enabled = false;
                }
                else
                {
                    ddlStates.Enabled = true;

                    SqlParameter parameter = new SqlParameter();
                    parameter.ParameterName = "@CountryId";
                    parameter.Value = ddlCountrys.SelectedValue;

                    ddlStates.DataSource = GetData("spGetStatesByCountryId", parameter);
                    ddlStates.DataBind();

                    ListItem liCountry = new ListItem("Select Country", "-1");
                    ddlStates.Items.Insert(0, liCountry);

                    ddlCitys.SelectedIndex = 0;
                    ddlCitys.Enabled = false;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        protected void ddlCitys_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlStates_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (ddlStates.SelectedValue == "-1")
                {
                    ddlCitys.SelectedIndex = 0;
                    ddlCitys.Enabled = false;
                }
                else
                {
                    ddlCitys.Enabled = true;

                    SqlParameter parameter = new SqlParameter();
                    parameter.ParameterName = "@StateId";
                    parameter.Value = ddlStates.SelectedValue;

                    ddlCitys.DataSource = GetData("spGetCitiesByStateId", parameter);
                    ddlCitys.DataBind();

                    ListItem liState = new ListItem("Select City", "-1");
                    ddlCitys.Items.Insert(0, liState);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {

            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
        }

        protected void txtEmailAddress_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(txtEmailAddress.Text))
                {
                    con = new SqlConnection(CS);
                    cmd = new SqlCommand("select * from EmployeeMaster where EmailAddress=@EmailAddress", con);
                    cmd.Parameters.AddWithValue("EmailAddress", txtEmailAddress.Text);
                    con.Open();
                    SqlDataReader sdr = cmd.ExecuteReader();
                    if (sdr.HasRows)
                    {
                        lblEmailId.Text = "EmailAddress Alrady Exist";
                        lblEmailId.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        lblEmailId.Text = "";
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                cmd.Dispose();
            }
        }

        protected void txtMobileNumber_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(txtMobileNumber.Text))
                {
                    con = new SqlConnection(CS);
                    cmd = new SqlCommand("select * from EmployeeMaster where MobileNumber=@MobileNumber", con);
                    cmd.Parameters.AddWithValue("MobileNumber", txtMobileNumber.Text);
                    con.Open();
                    SqlDataReader sdr = cmd.ExecuteReader();
                    if (sdr.HasRows)
                    {
                        lblMobileNo.Text = "Mobile Number Alrady Exist";
                        lblMobileNo.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        lblMobileNo.Text = "";
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                cmd.Dispose();
            }
        }

        protected void txtPassportNumber_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(txtPassportNumber.Text))
                {
                    con = new SqlConnection(CS);
                    cmd = new SqlCommand("select * from EmployeeMaster where PassportNumber=@PassportNumber", con);
                    cmd.Parameters.AddWithValue("PassportNumber", txtPassportNumber.Text);
                    con.Open();
                    SqlDataReader sdr = cmd.ExecuteReader();
                    if (sdr.HasRows)
                    {
                        lblpassport.Text = "Passport Number Alrady Exist";
                        lblpassport.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        lblpassport.Text = "";
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                cmd.Dispose();
            }
        }

    }
}