<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeMasterList.aspx.cs" Inherits="EmployeeManagement.EmployeeMasterList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<script src="jquery-1.10.2.min.js"></script>--%>
    <script src="Scripts/jquery-3.6.0.js"></script>
    <script src="Scripts/DataTables/jquery.dataTables.min.js"></script>
    <link href="Content/DataTables/css/jquery.dataTables.min.css" rel="stylesheet" />

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

<%--    <script type="text/javascript">
        $(function () {
            $("GridView1").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
        });
    </script>--%>


</head>
<body>
    <form id="form1" runat="server">
        <div>
            Search :
            <asp:TextBox ID="txtSearch" runat="server" Font-Size="20px" onkeyup="Search_Gridview(this)"></asp:TextBox><br />
            <br />
            <asp:GridView ID="GridView1" runat="server" CssClass="gvv" ClientIDMode="AutoID" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" PageSize="3"
                BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" ShowHeaderWhenEmpty="True"
                CellPadding="3" CellSpacing="2" DataKeyNames="EmployeeId,CountryId,StateId,CityId" OnRowUpdating="GridView1_RowUpdating" OnRowEditing="GridView1_RowEditing1" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDeleting="GridView1_RowDeleting" OnRowDataBound="GridView1_RowDataBound" OnSorting="GridView1_Sorting">
                <Columns>
                    <asp:TemplateField HeaderText="EmailAddress" SortExpression="EmailAddress">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEmailAddress" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:TextBox>
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
                    <asp:TemplateField HeaderText="PanNumber" SortExpression="PanNumber">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPanNumber" runat="server" Text='<%# Bind("PanNumber") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("PanNumber") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PassportNumber" SortExpression="PassportNumber">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPassportNumber" runat="server" Text='<%# Bind("PassportNumber") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("PassportNumber") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Gender" SortExpression="Gender">
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
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("ProfileImage") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

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
    </form>
</body>
</html>
