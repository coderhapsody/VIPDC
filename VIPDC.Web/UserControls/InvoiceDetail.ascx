<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InvoiceDetail.ascx.cs" Inherits="VIPDC.Web.UserControls.InvoiceDetail" %>
<asp:DetailsView runat="server" ID="dtvInvoice" AutoGenerateRows="False" CellPadding="4" DataSourceID="sdsInvoice" ForeColor="#333333" GridLines="None" Width="500px">
    <AlternatingRowStyle BackColor="White" />
    <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
    <EditRowStyle BackColor="#2461BF" />
    <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
    <Fields>
        <asp:BoundField HeaderStyle-Width="200px" DataField="InvoiceNo" HeaderText="Invoice No." SortExpression="InvoiceNo" />
        <asp:BoundField DataField="LetterNo" HeaderText="Letter No." SortExpression="LetterNo" />
        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" DataFormatString="{0:###,##0.00}" />
        <asp:BoundField DataField="Tax" HeaderText="Tax" SortExpression="Tax" DataFormatString="{0:###,##0.00}" />
        <asp:BoundField DataField="PPH" HeaderText="PPH" SortExpression="PPH" DataFormatString="{0:###,##0.00}" />
        <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" SortExpression="TotalPrice" DataFormatString="{0:###,##0.00}" />
        <%--<asp:BoundField DataField="TrainingDate" HeaderText="Training Date" SortExpression="TrainingDate" DataFormatString="{0:dddd, dd MMMM yyyy}" />--%>
        <asp:BoundField DataField="PaymentDueDate" HeaderText="Payment Due Date" SortExpression="PaymentDueDate" DataFormatString="{0:dddd, dd MMMM yyyy}" />
        <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
        <asp:BoundField DataField="CustomerCode" HeaderText="Customer Code" SortExpression="CustomerCode" />
        <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" SortExpression="CustomerName" />
    </Fields>
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#EFF3FB" />
</asp:DetailsView>
<asp:SqlDataSource ID="sdsInvoice" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" OnSelecting="sdsInvoice_Selecting" SelectCommand="proc_GetInvoice" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="InvoiceNo" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
