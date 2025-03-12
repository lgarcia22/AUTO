<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeBehind="Informes.aspx.cs" Inherits="PREDJL.Mantenimiento.Informes" %>

<asp:Content runat="server" ContentPlaceHolderID="Head">
  <script type="text/javascript">
      //para guardar los docuementos
      function Click_Add_Dtos(s, e) {
          ASPxCallback_Guardar_Dctos.PerformCallback();
          ASPxGridView1.PerformCallback();

      }


      function Guardar_Dctos_Complete(s, e) {
          ASPxGridView1.PerformCallback();
          /*  *//* alert(e.result);*/
          Informe.SetText(null);
          
          deleteFileButton.SetVisible(false);
          AddFileButton.SetVisible(false);

          return;
      }

      function onFileUploadComplete(s, e) {
          if (e.callbackData != "") {
              Informe.SetText(e.callbackData);
             
              deleteFileButton.SetVisible(true);
              AddFileButton.SetVisible(true);
          }
      }

      function onClick(s, e) {
          callback.PerformCallback(fileNameLabel.GetText());
      }
      function onCallbackComplete(s, e) {
          if (e.result == "OK") {
              Informe.SetText(null);
             
              deleteFileButton.SetVisible(false);
              AddFileButton.SetVisible(false);
          }
      }

  </script>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="PageToolbar">
  
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="Content" runat="server">
    <dx:ASPxLabel ID="MessageLabel" runat="server" Font-Bold="True" ForeColor="#CC0000" style="font-size: small" Visible="False"></dx:ASPxLabel>
    <asp:Panel ID="Panel_Content" runat="server">
 

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
        <br />
        <h1 style="color: #006699; background-color: #FFFFFF; text-align: center">MANTENIMIENTO DE INFORMES</h1>
            <div style="display: flex;
                        justify-content: center">
                        <div style="padding: 5px; margin: 10px; ">
                                     <dx:ASPxButton ID="Popup_Tipo_Inst" runat="server" AutoPostBack="false" Text="AGREGAR AÑO" UseSubmitBehavior="false"  BackColor="#3498DB" Font-Bold="True" ForeColor="White">
                                         <ClientSideEvents Click="function(s, e) { ShowTipoWindow(); }" />
                                         <Image IconID="actions_addfile_16x16">
                                        </Image>
                                    </dx:ASPxButton>
                            </div>
              </div>
        <dx:ASPxGridView ID="GV_Instituciones" runat="server"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourceInformes" KeyFieldName="Id_Informe" Style="margin-left: auto; margin-right: auto;" Theme="iOS"
            OnInitNewRow="GV_Instituciones_InitNewRow" OnRowUpdated="GV_Instituciones_RowUpdated" OnStartRowEditing="GV_Instituciones_StartRowEditing" OnRowInserted="GV_Instituciones_RowInserted">
              
              
<%-- OnRowDataBound="GridView1_RowDataBound"--%>
<%--                        <ClientSideEvents EndCallback ="function(s, e){ 
e.processOnServer = confirm('¿Esta seguro de guardar los datos?');
}" />--%>
   
<%--<ClientSideEvents EndCallback="OnCommand"/>--%>

             <SettingsEditing Mode="PopupEditForm">
            </SettingsEditing>
            <SettingsText PopupEditFormCaption="EDITAR DATOS DEL INFORME" />
            <ClientSideEvents EndCallback="function(s, e) {
                        if (s.cpUpdateInstit) {
                            alert(s.cpUpdateInstit);
                                delete s.cpUpdateInstit;

                        }
                    }" />
            <SettingsAdaptivity AdaptivityMode="HideDataCells">
                <AdaptiveDetailLayoutProperties>
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit"></SettingsAdaptivity>
                </AdaptiveDetailLayoutProperties>
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
          
            <SettingsPopup>
                <EditForm Modal="True" HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter">
                </EditForm>
                <CustomizationWindow HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" />
                <FilterControl AutoUpdatePosition="False">
                </FilterControl>
            </SettingsPopup>

            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>

            <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
          
            <SettingsText CommandUpdate="Actualizar"/>

            <EditFormLayoutProperties ColCount="2" ColumnCount="2">
                <Items>
                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="N° DE INFORME" ColumnSpan="1">
                    </dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="DESCRIPCIÓN" ColumnSpan="1" Name="Descripcion">
                    </dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="AÑO" ColumnSpan="1">
                    </dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem Caption="SUBIR INFORME" ColSpan="1">
                        <Template>
                            <dx:ASPxUploadControl ID="UploadControl" runat="server" AutoStartUpload="true" Width="280px" NullText="Subir Docs..." OnFileUploadComplete="UploadControl_FileUploadComplete" ShowProgressPanel="true" UploadMode="Auto">
                                <ValidationSettings AllowedFileExtensions=".rtf, .pdf, .doc, .docx, .odt, .txt, .xls, .xlsx, .ods, .ppt, .pptx, .odp, .jpe, .jpeg, .jpg, .gif, .png" MaxFileSize="104857600" />
                                <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                            </dx:ASPxUploadControl>
                       <%--     <dx:ASPxLabel ID="FileNameLabel" runat="server" ClientInstanceName="fileNameLabel" Font-Size="X-Small">
                            </dx:ASPxLabel>--%>

                         <%--   <dx:ASPxButton ID="ASPxDeleteButton" runat="server" RenderMode="Link" Text="Eliminar" Font-Size="Small" ForeColor="#CC0000" ClientVisible="false" ClientInstanceName="deleteFileButton" AutoPostBack="false">
                                <ClientSideEvents Click="onClick" />
                            </dx:ASPxButton>
                            <dx:ASPxButton ID="ASPxAddButton" runat="server" Text="Subir" RenderMode="Link" ClientInstanceName="AddFileButton" ClientVisible="false">
                                <ClientSideEvents Click="Click_Add_Dtos" />
                            </dx:ASPxButton>--%>

                            <dx:ASPxCallback ID="ASPxCallback_Guardar_Dctos" runat="server" OnCallback="ASPxCallback_Guardar_Dctos_Callback" ClientInstanceName="ASPxCallback_Guardar_Dctos">

                                <ClientSideEvents CallbackComplete="Guardar_Dctos_Complete" />
                            </dx:ASPxCallback>
                            </div>
                        </Template>
                    </dx:GridViewColumnLayoutItem>

                    <dx:EditModeCommandLayoutItem ColSpan="2" ColumnSpan="2" HorizontalAlign="Right">
                    </dx:EditModeCommandLayoutItem>
                </Items>
            </EditFormLayoutProperties>

            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" ButtonRenderMode="Image" ButtonType="Image">
                    <%--  ButtonRenderMode="Button" ButtonType="Button" --%>

                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle ForeColor="#006699" HorizontalAlign="Center" Border-BorderColor="#CCCCCC">
                        <Border BorderColor="#CCCCCC" />
                    </CellStyle>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Id_Informe" ReadOnly="True" Visible="False" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle ForeColor="#006699" HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="N° DE INFORME" FieldName="FileName" VisibleIndex="2">
                    <PropertiesTextEdit Width="350px" ClientInstanceName="Informe">
                        <%-- <ValidationSettings ErrorDisplayMode="ImageWithText" ErrorTextPosition="Bottom" SetFocusOnError="True">
                            <RequiredField ErrorText="EL NOMBRE DE LA INSTITUCIÓN ES REQUERIDO" IsRequired="True" />
                        </ValidationSettings>--%>
                    </PropertiesTextEdit>
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Justify">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="DESCRIPCIÓN" FieldName="Descripcion" VisibleIndex="3" Width="300px">
                    <PropertiesTextEdit Width="100px" ClientInstanceName="Descripcion" NullDisplayText="Descripcion">
                        <ClientSideEvents KeyUp="function(s, e) { convierteTextoAMayusculas(s, e); }" />
                        <HelpTextSettings DisplayMode="Popup"></HelpTextSettings>

                        <ValidationSettings SetFocusOnError="True">
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataComboBoxColumn Caption="AÑO" FieldName="Año" VisibleIndex="4">
                    <PropertiesComboBox DataSourceID="SqlDataSource_Años" TextField="Año" ValueField="Año">
                    </PropertiesComboBox>
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataComboBoxColumn>
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

        <asp:SqlDataSource ID="SqlDataSource_Años" runat="server" ConnectionString="<%$ ConnectionStrings:DB_PARTICIPACIONConnectionString %>" SelectCommand="SELECT * FROM [tblAños]"></asp:SqlDataSource>

       
        <%--<asp:SqlDataSource ID="SqlDataSourceInformes" runat="server" ConnectionString="<%$ ConnectionStrings:DB_PARTICIPACIONConnectionString %>" DeleteCommand="DELETE FROM [tblInformes] WHERE [Id_Informe] = @original_Id_Informe" InsertCommand="INSERT INTO [tblInformes] ([Descripcion], [Anio]) VALUES (@Descripcion, @Anio)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Id_Informe], [FileName], [Descripcion], [Anio] FROM [tblInformes]" UpdateCommand="UPDATE [tblInformes] SET [FileName] = @FileName, [Descripcion] = @Descripcion, [Anio] = @Anio WHERE [Id_Informe] = @original_Id_Informe">--%>
        <asp:SqlDataSource ID="SqlDataSourceInformes" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DB_PARTICIPACIONConnectionString %>" DeleteCommand="DELETE FROM [tblInformes] WHERE [Id_Informe] = @original_Id_Informe" InsertCommand="INSERT INTO [tblInformes] ( [FileName],[Descripcion], [Año]) VALUES (@FileName, @Descripcion, @Año)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT I.Id_Informe, I.FileName, I.Descripcion, A.Año 
FROM tblInformes AS I
 LEFT OUTER JOIN tblAños AS A ON A.Año  = I.Año 
ORDER BY A.Id_año DESC"
            UpdateCommand="UPDATE [tblInformes] SET  [FileName] = @[FileName],[Descripcion] = @[Descripcion] ,[Año]=@[Año]
WHERE [Id_Informe] = @Id_Informe">
            <DeleteParameters>
                <asp:Parameter Name="original_Id_Informe" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="FileName"></asp:Parameter>
                <asp:Parameter Name="Descripcion"></asp:Parameter>
                <asp:Parameter Name="A&#241;o"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter />
                <asp:Parameter Name="Id_Informe" />
            </UpdateParameters>
        </asp:SqlDataSource>
         </div>

    <dx:ASPxPopupControl ID="Tipo_Inst" runat="server" Width="400px"  Modal="True" CloseAction="CloseButton" CloseOnEscape="true"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"   ClientInstanceName="Tipo_Inst"
        HeaderText="AÑOS" AllowDragging="True" PopupAnimationType="None"  EnableViewState="False" Height="200px" AutoUpdatePosition="true">
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
                                                <dx:LayoutItem Caption="AÑO:" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxTextBox ID="txtAño" runat="server" Width="200px">
                                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                                                    <RequiredField ErrorText="EL CAMPO ES REQUERIDO." IsRequired="True" />
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