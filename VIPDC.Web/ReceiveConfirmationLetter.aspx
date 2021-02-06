<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="ReceiveConfirmationLetter.aspx.cs" Inherits="VIPDC.Web.ReceiveConfirmationLetter" %>

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
    Receive Confirmation Letter
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <table class="fullwidth noborder">
        <tr>
            <td class="auto-style3">Confirmation Letter No.</td>
            <td class="auto-style4">:</td>
            <td>
                <telerik:RadTextBox runat="server" ID="txtConfirmationLetterNo" ValidationGroup="Search"></telerik:RadTextBox>
                &nbsp;<telerik:RadButton runat="server" ID="btnRefresh" Text="Refresh" OnClick="btnRefresh_Click" ValidationGroup="Search" />
                &nbsp;<asp:RequiredFieldValidator runat="server" ID="rqvConfirmationLetter" ControlToValidate="txtConfirmationLetterNo" ErrorMessage="<b>Confirmation Letter Number</b> must be specified" SetFocusOnError="true" Display="Dynamic" ValidationGroup="Search" CssClass="errorMessage"></asp:RequiredFieldValidator>
                &nbsp;</td>

        </tr>
        <tr>
            <td class="auto-style3">&nbsp;</td>
            <td class="auto-style4">&nbsp;</td>
            <td>
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
                <td class="auto-style3">Receive Date</td>
                <td class="auto-style4">:</td>
                <td>
                    <telerik:RadDatePicker runat="server" ID="dtpReceiveDate"></telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="rqvConfirmationLetter0" runat="server" ControlToValidate="dtpReceiveDate" CssClass="errorMessage" Display="Dynamic" ErrorMessage="&lt;b&gt;Receive Date&lt;/b&gt; must be specified" SetFocusOnError="true" ValidationGroup="Search"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style3"></td>
                <td></td>
                <td>
                    <telerik:RadButton runat="server" ID="btnSave" Text="Save" OnClick="btnSave_Click" />
                    &nbsp;&nbsp;&nbsp;
                <telerik:RadButton runat="server" ID="btnCancel" Text="Cancel" OnClick="btnCancel_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
