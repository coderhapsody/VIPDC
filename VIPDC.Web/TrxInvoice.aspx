<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="TrxInvoice.aspx.cs" Inherits="VIPDC.Web.TrxInvoice" StylesheetTheme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 130px;
        }

        .auto-style2 {
            width: 5px;
        }

        .auto-style3 {
            width: 180px;
        }

        .auto-style4 {
            width: 4px;
        }
    .RadDropDownList { display:inline-block !important; 
                                               width: 160px !important; } .RadDropDownList_Default{color:#333;font:normal 12px/16px "Segoe UI",Arial,Helvetica,sans-serif}.RadDropDownList{margin:0;padding:0;*zoom:1;display:-moz-inline-stack;display:inline-block;*display:inline;width:160px;text-align:left;vertical-align:middle;_vertical-align:top;white-space:nowrap;cursor:default} .RadDropDownList { display:inline-block !important; 
                                               width: 160px !important; } .RadDropDownList_Default{color:#333;font:normal 12px/16px "Segoe UI",Arial,Helvetica,sans-serif}.RadDropDownList{margin:0;padding:0;*zoom:1;display:-moz-inline-stack;display:inline-block;*display:inline;width:160px;text-align:left;vertical-align:middle;_vertical-align:top;white-space:nowrap;cursor:default}.RadDropDownList_Default .rddlInner{border-radius:3px;background-image:url('mvwres://Telerik.Web.UI, Version=2013.3.1114.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radGradientButtonSprite.png');_background-image:none;border-color:#8a8a8a;color:#333;background-color:#e8e8e8;background-image:-webkit-linear-gradient(top,#faf9f9 0,#e8e8e8 100%);background-image:-moz-linear-gradient(top,#faf9f9 0,#e8e8e8 100%);background-image:-ms-linear-gradient(top,#faf9f9 0,#e8e8e8 100%);background-image:-o-linear-gradient(top,#faf9f9 0,#e8e8e8 100%);background-image:linear-gradient(top,#faf9f9 0,#e8e8e8 100%)}.RadDropDownList .rddlInner{padding:2px 22px 2px 5px;border-width:1px;border-style:solid;display:block;position:relative;overflow:hidden}.RadDropDownList_Default .rddlInner{border-radius:3px;background-image:url('mvwres://Telerik.Web.UI, Version=2013.3.1114.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radGradientButtonSprite.png');_background-image:none;border-color:#8a8a8a;color:#333;background-color:#e8e8e8;background-image:-webkit-linear-gradient(top,#faf9f9 0,#e8e8e8 100%);background-image:-moz-linear-gradient(top,#faf9f9 0,#e8e8e8 100%);background-image:-ms-linear-gradient(top,#faf9f9 0,#e8e8e8 100%);background-image:-o-linear-gradient(top,#faf9f9 0,#e8e8e8 100%);background-image:linear-gradient(top,#faf9f9 0,#e8e8e8 100%)}.RadDropDownList .rddlInner{padding:2px 22px 2px 5px;border-width:1px;border-style:solid;display:block;position:relative;overflow:hidden}.RadDropDownList_Default .rddlDefaultMessage{color:#a5a5a5;font-style:italic}.RadDropDownList .rddlDefaultMessage{font-style:italic}.RadDropDownList .rddlFakeInput{margin:0;padding:0;width:100%;height:16px;line-height:16px;display:block;overflow:hidden}.RadDropDownList_Default .rddlDefaultMessage{color:#a5a5a5;font-style:italic}.RadDropDownList .rddlDefaultMessage{font-style:italic}.RadDropDownList .rddlFakeInput{margin:0;padding:0;width:100%;height:16px;line-height:16px;display:block;overflow:hidden}.RadDropDownList_Default .rddlIcon{background-image:url('mvwres://Telerik.Web.UI, Version=2013.3.1114.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radActionsSprite.png');background-position:-21px -20px}.RadDropDownList .rddlIcon{width:18px;height:20px;border:0;background-repeat:no-repeat;position:absolute;top:0;right:0}.RadDropDownList_Default .rddlIcon{background-image:url('mvwres://Telerik.Web.UI, Version=2013.3.1114.45, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radActionsSprite.png');background-position:-21px -20px}.RadDropDownList .rddlIcon{width:18px;height:20px;border:0;background-repeat:no-repeat;position:absolute;top:0;right:0}.rddlSlide{_height:1px;float:left;display:none;position:absolute;overflow:hidden;z-index:7000}.rddlSlide{_height:1px;float:left;display:none;position:absolute;overflow:hidden;z-index:7000}.rddlPopup_Default{border-color:#8a8a8a;color:#333;background:white;font:normal 12px "Segoe UI",Arial,Helvetica,sans-serif;line-height:16px}.rddlPopup{*zoom:1;padding:2px;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;box-sizing:border-box;border-width:1px;border-style:solid;text-align:left;position:relative;cursor:default;width:160px;*width:154px}.rddlPopup_Default{border-color:#8a8a8a;color:#333;background:white;font:normal 12px "Segoe UI",Arial,Helvetica,sans-serif;line-height:16px}.rddlPopup{*zoom:1;padding:2px;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;box-sizing:border-box;border-width:1px;border-style:solid;text-align:left;position:relative;cursor:default;width:160px;*width:154px}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Invoicing
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <asp:ScriptManagerProxy runat="server">
        <Services>
            <asp:ServiceReference Path="AjaxService.svc" />
        </Services>
    </asp:ScriptManagerProxy>    
    <asp:MultiView runat="server" ID="mvwForm">
        <asp:View runat="server" ID="viwRead">
            <fieldset>
                <table class="fullwidth noborder">
                    <tr>
                        <td class="auto-style1">Invoice No.</td>
                        <td class="auto-style2">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindInvoiceNo"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Purchase Date</td>
                        <td class="auto-style2">:</td>
                        <td>
                            <telerik:RadDatePicker runat="server" ID="dtpFindPurchaseDateFrom"></telerik:RadDatePicker>
                            to 
                        <telerik:RadDatePicker runat="server" ID="dtpFindPurchaseDateTo"></telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Customer</td>
                        <td class="auto-style2">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindCustomer"></telerik:RadTextBox>
                            &nbsp;&nbsp;
                            <asp:CheckBox runat="server" ID="chkActiveOnly" Text="Only active invoices" />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1"></td>
                        <td class="auto-style2"></td>
                        <td>
                            <telerik:RadButton runat="server" ID="btnSearch" Text="Search" OnClick="btnSearch_Click"></telerik:RadButton>
                            <asp:Label runat="server" ID="lblStatus" EnableViewState="false"></asp:Label>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />
            <asp:LinkButton runat="server" ID="lnbAddNew" Text="Add New" OnClick="lnbAddNew_Click" SkinID="AddNewButton" />
            <br />
            <br />
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" ShowGroupPanel="True" AutoGenerateColumns="False" OnItemCommand="RadGrid1_ItemCommand" GroupingSettings-CaseSensitive="false" OnItemDataBound="RadGrid1_ItemDataBound">
                <GroupingSettings CaseSensitive="False" />
                <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True" EnableRowHoverStyle="true">
                </ClientSettings>
                <MasterTableView DataKeyNames="ID" DataSourceID="sdsMaster">
                    <Columns>
                        <telerik:GridBoundColumn DataField="ID" DataType="System.Int32" FilterControlAltText="Filter ID column" HeaderText="ID" ReadOnly="True" SortExpression="ID" UniqueName="ID">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="InvoiceNo" FilterControlAltText="Filter InvoiceNo column" HeaderText="InvoiceNo" SortExpression="InvoiceNo" UniqueName="InvoiceNo">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="LetterNo" FilterControlAltText="Filter LetterNo column" HeaderText="LetterNo" SortExpression="LetterNo" UniqueName="LetterNo">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" SortExpression="Date" UniqueName="Date" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CustomerCode" FilterControlAltText="Filter CustomerCode column" HeaderText="CustomerCode" SortExpression="CustomerCode" UniqueName="CustomerCode">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CustomerName" FilterControlAltText="Filter CustomerName column" HeaderText="CustomerName" SortExpression="CustomerName" UniqueName="CustomerName">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TotalPrice" FilterControlAltText="Filter TotalPrice column" HeaderText="TotalPrice" SortExpression="TotalPrice" UniqueName="TotalPrice" DataType="System.Decimal" DataFormatString="{0:###,##0.00}">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="PaymentDueDate" DataType="System.DateTime" FilterControlAltText="Filter PaymentDueDate column" HeaderText="PaymentDueDate" SortExpression="PaymentDueDate" UniqueName="PaymentDueDate" DataFormatString="{0:dd/MM/yyyy}">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridCheckBoxColumn DataField="Void" DataType="System.Boolean" FilterControlAltText="Filter Void column" HeaderText="Void" ReadOnly="True" SortExpression="Void" UniqueName="Void">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                            <ItemTemplate>
                                <asp:HyperLink runat="server" ToolTip="Print Invoice" ID="hypPrintInvoice" NavigateUrl='#' ImageUrl="~/Images/PrintHS.png"></asp:HyperLink>
                            </ItemTemplate>
                            <ItemStyle Width="20px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                            <ItemTemplate>
                                <asp:HyperLink runat="server" ToolTip="Print Kwitansi" ID="hypPrintKwitansi" NavigateUrl='#' ImageUrl="~/Images/EditCodeHS.png"></asp:HyperLink>
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
            <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_GetAllInvoices" SelectCommandType="StoredProcedure" OnSelecting="sdsMaster_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="InvoiceNo" Type="String" />
                    <asp:Parameter Name="PurchaseDateFrom" Type="DateTime" />
                    <asp:Parameter Name="PurchaseDateTo" Type="DateTime" />
                    <asp:Parameter Name="Customer" Type="String" />
                    <asp:Parameter Name="ActiveOnly" Type="Boolean" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:View>
        <asp:View ID="viwAddEdit" runat="server">
            <table class="fullwidth noborder">
                <tr>
                    <td class="auto-style3">Invoice No.</td>
                    <td class="auto-style4">:</td>
                    <td>
                        <asp:Label runat="server" ID="lblInvoiceNo"></asp:Label></td>
                </tr>
                <tr>
                    <td class="auto-style3">Confirmation Letter No.</td>
                    <td class="auto-style4">:</td>
                    <td>
                        <telerik:RadTextBox runat="server" ID="txtConfirmationLetterNo" ValidationGroup="AddEdit" ReadOnly="true" ></telerik:RadTextBox>
                        <asp:HyperLink runat="server" ID="hypLookUpCL" ImageUrl="Images/zoom.png" Style="cursor: pointer;" ToolTip="Look up Confirmation Letter"></asp:HyperLink>
                        <asp:RequiredFieldValidator runat="server" ID="rqvConfirmationLetterNo" ControlToValidate="txtConfirmationLetterNo" SetFocusOnError="true" CssClass="errorMessage" Display="Dynamic" ErrorMessage="<b>Confirmation Letter Number</b> must be specified" ValidationGroup="AddEdit"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Date</td>
                    <td class="auto-style4">:</td>
                    <td>
                        <telerik:RadDatePicker runat="server" ID="dtpDate"></telerik:RadDatePicker>
                        <asp:RequiredFieldValidator runat="server" ID="rqvDate" ControlToValidate="dtpDate" SetFocusOnError="true" CssClass="errorMessage" Display="Dynamic" ErrorMessage="<b>Invoice Date</b> must be specified" ValidationGroup="AddEdit"></asp:RequiredFieldValidator>
                        
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Notes</td>
                    <td class="auto-style4">:</td>
                    <td>
                        <telerik:RadTextBox runat="server" ID="txtNotes" TextMode="MultiLine" Columns="40" Rows="3"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Payment Due Date</td>
                    <td class="auto-style4">:</td>
                    <td>
                        <telerik:RadDatePicker runat="server" ID="dtpPaymentDueDate"></telerik:RadDatePicker>
                        <asp:RequiredFieldValidator runat="server" ID="rqvPaymentDueDate" ControlToValidate="dtpPaymentDueDate" SetFocusOnError="true" CssClass="errorMessage" Display="Dynamic" ErrorMessage="<b>Payment Due Date</b> must be specified" ValidationGroup="AddEdit"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Price</td>
                    <td class="auto-style4">:</td>
                    <td>
                        <telerik:RadNumericTextBox runat="server" ID="ntbPrice" ValidationGroup="AddEdit" DataType="System.Decimal">
                            <ClientEvents OnBlur="recalculatePrice"></ClientEvents>
                        </telerik:RadNumericTextBox>
                        <asp:RequiredFieldValidator runat="server" ID="rqvPrice" ControlToValidate="ntbPrice" SetFocusOnError="true" CssClass="errorMessage" Display="Dynamic" ErrorMessage="<b>Price</b> must be specified" ValidationGroup="AddEdit"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Tax</td>
                    <td class="auto-style4">:</td>
                    <td>
                        <telerik:RadNumericTextBox runat="server" ID="ntbTax" ReadOnly="true"></telerik:RadNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">PPH</td>
                    <td class="auto-style4">:</td>
                    <td>
                        <telerik:RadNumericTextBox runat="server" ID="ntbPPH" ReadOnly="true"></telerik:RadNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Discount</td>
                    <td class="auto-style4">:</td>
                    <td>
                        <telerik:RadNumericTextBox runat="server" ID="ntbDiscount" ValidationGroup="AddEdit">
                            <ClientEvents OnBlur="recalculatePrice"></ClientEvents>
                        </telerik:RadNumericTextBox>
                        <asp:RequiredFieldValidator runat="server" ID="rqvDiscount" ControlToValidate="ntbDiscount" SetFocusOnError="true" CssClass="errorMessage" Display="Dynamic" ErrorMessage="<b>Discount</b> must be specified" ValidationGroup="AddEdit"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Total Invoice</td>
                    <td class="auto-style4">:</td>
                    <td>
                        <telerik:RadNumericTextBox runat="server" ID="ntbTotalInvoice" ReadOnly="true"></telerik:RadNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Transfer to</td>
                    <td class="auto-style4">:</td>
                    <td>
                        <telerik:RadDropDownList ID="ddlBank" runat="server" DefaultMessage="Select Bank" OnClientSelectedIndexChanged="recalculatePrice">
                        </telerik:RadDropDownList>
                        <asp:RequiredFieldValidator ID="rqvBank" runat="server" ControlToValidate="ddlBank" CssClass="errorMessage" Display="Dynamic" EnableViewState="False" ErrorMessage="&lt;b&gt;Bank&lt;/b&gt; must be specified" SetFocusOnError="True" ValidationGroup="AddEdit" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td>
                        <telerik:RadButton runat="server" ID="btnSave" Text="Save" ValidationGroup="AddEdit" OnClick="btnSave_Click"></telerik:RadButton>
                        &nbsp;&nbsp;&nbsp;
                        <telerik:RadButton runat="server" ID="btnCancel" Text="Cancel" CausesValidation="false" OnClick="btnCancel_Click"></telerik:RadButton>
                        &nbsp;&nbsp;
                        <telerik:RadButton runat="server" ID="btnVoid" Text="Void" AutoPostBack="false" OnClientClicking="btnVoidClick"></telerik:RadButton>
                        <asp:Label ID="lblStatusAddEdit" runat="server" EnableViewState="false" />
                    </td>
                </tr>
            </table>
            <telerik:RadWindow runat="server" ID="wndVoidReason" Title="Enter Void Reason" Width="500px" Height="250px" Modal="true" VisibleStatusbar="False" Behaviors="Close" InitialBehaviors="Close" OnClientShow="ModalPopUpShow" ReloadOnShow="True">
                <ContentTemplate>
                    <br />
                    <telerik:RadTextBox runat="server" ID="txtVoidReason" TextMode="MultiLine" Width="400px" Rows="5"></telerik:RadTextBox>
                    <br />
                    <br />
                    <div style="text-align: center;">
                        <telerik:RadButton runat="server" ID="btnProcessVoid" Text="Process Void" OnClick="btnProcessVoid_Click"></telerik:RadButton>
                    </div>
                    <br/>
                    Void Invoice will also void Confirmation Letter. This process is irreversible.
                </ContentTemplate>
            </telerik:RadWindow>
        </asp:View>
    </asp:MultiView>

    <script>

        function recalculatePrice() {
            var txtLetterNo = $telerik.findControl(document.forms[0], "<%= txtConfirmationLetterNo.ClientID %>");
            var ntbPrice = $telerik.findControl(document.forms[0], "<%= ntbPrice.ClientID %>");
            var ntbTax = $telerik.findControl(document.forms[0], "<%= ntbTax.ClientID %>");
            var ntbPPH = $telerik.findControl(document.forms[0], "<%= ntbPPH.ClientID %>");
            var ntbDiscount = $telerik.findControl(document.forms[0], "<%= ntbDiscount.ClientID %>");
            var ntbTotalInvoice = $telerik.findControl(document.forms[0], "<%= ntbTotalInvoice.ClientID %>");
            var letterNo = txtLetterNo.get_value();

            var ajaxSvc = new Service.AjaxService();
            ajaxSvc.GetConfirmationLetterInfo(letterNo, function (data) {
                var totalPrice = 0;
                var ratePPN = data.RatePPN / 100;
                var ratePPH = data.RatePPH / 100;
                if (data.IsTaxed) {
                    ntbTax.set_value(ratePPN * (ntbPrice.get_value() - ntbDiscount.get_value()));
                    ntbPPH.set_value(ratePPH * (ntbPrice.get_value() - ntbDiscount.get_value()));
                } else {
                    ntbTax.set_value(0);
                    ntbPPH.set_value(0);
                }
                totalPrice = ntbPrice.get_value() - ntbDiscount.get_value() + ntbTax.get_value() - ntbPPH.get_value();
                ntbTotalInvoice.set_value(totalPrice);
            });
        }

        function LoadConfirmationLetterInfo() {
            var txtLetterNo = $telerik.findControl(document.forms[0], "<%= txtConfirmationLetterNo.ClientID %>");
            var ntbPrice = $telerik.findControl(document.forms[0], "<%= ntbPrice.ClientID %>");
            var ntbTax = $telerik.findControl(document.forms[0], "<%= ntbTax.ClientID %>");
            var ntbPPH = $telerik.findControl(document.forms[0], "<%= ntbPPH.ClientID %>");
            var ntbDiscount = $telerik.findControl(document.forms[0], "<%= ntbDiscount.ClientID %>");
            var ntbTotalInvoice = $telerik.findControl(document.forms[0], "<%= ntbTotalInvoice.ClientID %>");
            var dtpPaymentDueDate = $telerik.findControl(document.forms[0], "<%= dtpPaymentDueDate.ClientID %>");
            var ddlBank = $telerik.findControl(document.forms[0], "<%= ddlBank.ClientID %>");

            var ajaxSvc = new Service.AjaxService();
            var letterNo = txtLetterNo.get_value();

            ajaxSvc.GetConfirmationLetterInfo(letterNo, function (data) {
                ntbPrice.set_value(data.Price);
                ntbPPH.set_value(data.PPH);
                ntbTax.set_value(data.Tax);
                ntbDiscount.set_value(data.Discount);
                ntbTotalInvoice.set_value(data.TotalPrice);
                dtpPaymentDueDate.set_selectedDate(data.PaymentDueDate);
                
                if(data.BankID > 0)
                    ddlBank.findItemByValue(data.BankID).set_selected(true);
            });
        }

        function ModalPopUpShow() {
            $find("<%= txtVoidReason.ClientID %>").focus();
        }

        function btnVoidClick() {
            $find("<%= wndVoidReason.ClientID %>").show();
        }
    </script>
</asp:Content>
