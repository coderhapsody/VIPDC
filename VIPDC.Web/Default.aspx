<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VIPDC.Web.Default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    <style>
        .RadScheduler .rsAptSubject {
            text-align: left;
            padding: 4px 0 1px;
            margin: 0 0 3px;                                    
            border-bottom: 1px solid #99DEFD;
            width: 100%;
        }

        .RadScheduler .rsAdvancedEdit .RadColorPicker label {
            text-align: left;
            display: block;
            padding: 0;
        }

        .rsHeaderDay { display: none !important; }
        /*.rsHeaderWeek { display: none !important; }*/
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadScheduler1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadScheduler1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <asp:HyperLink runat="server" ID="hypAlerts" Text="Go to Alerts" NavigateUrl="ManageAlerts.aspx"></asp:HyperLink>
    <telerik:RadScheduler ID="RadScheduler1" runat="server" DataEndField="EndDate" DataKeyField="ID"  
        DataStartField="StartDate" DataSubjectField="Subject" SelectedView="MonthView"  ReadOnly="True"
        DataDescriptionField="Description" FirstDayOfWeek="Monday" LastDayOfWeek="Sunday" StartInsertingInAdvancedForm="True"
        AdvancedForm-EnableCustomAttributeEditing="true" 
        OnAppointmentCreated="RadScheduler1_AppointmentCreated" 
        OnAppointmentDataBound="RadScheduler1_AppointmentDataBound" 
        OnAppointmentInsert="RadScheduler1_AppointmentInsert" 
        OnAppointmentUpdate="RadScheduler1_AppointmentUpdate" 
        Skin="Outlook" OnAppointmentDelete="RadScheduler1_AppointmentDelete" EnableCustomAttributeEditing="True" OnAppointmentCommand="RadScheduler1_AppointmentCommand" SelectedDate="2014-02-15" >
        <ExportSettings>
            <Pdf PageTopMargin="1in" PageBottomMargin="1in" PageLeftMargin="1in" PageRightMargin="1in"></Pdf>
        </ExportSettings>
        <Reminders Enabled="true"></Reminders>
        <AdvancedForm Modal="true" EnableCustomAttributeEditing="True"> </AdvancedForm>
        <MonthView UserSelectable="true" ></MonthView>
        <AppointmentContextMenuSettings EnableDefault="False" />
        <TimeSlotContextMenuSettings EnableDefault="True" />        
        <AppointmentTemplate>
            <div class="rsAptSubject">
                <%# Eval("Subject") %>
            </div>
            <br />
            <%# Eval("Description") %>
        </AppointmentTemplate>
    </telerik:RadScheduler>
    <asp:SqlDataSource ID="sqldsAlerts" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_GetAlerts" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Active" Type="Boolean" DefaultValue="true" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
        
    <vipdc:PaymentDueAlerts ID="PaymentDueAlerts1" runat="server" />
    <br />
    <br />
</asp:Content>
