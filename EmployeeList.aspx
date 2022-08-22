<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeList.aspx.cs" Inherits="EmployeeManagement.EmployeeList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <%--<script src="Scripts/jquery-3.6.0.js"></script>--%>
    <%--    <link href="Content/DataTables/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="Scripts/DataTables/jquery.dataTables.min.js"></script>--%>

    <script type="text/javascript">    
        $(document).ajaxStart(function () {
            $("#loading").removeClass('hide');
        }).ajaxStop(function () {
            $("#loading").addClass('hide');
        });

        $(document).ready(function () {
            $.ajax({                
                async: false,
                "serverSide": true,
                url: 'EmployeeService.asmx/GetEmployees',
                method: 'post',
                dataType: 'json',               
                success: function (data) {
                    $('#datatable').dataTable({
                        //"processing": true,
                        //"language": {
                        //    processing: '<div class="spinner"></div>'
                        //},
                        bLengthChange: true,
                        lengthMenu: [[5, 10, -1], [5, 10, "All"]],
                        paging: true,
                        sort: true,
                        "columnDefs": [
                            { "orderable": false, "targets": [6, 7, 8, 9, 10, 11] }
                        ],
                        searching: true,
                        data: data,
                        columns: [
                            { 'data': 'EmployeeId' },
                            { 'data': 'EmailAddress' },
                            { 'data': 'CountryId' },
                            { 'data': 'StateId' },
                            { 'data': 'CityId' },
                            { 'data': 'PanNumber' },
                            { 'data': 'PassportNumber' },
                            { 'data': 'Gender' },
                            { 'data': 'IsActive' },
                            { 'data': 'ProfileImage' },
                            {
                                "data": null,
                                "defaultContent": '<input type="button" id="btnEdit" class="btn btn-primary" value="Edit" />',
                            },
                            {
                                "data": null,
                                "defaultContent": '<input type="button" id="btnDelete" class="btn btn-primary" value="Delete" />'
                            }
                        ]
                    });
                }
            });

            function showLoader() {
                $("#progressbar").css("display", "");
            }

            function hideLoader() {
                setTimeout(function () {
                    $("#progressbar").css("display", "none");
                }, 1000);
            }

            $('body').on('click', '[id*=btnEdit]', function () {
                var data = $(this).parents('tr').find('td');
                $('[id*=tbtUpdate]').show();
                var employeeeId = data.eq(0).html();
                var emailAddress = data.eq(1).html();
                var countryId = data.eq(2).html();
                var stateId = data.eq(3).html();
                var cityId = data.eq(4).html();
                var panNumber = data.eq(5).html();
                var passportNumber = data.eq(6).html();
                var gender = data.eq(7).html();
                var isActive = data.eq(8).html();
                var profileImage = data.eq(9).html();
                console.log(data);
                $('[id*=txtEmployeeId]').val(employeeeId);
                $('[id*=txtEmailAddress]').val(emailAddress);
                $('[id*=txtCountryId]').val(countryId);
                $('[id*=txtStateId]').val(stateId);
                $('[id*=txtCityId]').val(cityId);
                $('[id*=txtPanNumber]').val(panNumber);
                $('[id*=txtPassportNumber]').val(passportNumber);
                $('[id*=txtGender]').val(gender);
                $('[id*=txtIsActive]').val(isActive);
                $('[id*=txtProfileImage]').val(profileImage);
                //PageMethods.PopulateCountryId(countryId);
                //var spinner = '<div class="spinner-border" role="status">< span class="visually-hidden" > Loading...</span ></div >'
                $('#EditModal').modal("show");
            });

            $('body').on('click', '[id*=btnDelete]', function () {
                var data = $(this).parents('tr').find('td');
                $('[id*=tbtDelete]').show();
                var employeeeId = data.eq(0).html();
                console.log('data: ', data);
                $('[id*=hndDelete]').val(employeeeId);
                //$('[id*=lblEmployeeDelete]').html(employeeeId);
                $('#DeleteModal').modal("show");
            });
        });

    </script>
    <style>
        #loading {
            width: 100%;
            height: 100%;
            top: 0px;
            left: 0px;
            position: fixed;
            display: block;
            opacity: 0.7;
            background-color: #fff;
            z-index: 99;
            text-align: center;
        }

        #loading-content {
            position: absolute;
            top: 40%;
            left: 44%;
            text-align: center;
            z-index: 100;
        }

        .hide {
            display: none !important;
        }

        .loader {
            border: 16px solid #f3f3f3; / Light grey /
            border-top: 16px solid #3498db; / Blue /
            border-radius: 50%;
            width: 120px;
            height: 120px;
            animation: spin 2s linear infinite;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
        <div id="loading" class="hide">
            <div id="loading-content">
                <div class="loader"></div>
            </div>
        </div>
        <div style="width: auto; padding: 3px">
            <table id="datatable" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>EmployeeId</th>
                        <th>EmailAddress</th>
                        <th>CountryId</th>
                        <th>StateId</th>
                        <th>CityId</th>
                        <th>PanNumber</th>
                        <th>PassportNumber</th>
                        <th>Gender</th>
                        <th>IsActive</th>
                        <th>ProfileImage</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th>EmployeeId</th>
                        <th>EmailAddress</th>
                        <th>CountryId</th>
                        <th>StateId</th>
                        <th>CityId</th>
                        <th>PanNumber</th>
                        <th>PassportNumber</th>
                        <th>Gender</th>
                        <th>IsActive</th>
                        <th>ProfileImage</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id="EditModal">
            <div class="modal-dialog" role="document">
                <div class="modal-contet modaledit" style="background-color: khaki">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h2 class="modal-title" id="myModalLabel">Employee Data</h2>
                    </div>
                    <div class="modal-body" style="background-color: aqua;">
                        <div class="panel-body">

                            <table id="tbtUpdate" style="display: none;" class="table">
                                <tr>
                                    <td>EmployeeId</td>
                                    <td>
                                        <asp:TextBox ID="txtEmployeeId" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>EmailAddress</td>
                                    <td>
                                        <asp:TextBox ID="txtEmailAddress" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Country</td>
                                    <td>
                                        <asp:DropDownList ID="ddlCountries" DataTextField="CountryName" DataValueField="CountryId" runat="server">
                                            <asp:ListItem Value="-1">Please Select</asp:ListItem>
                                            <asp:ListItem Value="1" Text="India"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Japan"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="Malaysia"></asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<asp:TextBox ID="txtCountryId" runat="server"></asp:TextBox>--%>                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>States</td>
                                    <td>
                                        <asp:DropDownList ID="ddlStates" DataTextField="StateName" DataValueField="StateId" runat="server">
                                            <asp:ListItem Value="-1">Please Select</asp:ListItem>
                                            <asp:ListItem Value="1" Text="Maharashtra"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Tokyo"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="Johor"></asp:ListItem>
                                            <asp:ListItem Value="4" Text="UP"></asp:ListItem>
                                            <asp:ListItem Value="5" Text="Osaka"></asp:ListItem>
                                            <asp:ListItem Value="6" Text="Sarawak"></asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<asp:TextBox ID="txtStateId" runat="server"></asp:TextBox>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>City</td>
                                    <td>
                                        <asp:DropDownList ID="ddlCities" DataTextField="CityName" DataValueField="CityId" runat="server">
                                            <asp:ListItem Value="-1">Please Select</asp:ListItem>
                                            <asp:ListItem Value="1" Text="Pune"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Mumbai"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="Nashik"></asp:ListItem>
                                            <asp:ListItem Value="4" Text="Tokyo"></asp:ListItem>
                                            <asp:ListItem Value="5" Text="Yokohama"></asp:ListItem>
                                            <asp:ListItem Value="6" Text="Yokoha"></asp:ListItem>
                                            <asp:ListItem Value="7" Text="Ipoh"></asp:ListItem>
                                            <asp:ListItem Value="8" Text="Sarawak"></asp:ListItem>
                                            <asp:ListItem Value="9" Text="Johor"></asp:ListItem>
                                            <asp:ListItem Value="10" Text="Kashi"></asp:ListItem>
                                            <asp:ListItem Value="11" Text="Banaras"></asp:ListItem>
                                            <asp:ListItem Value="12" Text="Yokoham"></asp:ListItem>
                                            <asp:ListItem Value="13" Text="Yokohaa"></asp:ListItem>
                                            <asp:ListItem Value="14" Text="Perak"></asp:ListItem>
                                            <asp:ListItem Value="15" Text="Lumpur"></asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<asp:TextBox ID="txtCityId" runat="server"></asp:TextBox>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>PanNumber</td>
                                    <td>
                                        <asp:TextBox ID="txtPanNumber" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>PassportNumber</td>
                                    <td>
                                        <asp:TextBox ID="txtPassportNumber" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Gender</td>
                                    <td>
                                        <asp:TextBox ID="txtGender" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>IsActive</td>
                                    <td>
                                        <asp:TextBox ID="txtIsActive" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>ProfileImage</td>
                                    <td>
                                        <asp:TextBox ID="txtProfileImage" runat="server"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td align="center">
                                        <asp:Button Text="Update" runat="server" OnClick="Update" class="btn btn-primary" /></td>
                                    <td></td>
                                </tr>
                            </table>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" id="btnUpdate" class="btn btn-custm" edit-id="" data-dismiss="modal">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id="DeleteModal">
            <div class="modal-dialog" role="document">
                <div class="modal-contet modaldelete" style="background-color: khaki">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h2 class="modal-title" id="myModalLabel1">Delete Employee Data</h2>
                    </div>
                    <div class="modal-body" style="background-color: aqua;">
                        <div class="panel-body">
                            <table id="tbtDelete" style="display: none;" class="table">
                                <tr>
                                    Do you want to delete employee  
                                    <%--<asp:TextBox ID="txtDelete" Width="0px" Height="0px" runat="server"></asp:TextBox>--%>
                                    <asp:HiddenField ID="hndDelete" runat="server" />
                                    <%--<asp:Label ID="lblEmployeeDelete" runat="server" Text="Label"></asp:Label>--%>
                                    ??                                    
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Button Text="Delete" runat="server" OnClick="Delete" class="btn btn-danger" /></td>
                                    <td></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" id="btnUpdate1" class="btn btn-custm" delete-id="" data-dismiss="modal">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
