<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeBehind="Instituciones.aspx.cs" Inherits="PREDJL.Mantenimiento.Instituciones" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
  
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="PageToolbar">
  
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="Content" runat="server">
    <dx:ASPxLabel ID="MessageLabel" runat="server" Font-Bold="True" ForeColor="#CC0000" style="font-size: small" Visible="False"></dx:ASPxLabel>
    <%--<asp:Panel ID="Panel_Content" runat="server">--%>
 

    <script type="text/javascript">
        function convierteTextoAMayusculas(s, e) {
            s.inputElement.value = s.inputElement.value.toUpperCase();
        }
        //      function confirmation() {
        //    if (confirm("Desea seguir?")) {
        //        return true;
        //    }
        //    else {
        //        return false;
        //    }
        //}
        //      function OnEndCallback(s, e) {
        //          if (e.command == 'UPDATEEDIT') {
        //              alert(cp_success);
        //              delete cp_success;
        //          }
        //      }
        //      function OnCommand(sender, e) {

        //          if (e.get_commandName() == "UpdateCommand") {
        //              confirm("Do you want to update your record!!");
        //          }
        //      }
              function ShowTipoWindow() {
                  Tipo_Inst.Show();
              }


    </script>
    <div style="background-color: #FFFFFF">
        <h1 style="color: #006699; background-color: #FFFFFF; text-align: center">MANTENIMIENTO DE INSTITUCIONES</h1>
      <%--      <div style="display: flex;
                        justify-content: center">
                        <div style="padding: 5px; margin: 10px; ">
                                     <dx:ASPxButton ID="Popup_Tipo_Inst" runat="server" AutoPostBack="false" Text="AGREGAR TIPO DE INSTITUCIÓN" UseSubmitBehavior="false"  BackColor="#3498DB" Font-Bold="True" ForeColor="White">
                                         <ClientSideEvents Click="function(s, e) { ShowTipoWindow(); }" />
                                         <Image IconID="actions_addfile_16x16">
                                        </Image>
                                    </dx:ASPxButton>
                            </div>
              </div>--%>
        <dx:ASPxGridView ID="GV_Instituciones" runat="server"
       AutoGenerateColumns="False"  DataSourceID="SqlDataSourceInstituciones" KeyFieldName="Id" Style="margin-left: auto; margin-right: auto;" Theme="iOS"
             OnInitNewRow="GV_Instituciones_InitNewRow" OnRowUpdated="GV_Instituciones_RowUpdated" OnStartRowEditing="GV_Instituciones_StartRowEditing" OnRowInserted="GV_Instituciones_RowInserted">
              
<%-- OnRowDataBound="GridView1_RowDataBound"--%>
<%--                        <ClientSideEvents EndCallback ="function(s, e){ 
e.processOnServer = confirm('¿Esta seguro de guardar los datos?');
}" />--%>
   
<%--<ClientSideEvents EndCallback="OnCommand"/>--%>

             <SettingsEditing Mode="PopupEditForm">
            </SettingsEditing>
            <SettingsText PopupEditFormCaption="EDITAR DATOS DE LA INSTITUCIÓN" />
            <ClientSideEvents EndCallback="function(s, e) {
                        if (s.cpUpdateInstit) {
                            alert(s.cpUpdateInstit);
                                delete s.cpUpdateInstit;

                        }
                    }" />
            <SettingsAdaptivity AdaptivityMode="HideDataCells">
                <AdaptiveDetailLayoutProperties ColCount="1">
                </AdaptiveDetailLayoutProperties>
            </SettingsAdaptivity>
            <SettingsPager PageSize="8">
            </SettingsPager>

             <SettingsEditing UseFormLayout="True" EditFormColumnCount="2" />

            <Settings ShowFilterRow="True" />
            <SettingsBehavior ConfirmDelete="True" EnableRowHotTrack="True" />
            <SettingsCommandButton>
                <NewButton ButtonType="Button" RenderMode="Button">
                    <Image IconID="actions_add_16x16">
                    </Image>
                    <Styles>
                        <Style BackColor="White" ForeColor="Black" Width="40px">
                            <HoverStyle BackColor="#069BFF" Border-BorderColor="#0066FF">
                                <Border BorderColor="#0066FF" />
                            </HoverStyle>
                        </Style>
                    </Styles>
                </NewButton>
                <UpdateButton ButtonType="Button" RenderMode="Button" >
                    <Image IconID="actions_apply_16x16">
                    </Image>
                     <Styles>
                        <Style BackColor="White" ForeColor="Black" Width="30px">
                            <HoverStyle BackColor="#069BFF" Border-BorderColor="#0066FF">
                                <Border BorderColor="#0066FF" />
                            </HoverStyle>
                        </Style>
                    </Styles>
                </UpdateButton>
                <CancelButton ButtonType="Button" RenderMode="Button" >
                    <Image IconID="actions_cancel_16x16">
                    </Image>
                    <Styles>
                        <Style BackColor="White" ForeColor="Black" Width="30px">
                            <HoverStyle BackColor="#069BFF" Border-BorderColor="#0066FF">
                                <Border BorderColor="#0066FF" />
                            </HoverStyle>
                        </Style>
                    </Styles>
                </CancelButton>
                <EditButton>
                    <Image IconID="actions_editname_16x16">
                    </Image>
                </EditButton>
                <DeleteButton>
                    <Image IconID="actions_clear_16x16">
                    </Image>
                </DeleteButton>
            </SettingsCommandButton>

            <SettingsDataSecurity AllowDelete="False" AllowInsert="False" AllowEdit="False"></SettingsDataSecurity>

            <SettingsPopup>
                <EditForm Modal="True" HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter">
                </EditForm>
                <CustomizationWindow HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" />
                <FilterControl AutoUpdatePosition="False">
                </FilterControl>
            </SettingsPopup>
            
             <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
          
            <SettingsText CommandUpdate="Actualizar"/>

            <EditFormLayoutProperties ColCount="2" ColumnCount="2">
                <Items>
                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="NOMBRE DE LA INSTITUCI&#211;N" ColumnSpan="1">
                    </dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="SIGLAS" ColumnSpan="1">
                    </dx:GridViewColumnLayoutItem>
                <%--    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="REGI&#211;N" ColumnSpan="1">
                    </dx:GridViewColumnLayoutItem>--%>
                    <dx:GridViewColumnLayoutItem ColumnName="ACTIVE" ColSpan="1"></dx:GridViewColumnLayoutItem>
                    <dx:EditModeCommandLayoutItem ColSpan="2" ColumnSpan="2" HorizontalAlign="Center">
                    </dx:EditModeCommandLayoutItem>
                </Items>
            </EditFormLayoutProperties>

            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" ButtonRenderMode="Image" ButtonType="Image">
                    <%--  ButtonRenderMode="Button" ButtonType="Button" --%>

                    <HeaderStyle BackColor="#1F497D" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle ForeColor="#006699" HorizontalAlign="Center" Border-BorderColor="#CCCCCC">
                        <Border BorderColor="#CCCCCC" />
                    </CellStyle>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Id" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                    <EditFormSettings Visible="False"></EditFormSettings>

                    <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>

                    <CellStyle HorizontalAlign="Center" ForeColor="#006699"></CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CompanyName" VisibleIndex="2" Caption="NOMBRE DE LA INSTITUCI&#211;N">
                    <PropertiesTextEdit Width="350px">
                        <ValidationSettings ErrorDisplayMode="ImageWithText" ErrorTextPosition="Bottom" SetFocusOnError="True">
                            <RequiredField IsRequired="True" ErrorText="EL NOMBRE DE LA INSTITUCI&#211;N ES REQUERIDO"></RequiredField>
                        </ValidationSettings>
                    </PropertiesTextEdit>


                    <HeaderStyle BackColor="#1F497D" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Justify">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="SIGLAS" FieldName="Acronym" VisibleIndex="3" Width="300px">
                    <PropertiesTextEdit Width="100px">
                        <ClientSideEvents KeyUp="function(s, e) { convierteTextoAMayusculas(s, e); }"></ClientSideEvents>

                        <ValidationSettings SetFocusOnError="True">
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <HeaderStyle BackColor="#1F497D" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
               <%-- <dx:GridViewDataTextColumn Caption="REGI&#211;N" FieldName="Region" VisibleIndex="4">
                    <HeaderStyle BackColor="#1F497D" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>--%>
                <dx:GridViewDataCheckColumn FieldName="Active" Caption="ACTIVE" VisibleIndex="5">
                     <HeaderStyle BackColor="#1F497D" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataCheckColumn>


            </Columns>
            <Toolbars>
                <dx:GridViewToolbar Enabled="true">
                    <Items>
                        <dx:GridViewToolbarItem Command="ExportToXls"  Text="EXPORTAR A EXCEL">
                        </dx:GridViewToolbarItem>
                    </Items>
                </dx:GridViewToolbar>
            </Toolbars>


              <Styles>
                  <RowHotTrack BackColor="#def7ff">
                  </RowHotTrack>
            <AlternatingRow Enabled="true" />
            <EditFormDisplayRow BackColor="#def7ff"></EditFormDisplayRow>
                  <EditForm BackColor="#def7ff">
                  </EditForm>
        </Styles>
            <Border BorderColor="Aqua" BorderStyle="Outset" />
        </dx:ASPxGridView>

        <%--<asp:SqlDataSource ID="SqlDataSource_Tipo_Instituc" runat="server" ConnectionString="<%$ ConnectionStrings:DB_PARTICIPACIONConnectionString %>" SelectCommand="SELECT * FROM [tblTipoInstituciones]"></asp:SqlDataSource>--%>

       <%-- <asp:SqlDataSource ID="SqlDataSourceInstituciones" runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [CompanyName], [Acronym], [Active], [Id] FROM [View_company]">
        </asp:SqlDataSource>--%>
          <asp:SqlDataSource ID="SqlDataSourceInstituciones" runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [CompanyName], [Acronym], [Active], [Id] FROM [Company]">
  </asp:SqlDataSource>
         </div>

    <dx:ASPxPopupControl ID="Tipo_Inst" runat="server" Width="400px"  Modal="True" CloseAction="CloseButton" CloseOnEscape="true"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"   ClientInstanceName="Tipo_Inst"
        HeaderText="TIPOS DE INSTITUCIONES" AllowDragging="True" PopupAnimationType="None"  EnableViewState="False" Height="200px" AutoUpdatePosition="true">
          <ClientSideEvents Closing="function(s, e) {
        ASPxClientEdit.ClearEditorsInContainerById('PopupCollection');
    }" />
        <ContentCollection>
               
            <dx:PopupControlContentControl runat="server">
                <div id="PopupCollection">
                            <div style="text-align: left">
                                <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="1">
                                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                                    </SettingsAdaptivity>
                                    <Items>
                                        <dx:LayoutGroup Caption="" ColCount="1" ColSpan="1">
                                            <Items>
                                                <dx:LayoutItem Caption="TIPO DE INSTITUCIÓN:" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox ID="txtTipo_Institucion" runat="server" Width="200px">
                                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                                                    <RequiredField ErrorText="EL CAMPO TIPO DE INSTITUCIÓN ES REQUERIDO." IsRequired="True" />
                                                                </ValidationSettings>
                                                            </dx:ASPxTextBox>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                            </Items>
                                        </dx:LayoutGroup>
                                         <dx:LayoutItem ShowCaption="False" Paddings-PaddingTop="19">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <table>
                                         <tr>
                        <td style="width: 159px">
                            <dx:ASPxButton ID="btnGuarda_Tipo_Institucion" runat="server" AutoPostBack="True" Style="float: left; margin-right: 8px" Text="Guardar" Width="170px" OnClick="btnGuarda_Tipo_Institucion_Click"
                                  >
                             <Image IconID="actions_apply_16x16">
                                </Image>

                            </dx:ASPxButton>
                                </td>
                                <td style="width: 159px; text-align: right;">
                                    <dx:ASPxButton ID="Cancelar" runat="server" AutoPostBack="False" Style="float: left; margin-right: 8px" Text="Cancelar" Width="170px">
                                                <ClientSideEvents Click="function(s, e) {
                                                 ASPxClientEdit.ClearEditorsInContainer(null);
                                                                 }" />
                                        <ClientSideEvents Click="function(s, e) { Tipo_Inst.Hide(); }" />
                                        <Image IconID="spreadsheet_removepivotfield_16x16">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                                        </table>   
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                        <Paddings PaddingTop="19px" />
                                    </dx:LayoutItem>
                                    </Items>
                                </dx:ASPxFormLayout>
                            </div>
                            <br />
                                 </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
            <HeaderImage IconID="actions_insert_32x32">
            </HeaderImage>
        <ContentStyle>
            <Paddings PaddingBottom="7px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
            </asp:Panel>
<%--    </div>--%>
</asp:Content>

<%--<asp:Content runat="server" ContentPlaceHolderID="LeftPanelContent">
    <h3 class="leftpanel-section section-caption">Filters</h3>
    <dx:ASPxNavBar runat="server" ID="FiltersNavBar" ClientInstanceName="filtersNavBar"
        AllowSelectItem="true" ShowGroupHeaders="false"
        Width="100%" CssClass="filters-navbar">
        <ItemStyle CssClass="item" />
        <Groups>
            <dx:NavBarGroup>
                <Items>
                    <dx:NavBarItem Text="All" Selected="true" Name="All" />
                    <dx:NavBarItem Text="Active issues" Name="Active" />
                    <dx:NavBarItem Text="Bugs" Name="Bugs" />
                    <dx:NavBarItem Text="Suggestions" Name="Suggestions" />
                    <dx:NavBarItem Text="High priority" Name="HighPriority" />
                </Items>
            </dx:NavBarGroup>
        </Groups>
        <ClientSideEvents ItemClick="onFiltersNavBarItemClick" />
    </dx:ASPxNavBar>
</asp:Content>--%>

<%--<asp:Content runat="server" ContentPlaceHolderID="RightPanelContent">
    <div class="settings-content">
        <h2>Settings</h2>
        <p>Place your content here</p>
    </div>
</asp:Content>--%>