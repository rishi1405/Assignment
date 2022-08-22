<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DemoInsert.aspx.cs" Inherits="EmployeeManagement.DemoInsert" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>

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
        .form-control {
            width:190px !important
        }
        /*.select2 {
            width: 50% !important;
        }*/
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
    <form runat="server">
        <asp:ScriptManager ID="scriptmanager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="updatepnl" runat="server">
            <Triggers>
                <asp:PostBackTrigger ControlID="Button1" />
            </Triggers>
            <ContentTemplate>
                <div class="container" style="border:1px solid #cecece; padding:5px">
                    
                        <h1>Add Employee Portal</h1>
                        <div class="row">
                            <div class="row mb-3">
                                <label for="lblFirstName" class="col-sm-2">First Name</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtFirstName" Class="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorFirstName"
                                        runat="server" ForeColor="Red"
                                        ErrorMessage="First Name is required"
                                        ControlToValidate="txtFirstName" Display="Dynamic" Text="*">
                                    </asp:RequiredFieldValidator>
                                </div>
                                <label for="lblLastName" class="col-sm-2">Last Name</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtLastName" Class="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="row mb-3">
                                <label for="lblEmailAddress" class="col-sm-2">Email Address</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtEmailAddress" Class="form-control" runat="server" AutoPostBack="true" OnTextChanged="txtEmailAddress_TextChanged"></asp:TextBox>
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
                                <label for="lblMobileNumber" class="col-sm-2">Mobile Number</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtMobileNumber" Class="form-control" runat="server" AutoPostBack="true" OnTextChanged="txtMobileNumber_TextChanged"></asp:TextBox>
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
                            </div>
                        </div>

                        <div class="row">
                            <div class="row mb-3">
                                <label for="lblPanNumber" class="col-sm-2">Pan Number</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtPanNumber" Class="form-control" AutoPostBack="true" OnTextChanged="txtPanNumber_TextChanged" runat="server"></asp:TextBox>
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
                                <label for="lblPassportNumber" class="col-sm-2">Passport Number</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtPassportNumber" Class="form-control" runat="server" AutoPostBack="true" OnTextChanged="txtPassportNumber_TextChanged"></asp:TextBox>
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
                            </div>
                        </div>

                        <div class="row">
                            <div class="row mb-3">
                                <label for="lblDateOfBirth" class="col-sm-2">Date Of Birth</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtDateOfBirth" Class="form-control" CssClass="classTarget" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorDateOfBirth"
                                        runat="server" ForeColor="Red"
                                        ErrorMessage="Date Of Birth is required"
                                        ControlToValidate="txtDateOfBirth" Display="Dynamic" Text="*">
                                    </asp:RequiredFieldValidator>
                                </div>
                                <label for="lblDateOfJoinee" class="col-sm-2">Date Of Joinee</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtDateOfJoinee" Class="form-control" CssClass="classTarget" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="row mb-3">
                                <label for="lblCountrys" class="col-sm-2">Country</label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="ddlCountrys" Class="form-control" DataValueField="CountryId"
                                        DataTextField="CountryName" runat="server" OnSelectedIndexChanged="ddlCountrys_SelectedIndexChanged" AutoPostBack="True">
                                    </asp:DropDownList>
                                </div>
                                <label for="lblStates" class="col-sm-2">State</label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="ddlStates" Class="form-control" DataTextField="StateName"
                                        DataValueField="StateId" runat="server" OnSelectedIndexChanged="ddlStates_SelectedIndexChanged" AutoPostBack="True">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="row mb-3">
                                <label for="lblCitys" class="col-sm-2">City</label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="ddlCitys" Class="form-control" DataTextField="CityName"
                                        DataValueField="CityId" runat="server" OnSelectedIndexChanged="ddlCitys_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                                <label for="lblFileUpload1" class="col-sm-2">Profile Picture</label>
                                <div class="col-sm-4">
                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                                        runat="server" ErrorMessage="Invalid Image Format"
                                        ControlToValidate="FileUpload1" ForeColor="Red"
                                        ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg)$" Display="Dynamic"
                                        Text="*">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="row mb-3">
                                <label for="lblGender" class="col-sm-2">Gender</label>
                                <div class="col-sm-4">
                                    <asp:RadioButtonList ID="GenderRadioButtonList" Class="form-control" runat="server"
                                        RepeatDirection="Horizontal">
                                        <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Female" Value="2"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <label for="lblStatus" class="col-sm-2">Active</label>
                                <div class="col-sm-4">
                                    <asp:CheckBox ID="chkStatus" Class="form-control" runat="server" Text="" />
                                </div>
                            </div>
                        </div>

                        <asp:Button ID="Button1" Class="btn btn-primary" runat="server" Text="Save" OnClick="btnSave_Click" />

                        <asp:ValidationSummary ID="ValidationSummary2" runat="server"
                            ForeColor="Red" HeaderText="Page Errors" ShowMessageBox="True"
                            ShowSummary="true" DisplayMode="List" />

                        <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
