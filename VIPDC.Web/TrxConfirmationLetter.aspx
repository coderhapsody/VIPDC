<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="TrxConfirmationLetter.aspx.cs" Inherits="VIPDC.Web.TrxConfirmationLetter" StylesheetTheme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 187px;
        }

        .auto-style2 {
            width: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Confirmation Letter
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <%--<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mvwForm" />
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>--%>
    <asp:ScriptManagerProxy runat="server">
        <Services>
            <asp:ServiceReference Path="AjaxService.svc" />
        </Services>
    </asp:ScriptManagerProxy>
    <asp:MultiView runat="server" ID="mvwForm">
        <asp:View runat="server" ID="viwRead">
            <fieldset>
                <table class="fullwidth noborder" style="float: left;">
                    <tr>
                        <td class="auto-style1">Confirmation Letter No.</td>
                        <td class="auto-style2">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindCLNo"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Customer</td>
                        <td class="auto-style2">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindCustomer"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style2">&nbsp;</td>
                        <td>
                            <telerik:RadButton runat="server" ID="btnSearch" Text="Search" OnClick="btnSearch_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>

            </fieldset>
            <asp:LinkButton runat="server" ID="lnbAddNew" Text="Add New" OnClick="lnbAddNew_Click" SkinID="AddNewButton" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;            
            <br />
            <br />
            <telerik:RadGrid ID="RadGrid1" runat="server" Width="100%" AllowPaging="True" ShowGroupPanel="true" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" AutoGenerateColumns="False" OnItemCommand="RadGrid1_ItemCommand" GroupingSettings-CaseSensitive="false" OnItemDataBound="RadGrid1_ItemDataBound">
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
                        <%--<telerik:GridCheckBoxColumn DataField="Void" DataType="System.Boolean" FilterControlAltText="Filter Void column" HeaderText="Void" ReadOnly="True" SortExpression="Void" UniqueName="Void">
                        </telerik:GridCheckBoxColumn>--%>
                        <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                            <ItemTemplate>
                                <asp:HyperLink runat="server" ToolTip="Print Confirmation Letter" ID="hypPrintInvoice" NavigateUrl='#' ImageUrl="~/Images/PrintHS.png"></asp:HyperLink>
                            </ItemTemplate>
                            <ItemStyle Width="20px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEdit" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="EditRow" SkinID="EditButton" />
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
            <%--<asp:ValidationSummary runat="server" ID="vsmSummary" EnableViewState="false" CssClass="errorMessage" ValidationGroup="AddEdit" />--%>
            <asp:Label runat="server" ID="lblStatusAddEdit" EnableViewState="False"></asp:Label>
            <div style="float: left;">
                <table class="noborder halfwidth" style="float: left;">
                    <tr>
                        <td style="width: 200px;">Confirmation Letter No.</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <asp:Label ID="lblConfirmationLetterNo" runat="server" Text="(Auto)"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Account Manager</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadComboBox ID="cboAccountManager" runat="server" AccessibilityMode="True" DropDownAutoWidth="Enabled" EmptyMessage="Select account manager" MarkFirstMatch="True">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator runat="server" ID="rqvAccountManager" ControlToValidate="cboAccountManager" ErrorMessage="<b>Account Manager</b> must be specified" SetFocusOnError="True" EnableViewState="False" Display="Dynamic" CssClass="errorMessage" ValidationGroup="AddEdit" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Customer</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadTextBox ID="txtCustomerName" runat="server" ReadOnly="true">
                            </telerik:RadTextBox>
                            <asp:HyperLink runat="server" ID="hypLookUpCustomer" ImageUrl="Images/zoom.png" ToolTip="Look up customer" onclick="showPromptPopUp('PromptCustomer.aspx?Code=cphMainContent_hidCustomerCode&Name=ctl00_cphMainContent_txtCustomerName', null, 550, 900);"></asp:HyperLink>
                            <asp:HiddenField runat="server" ID="hidCustomerCode" />
                            <asp:RequiredFieldValidator ID="rqvCustomer" runat="server" ControlToValidate="txtCustomerName" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Customer&lt;/b&gt; must be specified" SetFocusOnError="True" ValidationGroup="AddEdit" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Total Participants</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadNumericTextBox ID="ntbTotalParticipants" runat="server" DataType="System.Int32" MinValue="1" ShowSpinButtons="True" ValidationGroup="AddEdit" Width="80px">
                                <NegativeStyle Resize="None" />
                                <NumberFormat DecimalDigits="0" ZeroPattern="n" />
                                <EmptyMessageStyle Resize="None" />
                                <ReadOnlyStyle Resize="None" />
                                <FocusedStyle Resize="None" />
                                <DisabledStyle Resize="None" />
                                <InvalidStyle Resize="None" />
                                <HoveredStyle Resize="None" />
                                <EnabledStyle Resize="None" />
                            </telerik:RadNumericTextBox>
                            <%--<asp:RangeValidator ID="ravTotalParticipants" runat="server" ControlToValidate="ntbTotalParticipants" CssClass="errorMessage" EnableViewState="False" ErrorMessage="Minimum participant is 1" MaximumValue="999999" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="AddEdit"></asp:RangeValidator>--%>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Training Location</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadTextBox ID="txtTrainingLocation" runat="server" ValidationGroup="AddEdit" />
                            <asp:RequiredFieldValidator ID="rqvTrainingLocation" runat="server" ControlToValidate="txtTrainingLocation" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Training Location&lt;/b&gt; must be specified" SetFocusOnError="True" ValidationGroup="AddEdit" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Description</td>
                        <td style="width: 5px;">&nbsp;</td>
                        <td>
                            <telerik:RadTextBox ID="txtDescription" runat="server" ValidationGroup="AddEdit" Width="400px" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Class Type</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlClassType" runat="server" DefaultMessage="Select Class Type" OnClientSelectedIndexChanged="recalculatePrice">
                            </telerik:RadDropDownList>
                            <asp:RequiredFieldValidator ID="rqvClassType" runat="server" ControlToValidate="ddlClassType" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Class Type&lt;/b&gt; must be specified" SetFocusOnError="True" ValidationGroup="AddEdit" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Topic</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlTopic" runat="server" DefaultMessage="Select Topic">
                            </telerik:RadDropDownList>
                            <asp:RequiredFieldValidator ID="rqvTopic" runat="server" ControlToValidate="ddlTopic" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Topic &lt;/b&gt; must be specified" SetFocusOnError="True" ValidationGroup="AddEdit" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Module</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <asp:CheckBoxList ID="cblModule" runat="server" RepeatLayout="Table" RepeatColumns="4" RepeatDirection="Horizontal">
                            </asp:CheckBoxList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">CL Reference</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadTextBox ID="txtCLRef" runat="server" ValidationGroup="AddEdit" ReadOnly="true" />
                            <asp:HyperLink runat="server" ID="hypCLRef" ImageUrl="Images/zoom.png" Style="cursor: pointer;" ToolTip="Look up Confirmation Letter"></asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Price</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadNumericTextBox ID="ntbPrice" runat="server" EnabledStyle-HorizontalAlign="Right">
                            </telerik:RadNumericTextBox>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        Tax:
                            <telerik:RadNumericTextBox ID="ntbTax" runat="server" ReadOnly="True" EnabledStyle-HorizontalAlign="Right">
                            </telerik:RadNumericTextBox>
                            PPH:
                            <telerik:RadNumericTextBox ID="ntbPPH" runat="server" ReadOnly="True" EnabledStyle-HorizontalAlign="Right">
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Discount</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadNumericTextBox ID="ntbDiscount" runat="server" EnabledStyle-HorizontalAlign="Right">
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Total Price</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadNumericTextBox ID="ntbTotalPrice" runat="server" EnabledStyle-HorizontalAlign="Right">
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Transfer To</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlBank" runat="server" DefaultMessage="Select Bank" OnClientSelectedIndexChanged="recalculatePrice">
                            </telerik:RadDropDownList>
                            <asp:RequiredFieldValidator ID="rqvBank" runat="server" ControlToValidate="ddlBank" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Bank&lt;/b&gt; must be specified" SetFocusOnError="True" ValidationGroup="AddEdit" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px;">Payment Due Date</td>
                        <td style="width: 5px;">:</td>
                        <td>
                            <telerik:RadDatePicker ID="dtpPaymentDueDate" runat="server" Width="110px">
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="rqvPaymentDueDate" runat="server" ControlToValidate="dtpPaymentDueDate" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Payment Due Date&lt;/b&gt; must be specified" SetFocusOnError="True" ValidationGroup="AddEdit" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td>
                            <telerik:RadButton runat="server" ID="btnSave" EnableViewState="False" Text="Save" ValidationGroup="AddEdit" OnClick="btnSave_Click">
            </telerik:RadButton>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <telerik:RadButton runat="server" ID="btnCancel" EnableViewState="False" Text="Cancel" CausesValidation="False" OnClick="btnCancel_Click">
                        </telerik:RadButton>
                        </td>
                    </tr>
                </table>

            </div>
            <div style="visibility: hidden;">
                <br />
                <fieldset>
                    <div style="font-weight: bold;">Specify Training Dates:</div>
                    <telerik:RadDatePicker runat="server" ID="dtpTrainingDate" ValidationGroup="AddTrainingDate" />
                    <telerik:RadButton runat="server" ID="btnAddTrainingDate" Text="Add Date" OnClick="btnAddTrainingDate_Click" ValidationGroup="AddTrainingDate"></telerik:RadButton>
                    <br />
                    <asp:RequiredFieldValidator runat="server" ID="rqvTrainingDate" ControlToValidate="dtpTrainingDate" CssClass="errorMessage" SetFocusOnError="true" ErrorMessage="<b>Training Date</b> must be specified" ValidationGroup="AddTrainingDate"></asp:RequiredFieldValidator>
                    <br />
                    <telerik:RadGrid runat="server" ID="grdTrainingDates" AutoGenerateColumns="false" OnItemCommand="grdTrainingDates_ItemCommand" AllowPaging="false" AllowSorting="false">
                        <MasterTableView DataKeyNames="Date">
                            <Columns>
                                <telerik:GridBoundColumn DataField="Date" DataType="System.DateTime" FilterControlAltText="Filter Date column" HeaderText="Training Date" ReadOnly="True" SortExpression="Date" UniqueName="Date" DataFormatString="{0:dddd, dd MMMM yyyy}" />
                                <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lnbDeleteTrainingDate" Text="Delete" CommandArgument='<%# Eval("Date") %>' CommandName="DeleteTrainingDate" OnClientClick="return confirm('Delete selected training date ? ')" CausesValidation="false"></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="20px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </fieldset>
            </div>
            <br />
            <br />

        </asp:View>
    </asp:MultiView>

    <script>
        $(function () {
            $("#<%= ntbPrice.ClientID %>").blur(function (e) {
                recalculatePrice();
            });

            $("#<%= ntbDiscount.ClientID %>").blur(function (e) {
                recalculatePrice();
            });
        });

        function recalculatePrice() {
            var ajaxSvc = new Service.AjaxService();
            var classType = $telerik.findControl(document.forms[0], "<%=ddlClassType.ClientID%>").get_selectedItem();
            if (classType != null) {
                var classTypeID = classType.get_value();
                ajaxSvc.GetClassTypeInfo(classTypeID, function (data) {
                    var price = $telerik.findControl(document.forms[0], "<%= ntbPrice.ClientID %>");
                    var tax = $telerik.findControl(document.forms[0], "<%= ntbTax.ClientID %>");
                    var pph = $telerik.findControl(document.forms[0], "<%= ntbPPH.ClientID %>");
                    var discount = $telerik.findControl(document.forms[0], "<%= ntbDiscount.ClientID %>");
                    var totalPrice = $telerik.findControl(document.forms[0], "<%= ntbTotalPrice.ClientID %>");

                    var _totalPrice = 0;
                    var ratePPN = data.RatePPN / 100;
                    var ratePPH = data.RatePPH / 100;
                    if (data.Tax) {
                        tax.set_value((price.get_value() - discount.get_value()) * ratePPN);
                        pph.set_value((price.get_value() - discount.get_value()) * ratePPH);
                    }

                    _totalPrice = price.get_value() - discount.get_value() + tax.get_value() - pph.get_value();
                    totalPrice.set_value(_totalPrice);
                });
            }
        }
    </script>
</asp:Content>
