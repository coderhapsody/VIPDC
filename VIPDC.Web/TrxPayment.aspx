<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="TrxPayment.aspx.cs" Inherits="VIPDC.Web.TrxPayment" StylesheetTheme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <style type="text/css">
        .auto-style3 {
            width: 177px;
        }

        .auto-style4 {
            width: 4px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Payment
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <asp:MultiView runat="server" ID="mvwForm">
        <asp:View runat="server" ID="viwRead">
            <fieldset>
                <table class="fullwidth noborder">
                    <tr>
                        <td class="auto-style3">Invoice Month / Year</td>
                        <td class="auto-style4">:</td>
                        <td>
                            <telerik:RadMonthYearPicker runat="server" ID="mypFindInvoice"></telerik:RadMonthYearPicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Customer</td>
                        <td class="auto-style4">:</td>
                        <td>
                            <telerik:RadTextBox runat="server" ID="txtFindCustomer"></telerik:RadTextBox>
                            &nbsp;&nbsp;
                            <asp:CheckBox runat="server" ID="chkActiveOnly" Text="Only outstanding invoices" />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3"></td>
                        <td class="auto-style4"></td>
                        <td>
                            <telerik:RadButton runat="server" ID="btnSearch" Text="Search" OnClick="btnSearch_Click"></telerik:RadButton>
                            <asp:Label runat="server" ID="lblStatus" EnableViewState="false"></asp:Label>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />
            <br />
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" CellSpacing="0" DataSourceID="sdsMaster" GridLines="None" ShowGroupPanel="True" AutoGenerateColumns="False" OnItemCommand="RadGrid1_ItemCommand" GroupingSettings-CaseSensitive="false">
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
                        <telerik:GridBoundColumn DataField="InvoiceNo" FilterControlAltText="Filter InvoiceNo column" HeaderText="Invoice No" SortExpression="InvoiceNo" UniqueName="InvoiceNo">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Date" FilterControlAltText="Filter Date column" HeaderText="Date" SortExpression="Date" UniqueName="Date" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy}">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="LetterNo" FilterControlAltText="Filter LetterNo column" HeaderText="Letter No" SortExpression="LetterNo" UniqueName="LetterNo">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CustomerCode" FilterControlAltText="Filter CustomerCode column" HeaderText="Customer Code" SortExpression="CustomerCode" UniqueName="CustomerCode">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CustomerName" FilterControlAltText="Filter CustomerName column" HeaderText="Customer Name" SortExpression="CustomerName" UniqueName="CustomerName">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridCheckBoxColumn DataField="Void" DataType="System.Boolean" FilterControlAltText="Filter Void column" HeaderText="Void" ReadOnly="True" SortExpression="Void" UniqueName="Void">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridBoundColumn DataField="TotalPrice" DataType="System.Decimal" FilterControlAltText="Filter TotalPrice column" HeaderText="TotalPrice" SortExpression="TotalPrice" UniqueName="TotalPrice" DataFormatString="{0:###,##0.00}">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="PaymentAmount" DataType="System.Decimal" FilterControlAltText="Filter PaymentAmount column" HeaderText="PaymentAmount" SortExpression="PaymentAmount" UniqueName="PaymentAmount" DataFormatString="{0:###,##0.00}">
                            <ColumnValidationSettings>
                                <ModelErrorMessage Text="" />
                            </ColumnValidationSettings>
                        </telerik:GridBoundColumn>
                        <telerik:GridCheckBoxColumn DataField="FullPaid" DataType="System.Boolean" FilterControlAltText="Filter FullPaid column" HeaderText="FullPaid" ReadOnly="True" SortExpression="FullPaid" UniqueName="FullPaid">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="lnbCreatePayment" Text="Create Payment" CommandArgument='<%# Eval("ID") %>' CommandName="EditRow"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Width="20px" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <asp:SqlDataSource ID="sdsMaster" runat="server" ConnectionString="<%$ ConnectionStrings:VIPDCConnectionString %>" SelectCommand="proc_GetInvoicesForPayment" SelectCommandType="StoredProcedure" OnSelecting="sdsMaster_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="InvoiceMonth" Type="Int32" />
                    <asp:Parameter Name="InvoiceYear" Type="Int32" />
                    <asp:Parameter Name="Customer" Type="String" />
                    <asp:Parameter Name="OnlyOutstandingInvoices" Type="Boolean" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:View>
        <asp:View runat="server" ID="viwAddEdit">
            <div>
                <vipdc:InvoiceDetail ID="InvoiceDetail1" runat="server" />
            </div>
            <div>
                <br />
                <fieldset>
                    <table>
                        <tr>
                            <td class="style34">
                                <b>Payment Type</b></td>
                            <td class="style33">
                                <b>Amount</b></td>
                            <td class="style28">
                                <b>Approval Code</b></td>
                            <td class="style28">
                                <b>Notes</b></td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style34">
                                <telerik:RadDropDownList ID="ddlPaymentType" runat="server" ValidationGroup="Payment" DefaultMessage="Select Payment Type" SelectedText="Cash" SelectedValue="Cash">
                                    <Items>
                                        <telerik:DropDownListItem runat="server" Text="Cash" Value="Cash" />
                                        <telerik:DropDownListItem runat="server" Text="Debit" Value="Debit" />
                                        <telerik:DropDownListItem runat="server" Text="Transfer" Value="Transfer" />
                                        <telerik:DropDownListItem runat="server" Text="Cheque" Value="Cheque" />
                                        <telerik:DropDownListItem runat="server" Text="Credit Card" Value="CreditCard" />
                                        <telerik:DropDownListItem runat="server" Text="Voucher" Value="Voucher" />
                                        <telerik:DropDownListItem runat="server" Text="Waive" Value="Waive" />                                        
                                    </Items>
                                </telerik:RadDropDownList>
                            </td>
                            <td class="style33">
                                <telerik:RadNumericTextBox ID="ntbAmount" runat="server" ValidationGroup="Payment">
                                </telerik:RadNumericTextBox>
                            </td>
                            <td class="style28">
                                <telerik:RadTextBox ID="txtApprovalCode" runat="server" ValidationGroup="Payment" Width="150px">
                                </telerik:RadTextBox>
                            </td>
                            <td class="style28">
                                <telerik:RadTextBox ID="txtPaymentNotes" runat="server" MaxLength="300" Width="250px">
                                </telerik:RadTextBox>
                            </td>
                            <td>
                                <telerik:RadButton ID="btnAddPayment" runat="server" OnClick="btnAddPayment_Click" Text="Add Payment" ValidationGroup="Payment" />
                            </td>
                            <td>&nbsp; </td>
                        </tr>
                        <tr>
                            <td class="style34">
                                <asp:RequiredFieldValidator CssClass="errorMessage" ID="rqvPaymentType" runat="server" ControlToValidate="ddlPaymentType" SetFocusOnError="True" ValidationGroup="Payment" ErrorMessage="<b>Payment Type</b> must be specified" EnableViewState="False" />
                            </td>
                            <td class="style33">
                                <asp:RequiredFieldValidator ID="rqvPaymentType0" runat="server" ControlToValidate="ntbAmount" CssClass="errorMessage" EnableViewState="False" ErrorMessage="&lt;b&gt;Amount&lt;/b&gt; must be specified" SetFocusOnError="True" ValidationGroup="Payment" />
                            </td>
                            <td class="style28">&nbsp;</td>
                            <td class="style28">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </fieldset>
                <br />
                <telerik:RadGrid ID="RadGridPayment" runat="server" AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnItemCommand="RadGridPayment_ItemCommand" OnItemDataBound="RadGridPayment_ItemDataBound" Width="800px">
                    <MasterTableView AutoGenerateColumns="False">
                        <Columns>
                            <telerik:GridBoundColumn UniqueName="PaymentType" DataField="PaymentType" HeaderText="PaymentType" />
                            <telerik:GridBoundColumn UniqueName="Amount" DataField="Amount" HeaderText="Amount" DataFormatString="{0:###,##0.00}" />
                            <telerik:GridBoundColumn UniqueName="PaymentDate" DataField="PaymentDate" HeaderText="PaymentDate" DataFormatString="{0:dd/MM/yyyy}" />
                            <telerik:GridBoundColumn UniqueName="ApprovalCode" DataField="ApprovalCode" HeaderText="ApprovalCode" />
                            <telerik:GridBoundColumn UniqueName="Notes" DataField="Notes" HeaderText="Notes" />
                            <telerik:GridTemplateColumn AllowFiltering="false" Groupable="false" ItemStyle-Width="20px">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="lnbAction" Text="Action" CommandArgument='<%# Eval("ID") %>' CommandName="Action"  ></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="20px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
                <br />
                Total Payment:
                <asp:Label ID="lblTotalPayment" runat="server" Font-Bold="True" />
                <br />
                <br />
                <telerik:RadButton runat="server" ID="btnSave" Text="Save" OnClick="btnSave_Click"></telerik:RadButton>
                &nbsp;&nbsp;&nbsp;
                <telerik:RadButton runat="server" ID="btnCancel" Text="Cancel" OnClick="btnCancel_Click"></telerik:RadButton>
            </div>

            <telerik:RadWindow runat="server" ID="wndVoidReason" Title="Enter Void Reason" Width="500px" Height="250px" Modal="true" VisibleStatusbar="False" Behaviors="Close" InitialBehaviors="Close" OnClientShow="ModalPopUpShow" ReloadOnShow="True">
                <ContentTemplate>
                    <table style="width:300px; text-align: left;">
                        <tr>
                            <td style="text-align: right;">Payment Type</td>
                            <td>:</td>
                            <td><span id="paymentType"></span></td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">Amount</td>
                            <td>:</td>
                            <td><span id="amount"></span></td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">Notes</td>
                            <td>:</td>
                            <td><span id="notes"></span></td>
                        </tr>
                    </table>                    
                    <br />
                    <telerik:RadTextBox runat="server" ID="txtVoidReason" TextMode="MultiLine" Width="400px" Rows="5"></telerik:RadTextBox>
                    <br />                    
                    <br/>
                    <asp:HiddenField runat="server" ID="hidPaymentID" />
                    <div style="text-align: center;">
                        <telerik:RadButton runat="server" ID="btnProcessVoid" Text="Process Void" OnClick="btnProcessVoid_Click"></telerik:RadButton>
                    </div>
                </ContentTemplate>
            </telerik:RadWindow>
        </asp:View>

    </asp:MultiView>

    <script>
        function ConfirmVoid(paymentID, paymentType, amount, notes) {
            $get("paymentType").innerHTML = paymentType;
            $get("notes").innerHTML = notes;
            $get("amount").innerHTML = amount;
            $get("<%= hidPaymentID.ClientID %>").value = paymentID;
            $find("<%= wndVoidReason.ClientID %>").show();

            return false;
        }

        function ModalPopUpShow() {
            $find("<%= txtVoidReason.ClientID %>").focus();
        }
    </script>
</asp:Content>
