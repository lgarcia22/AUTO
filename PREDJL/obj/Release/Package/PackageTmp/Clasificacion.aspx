<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeBehind="Clasificacion.aspx.cs" Inherits="PREDJL.Clasificacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
<style>
/*    .responsive-grid .dxgvHeader, .responsive-grid .dxgvDataRow {
        overflow-x: auto;
        display: block;
    }

    @media screen and (max-width: 768px) {
        .responsive-grid .dxgvHeader, .responsive-grid .dxgvDataRow {
            white-space: nowrap;
        }

        .responsive-grid .dxgvCommandColumn {
            display: none;
        }

        .responsive-grid .dxgvHeader .dxgvHeaderText, .responsive-grid .dxgvDataRow .dxgv {
            font-size: 0.9em;
        }
    }

    @media screen and (max-width: 480px) {
        .responsive-grid .dxgvDataTextColumn {
            display: block;
            width: 100%;
        }

        .responsive-grid .dxgvHeader .dxgvHeaderText {
            display: block;
            text-align: left;
            width: 100%;
            font-size: 0.8em;
        }

        .responsive-grid .dxgvDataRow .dxgv {
            display: block;
            width: 100%;
            font-size: 0.8em;
        }

        .responsive-grid .dxgvCommandColumn {
            display: none;
        }
    }*/
   .swal2-container {
          z-index: 20000 !important; /* Asegúrate de que sea mayor que el z-index del popup */
      }
      .dx-popup {
          z-index: 10000 !important; /* Ajusta esto según el valor adecuado para tu popup */
      }
</style>
      <script>
          //function btnPopupUpdate_Click(s, e) {
          //    var campos = [
          //        cmbStatus.GetText(),
          //        txtObs.GetText()
          //    ];

          //    var camposVacios = campos.some(function (valor) {
          //        return valor === '' || valor === null;
          //    });

          //    if (camposVacios) {
          //        Swal.fire({
          //            title: "¡Alerta!",
          //            text: "Debe completar los campos Obligatorios",
          //            icon: "warning",
          //            confirmButtonColor: "#1F497D",
          //        });
          //        popupUpdateStatus.Show();
          //        //alert('Debe completar los campos Obligatorios.');
          //    } else {
          //        //SetCampos();
          //        ASPxCallback_PopupUpdate.PerformCallback();
          //        GV_PreUsuarios.PerformCallback();

          //    }
          //}

          function btnPopupUpdate_Click(s, e) {
              //e.preventDefault();  // Prevenir el comportamiento por defecto del botón

              var campos = [
                  cmbStatus.GetText(),
                  txtObs.GetText()
              ];

              var camposVacios = campos.some(function (valor) {
                  return valor === '' || valor === null;
              });

              if (camposVacios) {
                  Swal.fire({
                      title: "¡Alerta!",
                      text: "Debe completar los campos Obligatorios",
                      icon: "warning",
                      confirmButtonColor: "#1F497D",
                  }).then(function () {
                      popupUpdateStatus.Show();  // Asegurar que el popup permanezca visible
                  });
              } else {
                  ASPxCallback_PopupUpdate.PerformCallback();
                  GV_PreUsuarios.PerformCallback();
                  popupUpdateStatus.Hide();
              }
          }


          function btnExportar_Click(s, e) {
           
                  ASPxCallback_Exportar.PerformCallback();
                  GV_PreUsuarios.PerformCallback();
              
             
          }

          //function ValidarSeleccionExportar() {
          //    // Obtener el número de filas seleccionadas
          //    var selectedRows = GV_PreUsuarios.GetSelectedRowCount();

          //    // Si no hay filas seleccionadas, mostrar alerta con SweetAlert
          //    if (selectedRows === 0) {
          //        Swal.fire({
          //            icon: 'warning',
          //            title: 'Selección requerida',
          //            text: 'Debe seleccionar al menos una fila antes de exportar.',
          //            confirmButtonText: 'Aceptar'
          //        });
          //        return; // Detener la ejecución si no hay selección
          //    }

          //    // Si hay filas seleccionadas, ejecutar la exportación
          //    btnExportar_Click(); // Llamar a la función de exportación
          //}

          function SetCampos() {
              cmbStatus.SetText(''),
                  txtObs.SetText('');


          }

          function btnBeforeExport(s, e) {
              var grid = ASPxClientControl.GetControlCollection().GetByName('GV_PreUsuarios');
              if (grid) {
                  var selectedRowKeys = grid.GetSelectedKeysOnPage();
                  if (selectedRowKeys.length = 1) {
                      ASPxCallback_BeforeExport.PerformCallback();
                      GV_PreUsuarios.PerformCallback();
                  } else {
                      Swal.fire({
                          title: "¡Alerta!",
                          text: "Por favor seleccione una fila para Exportar usuario.",
                          icon: "warning",
                          confirmButtonColor: "#1F497D"
                      });
                      //alert('Please select a row to update the status.');
                  }
              }
          }
      </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageToolbar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Content" runat="server">


      <asp:Panel ID="Panel_Content" runat="server">
          <link href="Content/css/sweetalert2.min.css" rel="stylesheet" />
           <script src="Content/js/sweetalert2.all.min.js"></script>
  <%--        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>--%>
          <script type="text/javascript">
            if (window.history.replaceState) {
                window.history.replaceState(null, null, window.location.href);
              }

              //function ShowPopup() {
              //    popupUpdateStatus.Show();
              //}


          </script>
                <div>
                    <br />
            <h1 style= "color: #006699; background-color: #FFFFFF; text-align:center ">
                <dx:ASPxImage ID="ASPxImage1" runat="server" ShowLoadingImage="true">
                    <EmptyImage IconID="people_usergroup_32x32">
                    </EmptyImage>
                </dx:ASPxImage>
&nbsp;Usuarios en Proceso </h1>
                    </div>
          <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <ContentTemplate>
       <%-- OnBeforeExport="GV_PreUsuarios_BeforeExport"--%>
    <dx:ASPxGridView ID="GV_PreUsuarios" runat="server" AutoGenerateColumns="False" Style="margin-left: auto; margin-right: auto;"
    KeyFieldName="Id" DataSourceID="SqlDataUsers" OnBeforeExport="GV_PreUsuarios_BeforeExport" ClientInstanceName="GV_PreUsuarios" OnCustomCallback="GV_PreUsuarios_CustomCallback" 
    Width="100%" CssClass="responsive-grid">
    <%--<SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" />--%>
    <%--<SettingsResizing ColumnResizeMode="Control" />--%>
          <SettingsPager AlwaysShowPager="True" PageSize="10">
     <PageSizeItemSettings Items="50, 100, 150" ShowAllItem="True" Visible="True">
         </PageSizeItemSettings>
</SettingsPager>
    <Settings ShowFilterRow="True" ShowHeaderFilterButton="True" ShowFooter="True" />
    <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
    <SettingsPopup>
        <FilterControl AutoUpdatePosition="False"></FilterControl>
    </SettingsPopup>
    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <%--<SettingsBehavior AllowFocusedRow="False" AllowSelectByRowClick="False" />--%>
        <SettingsBehavior AllowFocusedRow="false" AllowSelectByRowClick="False" AllowSelectSingleRowOnly="True" />
                  
<SettingsPopup>
<FilterControl AutoUpdatePosition="False"></FilterControl>
</SettingsPopup>
                   <Toolbars>
    <dx:GridViewToolbar>
        <SettingsAdaptivity Enabled="true" EnableCollapseRootItemsToIcons="true" />
        <Items>

             <dx:GridViewToolbarItem Command="Custom">
      <Template>
             <%--<dx:ASPxButton ID="btnEdit" runat="server" Text="Editar" AutoPostBack="False">
                 <ClientSideEvents Click="function(s, e) { EditSelectedRow(); }" />
             </dx:ASPxButton>--%>
          <dx:ASPxButton ID="btnUpdateStatus" runat="server" Text="Actualizar Estado" AutoPostBack="False">
       
               <ClientSideEvents Click="function(s, e) { ShowPopup(); }" />

         </dx:ASPxButton>

         </Template>
    
            </dx:GridViewToolbarItem>
                               <dx:GridViewToolbarItem Command="Custom">
<Template>
    <dx:ASPxButton ID="btnExportar" runat="server" Text="Exportar To CSV" OnClick="btnExportar_Click" AutoPostBack="False">


   </dx:ASPxButton>

   </Template>
    
      </dx:GridViewToolbarItem>
<%--                   <dx:GridViewToolbarItem Command="Custom">
<Template>--%>
       <%--<dx:ASPxButton ID="btnEdit" runat="server" Text="Editar" AutoPostBack="False">
           <ClientSideEvents Click="function(s, e) { EditSelectedRow(); }" />
       </dx:ASPxButton>
<%--     <dx:ASPxButton ID="btnExportar" runat="server" Text="Actualizar" AutoPostBack="False" UseSubmitBehavior="false" ClientInstanceName="btnExportar">
     <ClientSideEvents Click="btnExportar_Click" />
 </dx:ASPxButton>
 <dx:ASPxCallback ID="ASPxCallback_Exportar" runat="server" ClientInstanceName="ASPxCallback_Exportar" OnCallback="ASPxCallback_Exportar_Callback">
 </dx:ASPxCallback>

   </Template>
    
      </dx:GridViewToolbarItem>--%>
                        <%-- <dx:GridViewToolbarItem Command="Custom">
                    <Template>
  
     <dx:ASPxButton ID="btnExportar" runat="server" Text="Exportar To CSV" AutoPostBack="False" UseSubmitBehavior="false" ClientInstanceName="btnExportar">
     <ClientSideEvents Click="btnExportar_Click" />
         <ClientSideEvents Click="function(s, e) { ValidarSeleccionExportar(); }" />
 </dx:ASPxButton>
 <dx:ASPxCallback ID="ASPxCallback_Exportar" runat="server" ClientInstanceName="ASPxCallback_Exportar" OnCallback="ASPxCallback_Exportar_Callback">
 </dx:ASPxCallback>

   </Template>
    
      </dx:GridViewToolbarItem> 
                   <dx:GridViewToolbarItem Command="Custom">
<Template>
    <dx:ASPxButton ID="btnExportar" runat="server" Text="Exportar a CSV" OnClick="btnExportar_Click">
         <%--<ClientSideEvents Click="function(s, e) { ValidarSeleccionExportar(); }" />--%>

<%--   </dx:ASPxButton>

   </Template>
    
      </dx:GridViewToolbarItem>--%>
 <%--                        <dx:GridViewToolbarItem Command="Custom">
      <Template>
                   <dx:ASPxButton ID="BeforeExport" runat="server" Text="Actualizar" AutoPostBack="False" UseSubmitBehavior="false" ClientInstanceName="BeforeExport">
                  <ClientSideEvents Click="btnBeforeExport" />
              </dx:ASPxButton>
            <dx:ASPxCallback ID="ASPxCallback_BeforeExport" runat="server" ClientInstanceName="ASPxCallback_BeforeExport" OnCallback="ASPxCallback_BeforeExport_Callback">

      </dx:ASPxCallback>

         </Template>
    
            </dx:GridViewToolbarItem>--%>
            <%--<dx:GridViewToolbarItem Command="ExportToCsv"  />--%>
            <dx:GridViewToolbarItem Command="Refresh"></dx:GridViewToolbarItem>
                                    <dx:GridViewToolbarItem Command="ExportToXls"  Text="Exportar a Excel">
</dx:GridViewToolbarItem>
        </Items>
    </dx:GridViewToolbar>
</Toolbars>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
    <Columns>
        <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowClearFilterButton="True" VisibleIndex="0" ShowSelectCheckbox="True" Caption="✔">
           <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
<CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
        </dx:GridViewCommandColumn>
              <dx:GridViewDataTextColumn FieldName="FirstName" ShowInCustomizationForm="True" VisibleIndex="3" Caption="NOMBRE">
           <PropertiesTextEdit>
                   <Style Font-Size="Small"></Style>
               </PropertiesTextEdit>
               <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
               <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
       </dx:GridViewDataTextColumn>
       <dx:GridViewDataTextColumn FieldName="LastName" ShowInCustomizationForm="True" VisibleIndex="4" Caption="APELLIDO">
                <PropertiesTextEdit>
                   <Style Font-Size="Small"></Style>
               </PropertiesTextEdit>
               <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
               <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
       </dx:GridViewDataTextColumn>
       <dx:GridViewDataTextColumn FieldName="EmployeeId" ShowInCustomizationForm="True" VisibleIndex="2" Caption="DNI">
           <PropertiesTextEdit>
                   <Style Font-Size="Small"></Style>
               </PropertiesTextEdit>
               <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
               <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
       </dx:GridViewDataTextColumn>
       <dx:GridViewDataTextColumn FieldName="Phone" ShowInCustomizationForm="True" VisibleIndex="6" Caption="T&#201;LEFONO">
                <PropertiesTextEdit>
                   <Style Font-Size="Small"></Style>
               </PropertiesTextEdit>
               <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
               <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
       </dx:GridViewDataTextColumn>
       <dx:GridViewDataDateColumn FieldName="CreatedDate" ShowInCustomizationForm="True" VisibleIndex="13" Caption="PRE-REGISTRO">
           <PropertiesDateEdit>
               <Style Font-Size="Small">
                   </Style>
           </PropertiesDateEdit>
           <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
           <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
       </dx:GridViewDataDateColumn>
       <dx:GridViewDataTextColumn FieldName="Address" VisibleIndex="9" Caption="DEPENDENCIA">
           <PropertiesTextEdit>
               <Style Font-Size="Small"></Style>
           </PropertiesTextEdit>
           <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
           <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
       </dx:GridViewDataTextColumn>
       <dx:GridViewDataTextColumn FieldName="Obs" VisibleIndex="10" Caption="OBSERVACIÓN">
           <PropertiesTextEdit>
               <Style Font-Size="Small"></Style>
           </PropertiesTextEdit>
           <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
           <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
       </dx:GridViewDataTextColumn>
       <dx:GridViewDataTextColumn FieldName="Email" ShowInCustomizationForm="True" VisibleIndex="5" Caption="EMAIL">
           <PropertiesTextEdit>
               <Style Font-Size="Small"></Style>
           </PropertiesTextEdit>
           <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
           <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
       </dx:GridViewDataTextColumn>
       <dx:GridViewDataTextColumn FieldName="UserId" VisibleIndex="8" Visible="False"></dx:GridViewDataTextColumn>
<%--       <dx:GridViewDataTextColumn FieldName="Company" ShowInCustomizationForm="True" VisibleIndex="7" Caption="INSTITUCI&#211;N">
           <PropertiesTextEdit>
               <Style Font-Size="Small"></Style>
           </PropertiesTextEdit>
           <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
           <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
       </dx:GridViewDataTextColumn>--%>
                                    <dx:GridViewDataComboBoxColumn Caption="INSTITUCIÓN" FieldName="Company" VisibleIndex="7" Settings-ShowFilterRowMenu="True">
    <PropertiesComboBox DataSourceID="SqlDataSourcDependencia" TextField="CompanyName" ValueField="CompanyName" ValueType="System.String"/>
    
              <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>

              <CellStyle HorizontalAlign="Center" Font-Bold="True" Font-Size="Small" ForeColor="#666666"></CellStyle>
</dx:GridViewDataComboBoxColumn>
       <dx:GridViewDataTextColumn FieldName="IdRole" VisibleIndex="1" Visible="False"></dx:GridViewDataTextColumn>
       <dx:GridViewDataTextColumn FieldName="Id" VisibleIndex="14" Visible="False"></dx:GridViewDataTextColumn>
   <%--    <dx:GridViewDataTextColumn FieldName="Descripcion_Estado" Caption="ESTADO" VisibleIndex="12">
           <PropertiesTextEdit>
               <Style Font-Size="Small"></Style>
           </PropertiesTextEdit>
           <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
           <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
       </dx:GridViewDataTextColumn>--%>
                      <dx:GridViewDataComboBoxColumn Caption="ESTADO" FieldName="Descripcion_Estado" VisibleIndex="12" Settings-ShowFilterRowMenu="True">
    <PropertiesComboBox DataSourceID="SqlDataSourcEstados" TextField="Descripcion_Estado" ValueField="Descripcion_Estado" ValueType="System.String"/>
    
              <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>

              <CellStyle HorizontalAlign="Center" Font-Bold="True" Font-Size="Small" ForeColor="#666666"></CellStyle>
</dx:GridViewDataComboBoxColumn>
       <dx:GridViewDataDateColumn FieldName="FechaIngreso" Caption="FECHA LABORAL" VisibleIndex="15">
               <PropertiesDateEdit>
    <Style Font-Size="Small">
        </Style>
</PropertiesDateEdit>
<HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
<CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
           
       </dx:GridViewDataDateColumn>
    </Columns>
    <Styles>
        <SelectedRow BackColor="#CCCCCC" ForeColor="#1F497D" Font-Bold="True" />
        <FocusedRow BackColor="White" />
    </Styles>
</dx:ASPxGridView>

               

    </ContentTemplate>

          <asp:SqlDataSource runat="server" ID="SqlDataUsers" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT * FROM [V_Usuarios] where Estado in (1,2,3) ORDER BY CreatedDate DESC"></asp:SqlDataSource>
             <asp:SqlDataSource ID="SqlDataSourcEstados" runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT * FROM [Estados] where Id_Estado in (1,2,3)"></asp:SqlDataSource>
          <%--<asp:SqlDataSource ID="SqlDataSourcDependencia" runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT CompanyName FROM Company ORDER BY CompanyName ASC "></asp:SqlDataSource>--%>
          <asp:SqlDataSource ID="SqlDataSourcDependencia" runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT CompanyName FROM View_company ORDER BY CompanyName ASC "></asp:SqlDataSource>
<%--<dx:ASPxPopupControl ID="popupUpdateStatus" runat="server" ClientInstanceName="popupUpdateStatus" 
    ShowCloseButton="True" HeaderText="Actualizar Estado"
    Width="400px" Height="300px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" SettingsAdaptivity-Mode="OnWindowInnerWidth" Modal="True" CloseAnimationType="None" AllowResize="False" AutoUpdatePosition="False" SettingsAdaptivity-VerticalAlign="WindowCenter">
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <div style="display: flex; align-items: center; justify-content: center; height: 100%;">
                <div style="text-align: center;">
                                        <dx:ASPxComboBox ID="cmbStatus" runat="server" ValueField="Id_Estado" TextField="Descripcion_Estado" ClientInstanceName="cmbStatus"
                        Width="300px" Height="30px" ValueType="System.Int32" Caption="Seleccionar el Estado" 
                        NullText="Seleccionar Estado" CaptionSettings-Position="Top" ClearButton-DisplayMode="Always" CaptionSettings-RequiredMarkDisplayMode="Required">
                   <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" RequiredField-IsRequired="true" 
    SetFocusOnError="True">
    <RequiredField ErrorText="La Estado es requerido." IsRequired="true" />
</ValidationSettings>
                        </dx:ASPxComboBox>
                    <br />
                    <dx:ASPxMemo ID="txtObs" runat="server"  Width="100%" Height="100px" NullText="Ingrese una Observación" 
                        ClientInstanceName="txtObs" Caption="Ingrese una Observación" CaptionSettings-Position="Top">
                        <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" RequiredField-IsRequired="true" 
                            SetFocusOnError="True">
                            <RequiredField ErrorText="La Obs es requerida." IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxMemo>
                    <br />
                    <dx:ASPxButton ID="btnPopupUpdate" runat="server" Text="Actualizar" AutoPostBack="False" UseSubmitBehavior="false" ClientInstanceName="btnPopupUpdate">
                        <ClientSideEvents Click="btnPopupUpdate_Click" />
                    </dx:ASPxButton>
                  <dx:ASPxCallback ID="ASPxCallback_PopupUpdate" runat="server" ClientInstanceName="ASPxCallback_PopupUpdate" OnCallback="ASPxCallback_PopupUpdate_Callback">

            </dx:ASPxCallback>
                </div>
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>--%>

          <dx:ASPxPopupControl ID="popupUpdateStatus" runat="server" ClientInstanceName="popupUpdateStatus" 
    ShowCloseButton="True" HeaderText="Actualizar Estado"
    Width="400px" Height="300px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" SettingsAdaptivity-Mode="OnWindowInnerWidth" Modal="True" CloseAnimationType="None" AllowResize="False" AutoUpdatePosition="False" SettingsAdaptivity-VerticalAlign="WindowCenter">
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <div style="display: flex; align-items: center; justify-content: center; height: 100%;">
                <div style="text-align: center;">
                    <dx:ASPxComboBox ID="cmbStatus" runat="server" ValueField="Id_Estado" TextField="Descripcion_Estado" ClientInstanceName="cmbStatus"
                        Width="300px" Height="30px" ValueType="System.Int32" Caption="Seleccionar el Estado" 
                        NullText="Seleccionar Estado" CaptionSettings-Position="Top" ClearButton-DisplayMode="Always" CaptionSettings-RequiredMarkDisplayMode="Required">
                        <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" RequiredField-IsRequired="true" 
                            SetFocusOnError="True">
                            <RequiredField ErrorText="El Estado es requerido." IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                    <br />
                    <dx:ASPxMemo ID="txtObs" runat="server" Width="100%" Height="100px" NullText="Ingrese una Observación" 
                        ClientInstanceName="txtObs" Caption="Ingrese una Observación" CaptionSettings-Position="Top">
                        <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" RequiredField-IsRequired="true" 
                            SetFocusOnError="True">
                            <RequiredField ErrorText="La Observación es requerida." IsRequired="true" />
                        </ValidationSettings>
                    </dx:ASPxMemo>
                    <br />
                    <dx:ASPxButton ID="btnPopupUpdate" runat="server" Text="Actualizar" AutoPostBack="False" UseSubmitBehavior="false" ClientInstanceName="btnPopupUpdate">
                        <ClientSideEvents Click="btnPopupUpdate_Click" />
                    </dx:ASPxButton>
                    <dx:ASPxCallback ID="ASPxCallback_PopupUpdate" runat="server" ClientInstanceName="ASPxCallback_PopupUpdate" OnCallback="ASPxCallback_PopupUpdate_Callback">
                    </dx:ASPxCallback>
                </div>
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>



<script type="text/javascript">
    //function ShowPopup() {
    //    popupUpdateStatus.Show();
    //}

    function ShowPopup() {
        var grid = ASPxClientControl.GetControlCollection().GetByName('GV_PreUsuarios');
        if (grid) {
            var selectedRowKeys = grid.GetSelectedKeysOnPage();

            // Cambié la asignación "=" por una comparación "==="
            if (selectedRowKeys.length === 1) {
                // Limpiar el ComboBox y el Memo
                var cmbStatus = ASPxClientControl.GetControlCollection().GetByName('cmbStatus');
                var txtObs = ASPxClientControl.GetControlCollection().GetByName('txtObs');

                if (cmbStatus) {
                    cmbStatus.SetSelectedIndex(-1); // Deseleccionar cualquier valor
                    cmbStatus.SetValue(null); // Limpiar valor seleccionado
                }

                if (txtObs) {
                    txtObs.SetText(''); // Limpiar texto
                }

                // Mostrar el popup si se selecciona una fila
                popupUpdateStatus.Show();
            } else {
                // Si no se selecciona exactamente una fila, muestra el mensaje de alerta
                Swal.fire({
                    title: "¡Alerta!",
                    text: "Por favor seleccione una fila para Actualizar el Estado.",
                    icon: "warning",
                    confirmButtonColor: "#1F497D"
                });
            }
        } else {
            alert('Grid no encontrado.');
        }
    }

    function closePopupAndClearFields() {
        // Cerrar el popup
        popupUpdateStatus.Hide();

        // Limpiar el ComboBox y el Memo
        var cmbStatus = ASPxClientControl.GetControlCollection().GetByName('cmbStatus');
        var txtObs = ASPxClientControl.GetControlCollection().GetByName('txtObs');

        if (cmbStatus) {
            cmbStatus.SetSelectedIndex(-1); // Deseleccionar cualquier valor
            cmbStatus.SetValue(null); // Limpiar valor seleccionado
        }

        if (txtObs) {
            txtObs.SetText(''); // Limpiar texto
        }
    }
    //function hidePopup() {
    //    popupUpdateStatus.Hide();
    //}

    //function ShowPopup() {
    //    var grid = ASPxClientControl.GetControlCollection().GetByName("GV_PreUsuarios");
    //    var selectedRowKey = grid.GetFocusedRowIndex();
    //    if (selectedRowKey >= 0) {
    //        popupUpdateStatus.Show();
    //    } else {
    //        alert('Por favor, seleccione una fila primero.');
    //    }
    //}
</script>
      
      </asp:Panel>
</asp:Content>
