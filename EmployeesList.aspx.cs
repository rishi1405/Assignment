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
    public partial class EmployeesList : System.Web.UI.Page
    {
        string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string item = e.Row.Cells[0].Text;
                foreach (LinkButton button in e.Row.Cells[9].Controls.OfType<LinkButton>())
                {
                    if (button.CommandName == "Delete")
                    {
                        button.Attributes["onclick"] = "if(!confirm('Do you want to delete " + item + "?')){ return false; };";
                    }
                }
            }
            if (e.Row.RowType == DataControlRowType.DataRow && GridView1.EditIndex == e.Row.RowIndex)
            {
                DropDownList ddlCountries = (DropDownList)e.Row.FindControl("ddlCountries");
                DropDownList ddlStates = (DropDownList)e.Row.FindControl("ddlStates");
                DropDownList ddlCities = (DropDownList)e.Row.FindControl("ddlCities");
                string sql = "SELECT CountryId,CountryName FROM tblCountries";
                string sqlState = "SELECT StateId,StateName FROM tblStates";
                string sqlCity = "SELECT CityId,CityName FROM tblCities";
                string conString = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
                using (SqlConnection con = new SqlConnection(conString))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(sql, con))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            ddlCountries.DataSource = dt;
                            ddlCountries.DataTextField = "CountryId";
                            ddlCountries.DataValueField = "CountryName";
                            ddlCountries.DataBind();
                            string selectedCountry = DataBinder.Eval(e.Row.DataItem, "CountryId").ToString();
                            ddlCountries.Items.FindByValue(selectedCountry).Selected = true;
                        }
                    }
                    using (SqlDataAdapter sda = new SqlDataAdapter(sqlState, con))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            ddlStates.DataSource = dt;
                            ddlStates.DataTextField = "StateId";
                            ddlStates.DataValueField = "StateName";
                            ddlStates.DataBind();
                            string selectedState = DataBinder.Eval(e.Row.DataItem, "StateId").ToString();
                            ddlStates.Items.FindByValue(selectedState).Selected = true;
                        }
                    }
                    using (SqlDataAdapter sda = new SqlDataAdapter(sqlCity, con))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            ddlCities.DataSource = dt;
                            ddlCities.DataTextField = "CityId";
                            ddlCities.DataValueField = "CityName";
                            ddlCities.DataBind();
                            string selectedCity = DataBinder.Eval(e.Row.DataItem, "CityId").ToString();
                            ddlCities.Items.FindByValue(selectedCity).Selected = true;
                        }
                    }
                }
            }
            
        }
        private DataSet GetData(string SPName, SqlParameter SPParameter)
        {
            string CS = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            SqlConnection con = new SqlConnection(CS);
            SqlDataAdapter da = new SqlDataAdapter(SPName, con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            if (SPParameter != null)
            {
                da.SelectCommand.Parameters.Add(SPParameter);
            }
            DataSet DS = new DataSet();
            da.Fill(DS);
            return DS;
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string CountryId = (GridView1.Rows[e.RowIndex].FindControl("ddlCountries") as DropDownList).SelectedItem.Text;
            string StateId= (GridView1.Rows[e.RowIndex].FindControl("ddlStates") as DropDownList).SelectedItem.Text;
            string CityId= (GridView1.Rows[e.RowIndex].FindControl("ddlCities") as DropDownList).SelectedItem.Text;
            bool IsActive = (GridView1.Rows[e.RowIndex].FindControl("chkStatus") as CheckBox).Checked;
            string EmployeeId = GridView1.DataKeys[e.RowIndex].Value.ToString();
            string conString = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                string query = "UPDATE EmployeeMaster SET CountryId = @CountryId WHERE EmployeeId = @EmployeeId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeId", EmployeeId);
                    cmd.Parameters.AddWithValue("@CountryId", CountryId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            using (SqlConnection con = new SqlConnection(conString))
            {
                string query = "UPDATE EmployeeMaster SET StateId = @StateId WHERE EmployeeId = @EmployeeId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeId", EmployeeId);
                    cmd.Parameters.AddWithValue("@StateId", StateId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            using (SqlConnection con = new SqlConnection(conString))
            {
                string query = "UPDATE EmployeeMaster SET CityId = @CityId WHERE EmployeeId = @EmployeeId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeId", EmployeeId);
                    cmd.Parameters.AddWithValue("@CityId", CityId);
                    con.Open();
                    cmd.ExecuteNonQuery();                    
                }
            }
            using (SqlConnection con = new SqlConnection(conString))
            {
                string query = "UPDATE EmployeeMaster SET IsActive = @IsActive WHERE EmployeeId = @EmployeeId";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeId", EmployeeId);
                    cmd.Parameters.AddWithValue("@IsActive", IsActive);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
            //int index = row.RowIndex;
            //int index = Convert.ToInt32(e.CommandArgument);

            //string id = GetTextFromGridViewLabel(gvBanquet, index, "lblID");
            //string name = GetTextFromGridViewLabel(gvBanquet, index, "lblName");

            //switch (e.CommandName)
            //{
            //    case "Edit":
            //        //lblID.Text = id;
            //        //txtName.Text = name;
            //        System.Text.StringBuilder sb = new System.Text.StringBuilder();
            //        sb.Append(@"<script type='text/javascript'>");
            //        sb.Append("$('#myModal').modal('show');");
            //        sb.Append(@"</script>");
            //        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "MyModal",
            //        sb.ToString(), false);

            //        break;
            //    default:
            //        break;
            //}
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

        }
    }
}