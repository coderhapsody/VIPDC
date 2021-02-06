<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPrompt.Master" AutoEventWireup="true" CodeBehind="PromptCustomer.aspx.cs" Inherits="VIPDC.Web.PromptCustomer" StylesheetTheme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 200px;
        }
        .auto-style2 {
            width: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Customer
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_PromptCustomer" SelectCommandType="StoredProcedure" OnSelecting="sdsMaster_Selecting">
        <SelectParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="CustomerType" Type="String" />
            <asp:Parameter Name="Gender" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="odsFilterJobPosition" runat="server" SelectMethod="GetActiveJobPositions" TypeName="VIPDC.Providers.JobPositionProvider" OnObjectCreating="odsFilterJobPosition_ObjectCreating"></asp:ObjectDataSource>
    <fieldset>
                <table class="fullwidth noborder">
                    <tr>
                        <td class="auto-style1">Name</td>
                        <td class="auto-style2">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindName" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Customer Type</td>
                        <td class="auto-style2">:</td>
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
                        <td class="auto-style1">Gender</td>
                        <td class="auto-style2">:</td>
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
                        <td class="auto-style1"></td>
                        <td class="auto-style2"></td>
                        <td>
                            <telerik:RadButton runat="server" ID="btnSearch" Text="Search" OnClick="btnSearch_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </fieldset>
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" ShowGroupPanel="True" AutoGenerateColumns="False" GroupingSettings-CaseSensitive="false" OnItemDataBound="RadGrid1_ItemDataBound">
        <GroupingSettings CaseSensitive="False" />
        <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True" EnableRowHoverStyle="true">
        </ClientSettings>
        <MasterTableView DataKeyNames="ID" DataSourceID="sdsMaster">
            <Columns>
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
                <telerik:GridBoundColumn DataField="CustomerTypeName" FilterControlAltText="Filter CustomerTypeName column" HeaderText="CustomerTypeName" ReadOnly="True" SortExpression="CustomerTypeName" UniqueName="CustomerTypeName">
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
                <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CellPhone" FilterControlAltText="Filter CellPhone column" HeaderText="CellPhone" SortExpression="CellPhone" UniqueName="CellPhone">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                    <ItemTemplate>
                        <asp:HyperLink ID="hypSelect" runat="server" Text="Select" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
</asp:Content>
