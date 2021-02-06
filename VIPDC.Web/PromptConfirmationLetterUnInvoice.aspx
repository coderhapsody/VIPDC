<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPrompt.Master" AutoEventWireup="true" CodeBehind="PromptConfirmationLetterUnInvoice.aspx.cs" Inherits="VIPDC.Web.PromptConfirmationLetterUnInvoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 215px;
        }
        .auto-style2 {
            width: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Oustanding Confirmation Letter
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <fieldset>
        <table class="fullwidth noborder">
            <tr>
                <td class="auto-style1">
                    Confirmation Letter Year
                </td>
                <td class="auto-style2">:</td>
                <td><telerik:RadDropDownList runat="server" id="ddlYear"></telerik:RadDropDownList>  </td>
            </tr>            
            <tr>
                <td class="auto-style1"></td>
                <td class="auto-style2"></td>
                <td><telerik:RadButton runat="server" ID="btnSearch" Text="Search" OnClick="btnSearch_Click"></telerik:RadButton> </td>
            </tr>
        </table>
    </fieldset>
    <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" ShowGroupPanel="True" AutoGenerateColumns="False" GroupingSettings-CaseSensitive="false" OnItemDataBound="RadGrid1_ItemDataBound">
        <GroupingSettings CaseSensitive="False" />
        <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True" EnableRowHoverStyle="true">
        </ClientSettings>
        <MasterTableView DataKeyNames="ID" DataSourceID="sdsMaster">
            <Columns>
                <telerik:GridBoundColumn DataField="LetterNo" FilterControlAltText="Filter LetterNo column" HeaderText="Letter No" SortExpression="LetterNo" UniqueName="LetterNo">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="AccountManager" FilterControlAltText="Filter AccountManager column" HeaderText="Account Manager" SortExpression="AccountManager" UniqueName="AccountManager">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <%--                <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>--%>
<%--                <telerik:GridBoundColumn DataField="TrainingDate" DataType="System.DateTime" FilterControlAltText="Filter TrainingDate column" HeaderText="Training Date" SortExpression="TrainingDate" UniqueName="TrainingDate">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>--%>
                <%--                <telerik:GridBoundColumn DataField="TrainingLocation" FilterControlAltText="Filter TrainingLocation column" HeaderText="TrainingLocation" SortExpression="TrainingLocation" UniqueName="TrainingLocation">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>--%>
                <telerik:GridBoundColumn DataField="ClassTypeName" FilterControlAltText="Filter ClassTypeName column" HeaderText="Class Type" SortExpression="ClassTypeName" UniqueName="ClassTypeName">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TopicName" FilterControlAltText="Filter TopicName column" HeaderText="Topic" SortExpression="TopicName" UniqueName="TopicName">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TotalPrice" DataType="System.Decimal" FilterControlAltText="Filter TotalPrice column" HeaderText="Total Price" SortExpression="TotalPrice" UniqueName="TotalPrice" DataFormatString="{0:###,##0.00}">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>
                <%--                <telerik:GridBoundColumn DataField="PaymentDueDate" DataType="System.DateTime" FilterControlAltText="Filter PaymentDueDate column" HeaderText="PaymentDueDate" SortExpression="PaymentDueDate" UniqueName="PaymentDueDate">
                    <ColumnValidationSettings>
                        <ModelErrorMessage Text="" />
                    </ColumnValidationSettings>
                </telerik:GridBoundColumn>--%>
                <%--                <telerik:GridCheckBoxColumn DataField="CLReceived" DataType="System.Boolean" FilterControlAltText="Filter CLReceived column" HeaderText="CLReceived" ReadOnly="True" SortExpression="CLReceived" UniqueName="CLReceived">
                </telerik:GridCheckBoxColumn>--%>
                <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                    <ItemTemplate>
                        <asp:HyperLink ID="hypSelect" runat="server" Text="Select" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_PromptConfirmationLetterForInvoicing" SelectCommandType="StoredProcedure" OnSelecting="sdsMaster_Selecting">
        <SelectParameters>            
            <asp:Parameter Name="LetterYear" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
