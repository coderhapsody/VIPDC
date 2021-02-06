<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/MasterWorkspace.Master" AutoEventWireup="true" CodeBehind="EditTextTemplates.aspx.cs" Inherits="VIPDC.Web.EditTextTemplates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainTitle" runat="server">
    Text Templates
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMainContent" runat="server">
    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="RadMultiPage1">
        <Tabs>
            <telerik:RadTab runat="server" Text="Terms and Conditions" Selected="True" PageViewID="RadPageView1" />
            <%--<telerik:RadTab runat="server" PageViewID="RadPageView2" Text="Root RadTab2" />--%>
        </Tabs>

    </telerik:RadTabStrip>
    <div style="text-align: left;">
        <telerik:RadMultiPage ID="RadMultiPage1" runat="server">
            <telerik:RadPageView ID="RadPageView1" runat="server" Selected="True">
                <telerik:RadEditor runat="server" ID="redTerms" Width="100%">
                    <Tools>
                        <telerik:EditorToolGroup Tag="MainToolbar">
                            <telerik:EditorTool Name="Print" ShortCut="CTRL+P" />
                            <telerik:EditorTool Name="AjaxSpellCheck" />
                            <telerik:EditorTool Name="FindAndReplace" ShortCut="CTRL+F" />
                            <telerik:EditorTool Name="SelectAll" ShortCut="CTRL+A" />
                            <telerik:EditorTool Name="Cut" />
                            <telerik:EditorTool Name="Copy" ShortCut="CTRL+C" />
                            <telerik:EditorTool Name="Paste" ShortCut="CTRL+V" />
                            <telerik:EditorToolStrip Name="PasteStrip">
                            </telerik:EditorToolStrip>
                            <telerik:EditorSeparator />
                            <telerik:EditorSplitButton Name="Undo">
                            </telerik:EditorSplitButton>
                            <telerik:EditorSplitButton Name="Redo">
                            </telerik:EditorSplitButton>
                        </telerik:EditorToolGroup>
                        <telerik:EditorToolGroup Tag="InsertToolbar">
                            <telerik:EditorTool Name="ImageManager" ShortCut="CTRL+G" />
                            <telerik:EditorTool Name="DocumentManager" />
                            <telerik:EditorTool Name="FlashManager" />
                            <telerik:EditorTool Name="MediaManager" />
                            <telerik:EditorTool Name="TemplateManager" />
                            <telerik:EditorSeparator />
                            <telerik:EditorTool Name="LinkManager" ShortCut="CTRL+K" />
                            <telerik:EditorTool Name="Unlink" ShortCut="CTRL+SHIFT+K" />
                        </telerik:EditorToolGroup>
                        <telerik:EditorToolGroup>
                            <telerik:EditorTool Name="Superscript" />
                            <telerik:EditorTool Name="Subscript" />
                            <telerik:EditorTool Name="InsertParagraph" />
                            <telerik:EditorTool Name="InsertGroupbox" />
                            <telerik:EditorTool Name="InsertHorizontalRule" />
                            <telerik:EditorTool Name="InsertDate" />
                            <telerik:EditorTool Name="InsertTime" />
                            <telerik:EditorSeparator />
                            <telerik:EditorTool Name="FormatCodeBlock" />
                        </telerik:EditorToolGroup>
                        <telerik:EditorToolGroup>
                            <telerik:EditorDropDown Name="FormatBlock">
                            </telerik:EditorDropDown>
                            <telerik:EditorDropDown Name="FontName">
                            </telerik:EditorDropDown>
                            <telerik:EditorDropDown Name="RealFontSize">
                            </telerik:EditorDropDown>
                        </telerik:EditorToolGroup>
                        <telerik:EditorToolGroup>
                            <telerik:EditorTool Name="AbsolutePosition" />
                            <telerik:EditorSeparator />
                            <telerik:EditorTool Name="Bold" ShortCut="CTRL+B" />
                            <telerik:EditorTool Name="Italic" ShortCut="CTRL+I" />
                            <telerik:EditorTool Name="Underline" ShortCut="CTRL+U" />
                            <telerik:EditorTool Name="StrikeThrough" />
                            <telerik:EditorSeparator />
                            <telerik:EditorTool Name="JustifyLeft" />
                            <telerik:EditorTool Name="JustifyCenter" />
                            <telerik:EditorTool Name="JustifyRight" />
                            <telerik:EditorTool Name="JustifyFull" />
                            <telerik:EditorTool Name="JustifyNone" />
                            <telerik:EditorSeparator />
                            <telerik:EditorTool Name="Indent" />
                            <telerik:EditorTool Name="Outdent" />
                            <telerik:EditorSeparator />
                            <telerik:EditorTool Name="InsertOrderedList" />
                            <telerik:EditorTool Name="InsertUnorderedList" />
                            <telerik:EditorSeparator />
                            <telerik:EditorTool Name="ToggleTableBorder" />
                            <telerik:EditorTool Name="XhtmlValidator" />
                        </telerik:EditorToolGroup>
                        <telerik:EditorToolGroup>
                            <telerik:EditorSplitButton Name="ForeColor">
                            </telerik:EditorSplitButton>
                            <telerik:EditorSplitButton Name="BackColor">
                            </telerik:EditorSplitButton>
                            <telerik:EditorDropDown Name="ApplyClass">
                            </telerik:EditorDropDown>
                            <telerik:EditorToolStrip Name="FormatStripper">
                            </telerik:EditorToolStrip>
                        </telerik:EditorToolGroup>
                        <telerik:EditorToolGroup Tag="DropdownToolbar">
                            <telerik:EditorSplitButton Name="InsertSymbol">
                            </telerik:EditorSplitButton>
                            <telerik:EditorToolStrip Name="InsertTable">
                            </telerik:EditorToolStrip>
                            <telerik:EditorToolStrip Name="InsertFormElement">
                            </telerik:EditorToolStrip>
                            <telerik:EditorSplitButton Name="InsertSnippet">
                            </telerik:EditorSplitButton>
                            <telerik:EditorTool Name="ImageMapDialog" />
                            <telerik:EditorDropDown Name="InsertCustomLink">
                            </telerik:EditorDropDown>
                            <telerik:EditorSeparator />
                            <telerik:EditorTool Name="ConvertToLower" />
                            <telerik:EditorTool Name="ConvertToUpper" />
                            <telerik:EditorSeparator />
                            <telerik:EditorDropDown Name="Zoom">
                            </telerik:EditorDropDown>
                            <telerik:EditorSplitButton Name="ModuleManager">
                            </telerik:EditorSplitButton>
                            <telerik:EditorTool Name="ToggleScreenMode" ShortCut="F11" />
                            <telerik:EditorTool Name="AboutDialog" />
                        </telerik:EditorToolGroup>
                    </Tools>
                    <Content>
                    </Content>
                    <CssFiles>
        <telerik:EditorCssFile Value="~/EditorContentArea.css" />
    </CssFiles>
                    <TrackChangesSettings CanAcceptTrackChanges="False" />
                </telerik:RadEditor>                               
            </telerik:RadPageView>
            <%--        <telerik:RadPageView ID="RadPageView2" runat="server">
            test2
        </telerik:RadPageView>--%>
        </telerik:RadMultiPage>
    </div>
    <br/>
    <telerik:RadButton runat="server" ID="btnSave" Text="Save Templates" OnClick="btnSave_Click"></telerik:RadButton>        
</asp:Content>
