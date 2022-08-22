<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsertEmployee.aspx.cs" Inherits="EmployeeManagement.InsertEmployee" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <script src="Scripts/jquery-3.6.0.js"></script>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.js"></script>
    <link href="Content/bootstrap-datepicker.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap-datepicker.min.js"></script>
    <link href="jquery-ui.css" rel="stylesheet" />
    <script src="jquery-ui.js"></script>
    <script src="Scripts/select2.min.js"></script>
    <link href="Content/css/select2.min.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {
            $("[id*=ddlCountrys]").select2();
            $("[id*=ddlStates]").select2();
            $("[id*=ddlCitys]").select2();
        });
        function pageLoad() {
            $("#txtDateOfBirth, #txtDateOfJoinee").datepicker(
                {
                    maxDate: '-1'
                });
        };
    </script>

    <style>
        /*.ChangeWidth {
            width: 34%;
        }*/
        .select2 {
            width: 30% !important;
        }
    </style>
    <script type="text/javascript" src="http://jqueryjs.googlecode.com/files/jquery-1.3.1.js">
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

            function EndRequestHandler(sender, args) {
                $('.classTarget').datepicker({ dateFormat: 'dd-mm-yy' });
            }
        });
    </script>
</head>
<body>
    <div class="container">
        <div class="row">
            <h2>Employee Form</h2>
            <form id="form1" class="form-horizontal" runat="server">
                <asp:ScriptManager ID="scriptmanager1" runat="server">
                </asp:ScriptManager>
                <div>
                    <asp:UpdatePanel ID="updatepnl" runat="server">
                        <Triggers>
                            <asp:PostBackTrigger ControlID="Button1" />
                        </Triggers>
                        <ContentTemplate>
                                <div class="form-group col-md-6">
                                    <label for="lblFirstName">First Name</label>
                                    <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorFirstName"
                                        runat="server" ForeColor="Red"
                                        ErrorMessage="First Name is required"
                                        ControlToValidate="txtFirstName" Display="Dynamic" Text="*">
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblLastName">Last Name</label>
                                    <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblEmailAddress">Email Address</label>
                                    <asp:TextBox ID="txtEmailAddress" runat="server" AutoPostBack="true" OnTextChanged="txtEmailAddress_TextChanged"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmailAddress"
                                        runat="server" ForeColor="Red"
                                        ErrorMessage="Email Address is required"
                                        ControlToValidate="txtEmailAddress" Display="Dynamic" Text="*">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail"
                                        runat="server" ErrorMessage="Invalid Email Format"
                                        ControlToValidate="txtEmailAddress" ForeColor="Red"
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"
                                        Text="*">
                                    </asp:RegularExpressionValidator>
                                    <asp:Label ID="lblEmailId" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblMobileNumber">Mobile Number</label>
                                    <asp:TextBox ID="txtMobileNumber" runat="server" AutoPostBack="true" OnTextChanged="txtMobileNumber_TextChanged"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorMobileNumber"
                                        runat="server" ForeColor="Red"
                                        ErrorMessage="Mobile Number is required"
                                        ControlToValidate="txtMobileNumber" Display="Dynamic" Text="*">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidatorMobileNumber" runat="server"
                                        ControlToValidate="txtMobileNumber" ErrorMessage="Mobile Number should be 10 digit"
                                        ValidationExpression="[0-9]{10}" Display="Dynamic" Text="*"></asp:RegularExpressionValidator>
                                    <asp:Label ID="lblMobileNo" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblPanNumber">Pan Number</label>
                                    <asp:TextBox ID="txtPanNumber" AutoPostBack="true" OnTextChanged="txtPanNumber_TextChanged" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPanNumber"
                                        runat="server" ForeColor="Red"
                                        ErrorMessage="Pan Number is required"
                                        ControlToValidate="txtPanNumber" Display="Dynamic" Text="*">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidatorPanNumber"
                                        runat="server" ErrorMessage="Invalid Pan Number Format"
                                        ControlToValidate="txtPanNumber" ForeColor="Red"
                                        ValidationExpression="([A-Z]){5}([0-9]){4}([A-Z]){1}$" Display="Dynamic"
                                        Text="*">
                                    </asp:RegularExpressionValidator>
                                    <asp:Label ID="lblpanmsg" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblPassportNumber">Passport Number</label>
                                    <asp:TextBox ID="txtPassportNumber" runat="server" AutoPostBack="true" OnTextChanged="txtPassportNumber_TextChanged"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassportNumber"
                                        runat="server" ForeColor="Red"
                                        ErrorMessage="Passport Number is required"
                                        ControlToValidate="txtPassportNumber" Display="Dynamic" Text="*">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidatorPassportNumber"
                                        runat="server" ErrorMessage="Invalid Passport Number Format"
                                        ControlToValidate="txtPassportNumber" ForeColor="Red"
                                        ValidationExpression="([A-Z]){1}([0-9]){7}$" Display="Dynamic"
                                        Text="*">
                                    </asp:RegularExpressionValidator>
                                    <asp:Label ID="lblpassport" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblDateOfBirth">Date Of Birth</label>
                                    <asp:TextBox ID="txtDateOfBirth" CssClass="classTarget" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorDateOfBirth"
                                        runat="server" ForeColor="Red"
                                        ErrorMessage="Date Of Birth is required"
                                        ControlToValidate="txtDateOfBirth" Display="Dynamic" Text="*">
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblDateOfJoinee">Date Of Joinee</label>
                                    <asp:TextBox ID="txtDateOfJoinee" CssClass="classTarget" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblCountrys">Country</label>
                                    <asp:DropDownList ID="ddlCountrys" DataValueField="CountryId"
                                        DataTextField="CountryName" runat="server" OnSelectedIndexChanged="ddlCountrys_SelectedIndexChanged" AutoPostBack="True">
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblStates">State</label>
                                    <asp:DropDownList ID="ddlStates" DataTextField="StateName"
                                        DataValueField="StateId" runat="server" OnSelectedIndexChanged="ddlStates_SelectedIndexChanged" AutoPostBack="True">
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblCitys">City</label>
                                    <asp:DropDownList ID="ddlCitys" DataTextField="CityName"
                                        DataValueField="CityId" runat="server" OnSelectedIndexChanged="ddlCitys_SelectedIndexChanged">
                                    </asp:DropDownList>

                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblFileUpload1">Profile Picture</label>
                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                                        runat="server" ErrorMessage="Invalid Image Format"
                                        ControlToValidate="FileUpload1" ForeColor="Red"
                                        ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg)$" Display="Dynamic"
                                        Text="*">
                                    </asp:RegularExpressionValidator>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblGender">Gender</label>
                                    <asp:RadioButtonList ID="GenderRadioButtonList" runat="server"
                                        RepeatDirection="Horizontal">
                                        <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Female" Value="2"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lblStatus">Active</label>
                                    <asp:CheckBox ID="chkStatus" runat="server" Text="" />
                                </div>
                                <div class="form-group col-md-6">
                                    <asp:Button ID="Button1" CssClass="btn btn-default" runat="server" Text="Save" OnClick="btnSave_Click" />
                                </div>
                                <div class="form-group col-md-6">
                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server"
                                        ForeColor="Red" HeaderText="Page Errors" ShowMessageBox="True"
                                        ShowSummary="true" DisplayMode="List" />
                                </div>
                                <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>

                            <%--<div style="font-family:Arial;">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblFirstName" runat="server" Text="First Name"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorFirstName"
                            runat="server" ForeColor="Red"
                            ErrorMessage="First Name is required"
                            ControlToValidate="txtFirstName" Display="Dynamic" Text="*">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblLastName" runat="server" Text="Last Name"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEmailAddress" runat="server" Text="Email Address"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmailAddress" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmailAddress"
                            runat="server" ForeColor="Red"
                            ErrorMessage="Email Address is required"
                            ControlToValidate="txtEmailAddress" Display="Dynamic" Text="*">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail"
                            runat="server" ErrorMessage="Invalid Email Format"
                            ControlToValidate="txtEmailAddress" ForeColor="Red"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"
                            Text="*">
                        </asp:RegularExpressionValidator>
                        <asp:Label ID="lblEmailId" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblMobileNumber" runat="server" Text="Mobile Number"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtMobileNumber" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorMobileNumber"
                            runat="server" ForeColor="Red"
                            ErrorMessage="Mobile Number is required"
                            ControlToValidate="txtMobileNumber" Display="Dynamic" Text="*">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorMobileNumber" runat="server"
                            ControlToValidate="txtMobileNumber" ErrorMessage="Mobile Number should be 10 digit"
                            ValidationExpression="[0-9]{10}" Display="Dynamic" Text="*"></asp:RegularExpressionValidator>
                        <asp:Label ID="lblMobileNo" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPanNumber" runat="server" Text="Pan Number"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPanNumber" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorPanNumber"
                            runat="server" ForeColor="Red"
                            ErrorMessage="Pan Number is required"
                            ControlToValidate="txtPanNumber" Display="Dynamic" Text="*">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorPanNumber"
                            runat="server" ErrorMessage="Invalid Pan Number Format"
                            ControlToValidate="txtPanNumber" ForeColor="Red"
                            ValidationExpression="([A-Z]){5}([0-9]){4}([A-Z]){1}$" Display="Dynamic"
                            Text="*">
                        </asp:RegularExpressionValidator>
                        <asp:Label ID="lblpanmsg" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPassportNumber" runat="server" Text="Passport Number"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPassportNumber" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassportNumber"
                            runat="server" ForeColor="Red"
                            ErrorMessage="Passport Number is required"
                            ControlToValidate="txtPassportNumber" Display="Dynamic" Text="*">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorPassportNumber"
                            runat="server" ErrorMessage="Invalid Passport Number Format"
                            ControlToValidate="txtPassportNumber" ForeColor="Red"
                            ValidationExpression="([A-Z]){1}([0-9]){7}$" Display="Dynamic"
                            Text="*">
                        </asp:RegularExpressionValidator>
                        <asp:Label ID="lblpassport" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblDateOfBirth" runat="server" Text="Date Of Birth"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDateOfBirth" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorDateOfBirth"
                            runat="server" ForeColor="Red"
                            ErrorMessage="Date Of Birth is required"
                            ControlToValidate="txtDateOfBirth" Display="Dynamic" Text="*">
                        </asp:RequiredFieldValidator>
                       
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblDateOfJoinee" runat="server" Text="Date Of Joinee"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDateOfJoinee" runat="server"></asp:TextBox>
                    </td>
                </tr>
        <tr>
            <td>
                <asp:Label ID="lblCountry" runat="server" Text="Country"></asp:Label></td>
            <td>
                <asp:DropDownList ID="ddlCountrys" CssClass="ChangeWidth" DataValueField="CountryId"
                    DataTextField="CountryName" runat="server" OnSelectedIndexChanged="ddlCountrys_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblState" runat="server" Text="State"></asp:Label></td>
            <td>
                <asp:DropDownList ID="ddlStates" CssClass="ChangeWidth" DataTextField="StateName"
                    DataValueField="StateId" runat="server" OnSelectedIndexChanged="ddlStates_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblCity" runat="server" Text="City"></asp:Label></td>
            <td>
                <asp:DropDownList ID="ddlCitys" CssClass="ChangeWidth" DataTextField="CityName"
                    DataValueField="CityId" runat="server" OnSelectedIndexChanged="ddlCitys_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblProfilePicture" runat="server" Text="Profile Picture"></asp:Label></td>
            <td>
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorFileUpload1"
                    runat="server" ErrorMessage="Invalid Image Format"
                    ControlToValidate="FileUpload1" ForeColor="Red"
                    ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg)$" Display="Dynamic"
                    Text="*">
                </asp:RegularExpressionValidator>

            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblGender" runat="server" Text="Gender"></asp:Label></td>
            <td>
                <asp:RadioButtonList ID="GenderRadioButtonList" runat="server"
                    RepeatDirection="Horizontal">
                    <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Female" Value="2"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblActive" runat="server" Text="Active"></asp:Label></td>
            <td>
                <asp:CheckBox ID="chkStatus" runat="server" Text="Active" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                    ForeColor="Red" HeaderText="Page Errors" ShowMessageBox="True"
                    ShowSummary="true" DisplayMode="List" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label></td>
        </tr>

        </table>

        </div>
                            --%>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

            </form>
        </div>
    </div>
</body>
</html>
