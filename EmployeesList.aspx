<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeesList.aspx.cs" Inherits="EmployeeManagement.EmployeesList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="jquery-ui.css" rel="stylesheet" />
    <script src="jquery-ui.js"></script>
    <script type="text/javascript">
        function Search_Gridview(strKey) {
            var strData = strKey.value.toLowerCase().split(" ");
            var tblData = document.getElementById("<%=GridView1.ClientID %>");
            var rowData;
            for (var i = 1; i < tblData.rows.length; i++) {
                rowData = tblData.rows[i].innerHTML;
                varstyleDisplay = 'none';
                for (var j = 0; j < strData.length; j++) {
                    if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                        styleDisplay = '';
                    else {
                        styleDisplay = 'none';
                        break;
                    }
                }
                tblData.rows[i].style.display = styleDisplay;
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="upModal" runat="server">
            <ContentTemplate>
                <triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                </triggers>
                <!-- Bootstrap Modal Dialog -->
                <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">Update Employee Data</h4>
                            </div>
                            <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                                <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px">

                                    <div class="form-group col-lg-6">
                                        <label>Email Address:</label>
                                        <asp:TextBox ID="txtEmailAddress" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <label>Country:</label>
                                        <asp:DropDownList ID="ddlCountrys" CssClass="form-control" DataValueField="CountryId"
                                            DataTextField="CountryName" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <label>States:</label>
                                        <asp:DropDownList ID="ddlStates" CssClass="form-control" DataValueField="CountryId"
                                            DataTextField="CountryName" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <label>City:</label>
                                        <asp:DropDownList ID="ddlCitys" CssClass="form-control" DataValueField="CountryId"
                                            DataTextField="CountryName" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <label>Pan Number:</label>
                                        <asp:TextBox ID="txtPanNumber" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <label>Passport Number:</label>
                                        <asp:TextBox ID="txtPassportNumber" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <label>Gender:</label>
                                        <asp:RadioButtonList ID="GenderRadioButtonList" runat="server"
                                            RepeatDirection="Horizontal">
                                            <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Female" Value="2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <label>IsActive:</label>
                                        <asp:CheckBox ID="chkIsActive" runat="server" Text="Active" />
                                    </div>
                                    <div class="form-group col-lg-6">
                                        <label>Profile Picture:</label>
                                        <asp:FileUpload ID="FileUpload1" runat="server" />
                                    </div>
                                </div>

                                <div class="modal-footer" style="padding-left: 0px; padding-right: 0px">
                                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click"
                                        CssClass="btn btn-success btn-lg btn-block" Text="SAVE" UseSubmitBehavior="false"
                                        data-dismiss="modal" />
                                </div>
                            </div>
                    </div>
                </div>
                </div>
                <!-- /.modal -->

            </ContentTemplate>
        </asp:UpdatePanel>
        <!-- /.upModel -->--%>

        <div style="font-family: Arial">
            Search :
            <asp:TextBox ID="txtSearch" runat="server" Font-Size="20px" onkeyup="Search_Gridview(this)"></asp:TextBox><br />
            <br />
            <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>--%>

            <div class="col-lg-12 table-responsive">
                <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered" ClientIDMode="AutoID" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" PageSize="3"
                    BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" ShowHeaderWhenEmpty="True"
                    CellPadding="3" CellSpacing="2" DataSourceID="ObjectDataSource2" DataKeyNames="EmployeeId" OnRowDataBound="GridView1_RowDataBound" OnRowUpdating="GridView1_RowUpdating" OnRowCommand="GridView1_RowCommand">
                    <Columns>

                        <%--<asp:BoundField DataField="CountryId" HeaderText="CountryId" SortExpression="CountryId" />--%>
                        <%--<asp:BoundField DataField="StateId" HeaderText="StateId" SortExpression="StateId" />
                    <asp:BoundField DataField="CityId" HeaderText="CityId" SortExpression="CityId" />--%>
                        <%--<asp:BoundField DataField="ProfileImage" HeaderText="ProfileImage" SortExpression="ProfileImage" />--%>
                        <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" SortExpression="EmailAddress" />
                        <asp:TemplateField HeaderText="CountryId">
                            <ItemTemplate>
                                <asp:Label ID="lblCountries" runat="server" Text='<%# Eval("CountryId")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlCountries" runat="server">
                                </asp:DropDownList>

                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="StateId">
                            <ItemTemplate>
                                <asp:Label ID="lblStates" runat="server" Text='<%# Eval("StateId")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlStates" runat="server">
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="CityId">
                            <ItemTemplate>
                                <asp:Label ID="lblCity" runat="server" Text='<%# Eval("CityId")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlCities" runat="server">
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="PanNumber" HeaderText="PanNumber" SortExpression="PanNumber" />
                        <asp:BoundField DataField="PassportNumber" HeaderText="PassportNumber" SortExpression="PassportNumber" />
                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                        <%--<asp:BoundField DataField="IsActive" HeaderText="IsActive" SortExpression="IsActive" />--%>
                        <asp:TemplateField HeaderText="Active">
                            <ItemTemplate>
                                <asp:Label Text='<%# Convert.ToBoolean(Eval("IsActive"))? "Yes" : "No" %>' runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkStatus" Text="Active" runat="server" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:ImageField DataImageUrlField="ProfileImage" HeaderText="ProfileImage"></asp:ImageField>

                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />

                    </Columns>
                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FFF1D4" />
                    <SortedAscendingHeaderStyle BackColor="#B95C30" />
                    <SortedDescendingCellStyle BackColor="#F1E5CE" />
                    <SortedDescendingHeaderStyle BackColor="#93451F" />
                    <EmptyDataTemplate>
                        <div align="center">No records found.</div>
                    </EmptyDataTemplate>
                    <HeaderStyle BackColor="#5cb85c" BorderColor="#4CAE4C" ForeColor="White"></HeaderStyle>
                    <PagerStyle Font-Size="Larger" ForeColor="Black" HorizontalAlign="Center" />
                </asp:GridView>
            </div>

            <%--  </ContentTemplate>
            </asp:UpdatePanel>--%>

            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SortParameterName="sortColumn"
                SelectMethod="GetEmployees" TypeName="EmployeeDataAccessLayer.EmployeeDataAccess" DeleteMethod="DeleteEmployee" UpdateMethod="UpdateEmployee">
                <DeleteParameters>
                    <asp:Parameter Name="EmployeeId" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="EmailAddress" Type="String" />
                    <%--<asp:Parameter Name="CountryId" Type="String" />--%>
                    <%-- <asp:Parameter Name="StateId" Type="String" />
                    <asp:Parameter Name="CityId" Type="String" />--%>
                    <asp:Parameter Name="PanNumber" Type="String" />
                    <asp:Parameter Name="PassportNumber" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <%--<asp:Parameter Name="IsActive" Type="Int32" />--%>
                    <asp:Parameter Name="ProfileImage" Type="String" />
                    <asp:Parameter Name="EmployeeId" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
        </div>
    </form>
</body>
</html>
