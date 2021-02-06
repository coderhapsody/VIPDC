<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="ManageParticipants.aspx.cs" Inherits="VIPDC.Web.ManageParticipants" StylesheetTheme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 407px;
        }

        .auto-style2 {
            width: 393px;
        }

        .auto-style3 {
            width: 160px;
        }

        .auto-style4 {
            width: 3px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Training Participants
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <asp:MultiView runat="server" ID="mvwForm">
        <asp:View runat="server" ID="viwRead">
            <fieldset>
                <table class="fullwidth noborder">
                    <tr>
                        <td class="auto-style3">Confirmation Letter No.</td>
                        <td class="auto-style4">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindCLNo"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Customer</td>
                        <td class="auto-style4">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindCustomer"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">&nbsp;</td>
                        <td class="auto-style4">&nbsp;</td>
                        <td>
                            <telerik:RadButton runat="server" ID="btnSearch" Text="Search" OnClick="btnSearch_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />
            <telerik:RadGrid ID="RadGrid1" runat="server" Width="100%" AllowPaging="True" ShowGroupPanel="true" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" AutoGenerateColumns="False" OnItemCommand="RadGrid1_ItemCommand" GroupingSettings-CaseSensitive="false">
                <GroupingSettings CaseSensitive="False" />
                <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True" EnableRowHoverStyle="true">
                </ClientSettings>
                <MasterTableView DataKeyNames="ID" DataSourceID="sdsMaster" Width="100%">
                    <RowIndicatorColumn Visible="False">
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn Created="True">
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridBoundColumn DataField="ID" DataType="System.Int32" FilterControlAltText="Filter ID column" HeaderText="ID" ReadOnly="True" SortExpression="ID" UniqueName="ID">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="LetterNo" FilterControlAltText="Filter LetterNo column" HeaderText="Letter No" SortExpression="LetterNo" UniqueName="LetterNo">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AccountManager" FilterControlAltText="Filter AccountManager column" HeaderText="Account Manager" SortExpression="AccountManager" UniqueName="AccountManager">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TrainingDate" DataFormatString="{0:dd/MM/yyyy}" DataType="System.DateTime" FilterControlAltText="Filter TrainingDate column" HeaderText="Training Date" SortExpression="TrainingDate" UniqueName="TrainingDate">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TrainingLocation" FilterControlAltText="Filter TrainingLocation column" HeaderText="Training Location" SortExpression="TrainingLocation" UniqueName="TrainingLocation">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ClassTypeName" FilterControlAltText="Filter ClassTypeName column" HeaderText="Class Type" SortExpression="ClassTypeName" UniqueName="ClassTypeName">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TopicName" FilterControlAltText="Filter TopicName column" HeaderText="Topic" SortExpression="TopicName" UniqueName="TopicName">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TotalPrice" DataFormatString="{0:###,##0}" DataType="System.Decimal" FilterControlAltText="Filter TotalPrice column" HeaderText="Total Price" SortExpression="TotalPrice" UniqueName="TotalPrice" AllowFiltering="false">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="PaymentDueDate" DataFormatString="{0:dd/MM/yyyy}" DataType="System.DateTime" FilterControlAltText="Filter PaymentDueDate column" HeaderText="Payment Due Date" SortExpression="PaymentDueDate" UniqueName="PaymentDueDate">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridCheckBoxColumn DataField="CLReceived" DataType="System.Boolean" FilterControlAltText="Filter CLReceived column" HeaderText="CL Received" ReadOnly="True" SortExpression="CLReceived" UniqueName="CLReceived">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridCheckBoxColumn DataField="Void" DataType="System.Boolean" FilterControlAltText="Filter Void column" HeaderText="Void" ReadOnly="True" SortExpression="Void" UniqueName="Void">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEdit" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="EditRow" ImageUrl="~/Images/user_green.png" ToolTip="Add/Remove Participant" />
                            </ItemTemplate>
                            <ItemStyle Width="20px" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_GetAllConfirmationLetter" SelectCommandType="StoredProcedure" OnSelecting="sdsMaster_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="LetterNo" Type="String" />
                    <asp:Parameter Name="Customer" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:View>
        <asp:View runat="server" ID="viwAddEdit">
            <asp:HiddenField runat="server" ID="hidLetterID" />
            <vipdc:ConfirmationLetterDetail ID="ConfirmationLetterDetail1" runat="server" />
            <br />
            <asp:HyperLink runat="server" ID="hypAddNewCust" ClientIDMode="Static" Text="Add New Customer" EnableViewState="false" NavigateUrl="#" />
            &nbsp;&nbsp;&nbsp;
            <asp:HyperLink runat="server" ID="hypAddExistingCust" ClientIDMode="Static" Text="Add Existing Customer" EnableViewState="false" NavigateUrl="#" />
            <br />
            <br />
            <asp:Button ID="btnRefreshParticipant" runat="server" OnClick="btnRefreshParticipant_Click" Style="display: none" />

            <telerik:RadGrid runat="server" ID="RadGridParticipants" CellSpacing="0" DataSourceID="sdsParticipants" GridLines="None" OnItemCommand="RadGridParticipants_ItemCommand" OnItemDataBound="RadGridParticipants_ItemDataBound">
                <ClientSettings AllowColumnsReorder="True" EnableRowHoverStyle="true" />
                <MasterTableView AutoGenerateColumns="False" DataSourceID="sdsParticipants">
                    <Columns>
                        <telerik:GridBoundColumn DataField="Code" FilterControlAltText="Filter Code column" HeaderText="Code" SortExpression="Code" UniqueName="Code">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column" HeaderText="Name" SortExpression="Name" UniqueName="Name">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CellPhone1" FilterControlAltText="Filter CellPhone1 column" HeaderText="CellPhone" SortExpression="CellPhone1" UniqueName="CellPhone1">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column" HeaderText="Email" SortExpression="Email" UniqueName="Email">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnbDelete" runat="server" CommandArgument='<%# Eval("Code") %>' CommandName="DeleteParticipant" Text="Delete" />
                            </ItemTemplate>
                            <ItemStyle Width="20px" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <asp:SqlDataSource ID="sdsParticipants" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_GetTrainingParticipants" SelectCommandType="StoredProcedure" OnSelecting="sdsParticipants_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="LetterNo" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <telerik:RadWindow runat="server" ID="wndAddCust" Title="Add Customer as Participant" Width="800px" Height="400px" Modal="true" VisibleStatusbar="False" Behaviors="Close" InitialBehaviors="Close" OnClientShow="ModalPopUpShow" ReloadOnShow="True">
                <ContentTemplate>
                    <asp:ValidationSummary runat="server" ID="vsmSummary" ValidationGroup="AddCust" style="text-align: left;" ForeColor="red" />
                    <table style="width: 100%; text-align: left;">
                        <tr>
                            <td>Name</td>
                            <td>:</td>
                            <td>
                                <telerik:RadTextBox runat="server" ID="txtCustName" ValidationGroup="AddCust"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rqvCustName" Text="*" SetFocusOnError="true" ForeColor="Red" ControlToValidate="txtCustName" ErrorMessage="<b>Customer Name</b> must be specified" ValidationGroup="AddCust"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr id="rowDateOfBirth">
                            <td class="auto-style6">Date of Birth</td>
                            <td class="auto-style4">:</td>
                            <td colspan="4">
                                <telerik:RadDatePicker runat="server" ID="dtpCustBirthDate" Width="110px" />
                            </td>
                        </tr>
                        <tr id="rowGender">
                            <td class="auto-style6">Gender</td>
                            <td class="auto-style5">:</td>
                            <td colspan="4">
                                <asp:RadioButtonList ID="rblCustGender" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True" Value="M">Male</asp:ListItem>
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr id="rowJobPosition">
                            <td class="auto-style6">Job Position</td>
                            <td>:</td>
                            <td colspan="4">
                                <telerik:RadDropDownList ID="ddlCustJobPosition" runat="server" DefaultMessage="Select">
                                </telerik:RadDropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Email</td>
                            <td>:</td>
                            <td colspan="4">
                                <telerik:RadTextBox ID="txtCustEmail" runat="server" ValidationGroup="AddCust" Width="200px" />
                                <asp:RegularExpressionValidator runat="server" ID="revEmail" EnableViewState="false" ControlToValidate="txtCustEmail" CssClass="errorMessage" Display="Dynamic" ErrorMessage="&lt;b&gt;Email&lt;/b&gt; address invalid" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="AddCust">*</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Address</td>
                            <td class="auto-style4">:</td>
                            <td colspan="4">
                                <telerik:RadTextBox ID="txtCustAddress" runat="server" ValidationGroup="AddCust" Width="500px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Zip Code</td>
                            <td>:</td>
                            <td colspan="4">
                                <telerik:RadTextBox ID="txtCustZipCode" runat="server" ValidationGroup="AddCust" Width="80px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Work Phone 1</td>
                            <td>:</td>
                            <td class="auto-style8">
                                <telerik:RadTextBox ID="txtCustWorkPhone1" runat="server" ValidationGroup="AddCust" />
                            </td>
                            <td class="auto-style11">Work Phone 2</td>
                            <td class="auto-style9">:</td>
                            <td>
                                <telerik:RadTextBox ID="txtCustWorkPhone2" runat="server" ValidationGroup="AddCust" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Cell Phone 1</td>
                            <td>:</td>
                            <td>
                                <telerik:RadTextBox ID="txtCustCellPhone1" runat="server" ValidationGroup="AddCust" />
                            </td>
                            <td class="auto-style11">Cell Phone 2</td>
                            <td class="auto-style9">:</td>
                            <td>
                                <telerik:RadTextBox ID="txtCustCellPhone2" runat="server" ValidationGroup="AddCust" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Website</td>
                            <td class="auto-style4">:</td>
                            <td colspan="4">
                                <telerik:RadTextBox ID="txtCustWebsite" runat="server" ValidationGroup="AddCust" Width="250px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Source of Information</td>
                            <td class="auto-style4">:</td>
                            <td colspan="4">
                                <telerik:RadTextBox ID="txtInformationSource" runat="server" ValidationGroup="AddCust" Width="250px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Social Media Network 1</td>
                            <td>:</td>
                            <td>
                                <telerik:RadTextBox ID="txtCustSocialMediaNetwork1" runat="server" ValidationGroup="AddCust" />
                                <asp:RegularExpressionValidator ID="revEmailCustSocialMedia1" runat="server" ControlToValidate="txtCustSocialMediaNetwork1" CssClass="errorMessage" Display="Dynamic" EnableViewState="false" ErrorMessage="&lt;b&gt;URL &lt;/b&gt; is invalid" SetFocusOnError="True" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?" ValidationGroup="AddCust">*</asp:RegularExpressionValidator>
                            </td>
                            <td class="auto-style11">Social Media Network 2</td>
                            <td class="auto-style9">:</td>
                            <td>
                                <telerik:RadTextBox ID="txtCustSocialMediaNetwork2" runat="server" ValidationGroup="AddCust" />
                                <asp:RegularExpressionValidator ID="revEmailCustSocialMedia2" runat="server" ControlToValidate="txtCustSocialMediaNetwork2" CssClass="errorMessage" Display="Dynamic" EnableViewState="false" ErrorMessage="&lt;b&gt;URL &lt;/b&gt; is invalid" SetFocusOnError="True" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?" ValidationGroup="AddCust">*</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <telerik:RadButton runat="server" ID="btnCustSave" Text="Save" ValidationGroup="AddCust" OnClick="btnCustSave_Click"></telerik:RadButton>

                </ContentTemplate>
            </telerik:RadWindow>
        </asp:View>
    </asp:MultiView>

    <script>
        $(function () {
            $("#<%= hypAddNewCust.ClientID %>").click(function (e) {
                e.preventDefault();
                $find("<%= wndAddCust.ClientID %>").show();
            });

            $("#<%= hypAddExistingCust.ClientID %>").click(function (e) {
                e.preventDefault();
                var letterID = $get("<%= hidLetterID.ClientID %>").value;
                showPopUp("PromptAddCustomerParticipant.aspx?LetterID=" + letterID + "&Refresh=<%=btnRefreshParticipant.ClientID%>", null, "cust", 500, 800, false, false, false);
            });
        });

        function ModalPopUpShow() {
            $find("<%= txtCustName.ClientID %>").focus();
        }
    </script>
</asp:Content>
