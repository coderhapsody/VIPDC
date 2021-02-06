<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PaymentDueAlerts.ascx.cs" Inherits="VIPDC.Web.UserControls.PaymentDueAlerts" %>

<asp:Label ID="lblMessage" runat="server" EnableViewState="false" />
<telerik:RadGrid ID="grdAlerts" runat="server" CellSpacing="0" DataSourceID="sdsData" GridLines="None">
    <MasterTableView AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="sdsData">
        <Columns>
            <telerik:GridBoundColumn DataField="InvoiceNo" FilterControlAltText="Filter InvoiceNo column" HeaderText="Invoice No." SortExpression="InvoiceNo" UniqueName="InvoiceNo">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="InvoiceDate" DataType="System.DateTime" FilterControlAltText="Filter InvoiceDate column" HeaderText="Invoice Date" SortExpression="InvoiceDate" UniqueName="InvoiceDate" DataFormatString="{0:dd-MMM-yyyy}">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="LetterNo" FilterControlAltText="Filter LetterNo column" HeaderText="CL No." SortExpression="LetterNo" UniqueName="LetterNo">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="CLDate" DataType="System.DateTime" FilterControlAltText="Filter CLDate column" HeaderText="CL Date" SortExpression="CLDate" UniqueName="CLDate" DataFormatString="{0:dd-MMM-yyyy}">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="Code" FilterControlAltText="Filter Code column" HeaderText="Cust. Code" SortExpression="Code" UniqueName="Code">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Cust. Name" SortExpression="Name" UniqueName="Name">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="TotalPrice" DataType="System.Decimal" FilterControlAltText="Filter TotalPrice column" HeaderText="Total Price" SortExpression="TotalPrice" UniqueName="TotalPrice" DataFormatString="{0:###,##0}" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="PaymentDueDate" DataType="System.DateTime" FilterControlAltText="Filter PaymentDueDate column" HeaderText="Payment Due Date" SortExpression="PaymentDueDate" UniqueName="PaymentDueDate" DataFormatString="{0:dd-MMM-yyyy}">
                <ColumnValidationSettings>
                    <ModelErrorMessage Text="" />
                </ColumnValidationSettings>
            </telerik:GridBoundColumn>
        </Columns>
    </MasterTableView>
</telerik:RadGrid>
<asp:SqlDataSource ID="sdsData" runat="server"
    ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>"
    OnSelecting="sdsAlert_Selecting" SelectCommand="proc_GetPaymentDueDateAlerts"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="DaysBefore" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>