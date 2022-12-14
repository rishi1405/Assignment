using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeeManagement
{
    public partial class EmployeeMasterList : System.Web.UI.Page
    {
        public string GridViewSortExpression
        {
            get
            {
                return ViewState["GridViewSortExpression"] == null ? "FirstName" : ViewState["GridViewSortExpression"] as string;
            }
            set
            {
                ViewState["GridViewSortExpression"] = value;
            }
        }

        /// <summary>
        /// for Sorting Direction
        /// </summary>
        public SortDirection GridViewSortDirection
        {
            get
            {
                if (ViewState["sortDirection"] == null)
                    ViewState["sortDirection"] = SortDirection.Ascending;

                return (SortDirection)ViewState["sortDirection"];
            }
            set { ViewState["sortDirection"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                populateData();
            }
        }

        private void populateData()
        {
            // here code for populate person data
            //using (Neosoft_RishiEntities dc = new Neosoft_RishiEntities())
            //{
            //    var v = (from p in dc.EmployeeMasters
            //             join cn in dc.tblCountries on p.CountryId equals cn.CountryId
            //             join s in dc.tblStates on p.StateId equals s.StateId
            //             join c in dc.tblCities on p.CityId equals c.CityId
            //             where p.IsActive == true & p.IsDeleted == false
            //             select new
            //             {
            //                 p,
            //                 cn.CountryName,
            //                 s.StateName,
            //                 c.CityName
            //             });
            //    List<EmployeeMaster> allP = new List<EmployeeMaster>();
            //    foreach (var i in v)
            //    {
            //        EmployeeMaster p = new EmployeeMaster();
            //        p = i.p;
            //        p.CountryName = i.CountryName;
            //        p.StateName = i.StateName;
            //        p.CityName = i.CityName;
            //        allP.Add(p);
            //    }

            //    GridView1.DataSource = allP;
            //    GridView1.DataBind();
            //}

            using (Neosoft_RishiEntities dc = new Neosoft_RishiEntities())
            {
                var v = (from p in dc.EmployeeMasters
                         join cn in dc.tblCountries on p.CountryId equals cn.CountryId
                         join s in dc.tblStates on p.StateId equals s.StateId
                         join c in dc.tblCities on p.CityId equals c.CityId
                         where p.IsActive == true & p.IsDeleted == false
                         select new {p,cn.CountryName,s.StateName,c.CityName});
                List<EmployeeMaster> allP = new List<EmployeeMaster>();
                foreach (var i in v)
                {
                    EmployeeMaster p = new EmployeeMaster();
                    p = i.p;
                    p.CountryName = i.CountryName;
                    p.StateName = i.StateName;
                    p.CityName = i.CityName;
                    allP.Add(p);
                }
                if (allP != null && allP.Count > 0)
                {
                    if (GridViewSortDirection == SortDirection.Ascending)
                    {
                        GridView1.DataSource = allP.OrderBy(x => x.GetType().GetProperty(GridViewSortExpression).GetValue(x, null)).ToList();
                    }
                    else
                    {
                        GridView1.DataSource = allP.OrderByDescending(x => x.GetType().GetProperty(GridViewSortExpression).GetValue(x, null)).ToList();
                    };
                }
                else
                {
                    GridView1.DataSource = null;
                }
                GridView1.DataBind();
            }
        }

        private List<tblCountry> populateCountry()
        {
            // here code for populate state
            List<tblCountry> all = new List<tblCountry>();
            using (Neosoft_RishiEntities dc = new Neosoft_RishiEntities())
            {
                all = dc.tblCountries.ToList();
            }
            return all;
        }

        private List<tblState> populateState(int countryId)
        {
            // here code for populate state
            List<tblState> all = new List<tblState>();
            using (Neosoft_RishiEntities dc = new Neosoft_RishiEntities())
            {
                all = dc.tblStates.Where(a => a.CountryId == countryId).ToList();
                //all = dc.tblStates.Where(a => a.CountryId.Equals(countryId)).ToList();
            }
            return all;
        }

        private List<tblCity> populateCity(int stateID)
        {
            // here code for populate city based on stateID
            List<tblCity> all = new List<tblCity>();
            using (Neosoft_RishiEntities dc = new Neosoft_RishiEntities())
            {
                all = dc.tblCities.Where(a => a.StateId == stateID).ToList();
                //all = dc.tblCities.Where(a => a.StateId.Equals(stateID)).ToList();
            }
            return all;
        }

        protected void ddlCountries_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Populate State
            string countryID = ((DropDownList)sender).SelectedValue;
            int rowIndex = GridView1.EditIndex;
            DropDownList ddStateEdit = (DropDownList)GridView1.Rows[rowIndex].FindControl("ddlStates");
            if (ddStateEdit != null)
            {
                var v = populateState(Convert.ToInt32(countryID));
                ddStateEdit.DataSource = v;
                ddStateEdit.DataBind();
                if (ddStateEdit.Items.Count > 0)
                {
                    ddStateEdit.SelectedIndex = 0;
                }
            }
        }

        protected void ddlStates_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Populate city
            string stateID = ((DropDownList)sender).SelectedValue;
            int rowIndex = GridView1.EditIndex;
            DropDownList ddCityEdit = (DropDownList)GridView1.Rows[rowIndex].FindControl("ddlcities");
            if (ddCityEdit != null)
            {
                var v = populateCity(Convert.ToInt32(stateID));
                ddCityEdit.DataSource = v;
                ddCityEdit.DataBind();
                if (ddCityEdit.Items.Count > 0)
                {
                    ddCityEdit.SelectedIndex = 0;
                }
            }
        }

        protected void GridView1_RowEditing1(object sender, GridViewEditEventArgs e)
        {
            string countryID = GridView1.DataKeys[e.NewEditIndex]["CountryId"].ToString();
            string stateID = GridView1.DataKeys[e.NewEditIndex]["StateId"].ToString();
            string cityID = GridView1.DataKeys[e.NewEditIndex]["CityId"].ToString();

            // Edit Event
            GridView1.EditIndex = e.NewEditIndex;
            populateData();

            // Here populate data for dropdown state
            DropDownList ddlCountryEdit = (DropDownList)GridView1.Rows[e.NewEditIndex].FindControl("ddlCountries");
            if (ddlCountryEdit != null)
            {
                ddlCountryEdit.DataSource = populateCountry();
                ddlCountryEdit.DataTextField = "CountryName";
                ddlCountryEdit.DataValueField = "CountryID";
                ddlCountryEdit.DataBind();
                ddlCountryEdit.SelectedValue = countryID;
            }

            DropDownList ddStateEdit = (DropDownList)GridView1.Rows[e.NewEditIndex].FindControl("ddlStates");
            if (ddStateEdit != null)
            {
                ddStateEdit.DataSource = populateState(Convert.ToInt32(countryID));
                ddStateEdit.DataTextField = "StateName";
                ddStateEdit.DataValueField = "StateID";
                ddStateEdit.DataBind();
                ddStateEdit.SelectedValue = stateID;
            }

            DropDownList ddCityEdit = (DropDownList)GridView1.Rows[e.NewEditIndex].FindControl("ddlCities");
            if (ddCityEdit != null)
            {
                ddCityEdit.DataSource = populateCity(Convert.ToInt32(stateID));
                ddCityEdit.DataTextField = "CityName";
                ddCityEdit.DataValueField = "CityID";
                ddCityEdit.DataBind();
                ddCityEdit.SelectedValue = cityID;
            }
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Here Update
            int EmployeeId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["EmployeeId"].ToString());
            DropDownList ddCountryEdit = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlCountries");
            DropDownList ddStateEdit = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlStates");
            DropDownList ddCityEdit = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlCities");
            TextBox txtEmailAddressEdit = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEmailAddress");
            TextBox txtPanNumberEdit = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtPanNumber");
            TextBox txtPassportNumberEdit = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtPassportNumber");
            CheckBox chkStatusEdit = (CheckBox)GridView1.Rows[e.RowIndex].FindControl("chkStatus");
            RadioButtonList GenderRadioButtonListEdit = (RadioButtonList)GridView1.Rows[e.RowIndex].FindControl("GenderRadioButtonList");
            FileUpload FileUpload1Edit = (FileUpload)GridView1.Rows[e.RowIndex].FindControl("FileUpload1");
            string path = "";
            if (FileUpload1Edit.HasFile)
            {
                // Get the file size
                int fileSize = FileUpload1Edit.PostedFile.ContentLength;
                // If file size is greater than 200 kb
                if (fileSize > 209715200)
                {
                }
                else
                {
                    path = @"~/Uploads/Employee/" + FileUpload1Edit.FileName;
                    // Upload the file
                    FileUpload1Edit.SaveAs(Server.MapPath(path));

                }
            }
            using (Neosoft_RishiEntities dc = new Neosoft_RishiEntities())
            {
                EmployeeMaster p = dc.EmployeeMasters.Where(a => a.EmployeeId.Equals(EmployeeId)).FirstOrDefault();
                if (p != null)
                {
                    p.EmailAddress = txtEmailAddressEdit.Text.Trim();
                    p.PanNumber = txtPanNumberEdit.Text.Trim();
                    p.PassportNumber = txtPassportNumberEdit.Text.Trim();
                    p.IsActive = chkStatusEdit.Checked;
                    p.CountryId = Convert.ToInt32(ddCountryEdit.SelectedValue);
                    p.StateId = Convert.ToInt32(ddStateEdit.SelectedValue);
                    p.CityId = Convert.ToInt32(ddCityEdit.SelectedValue);
                    if (GenderRadioButtonListEdit.SelectedItem != null)
                    {
                        p.Gender = GenderRadioButtonListEdit.SelectedItem.Text;
                    }
                    if (path != "")
                    {
                        p.ProfileImage = path;
                    }
                    p.UpdatedDate = DateTime.Now;
                    dc.SaveChanges();
                    GridView1.EditIndex = -1;
                    populateData();
                }
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int EmployeeId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["EmployeeId"].ToString());
            using (Neosoft_RishiEntities dc = new Neosoft_RishiEntities())
            {
                EmployeeMaster p = dc.EmployeeMasters.Where(a => a.EmployeeId.Equals(EmployeeId)).FirstOrDefault();
                if (p != null)
                {
                    // p.EmailAddress = txtPersonNameEdit.Text.Trim();
                    // p.Address = txtAddressEdit.Text.Trim();
                    p.IsDeleted = true;
                    p.DeletedDate = DateTime.Now;
                    dc.SaveChanges();
                    populateData();
                }
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            populateData(); //bindgridview will get the data source and bind it again
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            populateData();
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

        }

        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            GridViewSortExpression = e.SortExpression;
            if (GridViewSortDirection == SortDirection.Ascending)
            {
                GridViewSortDirection = SortDirection.Descending;
            }
            else
            {
                GridViewSortDirection = SortDirection.Ascending;
            };
            populateData();
        }

    }
}