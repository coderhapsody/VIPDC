<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterPrompt.Master" AutoEventWireup="true" CodeBehind="PromptConfirmationLetter.aspx.cs" Inherits="VIPDC.Web.PromptConfirmationLetter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 150px;
        }
        .auto-style2 {
            width: 2px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <fieldset>
        <table class="fullwidth noborder">
            <tr>
                <td class="auto-style1">Letter No.</td>
                <td class="auto-style2">:</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtFindLetterNo" Width="150px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Account Manager</td>
                <td class="auto-style2">:</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtFindAccountManager" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Customer</td>
                <td class="auto-style2">:</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtFindCustomer" Width="200px"></telerik:RadTextBox>
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
    <br/>
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
<%--                <telerik:GridBoundColumn DataField="TrainingDate" DataType="System.DateTime" FilterControlAltText="Filter TrainingDate column" HeaderText="Training Date" SortExpression="TrainingDate" UniqueName="TrainingDate" DataFormatString="{0:dd/MM/yyyy}">
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
                <telerik:GridBoundColumn DataField="TotalPrice" DataType="System.Decimal" FilterControlAltText="Filter TotalPrice column" HeaderText="Total" SortExpression="TotalPrice" UniqueName="TotalPrice" DataFormatString="{0:###,##0.00}">
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
                <telerik:GridCheckBoxColumn DataField="Void" DataType="System.Boolean" FilterControlAltText="Filter Void column" HeaderText="Void" ReadOnly="True" SortExpression="Void" UniqueName="Void">
                </telerik:GridCheckBoxColumn>
                <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                    <ItemTemplate>
                        <asp:HyperLink ID="hypSelect" runat="server" Text="Select" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_PromptConfirmationLetter" SelectCommandType="StoredProcedure" OnSelecting="sdsMaster_Selecting">
        <SelectParameters>
            <asp:Parameter Name="LetterNo" Type="String" />
            <asp:Parameter Name="AccountManager" Type="String" />
            <asp:Parameter Name="Customer" Type="String" />
            <asp:Parameter Name="ExcludeVoid" Type="Boolean" />
            <asp:QueryStringParameter Name="ExcludeLetterNo" QueryStringField="CurrentCLNo" Type="String" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
