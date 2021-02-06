<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="MasterCustomer.aspx.cs" Inherits="VIPDC.Web.MasterCustomer" StylesheetTheme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
         .auto-style2 {
             width: 5px;
             height: 17px;
         }

        .auto-style4 {
            height: 26px;
        }

        .auto-style5 {
            height: 17px;
        }

        .auto-style6 {
            width: 140px;
        }

        .auto-style8 {
            width: 200px;
        }

        .auto-style9 {
            width: 2px;
        }

        .auto-style11 {
            width: 154px;
        }
        .auto-style12 {
            width: 120px;
            height: 17px;
        }
        .auto-style13 {
            width: 4px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Customer
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mvwForm" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>--%>
    <asp:MultiView runat="server" ID="mvwForm">
        <asp:View runat="server" ID="viwRead">
            <fieldset>
                <table class="fullwidth noborder">
                    <tr>
                        <td class="auto-style12">Name</td>
                        <td class="auto-style13">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindName" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style12">Customer Type</td>
                        <td class="auto-style13">:</td>
                        <td>
                            <telerik:RadDropDownList runat="server" ID="ddlFindCustomerType" SelectedText="All">
                                <Items>
                                    <telerik:DropDownListItem runat="server" Selected="True" Text="All" />
                                    <telerik:DropDownListItem runat="server" Text="Individual" Value="I" />
                                    <telerik:DropDownListItem runat="server" Text="Corporate" Value="C" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style12">Gender</td>
                        <td class="auto-style13">:</td>
                        <td>
                            <telerik:RadDropDownList runat="server" ID="ddlFindGender" style="margin-left: 188">
                                <Items>
                                    <telerik:DropDownListItem runat="server" Selected="True" Text="All" />
                                    <telerik:DropDownListItem runat="server" Text="Male" Value="M" />
                                    <telerik:DropDownListItem runat="server" Text="Female" Value="F" />
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style12"></td>
                        <td class="auto-style13"></td>
                        <td>
                            <telerik:RadButton runat="server" ID="btnSearch" Text="Search" OnClick="btnSearch_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <asp:LinkButton runat="server" ID="lnbAddNew" Text="Add New" OnClick="lnbAddNew_Click" SkinID="AddNewButton" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton runat="server" ID="lnbDelete" Text="Delete" OnClick="lnbDelete_Click" SkinID="DeleteButton" OnClientClick="return confirm('Delete marked row(s) ?')" />
            <br />
            <br />
            <asp:Label runat="server" ID="lblStatus" EnableViewState="False"></asp:Label>
            <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_GetAllCustomer" SelectCommandType="StoredProcedure" OnSelecting="sdsMaster_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="CustomerType" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:ObjectDataSource ID="odsFilterJobPosition" runat="server" SelectMethod="GetActiveJobPositions" TypeName="VIPDC.Providers.JobPositionProvider" OnObjectCreating="odsFilterJobPosition_ObjectCreating"></asp:ObjectDataSource>

            <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="False" AllowPaging="True" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" ShowGroupPanel="True" AutoGenerateColumns="False" OnItemCommand="RadGrid1_ItemCommand" GroupingSettings-CaseSensitive="false">
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
                        <telerik:GridBoundColumn DataField="Code" FilterControlAltText="Filter Code column" HeaderText="Code" SortExpression="Code" UniqueName="Code">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CustomerTypeName" FilterControlAltText="Filter CustomerTypeName column" HeaderText="Customer Type" ReadOnly="True" SortExpression="CustomerTypeName" UniqueName="CustomerTypeName">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                            <FilterTemplate>
                                <telerik:RadComboBox runat="server" ID="rcbFilterCustomerTypeName" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("CustomerTypeName").CurrentFilterValue %>' AppendDataBoundItems="true" OnClientSelectedIndexChanged="CustomerTypeNameSelectedIndexChanged">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="All" Value="" />
                                        <telerik:RadComboBoxItem Text="Individual" Value="Individual" />
                                        <telerik:RadComboBoxItem Text="Corporate" Value="Corporate" />
                                    </Items>
                                </telerik:RadComboBox>
                                <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                    <script type="text/javascript">
                                        function CustomerTypeNameSelectedIndexChanged(sender, args) {
                                            var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                            var filterVal = args.get_item().get_value();
                                            if (filterVal == "") {
                                                tableView.filter("CustomerTypeName", filterVal, "NoFilter");
                                            }
                                            else {
                                                tableView.filter("CustomerTypeName", filterVal, "EqualTo");
                                            }
                                        }
                                    </script>
                                </telerik:RadScriptBlock>
                            </FilterTemplate>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Gender" FilterControlAltText="Filter Gender column" HeaderText="Gender" SortExpression="Gender" UniqueName="Gender">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                            <FilterTemplate>
                                <telerik:RadComboBox runat="server" ID="rcbFilterGender" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("Gender").CurrentFilterValue %>' AppendDataBoundItems="true" OnClientSelectedIndexChanged="GenderSelectedIndexChanged">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="All" Value="" />
                                        <telerik:RadComboBoxItem Text="Male" Value="M" />
                                        <telerik:RadComboBoxItem Text="Female" Value="F" />
                                    </Items>
                                </telerik:RadComboBox>
                                <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
                                    <script type="text/javascript">
                                        function GenderSelectedIndexChanged(sender, args) {
                                            var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                            var filterVal = args.get_item().get_value();
                                            if (filterVal == "") {
                                                tableView.filter("Gender", filterVal, "NoFilter");
                                            }
                                            else {
                                                tableView.filter("Gender", filterVal, "EqualTo");
                                            }
                                        }
                                    </script>
                                </telerik:RadScriptBlock>
                            </FilterTemplate>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="JobPositionName" FilterControlAltText="Filter JobPositionName column" HeaderText="Job Position" SortExpression="JobPositionName" UniqueName="JobPositionName">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                            <FilterTemplate>
                                <telerik:RadComboBox ID="RadComboBoxCity" DataSourceID="odsFilterJobPosition" DataTextField="Name"
                                    DataValueField="Name" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("JobPositionName").CurrentFilterValue %>'
                                    runat="server" OnClientSelectedIndexChanged="JobPositionFilterIndexChanged">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="All" />
                                    </Items>
                                </telerik:RadComboBox>

                                <telerik:RadScriptBlock ID="RadScriptBlock3" runat="server">
                                    <script type="text/javascript">
                                        function JobPositionFilterIndexChanged(sender, args) {
                                            var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                            tableView.filter("JobPositionName", args.get_item().get_value(), "EqualTo");
                                        }
                                    </script>
                                </telerik:RadScriptBlock>
                            </FilterTemplate>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CellPhone" FilterControlAltText="Filter CellPhone column" HeaderText="Cell Phone" SortExpression="CellPhone" UniqueName="CellPhone">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEdit" runat="server" SkinID="EditButton" CommandName="EditRow" CommandArgument='<%# Eval("ID") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkDelete" runat="server" ToolTip="Mark this row to delete" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </asp:View>
        <asp:View runat="server" ID="viwAddEdit">            
            <asp:ValidationSummary runat="server" ID="vsmSummary" EnableViewState="false" CssClass="errorMessage" ValidationGroup="AddEdit" />
            <asp:Label runat="server" ID="lblStatusAddEdit" EnableViewState="False"></asp:Label>
            <table class="noborder fullwidth">
                <tr>
                    <td class="auto-style6">Code / EIN</td>
                    <td style="width: 5px;">:</td>
                    <td colspan="4">
                        <asp:Label ID="lblCustomerCode" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Name</td>
                    <td class="auto-style2">:</td>
                    <td colspan="4">
                        <telerik:RadTextBox ID="txtName" runat="server" ValidationGroup="AddEdit" Width="300px" />
                        <asp:RequiredFieldValidator ID="rqvName" runat="server" ControlToValidate="txtName" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Name&lt;/b&gt; must be specified" SetFocusOnError="True" Text="*" ValidationGroup="AddEdit" />
                    </td>
                </tr>
                <tr id="rowCustomerType">
                    <td class="auto-style6">Customer Type</td>
                    <td class="auto-style2">:</td>
                    <td colspan="4">
                        <asp:RadioButtonList ID="rblCustomerType" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True" Value="I">Individual</asp:ListItem>
                            <asp:ListItem Value="C">Corporate</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                 <tr id="rowContactPerson">
                     <td class="auto-style6">&nbsp;</td>
                     <td class="auto-style2">&nbsp;</td>
                     <td colspan="4">
                         <fieldset id="contactPerson" style="width:400px;">
                             <table style="width:100%;">
                                 <tr>
                                     <td>Contact Person Name: </td>
                                     <td><telerik:RadTextBox runat="server" ID="txtContactPersonName"></telerik:RadTextBox></td>
                                 </tr>
                             </table>
                         </fieldset>
                     </td>
                </tr>
                 <tr id="rowDateOfBirth">
                    <td class="auto-style6">Date of Birth</td>
                    <td class="auto-style2">:</td>
                    <td colspan="4"><div style="display:inline; width:120px;">
                        <telerik:RadDatePicker runat="server" ID="dtpBirthDate" Width="110px" />
                        </div>
                    </td>
                </tr>
                <tr id="rowGender">
                    <td class="auto-style6">Gender</td>
                    <td class="auto-style5">:</td>
                    <td colspan="4">
                        <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
                            <asp:ListItem Value="F">Female</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr id="rowJobPosition">
                    <td class="auto-style6">Job Position</td>
                    <td>:</td>
                    <td colspan="4">
                        <telerik:RadDropDownList ID="ddlJobPosition" runat="server" DefaultMessage="Select">
                        </telerik:RadDropDownList>                        
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Email</td>
                    <td>:</td>
                    <td colspan="4">
                        <telerik:RadTextBox ID="txtEmail" runat="server" ValidationGroup="AddEdit" Width="200px" />
                        <asp:RegularExpressionValidator runat="server" ID="revEmail" EnableViewState="false" ControlToValidate="txtEmail" CssClass="errorMessage" Display="Dynamic" ErrorMessage="&lt;b&gt;Email&lt;/b&gt; address invalid" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="AddEdit">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Address</td>
                    <td class="auto-style4">:</td>
                    <td colspan="4">
                        <telerik:RadTextBox ID="txtAddress" runat="server" ValidationGroup="AddEdit" Width="500px" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Zip Code</td>
                    <td>:</td>
                    <td colspan="4">
                        <telerik:RadTextBox ID="txtZipCode" runat="server" ValidationGroup="AddEdit" Width="80px" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Source of Information</td>
                    <td>:</td>
                    <td colspan="4">
                        <telerik:RadDropDownList ID="ddlInformationSource" runat="server" DefaultMessage="Select" AppendDataBoundItems="true" >
                        </telerik:RadDropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Work Phone 1</td>
                    <td>:</td>
                    <td class="auto-style8">
                        <telerik:RadTextBox ID="txtWorkPhone1" runat="server" ValidationGroup="AddEdit" />
                    </td>
                    <td class="auto-style11">Work Phone 2</td>
                    <td class="auto-style9">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtWorkPhone2" runat="server" ValidationGroup="AddEdit" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Cell Phone 1</td>
                    <td>:</td>
                    <td>
                        <telerik:RadTextBox ID="txtCellPhone1" runat="server" ValidationGroup="AddEdit" />
                    </td>
                    <td class="auto-style11">Cell Phone 2</td>
                    <td class="auto-style9">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtCellPhone2" runat="server" ValidationGroup="AddEdit" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Website</td>
                    <td class="auto-style4">:</td>
                    <td colspan="4">
                        <telerik:RadTextBox ID="txtWebsite" runat="server" ValidationGroup="AddEdit" Width="250px" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Social Media Network 1</td>
                    <td>:</td>
                    <td>
                        <telerik:RadTextBox ID="txtSocialMediaNetwork1" runat="server" ValidationGroup="AddEdit" />
                        <asp:RegularExpressionValidator ID="revEmail0" runat="server" ControlToValidate="txtSocialMediaNetwork1" CssClass="errorMessage" Display="Dynamic" EnableViewState="false" ErrorMessage="&lt;b&gt;URL &lt;/b&gt; is invalid" SetFocusOnError="True" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?" ValidationGroup="AddEdit">*</asp:RegularExpressionValidator>
                    </td>
                    <td class="auto-style11">Social Media Network 2</td>
                    <td class="auto-style9">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtSocialMediaNetwork2" runat="server" ValidationGroup="AddEdit" />
                        <asp:RegularExpressionValidator ID="revEmail1" runat="server" ControlToValidate="txtSocialMediaNetwork2" CssClass="errorMessage" Display="Dynamic" EnableViewState="false" ErrorMessage="&lt;b&gt;URL &lt;/b&gt; is invalid" SetFocusOnError="True" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?" ValidationGroup="AddEdit">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6"></td>
                    <td></td>
                    <td colspan="4">
                        <telerik:RadButton runat="server" ID="btnSave" EnableViewState="False" Text="Save" ValidationGroup="AddEdit" OnClick="btnSave_Click">
                        </telerik:RadButton>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <telerik:RadButton runat="server" ID="btnCancel" EnableViewState="False" Text="Cancel" CausesValidation="False" OnClick="btnCancel_Click">
                        </telerik:RadButton>
                    </td>
                </tr>
            </table>
            
           
        </asp:View>
    </asp:MultiView>
    
     <script>
         $(function () {
             var customerType = $("#cphMainContent_rblCustomerType_0").is(":checked") ? "I" : "C";

             if (customerType == "C") {
                 $("#rowDateOfBirth").hide();
                 $("#rowGender").hide();
                 $("#rowJobPosition").hide();
                 $("#rowContactPerson").show();
             }
             else {
                 $("#rowDateOfBirth").show();
                 $("#rowGender").show();
                 $("#rowJobPosition").show();
                 $("#rowContactPerson").hide();
             }

             $("#cphMainContent_rblCustomerType_0").change(function () {                 
                 $("#rowDateOfBirth").show();
                 $("#rowGender").show();
                 $("#rowJobPosition").show();
                 $("#rowContactPerson").hide();
             });

             $("#cphMainContent_rblCustomerType_1").change(function () {
                 $("#rowDateOfBirth").hide();
                 $("#rowGender").hide();
                 $("#rowJobPosition").hide();
                 $("#rowContactPerson").show();
             });
         });

            </script>
</asp:Content>
