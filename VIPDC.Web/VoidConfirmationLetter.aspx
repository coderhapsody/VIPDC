<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="VoidConfirmationLetter.aspx.cs" Inherits="VIPDC.Web.VoidConfirmationLetter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .auto-style4 {
            width: 4px;
        }

        .auto-style3 {
            width: 160px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Void Confirmation Letter
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <table class="fullwidth noborder">
        <tr>
            <td class="auto-style3">Confirmation Letter No.</td>
            <td class="auto-style4">:</td>
            <td>
                <telerik:RadTextBox runat="server" ID="txtConfirmationLetterNo" ValidationGroup="Search"></telerik:RadTextBox>
                <asp:HyperLink runat="server" ID="hypCLRef" ImageUrl="Images/zoom.png" style="cursor:pointer;" ToolTip="Look up Confirmation Letter"></asp:HyperLink>
                &nbsp;<telerik:RadButton runat="server" ID="btnRefresh" Text="Refresh" OnClick="btnRefresh_Click" ValidationGroup="Search" />
                <asp:RequiredFieldValidator runat="server" ID="rqvConfirmationLetter" ControlToValidate="txtConfirmationLetterNo" ErrorMessage="<b>Confirmation Letter Number</b> must be specified" SetFocusOnError="true" Display="Dynamic" ValidationGroup="Search" CssClass="errorMessage"></asp:RequiredFieldValidator>
                <asp:Label ID="lblStatus" runat="server" EnableViewState="false" />
            </td>

        </tr>
    </table>
    <asp:Panel ID="pnlReceiveDate" runat="server">
        <br />
        <vipdc:ConfirmationLetterDetail ID="ConfirmationLetterDetail1" runat="server" />
        <br />
        <table class="fullwidth noborder">
            <tr>
                <td class="auto-style3">Reason</td>
                <td class="auto-style4">:</td>
                <td>
                    <telerik:RadTextBox ID="txtReason" runat="server" ValidationGroup="Search" Columns="80" Rows="3" TextMode="MultiLine" Width="400px">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style3"></td>
                <td class="auto-style4"></td>
                <td>
                    <telerik:RadButton ID="btnVoid" runat="server" OnClick="btnVoid_Click" Text="Void" />
                    &nbsp;&nbsp;&nbsp;
                    <telerik:RadButton ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>