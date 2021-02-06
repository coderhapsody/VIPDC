<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="ManageAlerts.aspx.cs" Inherits="VIPDC.Web.ManageAlerts" StylesheetTheme="Default" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="VIPDC.Web" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .style1 {
            width: 160px;
            height: 41px;
        }

        .style2 {
            width: 1px;
            height: 41px;
        }

        .style3 {
            height: 41px;
        }

        div.RadPicker table {
            width: 180px !important;
        }

        .col1,
        .col2,
        .col3 {
            margin: 0;
            padding: 0 5px 0 0;
            width: 110px;
            line-height: 14px;
            float: left;
        }

        .rcbHeader ul,
        .rcbFooter ul,
        .rcbItem ul,
        .rcbHovered ul,
        .rcbDisabled ul {
            margin: 0;
            padding: 0;
            width: 100%;
            display: inline-block;
            list-style-type: none;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Alerts
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">        
    <asp:MultiView ID="mvwForm" runat="server">
        <asp:View ID="viwRead" runat="server">
            <table style="width: 100%">
                <tr>
                    <td>
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 180px">Filter by</td>
                                <td style="width: 1px">:
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlFilter" runat="server" CssClass="dropdown">
                                        <asp:ListItem Selected="True" Value="0">Show All Alert(s)</asp:ListItem>
                                        <asp:ListItem Value="1">Show Only Active Alert(s)</asp:ListItem>
                                        <asp:ListItem Value="2">Show Only Inactive Alert(s)</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 180px">&nbsp;
                                </td>
                                <td style="width: 1px">&nbsp;
                                </td>
                                <td>
                                    <asp:Button ID="btnRefresh" EnableViewState="false" CommandName="FormCommand" CommandArgument="Refresh"
                                        CssClass="button" runat="server" Text="Refresh" ToolTip="Show data with specified criteria"
                                        ValidationGroup="View" OnClick="btnRefresh_Click" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblStatus" runat="server" EnableViewState="False"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:LinkButton ID="lnbAddNew" runat="server" CommandArgument="AddNew" CommandName="FormCommand"
                            EnableViewState="false" SkinID="AddNewButton" OnClick="lnbAddNew_Click" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="lnbDelete" runat="server" CommandArgument="Delete" CommandName="FormCommand" OnClientClick="return confirm('Delete marked row(s) ?');"
                            EnableViewState="false" SkinID="DeleteButton" OnClick="lnbDelete_Click" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:HyperLink runat="server" ID="hypCalendar" Text="View Calendar" NavigateUrl="Default.aspx?FromAlert=1"></asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" ShowGroupPanel="True" AutoGenerateColumns="False" OnItemCommand="RadGrid1_ItemCommand" GroupingSettings-CaseSensitive="false" AllowCustomPaging="True" OnPageIndexChanged="RadGrid1_PageIndexChanged">
                            <GroupingSettings CaseSensitive="False" />
                            <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True" EnableRowHoverStyle="true">
                            </ClientSettings>
                            <MasterTableView DataKeyNames="ID" DataSourceID="sdsMaster">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="ID" DataType="System.Int32" FilterControlAltText="Filter ID column" HeaderText="ID" ReadOnly="True" SortExpression="ID" UniqueName="ID">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Subject" FilterControlAltText="Filter Subject column" HeaderText="Subject" SortExpression="Subject" UniqueName="Subject">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" SortExpression="Description" UniqueName="Description">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PIC" FilterControlAltText="Filter PIC column" HeaderText="PIC" SortExpression="emp.Name" UniqueName="PIC">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="StartDate" DataType="System.DateTime" FilterControlAltText="Filter StartDate column" HeaderText="Start Date" SortExpression="StartDate" UniqueName="StartDate" DataFormatString="{0:ddd, dd-MMM-yyyy}">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <telerik:RadDatePicker ID="StartDateFilterDatePicker" runat="server" Width="100px"
                                                ClientEvents-OnDateSelected="StartDateSelected" DbSelectedDate='<%# SetStartDate(Container) %>' />
                                            <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
                                                <script type="text/javascript">
                                                    function StartDateSelected(sender, args) {
                                                        var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                                        var date = FormatSelectedDate(sender);
                                                        tableView.filter("StartDate", date, "GreaterThanOrEqualTo");
                                                    }

                                                    function FormatSelectedDate(picker) {
                                                        var date = picker.get_selectedDate();
                                                        var dateInput = picker.get_dateInput();
                                                        var formattedDate = dateInput.get_dateFormatInfo().FormatDate(date, dateInput.get_displayDateFormat());
                                                        return formattedDate;

                                                    }
                                                </script>
                                            </telerik:RadScriptBlock>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="EndDate" DataType="System.DateTime" FilterControlAltText="Filter EndDate column" HeaderText="End Date" SortExpression="EndDate" UniqueName="EndDate" DataFormatString="{0:ddd, dd-MMM-yyyy}">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text="" />
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <telerik:RadDatePicker ID="EndDateFilterDatePicker" runat="server" Width="100px"
                                                ClientEvents-OnDateSelected="StartDateSelected" DbSelectedDate='<%# SetEndDate(Container) %>' />
                                            <telerik:RadScriptBlock ID="RadScriptBlock3" runat="server">
                                                <script type="text/javascript">
                                                    function StartDateSelected(sender, args) {
                                                        var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                                        var date = FormatSelectedDate(sender);
                                                        tableView.filter("EndDate", date, "LessThanOrEqualTo");
                                                    }
                                                </script>
                                            </telerik:RadScriptBlock>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridCheckBoxColumn DataField="Active" DataType="System.Boolean" FilterControlAltText="Filter Active column" HeaderText="Active" SortExpression="Active" UniqueName="Active">
                                    </telerik:GridCheckBoxColumn>
                                    <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imbEdit" runat="server" SkinID="EditButton" CommandName="EditRow" CommandArgument='<%# Eval("ID") %>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkDelete" runat="server" ToolTip="Mark this row to delete" data-value='<%# Eval("ID") %>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>"
                            OnSelected="sdsMaster_Selected" OnSelecting="sdsMaster_Selecting" SelectCommand="proc_GetAllAlert_Paged"
                            SelectCommandType="StoredProcedure" SortParameterName="OrderByClause">
                            <SelectParameters>
                                <asp:Parameter Name="PageIndex" Type="Int32" />
                                <asp:Parameter Name="PageSize" Type="Int32" />
                                <asp:Parameter Direction="InputOutput" Name="RecordCount" Type="Int32" />
                                <asp:Parameter Name="ShowOnlyActiveAlerts" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </asp:View>
        <asp:View ID="viwAddEdit" runat="server">
            <asp:ValidationSummary ID="vsSummary" runat="server" EnableViewState="false" ValidationGroup="AddEdit"
                CssClass="errorMessage" ToolTip="Validation error" />
            <table style="width: 100%">
                <tr>
                    <td style="width: 160px">Subject
                    </td>
                    <td style="width: 1px">:
                    </td>
                    <td>
                        <asp:TextBox ID="txtSubject" runat="server" CssClass="textbox" ValidationGroup="AddEdit"
                            Width="400px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqvSubject" runat="server" CssClass="errorMessage"
                            ControlToValidate="txtSubject" ErrorMessage="<strong>Subject</strong> must be specified"
                            ToolTip="Subject must be specified" Text="*" SetFocusOnError="true" ValidationGroup="AddEdit" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 160px">Description
                    </td>
                    <td style="width: 1px">:
                    </td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="textbox" ValidationGroup="AddEdit"
                            Width="400px" Columns="60" Rows="8" TextMode="MultiLine" MaxLength="2000"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqvDescription" runat="server" CssClass="errorMessage"
                            ControlToValidate="txtDescription" ErrorMessage="<strong>Description</strong> must be specified"
                            ToolTip="Description must be specified" Text="*" SetFocusOnError="true" ValidationGroup="AddEdit" />
                    </td>
                </tr>
                <tr>
                    <td class="style1">Start Date
                    </td>
                    <td class="style2">:
                    </td>
                    <td class="style3">
                        <telerik:RadDateTimePicker runat="server" ID="CalendarPopup1" Width="180px"></telerik:RadDateTimePicker>
                        <%--                        &nbsp;<ew:CustomValidator ID="cvlDateFrom" runat="server" ErrorMessage="<strong>Date</strong> is invalid"
                            EnableViewState="false" ControlToValidate="CalendarPopup1" ValidationGroup="View"
                            CssClass="errorMessage" ClientValidationFunction="ValidateDate" ValidateEmptyText="true" />--%>                        
                    </td>
                </tr>
                <tr>
                    <td style="width: 160px">End Date
                    </td>
                    <td style="width: 1px">:
                    </td>
                    <td>
                        <telerik:RadDateTimePicker runat="server" ID="CalendarPopup2" Width="180px"></telerik:RadDateTimePicker>

                        <%--                        &nbsp;<ew:CustomValidator ID="cvlDateTo" runat="server" ErrorMessage="<strong>Date</strong> is invalid"
                            EnableViewState="false" ControlToValidate="CalendarPopup2" ValidationGroup="View"
                            CssClass="errorMessage" ClientValidationFunction="ValidateDate" ValidateEmptyText="true" />--%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 160px">PIC (from Employee)</td>
                    <td style="width: 1px">:</td>
                    <td>
                        <telerik:RadDropDownList runat="server" ID="ddlPIC"></telerik:RadDropDownList>                   
                        <asp:RequiredFieldValidator runat="server" ID="rqvPIC" ControlToValidate="ddlPIC" ErrorMessage="<b>PIC</b> must be specified" CssClass="errorMessage" Text="*"></asp:RequiredFieldValidator>
                    </td> 
                </tr>
                <tr>
                    <td style="width: 160px">&nbsp;</td>
                    <td style="width: 1px">&nbsp;</td>
                    <td>
                        <asp:CheckBox ID="chkInfinite" runat="server" Text="Set as infinite" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 160px">&nbsp;
                    </td>
                    <td style="width: 1px">&nbsp;
                    </td>
                    <td>
                        <asp:CheckBox ID="chkActive" runat="server" Text="Set as active alert" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 160px">&nbsp;
                    </td>
                    <td style="width: 1px">&nbsp;
                    </td>
                    <td>
                        <asp:Button ID="btnSave" runat="server" SkinID="SaveButton" EnableViewState="false"
                            CommandName="FormCommand" CommandArgument="Save" ValidationGroup="AddEdit" OnClick="btnSave_Click" />&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnCancel" runat="server" SkinID="CancelButton" CommandName="FormCommand"
                            CommandArgument="Cancel" OnClientClick="return confirm('Cancel current operation ?')"
                            EnableViewState="false" CausesValidation="false" OnClick="btnCancel_Click" />
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>

    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            if ($("#<%= chkInfinite.ClientID %>").is(":checked")) {
                $("#<%= CalendarPopup2.ClientID %>").hide();
            }
            else {
                $("#<%= CalendarPopup2.ClientID %>").show();
            }
            $("#<%= chkInfinite.ClientID %>").click(
                    function () {
                        chk = $("#<%= chkInfinite.ClientID %>");
                        if (chk.is(":checked")) {
                            $("#<%= CalendarPopup2.ClientID %>").hide();
                        }
                        else {
                            $("#<%= CalendarPopup2.ClientID %>").show();
                        }
                    });
        });
    </script>
</asp:Content>
