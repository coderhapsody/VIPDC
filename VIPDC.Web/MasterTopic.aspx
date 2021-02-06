﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="MasterTopic.aspx.cs" Inherits="VIPDC.Web.MasterTopic" StylesheetTheme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphMainTitle" runat="server">
    Topic
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainContent" runat="server">
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
        <asp:View runat="server" ID="viwRead">
            <fieldset>
                <table class="fullwidth noborder">
                    <tr>
                        <td class="auto-style2">Code</td>
                        <td class="auto-style1">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindCode" Width="100px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Name</td>
                        <td class="auto-style1">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindName" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2"></td>
                        <td class="auto-style1"></td>
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
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" ShowGroupPanel="True" AutoGenerateColumns="False" OnItemCommand="RadGrid1_ItemCommand" GroupingSettings-CaseSensitive="false">
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

            <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_GetAllTopics" SelectCommandType="StoredProcedure" OnSelecting="sdsMaster_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="Code" Type="String" />
                    <asp:Parameter Name="Name" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:View>
        <asp:View runat="server" ID="viwAddEdit">
            <asp:ValidationSummary runat="server" ID="vsmSummary" EnableViewState="false" CssClass="errorMessage" ValidationGroup="AddEdit" />
            <asp:Label runat="server" ID="lblStatusAddEdit" EnableViewState="False"></asp:Label>
            <table class="noborder fullwidth">
                <tr>
                    <td style="width: 200px;">Code</td>
                    <td style="width: 5px;">:</td>
                    <td>
                        <telerik:RadTextBox runat="server" ID="txtCode" ValidationGroup="AddEdit" Width="80px" MaxLength="20" />
                        <asp:RequiredFieldValidator runat="server" ID="rqvCode" ControlToValidate="txtName" ErrorMessage="<b>Code</b> must be specified" Text="*" SetFocusOnError="True" EnableViewState="False" Display="Dynamic" CssClass="errorMessage" ValidationGroup="AddEdit" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 200px;">Name</td>
                    <td style="width: 5px;">:</td>
                    <td>
                        <telerik:RadTextBox runat="server" ID="txtName" ValidationGroup="AddEdit" MaxLength="100" />
                        <asp:RequiredFieldValidator runat="server" ID="rqvName" ControlToValidate="txtName" ErrorMessage="<b>Name</b> must be specified" Text="*" SetFocusOnError="True" EnableViewState="False" Display="Dynamic" CssClass="errorMessage" ValidationGroup="AddEdit" />
                    </td>
                </tr>
                <tr>
                    <td>Is Active</td>
                    <td>:</td>
                    <td>
                        <asp:CheckBox runat="server" ID="chkIsActive"></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td>
                        <telerik:RadButton runat="server" ID="btnSave" EnableViewState="False" Text="Save" ValidationGroup="AddEdit" OnClick="btnSave_Click"></telerik:RadButton>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <telerik:RadButton runat="server" ID="btnCancel" EnableViewState="False" Text="Cancel" CausesValidation="False" OnClick="btnCancel_Click"></telerik:RadButton>
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>
</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="cphHead">
    <style type="text/css">
        .auto-style1 {
            width: 5px;
        }

        .auto-style2 {
            width: 90px;
        }
    </style>
</asp:Content>

