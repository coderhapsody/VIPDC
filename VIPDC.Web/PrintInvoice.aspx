<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="PrintInvoice.aspx.cs" Inherits="VIPDC.Web.PrintInvoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Print Invoice
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    
    <vipdc:InvoiceDetail ID="InvoiceDetail1" runat="server" />
    
    <br/>
    <button id="btnPrint" class="button">Print</button>
</asp:Content>
