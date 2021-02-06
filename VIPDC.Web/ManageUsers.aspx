<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="VIPDC.Web.ManageUsers" StylesheetTheme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Users
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
<%--            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mvwForm" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>--%>
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" ShowGroupPanel="True" AutoGenerateColumns="False" OnItemCommand="RadGrid1_ItemCommand" GroupingSettings-CaseSensitive="false">
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
                <telerik:GridBoundColumn DataField="UserName" FilterControlAltText="Filter UserName column" HeaderText="User Name" SortExpression="UserName" UniqueName="UserName">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="RoleName" FilterControlAltText="Filter RoleName column" HeaderText="Role" SortExpression="RoleName" UniqueName="RoleName">
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
                <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" ID="lnbReset" Text="Reset Password" CommandName="ResetPassword" CommandArgument='<%# Eval("ID") %>' OnClientClick="return confirm('Are you sure want to reset password for selected user ?')" ></asp:LinkButton>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_GetAllowedLoginEmployees" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource runat="server" ID="odsFilterRoleName" OnObjectCreating="odsFilterRoleName_ObjectCreating" SelectMethod="GetAllRoles" TypeName="VIPDC.Providers.SecurityProvider" OnSelecting="odsFilterRoleName_Selecting"></asp:ObjectDataSource>
</asp:Content>
