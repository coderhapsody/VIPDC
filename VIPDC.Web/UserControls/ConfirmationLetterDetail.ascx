<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ConfirmationLetterDetail.ascx.cs" Inherits="VIPDC.Web.UserControls.ConfirmationLetterDetail" %>
<style type="text/css">
    .auto-style1 {
        width: 500px;
    }
</style>

<asp:DetailsView ID="dtvConfirmationLetter" runat="server" AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="sdsDetailInfo" Height="50px" Width="600px" CellPadding="4" ForeColor="#333333" GridLines="None">
    <AlternatingRowStyle BackColor="White" />
    <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
    <EditRowStyle BackColor="#2461BF" />
    <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
    <Fields>        
        <asp:BoundField HeaderStyle-Width="200px" DataField="LetterNo" HeaderText="Letter No." SortExpression="LetterNo" />
        <asp:BoundField DataField="AccountManager" HeaderText="Account Manager" SortExpression="AccountManager" />
        <asp:BoundField DataField="LetterDate" HeaderText="Letter Date" SortExpression="LetterDate" DataFormatString="{0:dddd, dd MMMM yyyy}" />
        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
        <asp:BoundField DataField="TrainingStartDate" HeaderText="Training Start Date" SortExpression="TrainingStartDate" DataFormatString="{0:dddd, dd MMMM yyyy}" />
        <asp:BoundField DataField="TrainingEndDate" HeaderText="Training End Date" SortExpression="TrainingEndDate" DataFormatString="{0:dddd, dd MMMM yyyy}" />
        <asp:BoundField DataField="TrainingLocation" HeaderText="Training Location" SortExpression="TrainingLocation" />
        <asp:BoundField DataField="ClassTypeName" HeaderText="Class Type Name" SortExpression="ClassTypeName" />
        <asp:BoundField DataField="TopicName" HeaderText="Topic Name" SortExpression="TopicName" />
        <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" SortExpression="TotalPrice" DataFormatString="{0:###,##0.00}" />
        <asp:BoundField DataField="BankName" HeaderText="Transfer to" SortExpression="BankName" />
        <asp:BoundField DataField="PaymentDueDate" HeaderText="Payment Due Date" SortExpression="PaymentDueDate" DataFormatString="{0:dddd, dd MMMM yyyy}" />
        <asp:BoundField DataField="CreatedWhen" HeaderText="Created Date" SortExpression="CreatedWhen" DataFormatString="{0:dddd, dd MMMM yyyy HH:mm}" />
        <asp:BoundField DataField="LetterReceiveDate" HeaderText="Letter Receive Date" SortExpression="LetterReceiveDate" DataFormatString="{0:dddd, dd MMMM yyyy}" />
    </Fields>
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#EFF3FB" />
</asp:DetailsView>
<asp:SqlDataSource ID="sdsDetailInfo" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_GetConfirmationLetter" SelectCommandType="StoredProcedure" OnSelecting="sdsDetailInfo_Selecting">
    <SelectParameters>
        <asp:Parameter Name="LetterNo" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>


