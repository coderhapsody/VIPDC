<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="ManageConfiguration.aspx.cs" Inherits="VIPDC.Web.ManageConfiguration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }

        .auto-style2 {
            width: 180px;
        }

        .auto-style3 {
            width: 3px;
        }
        .auto-style4 {
            width: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Configuration
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <div>
        Company Information
        <fieldset>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">Address 1</td>
                    <td class="auto-style3">:</td>
                    <td>
                        <telerik:RadTextBox runat="server" ID="txtAddress1" Width="300px"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Address 2</td>
                    <td class="auto-style3">:</td>
                    <td>
                        <telerik:RadTextBox runat="server" ID="txtAddress2" Width="300px"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Fax</td>
                    <td class="auto-style3">:</td>
                    <td>
                        <telerik:RadTextBox runat="server" ID="txtFax" Width="150px"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Phone</td>
                    <td class="auto-style3">:</td>
                    <td>
                        <telerik:RadTextBox runat="server" ID="txtPhone" Width="150px"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Website</td>
                    <td class="auto-style3">:</td>
                    <td>
                        <telerik:RadTextBox runat="server" ID="txtWebsite" Width="300px"></telerik:RadTextBox>
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>

    <br />
    <div>
        Tax Parameters
        <fieldset>
            <table class="fullwidth">
                <tr>
                    <td class="auto-style2">PPN Rate</td>
                    <td class="auto-style4">:</td>
                    <td><telerik:RadNumericTextBox runat="server" ID="ntbPPN" Width="50px" EnabledStyle-HorizontalAlign="Right"></telerik:RadNumericTextBox>% </td>
                </tr>
                <tr>
                    <td class="auto-style2">PPH Rate</td>
                    <td class="auto-style4">:</td>
                    <td><telerik:RadNumericTextBox runat="server" ID="ntbPPH" Width="50px" EnabledStyle-HorizontalAlign="Right"></telerik:RadNumericTextBox>% </td>
                </tr>
            </table>
        </fieldset>
    </div>
    <br />
    <div>
        Alerts
        <fieldset>
            <table class="fullwidth">
                <tr>
                    <td class="auto-style2">Show alert for invoices before</td>
                    <td class="auto-style4">:</td>
                    <td><telerik:RadNumericTextBox runat="server" ID="ntbAlertInvoice" Width="50px" NumberFormat-DecimalDigits="0" EnabledStyle-HorizontalAlign="Right"></telerik:RadNumericTextBox> days </td>
                </tr>
            </table>
        </fieldset>
    </div>
    <br/>     
    <div>
        Invoicing
        <fieldset>
            <table class="fullwidth">
                <tr>
                    <td class="auto-style2">Sign by Name</td>
                    <td class="auto-style4">:</td>
                    <td><telerik:RadTextBox runat="server" ID="txtSignName" ></telerik:RadTextBox></td>
                </tr>
                <tr>
                    <td class="auto-style2">Occupation</td>
                    <td class="auto-style4">:</td>
                    <td><telerik:RadTextBox runat="server" ID="txtSignOccupation" ></telerik:RadTextBox></td>
                </tr>
            </table>
        </fieldset>
    </div>
    <br/>
    <asp:Label ID="lblStatus" runat="server" EnableViewState="False" />
    <br/>
    <telerik:RadButton runat="server" ID="btnSave" Text="Save" OnClick="btnSave_Click"></telerik:RadButton>
</asp:Content>
