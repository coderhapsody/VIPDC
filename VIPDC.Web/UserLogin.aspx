<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterUnregisteredPage.Master" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="VIPDC.Web.UserLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" runat="server">
    <style>
        .centered {
            width: 300px;
    margin: 0 auto;

        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphTitle" runat="server">
    <img src="Images/vip_logo.jpg" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">    
    <hr />
    <div class="centered">
        <table class="noborder">
            <tr>
                <td>User Name</td>
                <td>:</td>
                <td>
                    <telerik:RadTextBox ID="txtUserName" runat="server">
                    </telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td>Password</td>
                <td>:</td>
                <td>
                    <telerik:RadTextBox ID="txtPassword" runat="server" TextMode="Password">
                    </telerik:RadTextBox>
                </td>

            </tr>
            <tr>
                <td></td>
                <td></td>
                <td><telerik:RadButton runat="server" ID="btnLogin" Text="Login" OnClick="btnLogin_Click" EnableViewState="false"></telerik:RadButton> </td>
            </tr>
        </table>
        <asp:Label runat="server" ID="lblStatus" EnableViewState="false"></asp:Label>
    </div>

</asp:Content>
