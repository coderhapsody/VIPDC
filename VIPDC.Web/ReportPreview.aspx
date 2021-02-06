<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportPreview.aspx.cs" Inherits="VIPDC.Web.ReportPreview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        a
        {
            text-decoration: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scmScriptManager" runat="server" />
    <div>
        <rsweb:ReportViewer ID="rptReport" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%">
            <localreport reportpath="Reports\Invoice.rdlc">
            </localreport>
        </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
