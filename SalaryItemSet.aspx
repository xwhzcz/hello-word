<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalaryItemSet.aspx.cs" Inherits="DigitalSystem.SalaryManagement.SalaryItemSet" %>

<%@ Register Assembly="DevExpress.Web.v10.2, Version=10.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v10.2, Version=10.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v10.2, Version=10.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v10.2, Version=10.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxSplitter" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v10.2, Version=10.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxSplitter" TagPrefix="dx1" %>

<%@ Register Assembly="DevExpress.Web.v10.2, Version=10.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

</head>

<body>
    <script type="text/javascript">
        function btnReordor_click() {
            document.getElementById("new_and_ban").style.display = "none";
            document.getElementById("reordor").style.display = "block";
        }
        function btnNew_click() {
            document.getElementById("new_and_ban").style.display = "block";
            document.getElementById("reordor").style.display = "none";
        }
        function up() {

            var listbox = window.document.getElementById("<%=Project_ListBox.ClientID%>");
            if (listbox.selectedIndex > 0) {
                var idx = listbox.selectedIndex;
                var selText = listbox.options[idx].text;
                var selVal = listbox.options[idx].value;

                listbox.options[idx].text = (idx+1) + "  " + cut(listbox.options[idx - 1].text);
                listbox.options[idx - 1].text = (idx) + "  " + cut(selText);
                listbox.options[idx].value = listbox.options[idx - 1].value;
                listbox.options[idx - 1].value = selVal;
                listbox.selectedIndex = listbox.selectedIndex - 1;

                var str = "";
                for (var i = 0; i < listbox.options.length; i++)
                    str += listbox.options[i].value + ",";
                //delCookie("order_list");
                document.cookie = "order_list = " + str;
            }
        }
        function down() {

            var listbox = window.document.getElementById("<%=Project_ListBox.ClientID%>");
            if (listbox.selectedIndex >= 0) {
                var idx = listbox.selectedIndex;
                var selText = listbox.options[idx].text;
                var selVal = listbox.options[idx].value;

                listbox.options[idx].text = (idx + 1) + "  " + cut(listbox.options[idx + 1].text);
                listbox.options[idx + 1].text = (idx + 2) + "  " + cut(selText);
                listbox.options[idx].value = listbox.options[idx + 1].value;
                listbox.options[idx + 1].value = selVal
                listbox.selectedIndex = listbox.selectedIndex + 1;
                
                //var order = document.getElementById("order");
                //order.innerHTML = "";
                var str = "";
                for (var i = 0; i < listbox.options.length; i++)
                    str += listbox.options[i].value + ",";
                //delCookie("order_list");
                document.cookie = "order_list = " + str;
            }
        }
        function delCookie(name) {//为了删除指定名称的cookie，可以将其过期时间设定为一个过去的时间 
            var date = new Date();
            date.setTime(date.getTime() - 10000);
            document.cookie = name + "=v; expires=" + date.toGMTString();
        }
        function new_click() {
            NewPro.Show();
        }

        function cut(str) {
            var i = str.length - 1;
            while (str.charAt(i) != ' ')
                i--;
            return str.substring(i+1);
        }

    </script>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxSplitter ID="mainsplitter" runat="server" Height="900px" Width="100%" FullscreenMode="True" Style="margin-bottom: 0px" ClientIDMode="AutoID">
                <Panes>
                    <dx:SplitterPane Name="left" ScrollBars="Auto" ShowCollapseBackwardButton="True"
                        ShowCollapseForwardButton="True" Size="30%">
                        <Panes>
                            <dx:SplitterPane Name="editOption" Size="50">
                                <ContentCollection>
                                    <dx:SplitterContentControl ID="SplitterContentControl1" runat="server" SupportsDisabledAttribute="True">
                                        <table>
                                            <tr>

                                                <td>
                                                    <dx:ASPxButton ID="btnNew" runat="server" Text="新建/禁用工资项" Wrap="False" AutoPostBack="False">
                                                        <ClientSideEvents Click="btnNew_click" />
                                                    </dx:ASPxButton>
                                                </td>

                                                <td>
                                                    <%--<dx:ASPxButton ID="btnBan" runat="server" Text="禁用工资项" Wrap="False" AutoPostBack="False">
                                                        <ClientSideEvents Click="btnBan_click" />
                                                    </dx:ASPxButton>--%>
                                                </td>

                                                <td>
                                                    <dx:ASPxButton ID="btnReordor" runat="server" Text="调整工资项顺序" Wrap="False" AutoPostBack="False">
                                                        <ClientSideEvents Click="btnReordor_click" />
                                                    </dx:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </dx:SplitterContentControl>
                                </ContentCollection>
                            </dx:SplitterPane>

                            <dx:SplitterPane Name="editArea" ScrollBars="Auto" ShowCollapseBackwardButton="True">
                                <ContentCollection>
                                    <dx:SplitterContentControl ID="SplitterContentControl2" runat="server" SupportsDisabledAttribute="True" >
                                        <div id="reordor" style="display:none">
                                            <table align="center">
                                                <tr>
                                                    <td>
                                                        <asp:listbox id="Project_ListBox" runat="server" selectionmode="single" height="300px"></asp:listbox>
                                                        <%--<dx:ASPxListBox ID="Project_ListBox" runat="server" SelectionMode="Single" Height="300px"></dx:ASPxListBox>--%>
                                                    </td>
                                                    <td>
                                                        <button type="button" onclick="up()"><img src="~/images/up.ico" /></button>
                                                        <%--<dx:ASPxButton ID="btnNodeUp" runat="server" Image-Url="~/images/up.ico" OnClick="btnNodeUp_click">
                                                            <Image Url="~/images/up.ico">
                                                            </Image>
                                                        </dx:ASPxButton>--%>
                                                        <div style="height: 20px; text-align: center;">
                                                        </div>
                                                        <dx:ASPxButton ID="btnRefresh" runat="server" Text="同步" OnClick="btnRefresh_click">
                                                        </dx:ASPxButton>
                                                        <div style="height: 20px; text-align: center;">
                                                        </div>
                                                        <button type="button" onclick="down()"><img src="~/images/down.ico" /></button>
                                                       <%-- <dx:ASPxButton ID="btnNodeDown" runat="server" Image-Url="~/images/down.ico" Wrap="False" AutoPostBack="False" OnClick="btnNodeDown_click">
                                                            <Image Url="~/images/down.ico"></Image>
                                                        </dx:ASPxButton>--%>
                                                    </td>
                                                </tr>     
                                            </table>
                                        </div>

                                        <div id="new_and_ban" style="height:100%">
                                           
                                            
                                            <dx:ASPxSplitter ID="ASPxSplitter1" runat="server" Orientation="Vertical" Height="100%" Styles-Pane-Paddings-Padding="0px">
                                                <Panes>
                                                    <dx:SplitterPane><ContentCollection>
                                            <dx:SplitterContentControl runat="server" SupportsDisabledAttribute="True">
                                                 <dx:aspxgridview id="useGV" runat="server" align="center" Width="100%" autogeneratecolumns="false" KeyFieldName="sm_id" OnPageIndexChanging="new_and_ban_PageIndexChanging">
                                                                                            <ClientSideEvents CustomButtonClick="function(s, e) {
	                                                                                            NewPro.Show();
                                                                                            }" />
                                                    <columns>
                                                        <dx:gridviewdatatextcolumn fieldname="sm_id" readonly="true" showincustomizationform="true" visibleindex="0" Visible="False" >
                                                            <EditFormSettings Visible="False" />
                                                        </dx:gridviewdatatextcolumn>
                                                        <dx:GridViewDataTextColumn Caption="已启用工资项" FieldName="sm_project" ShowInCustomizationForm="True" VisibleIndex="1">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="sm_serial_number" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataCheckColumn FieldName="sm_use" ShowInCustomizationForm="True" Visible="False" VisibleIndex="3" ReadOnly="false">
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewDataCheckColumn FieldName="sm_enname" ShowInCustomizationForm="True" Visible="False" VisibleIndex="4" ReadOnly="false">
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewCommandColumn Caption="新建/禁用" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="5" >
                                                        
                            
                                                            <ClearFilterButton Visible="True">
                                                            </ClearFilterButton>
                                                            <CustomButtons>
                                                                <dx:GridViewCommandColumnCustomButton Text="新建">
                                                                </dx:GridViewCommandColumnCustomButton>
                                                            </CustomButtons>
                                                        </dx:GridViewCommandColumn>
                                                    </columns>
                                                
                                                
                                                    <SettingsText EmptyDataRow="无数据显示" />
                                                    <SettingsPager>
                                                        <Summary Text="第{0}页  共{1}页 (共{2} 项)" />
                                                    </SettingsPager>
                                                </dx:aspxgridview>
                                                
                                            </dx:SplitterContentControl>
                                            </ContentCollection>
                                                    </dx:SplitterPane>

                                                    <dx:SplitterPane><ContentCollection>
                                                        <dx:SplitterContentControl runat="server" SupportsDisabledAttribute="True">
                                                     <dx:aspxgridview id="banGV" runat="server" align="center" Width="100%" autogeneratecolumns="false" KeyFieldName="sm_id" OnPageIndexChanging="new_and_ban_PageIndexChanging">
                                                                                            <ClientSideEvents CustomButtonClick="function(s, e) {
	                                                                                            NewPro.Show();
                                                                                            }" />
                                                    <columns>
                                                        <dx:gridviewdatatextcolumn fieldname="sm_id" readonly="true" showincustomizationform="true" visibleindex="0" Visible="False" >
                                                            <EditFormSettings Visible="False" />
                                                        </dx:gridviewdatatextcolumn>
                                                        <dx:GridViewDataTextColumn Caption="已禁用工资项" FieldName="sm_project" ShowInCustomizationForm="True" VisibleIndex="1">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="sm_serial_number" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataCheckColumn FieldName="sm_use" ShowInCustomizationForm="True" Visible="False" VisibleIndex="3" ReadOnly="false">
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewDataCheckColumn FieldName="sm_enname" ShowInCustomizationForm="True" Visible="False" VisibleIndex="4" ReadOnly="false">
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewCommandColumn Caption="新建/启用" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="5" >
                                                        
                            
                                                            <ClearFilterButton Visible="True">
                                                            </ClearFilterButton>
                                                            <CustomButtons>
                                                                <dx:GridViewCommandColumnCustomButton Text="新建">
                                                                </dx:GridViewCommandColumnCustomButton>
                                                            </CustomButtons>
                                                        </dx:GridViewCommandColumn>
                                                    </columns>
                                                
                                                
                                                    <SettingsText EmptyDataRow="无数据显示" />
                                                    <SettingsPager>
                                                        <Summary Text="第{0}页  共{1}页 (共{2} 项)" />
                                                    </SettingsPager>
                                                    </dx:aspxgridview>

                                                        </dx:SplitterContentControl>
                                                        </ContentCollection>
                                                    </dx:SplitterPane>
                                                    <dx:SplitterPane PaneStyle-Paddings-Padding="0px" Size="25" PaneStyle-Paddings-PaddingBottom="0px">
                                                        <PaneStyle>
                                                        <Paddings Padding="0px" PaddingBottom="0px" ></Paddings>
                                                        </PaneStyle>
                                                        <ContentCollection>
                                                            <dx:SplitterContentControl>
                                                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="同步" align="center" Paddings-PaddingBottom="0px" Width="100%" OnClick="new_ban_refresh">
<Paddings PaddingBottom="0px"></Paddings>
                                                                </dx:ASPxButton>
                                                            </dx:SplitterContentControl>
                                                        </ContentCollection>
                                                    </dx:SplitterPane>
                                                </Panes>

<Styles>
<Pane>
<Paddings Padding="0px"></Paddings>
</Pane>
</Styles>
                                            </dx:ASPxSplitter>
                                            
                                        </div>
                                       
                                    </dx:SplitterContentControl>
                                </ContentCollection>
                            </dx:SplitterPane>
                        </Panes>

                            <%--<ContentCollection>
                                <dx:SplitterContentControl runat="server" SupportsDisabledAttribute="True"></dx:SplitterContentControl>
                            </ContentCollection>--%>

                    <ContentCollection>
                    <dx:SplitterContentControl runat="server" SupportsDisabledAttribute="True"></dx:SplitterContentControl>
                    </ContentCollection>

                    </dx:SplitterPane>


                    <dx:SplitterPane Name="right" ScrollBars="Auto" ShowCollapseBackwardButton="True" ContentUrl="Preview.aspx"
                        ShowCollapseForwardButton="True">
                        <ContentCollection>
                            <dx:SplitterContentControl runat="server" SupportsDisabledAttribute="True"></dx:SplitterContentControl>
                        </ContentCollection>
                    </dx:SplitterPane>
                    
                </Panes>
            </dx:ASPxSplitter>

            <dx:ASPxPopupControl ID="NewProject" runat="server" CloseAction="CloseButton" Modal="True" Width="300"
                PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="NewPro"
                HeaderText="新建工资项" AllowDragging="True" EnableAnimation="False" EnableViewState="False" >
                <%--<ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('NewDeptGroup'); NewDepartmentName.Focus(); }" />--%>
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server" SupportsDisabledAttribute="True" >
                        <dx:ASPxPanel ID="ASPxPanel1" runat="server" ClientIDMode="AutoID"
                            Width="207px">
                            <PanelCollection>
                                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                                    <table cellpadding="0" cellspacing="0" style="width: 132%">
                                        <tr>

                                            <td valign="top">
                                                <dx:ASPxLabel ID="NameLabel" runat="server" Text="项目中文名称:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="pcmCellText">
                                                <dx:ASPxTextBox ID="cn_name" runat="server" Width="150px" ClientInstanceName="cn_ProjectName">
                                                    <ValidationSettings ValidationGroup="NewProjectGroup" Display="Dynamic"
                                                        ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="True">
                                                        <RequiredField ErrorText="项目名称不能为空" IsRequired="True" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td rowspan="4">
                                                <div class="pcmSideSpacer">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>

                                            <td valign="top">
                                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="项目英文名称:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="pcmCellText">
                                                <dx:ASPxTextBox ID="en_name" runat="server" Width="150px" ClientInstanceName="en_ProjectName">
                                                    <ValidationSettings ValidationGroup="NewProjectGroup" Display="Dynamic"
                                                        ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="True">
                                                        <RequiredField ErrorText="项目名称不能为空" IsRequired="True" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td rowspan="4">
                                                <div class="pcmSideSpacer">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="pcmCellCaption" valign="top">
                                                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="是否启用:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="pcmCellText">
                                                <dx:ASPxRadioButton ID="used" runat="server" GroupName="if_use" Checked="true" Text="是"></dx:ASPxRadioButton>
                                            </td>
                                            <td class="pcmCellText">
                                                <dx:ASPxRadioButton ID="baned" runat="server" GroupName="if_use" Text="否"></dx:ASPxRadioButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div class="pcmButton">
                                                    <table width="100%" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td align="right">
                                                                <dx:ASPxButton ID="btOK" runat="server" Text="确认" Width="80px"
                                                                    AutoPostBack="False" OnClick="btnNew_click" ValidationGroup="NewProjectGroup">
                                                                    <%--<ClientSideEvents Click="function(s, e) { NewPro.Hide(); }" />--%>
                                                                    <ClientSideEvents Click="function(s, e) {if(!ASPxClientEdit.ValidateGroup('NewProjectGroup')){e.processOnServer = false; }else{NewPro.Hide();} }" />

                                                                </dx:ASPxButton>
                                                            </td>
                                                            <td>
                                                                <div style="width: 8px;">
                                                                </div>
                                                            </td>
                                                            <td align="left">
                                                                <dx:ASPxButton ID="btCancel" runat="server" Text="取消" Width="80px" AutoPostBack="False">
                                                                    <ClientSideEvents Click="function(s, e) { NewPro.Hide(); }" />
                                                                </dx:ASPxButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxPanel>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>



           
        </div>
    </form>
</body>
</html>
