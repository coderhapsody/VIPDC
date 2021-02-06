<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPrompt.Master" AutoEventWireup="true" CodeBehind="PromptAddCustomerParticipant.aspx.cs" Inherits="VIPDC.Web.PromptAddCustomerParticipant" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 150px;
        }
        .auto-style2 {
            width: 3px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Add Existing Customer as Participant
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_PromptCustomerParticipant" SelectCommandType="StoredProcedure" OnSelecting="sdsMaster_Selecting">
        <SelectParameters>
            <asp:Parameter Name="Customer" Type="String" />
            <asp:Parameter Name="CustomerType" Type="String" />
            <asp:Parameter Name="Gender" Type="String" />
            <asp:Parameter Name="LetterNo" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>    
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
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" ShowGroupPanel="True" AutoGenerateColumns="False" GroupingSettings-CaseSensitive="false">
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
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Gender" FilterControlAltText="Filter Gender column" HeaderText="Gender" SortExpression="Gender" UniqueName="Gender">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="JobPositionName" FilterControlAltText="Filter JobPositionName column" HeaderText="Job Position" SortExpression="JobPositionName" UniqueName="JobPositionName">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>                   
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
                        <asp:CheckBox ID="chkDelete" runat="server" ToolTip="Mark this row to delete" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <br/>
    <telerik:RadButton runat="server" ID="btnSelect" Text="Confirm Selected Customers" OnClick="btnSelect_Click"></telerik:RadButton>
</asp:Content>
