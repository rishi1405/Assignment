<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Demo.aspx.cs" Inherits="EmployeeManagement.Demo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%-- <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <script src="bootstrap/js/bootstrap.min.js"></script>--%>
    <script src="jquery-1.10.2.min.js"></script>
    <script src="Scripts/DataTables/jquery.dataTables.min.js"></script>
    <link href="Content/DataTables/css/jquery.dataTables.min.css" rel="stylesheet" />

    <script type="text/javascript">
        $(function () {
            $(".gvv").DataTable({
                "processing": true,
                "language": {
                    processing: '<div class="spinner"></div>'
                },
                bLengthChange: true,
                lengthMenu: [[5, 10, -1], [5, 10, "All"]],
                bFilter: true,
                "columnDefs": [
                    { "orderable": false, "targets": [6, 7, 8, 9] }
                ],
                bPaginate: true
            });
        });
        
    </script>

    <style type="text/css">
        .buttonClass {
            padding: 1px 10px;
            text-decoration: none;
            border: solid 1px black;
            background-color: #ababab;
        }
        .Demo
        {
         font-family:Arial;
         font-size:201%;
         padding-left:40%;
        }
            .buttonClass:hover {
                border: solid 1px Black;
                background-color: #ffffff;
            }
    </style>

    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }       
       
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%--<h1 style="text-align: center">Employee Master List</h1>--%>
            <asp:Label ID="lblHeader" CssClass="Demo" runat="server" Text=""></asp:Label>
            <asp:GridView ID="GridView1" runat="server" CssClass="gvv" ClientIDMode="AutoID" AutoGenerateColumns="False"
                BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" ShowHeaderWhenEmpty="True"
                CellPadding="3" CellSpacing="2" DataKeyNames="EmployeeId,CountryId,StateId,CityId" OnRowUpdating="GridView1_RowUpdating" OnRowEditing="GridView1_RowEditing1" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting" OnRowDataBound="GridView1_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="EmailAddress">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEmailAddress" Width="90%" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CountryId">
                        <ItemTemplate>
                            <asp:Label ID="lblCountries" runat="server" Text='<%# Eval("CountryName")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlCountries" AutoPostBack="true" DataTextField="CountryName" DataValueField="CountryId" OnSelectedIndexChanged="ddlCountries_SelectedIndexChanged" runat="server">
                            </asp:DropDownList>

                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="StateId">
                        <ItemTemplate>
                            <asp:Label ID="lblStates" runat="server" Text='<%# Eval("StateName")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlStates" AutoPostBack="true" DataTextField="StateName" OnSelectedIndexChanged="ddlStates_SelectedIndexChanged" DataValueField="StateId" runat="server">
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CityId">
                        <ItemTemplate>
                            <asp:Label ID="lblCity" runat="server" Text='<%# Eval("CityName")%>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlCities" DataTextField="CityName" DataValueField="CityId" runat="server">
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PanNo">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPanNumber"  Width="90%" runat="server" Text='<%# Bind("PanNumber") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("PanNumber") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PassportNo">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPassportNumber"  Width="90%" runat="server" Text='<%# Bind("PassportNumber") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("PassportNumber") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Gender">
                        <EditItemTemplate>
                            <asp:RadioButtonList ID="GenderRadioButtonList" runat="server"
                                RepeatDirection="Horizontal">
                                <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="2"></asp:ListItem>
                            </asp:RadioButtonList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Active">
                        <ItemTemplate>
                            <asp:Label Text='<%# Convert.ToBoolean(Eval("IsActive"))? "Yes" : "No" %>' runat="server" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkStatus" Text="Active" runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ProfileImage">
                        <EditItemTemplate>
                            <asp:FileUpload ID="FileUpload1"  Width="105%" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("ProfileImage") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions" ShowHeader="False">
                        <EditItemTemplate>                            
                            <div>
                            <asp:LinkButton ID="LinkButton1" CssClass="buttonClass" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                           </div>
                            </br><asp:LinkButton ID="LinkButton2" CssClass="buttonClass" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <div><asp:LinkButton ID="LinkButton1" CssClass="buttonClass" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                            </div>
                            </br><asp:LinkButton ID="LinkButton2" CssClass="buttonClass" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />--%>
                </Columns>
                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                <EmptyDataTemplate>
                    <div align="center">No records found.</div>
                </EmptyDataTemplate>
                <HeaderStyle BackColor="#5cb85c" BorderColor="#4CAE4C" ForeColor="White"></HeaderStyle>
            </asp:GridView>

        </div>

    </form>
</body>
</html>
