<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="MasterEmployee.aspx.cs" Inherits="VIPDC.Web.MasterEmployee" StylesheetTheme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 100px;
        }

        .auto-style2 {
            width: 4px;
        }
        .auto-style3 {
            width: 39px;
        }
        .auto-style4 {
            width: 140px;
        }
        .auto-style5 {
            width: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Employee
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mvwForm" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <asp:MultiView runat="server" ID="mvwForm">
        <asp:View ID="viwRead" runat="server">
            <fieldset>
                <table class="fullwidth noborder">
                    <tr>
                        <td class="auto-style1">Code</td>
                        <td class="auto-style2">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindCode" Width="100px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Name</td>
                        <td class="auto-style2">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindName" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Role</td>
                        <td class="auto-style2">:</td>
                        <td>
                            <telerik:RadDropDownList runat="server" ID="ddlFindRole" Width="200px"></telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1"></td>
                        <td class="auto-style2"></td>
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
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" ShowGroupPanel="True" AutoGenerateColumns="False" OnItemCommand="RadGrid1_ItemCommand" GroupingSettings-CaseSensitive="false" OnItemDataBound="RadGrid1_ItemDataBound">
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
                        <telerik:GridBoundColumn DataField="UserName" FilterControlAltText="Filter Code column" HeaderText="Code" SortExpression="UserName" UniqueName="UserName">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>     
                         <telerik:GridBoundColumn DataField="Initial" FilterControlAltText="Filter Initial column" HeaderText="Initial" SortExpression="Initial" UniqueName="Initial">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
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
                        <telerik:GridBoundColumn DataField="RoleName" FilterControlAltText="Filter RoleName column" HeaderText="Role Name" SortExpression="RoleName" UniqueName="RoleName">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                            <FilterTemplate>
                                <telerik:RadComboBox ID="RadComboBoxRoleName" DataSourceID="odsFilterRoleName" DataTextField="Name"
                                    DataValueField="Name" AppendDataBoundItems="true" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("RoleName").CurrentFilterValue %>'
                                    runat="server" OnClientSelectedIndexChanged="RoleNameFilterIndexChanged">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="All" />
                                    </Items>
                                </telerik:RadComboBox>

                                <telerik:RadScriptBlock ID="RadScriptBlock3" runat="server">
                                    <script type="text/javascript">
                                        function RoleNameFilterIndexChanged(sender, args) {
                                            var tableView = $find("<%# ((GridItem)Container).OwnerTableView.ClientID %>");
                                            tableView.filter("RoleName", args.get_item().get_value(), "EqualTo");
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
                        <telerik:GridBoundColumn DataField="CellPhone1" FilterControlAltText="Filter CellPhone1 column" HeaderText="Cell Phone" SortExpression="CellPhone1" UniqueName="CellPhone1">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridCheckBoxColumn DataField="IsAllowLogin" DataType="System.Boolean" FilterControlAltText="Filter IsAllowLogin column" HeaderText="Is Allow Login" SortExpression="IsAllowLogin" UniqueName="IsAllowLogin">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="IsActive" DataType="System.Boolean" FilterControlAltText="Filter IsActive column" HeaderText="Is Active" SortExpression="IsActive" UniqueName="IsActive">
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
            <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_GetAllEmployee" SelectCommandType="StoredProcedure" OnSelecting="sdsMaster_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="UserName" Type="String" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="RoleID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:ObjectDataSource runat="server" ID="odsFilterRoleName" OnObjectCreating="odsFilterRoleName_ObjectCreating" SelectMethod="GetAllRoles" TypeName="VIPDC.Providers.SecurityProvider" OnSelecting="odsFilterRoleName_Selecting"></asp:ObjectDataSource>
        </asp:View>
        <asp:View ID="viwAddEdit" runat="server">
            <asp:ValidationSummary runat="server" ID="vsmSummary" EnableViewState="false" CssClass="errorMessage" ValidationGroup="AddEdit" />
            <asp:Label runat="server" ID="lblStatusAddEdit" EnableViewState="False"></asp:Label>
            <table class="fullwidth">
                <tr>
                    <td class="auto-style4">Code</td>
                    <td class="auto-style5">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtCode" runat="server" ValidationGroup="AddEdit" Width="100px" />&nbsp;<asp:RequiredFieldValidator ID="rqvCode" runat="server" ControlToValidate="txtCode" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Code&lt;/b&gt; must be specified" SetFocusOnError="True" Text="*" ValidationGroup="AddEdit" />
                    </td>

                </tr>
                <tr>
                    <td class="auto-style4">&nbsp;</td>
                    <td class="auto-style5">&nbsp;</td>
                    <td><i>* This code will be a user name to log in to application</i></td>
                </tr>
                <tr>
                    <td class="auto-style4">Name</td>
                    <td class="auto-style5">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtName" runat="server" ValidationGroup="AddEdit" Width="300px" />
                        <asp:RequiredFieldValidator ID="rqvName" runat="server" ControlToValidate="txtName" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Name&lt;/b&gt; must be specified" SetFocusOnError="True" Text="*" ValidationGroup="AddEdit" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">Initial</td>
                    <td class="auto-style5">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtInitial" runat="server" ValidationGroup="AddEdit" Width="50px"  MaxLength="5"/>
                        <asp:RequiredFieldValidator ID="rqvInitial" runat="server" ControlToValidate="txtInitial" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Initial&lt;/b&gt; must be specified" SetFocusOnError="True" Text="*" ValidationGroup="AddEdit" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">Gender</td>
                    <td class="auto-style5">:</td>
                    <td>
                        <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
                            <asp:ListItem Value="F">Female</asp:ListItem>
                        </asp:RadioButtonList></td>
                </tr>
                <tr>
                    <td class="auto-style4">Cell Phone 1</td>
                    <td class="auto-style5">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtCellPhone1" runat="server" ValidationGroup="AddEdit" Width="150px" /></td>
                </tr>
                <tr>
                    <td class="auto-style4">Cell Phone 2</td>
                    <td class="auto-style5">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtCellPhone2" runat="server" ValidationGroup="AddEdit" Width="150px" /></td>
                </tr>
                <tr>
                    <td class="auto-style4">Email</td>
                    <td class="auto-style5">:</td>
                    <td>
                        <telerik:RadTextBox ID="txtEmail" runat="server" ValidationGroup="AddEdit" Width="250px" />
                        <asp:RegularExpressionValidator runat="server" ID="revEmail" EnableViewState="false" ControlToValidate="txtEmail" CssClass="errorMessage" Display="Dynamic" ErrorMessage="&lt;b&gt;Email&lt;/b&gt; address invalid" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="AddEdit">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">Role</td>
                    <td class="auto-style5">:</td>
                    <td>
                        <telerik:RadDropDownList ID="ddlRole" runat="server" DefaultMessage="Select role">
                        </telerik:RadDropDownList>
                        <asp:RequiredFieldValidator ID="rqvRole" runat="server" ControlToValidate="ddlRole" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Role&lt;/b&gt; must be specified" SetFocusOnError="True" Text="*" ValidationGroup="AddEdit" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">Accessibility</td>
                    <td class="auto-style5">:</td>
                    <td>
                        <asp:CheckBox runat="server" ID="chkIsAllowLogin" Text="Is Allow Login" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:CheckBox runat="server" ID="chkIsActive" Text="Is Active" />
                        &nbsp;&nbsp;
                        <asp:CheckBox ID="chkIsAllowBackdate" runat="server" Text="Is Allow Backdate" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">Background Color</td>
                    <td class="auto-style5">:</td>
                    <td>
                        <telerik:RadColorPicker ID="RadColorPicker1" Runat="server" ShowIcon="True">
                        </telerik:RadColorPicker>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4"></td>
                    <td class="auto-style5"></td>
                    <td>
                        <telerik:RadButton ID="btnSave" runat="server" EnableViewState="False" OnClick="btnSave_Click" Text="Save" ValidationGroup="AddEdit">
                        </telerik:RadButton>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <telerik:RadButton ID="btnCancel" runat="server" CausesValidation="False" EnableViewState="False" OnClick="btnCancel_Click" Text="Cancel">
                                        </telerik:RadButton>
                    </td>
                </tr>                
            </table>
        </asp:View>
    </asp:MultiView>
</asp:Content>
