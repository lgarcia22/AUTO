<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeBehind="Users_Trasladados.aspx.cs" Inherits="PREDJL.Users_Trasladados" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageToolbar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Content" runat="server">
      <asp:Panel ID="Panel_Content" runat="server">
            <link href="Content/css/sweetalert2.min.css" rel="stylesheet" />
   <script src="Content/js/sweetalert2.all.min.js"></script>
<%--          <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>--%>
   <%-- <script type="text/javascript">
        function EditSelectedRow() {
            var grid = ASPxClientGridView.Cast('GV_UsersTrasladados');
            if (grid.GetFocusedRowIndex() !== -1) {
                grid.StartEditRow(grid.GetFocusedRowIndex());
            }
            else {
                alert('Por favor seleccione una fila para editar.');
            }
        }
    </script>--%>

          <script type="text/javascript">
              if (window.history.replaceState) {
                  window.history.replaceState(null, null, window.location.href);
              }
          </script>

    <script type="text/javascript">
        //function updateStatus() {
        //    var grid = ASPxClientGridView.Cast('GV_UsersTrasladados');
        //    grid.GetSelectedFieldValues('Id', function (selectedKeys) {
        //        if (selectedKeys.length === 0) {
        //            alert('Por favor seleccione al menos una fila.');
        //            return;
        //        }
        //        // Llama a un método en el servidor usando AJAX
        //        __doPostBack('UpdateStatus', JSON.stringify(selectedKeys));
        //    });
        //}

        //function updateStatus() {
        //    var grid = ASPxClientGridView.Cast('GV_UsersTrasladados');
        //    // Obtener tanto el Id como el Estado
        //    grid.GetSelectedFieldValues('Id;Descripcion_Estado', function (selectedItems) {
        //        var hasExported = false;
        //        for (var i = 0; i < selectedItems.length; i++) {
        //            // Asumiendo que cada item tiene dos elementos: [Id, Estado]
        //            if (selectedItems[i][1] === "Exportado") {
        //                hasExported = true;
        //                break;  // Si al menos uno está en estado Exportado, detener la verificación
        //            }
        //        }

        //        if (!hasExported) {
        //            alert('Por favor seleccione al menos una fila en estado "Exportado".');
        //            return;
        //        }
        //        // Si hay al menos una fila en estado "Exportado", proceder
        //        // Llama a un método en el servidor usando AJAX
        //        __doPostBack('UpdateStatus', JSON.stringify(selectedItems.map(function (item) { return item[0]; }))); // Enviar solo los Ids
        //    });
        //}

        function updateStatus() {
            var grid = ASPxClientGridView.Cast('GV_UsersTrasladados');
            grid.GetSelectedFieldValues('Id;Descripcion_Estado', function (selectedItems) {
                var filteredIds = [];
                for (var i = 0; i < selectedItems.length; i++) {
                    // Asegúrate de que solo los IDs con Estado "Procesando" sean incluidos
                    if (selectedItems[i][1] === "Procesando") {
                        filteredIds.push(selectedItems[i][0]);
                    }
                }

                if (filteredIds.length === 0) {
                    Swal.fire({
                        title: "¡Alerta!",
                        text: "Por favor seleccione al menos una fila en estado Procesando.",
                        icon: "warning",
                        confirmButtonColor: "#1F497D"
                    });
                   /* alert('Por favor seleccione al menos una fila en estado "Procesando".');*/
                    return;
                }

                // Llama a un método en el servidor usando AJAX
                __doPostBack('UpdateStatus', JSON.stringify(filteredIds));
            });
        }

        //function onSelectAllChanged(s, e) {
        //    var grid = ASPxClientGridView.Cast('GV_UsersTrasladados');
        //    if (s.GetChecked()) {
        //        grid.SelectRows();
        //        grid.GetVisibleRowsOnPage().forEach(function (index) {
        //            var row = grid.GetRow(index);
        //            var estado = grid.GetRowValues(index, 'Descripcion_Estado', function (value) {
        //                if (value !== 'Exportado') {
        //                    grid.UnselectRowOnPage(index);
        //                }
        //            });
        //        });
        //    } else {
        //        grid.UnselectRows();
        //    }
        //}

        //window.onload = function () {
        //    var grid = ASPxClientGridView.Cast('GV_UsersTrasladados');
        //    var headerCheckbox = document.querySelector('.dxgvHeaderPanel_' + grid.name + ' input[type=checkbox]');

        //    if (headerCheckbox) {
        //        headerCheckbox.onclick = function (event) {
        //            // Evitar el comportamiento por defecto del checkbox
        //            event.preventDefault();
        //            event.stopPropagation();

        //            var isChecked = headerCheckbox.checked;
        //            headerCheckbox.checked = !isChecked; // Toggle del estado actual del checkbox

        //            // Lógica para seleccionar manualmente las filas
        //            if (headerCheckbox.checked) {
        //                selectExportedOnly(grid);
        //            } else {
        //                grid.UnselectAllRowsOnPage();
        //            }
        //        };
        //    }
        //};

        //function selectExportedOnly(grid) {
        //    grid.SelectAllRowsOnPage();
        //    grid.GetVisibleRowsOnPage().forEach(function (index) {
        //        grid.GetRowValues(index, 'Descripcion_Estado', function (value) {
        //            if (value !== 'Exportado') {
        //                grid.UnselectRowOnPage(index);
        //            }
        //        });
        //    });
        //}

        $(document).ready(function () {
            var grid = ASPxClientGridView.Cast('GV_UsersTrasladados');

            // Esperar hasta que el grid esté completamente inicializado
            ASPxClientUtils.AttachEventToElement(grid.GetMainElement(), 'load', function () {
                // Acceder al checkbox de "Select All" en la cabecera de la columna de selección
                var headerCheckbox = $(grid.GetMainElement()).find('.dxgvHeaderPanel .dxgvSelectAllCheckBox')[0];
                if (headerCheckbox) {
                    headerCheckbox.addEventListener('click', function (event) {
                        // Prevenir la acción por defecto
                        event.preventDefault();

                        var isChecked = headerCheckbox.checked;
                        headerCheckbox.checked = !isChecked; // Cambiar el estado actual del checkbox

                        // Implementar la lógica de selección personalizada
                        if (headerCheckbox.checked) {
                            grid.SelectAllRowsOnPage();
                            grid.GetVisibleRowsOnPage().forEach(function (index) {
                                var estado = grid.batchEditApi.GetCellValue(index, 'Descripcion_Estado');
                                if (estado === 'Registrado') {
                                    grid.UnselectRowOnPage(index);
                                }
                            });
                        } else {
                            grid.UnselectAllRowsOnPage();
                        }
                    });
                }
            });
        });


        //function checkSelectionAndExport(grid, exportType) {
        //    var selectedKeys = grid.GetSelectedKeysOnPage();
        //    if (selectedKeys.length === 0) {
        //        alert('No hay elementos seleccionados para exportar.');
        //        return false; // Cancelar la exportación
        //    } else {
        //        grid.PerformCallback({ command: exportType });
        //    }
        //}

        //function onToolbarItemClick(s, e) {
        //    if (e.item.name === "ExportCsv") {
        //        e.processOnServer = false; // Cancelar la exportación en el servidor
        //        checkSelectionAndExport(s, 'csv');
        //    }
        //}
    </script>
                          <div>
                               <br />
            <h1 style= "color: #006699; background-color: #FFFFFF; text-align:center ">
                <dx:ASPxImage ID="ASPxImage1" runat="server" ShowLoadingImage="true">
                    <EmptyImage IconID="people_usergroup_32x32">
                    </EmptyImage>
                </dx:ASPxImage>
&nbsp;Usuarios Registrados </h1>
                    </div>
          <asp:ScriptManager ID="ScriptManager1" runat="server"/>
    <dx:ASPxGridView ID="GV_UsersTrasladados" runat="server" AutoGenerateColumns="False" OnHtmlDataCellPrepared="GV_UsersTrasladados_HtmlDataCellPrepared" 
       Style="margin-left: auto; margin-right: auto;" Width="100%" CssClass="responsive-grid"
          KeyFieldName="Id" OnBeforeExport="GV_PreUsuarios_BeforeExport" SettingsAdaptivity-AdaptivityMode="Off" DataSourceID="SqlDataTrasladados" ClientInstanceName="GV_UsersTrasladados" OnHtmlRowPrepared="GV_UsersTrasladados_HtmlRowPrepared" OnDataBound="GV_UsersTrasladados_DataBound">
       <%--KeyFieldName="Id" OnBeforeExport="GV_PreUsuarios_BeforeExport" SettingsAdaptivity-AdaptivityMode="Off" DataSourceID="SqlDataTrasladados" ClientInstanceName="GV_UsersTrasladados" >--%>
        <%--<SettingsEditing Mode="PopupEditForm" />--%>
        <%--<SettingsBehavior AllowFocusedRow="True" />--%>
        <%--<SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="true" />--%>
        <%--<SettingsSelection EnableCheckBoxSelector="True" SelectorColumnWidth="30"/>--%>
          <%--<SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" />--%>
       <SettingsPager AlwaysShowPager="True" PageSize="10">
     <PageSizeItemSettings Items="50, 100, 150" ShowAllItem="True" Visible="True">
         </PageSizeItemSettings>
</SettingsPager>
    <%--  <SettingsPager PageSize="10" PageSizeItemSettings-ShowAllItem="True" PageSizeItemSettings-Items="10,20,30" />--%>
           <Settings ShowFilterRow="True" ShowHeaderFilterButton="True" ShowFooter="True" />
    <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
    <SettingsPopup>
        
        <FilterControl AutoUpdatePosition="False"></FilterControl>
    </SettingsPopup>
    <%--<SettingsBehavior AllowSelectByRowClick="False" AllowSelectSingleRowOnly="False"/>--%>
          <SettingsBehavior AllowFocusedRow="False" AllowSelectByRowClick="False" AllowSelectSingleRowOnly="False" />
         <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
          <Columns>
            
              <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="None" ShowClearFilterButton="True" VisibleIndex="0" Caption="✔">
           <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White" Font-Size="Small"></HeaderStyle>
<CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
            </dx:GridViewCommandColumn>
              <dx:GridViewDataTextColumn FieldName="FirstName" ShowInCustomizationForm="True" Caption="NOMBRE" VisibleIndex="3">
                  <PropertiesTextEdit>
                      <Style Font-Size="Small"></Style>
                  </PropertiesTextEdit>

                  <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>

                  <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn FieldName="LastName" ShowInCustomizationForm="True" VisibleIndex="5" Caption="APELLIDO">
                  <PropertiesTextEdit>
                      <Style Font-Size="Small"></Style>
                  </PropertiesTextEdit>
                  <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>
                  <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn FieldName="EmployeeId" ShowInCustomizationForm="True" VisibleIndex="2" Caption="DNI">
                  <PropertiesTextEdit>
                      <Style Font-Size="Small"></Style>
                  </PropertiesTextEdit>
                  <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>
                  <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn FieldName="Phone" ShowInCustomizationForm="True" VisibleIndex="7" Caption="T&#201;LEFONO">
                  <PropertiesTextEdit>
                      <Style Font-Size="Small"></Style>
                  </PropertiesTextEdit>
                  <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>
                  <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataDateColumn FieldName="FechaExportado" ShowInCustomizationForm="True" VisibleIndex="12" Caption="FECHA EXPORTACI&#211;N">
                  <PropertiesDateEdit>
                      <Style Font-Size="Small">
                        </Style>
                  </PropertiesDateEdit>
                  <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>
                  <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
              </dx:GridViewDataDateColumn>
                                <dx:GridViewDataComboBoxColumn Caption="INSTITUCIÓN" FieldName="Company" VisibleIndex="8" Settings-ShowFilterRowMenu="True">
        <PropertiesComboBox DataSourceID="SqlDataSourcDependencia" TextField="CompanyName" ValueField="CompanyName" ValueType="System.String"/>
        
                  <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>

                  <CellStyle HorizontalAlign="Center" Font-Bold="True" Font-Size="Small" ForeColor="#666666"></CellStyle>
    </dx:GridViewDataComboBoxColumn>
              <dx:GridViewDataTextColumn FieldName="Address" ShowInCustomizationForm="True" VisibleIndex="8" Caption="DEPENDENCIA">
     <PropertiesTextEdit>
         <Style Font-Size="Small"></Style>
     </PropertiesTextEdit>
     <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>
     <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
 </dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn FieldName="Email" ShowInCustomizationForm="True" VisibleIndex="6" Caption="EMAIL">
                  <PropertiesTextEdit>
                      <Style Font-Size="Small"></Style>
                  </PropertiesTextEdit>
                  <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>
                  <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
              </dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn FieldName="UserId" VisibleIndex="9" Visible="False"></dx:GridViewDataTextColumn>
             <%-- <dx:GridViewDataTextColumn FieldName="Company" ShowInCustomizationForm="True" VisibleIndex="8" Caption="INSTITUCI&#211;N">
                  <PropertiesTextEdit>
                      <Style Font-Size="Small"></Style>
                  </PropertiesTextEdit>
                  <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>
                  <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
              </dx:GridViewDataTextColumn>--%>
              <dx:GridViewDataTextColumn FieldName="IdRole" VisibleIndex="1" Visible="False"></dx:GridViewDataTextColumn>
              <dx:GridViewDataTextColumn FieldName="Id" VisibleIndex="14" Visible="False"></dx:GridViewDataTextColumn>
              <dx:GridViewDataDateColumn FieldName="FechaRegistrado" Caption="FECHA REGISTRO" VisibleIndex="13">
                  <PropertiesDateEdit>
                      <Style Font-Size="Small">
                        </Style>
                  </PropertiesDateEdit>
                  <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>
                  <CellStyle HorizontalAlign="Center" Font-Size="Small"></CellStyle>
              </dx:GridViewDataDateColumn>
                  <dx:GridViewDataComboBoxColumn Caption="ESTADO" FieldName="Descripcion_Estado" VisibleIndex="11" Settings-ShowFilterRowMenu="True">
        <PropertiesComboBox DataSourceID="SqlDataSourcEstados" TextField="Descripcion_Estado" ValueField="Descripcion_Estado" ValueType="System.String"/>
        
                  <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>

                  <CellStyle HorizontalAlign="Center" Font-Bold="True" Font-Size="Small" ForeColor="#666666"></CellStyle>
    </dx:GridViewDataComboBoxColumn>
<%--              <dx:GridViewDataTextColumn FieldName="Descripcion_Estado" Caption="ESTADO" VisibleIndex="11">
                  <PropertiesTextEdit>
                      <Style Font-Size="Small"></Style>
                  </PropertiesTextEdit>

                  <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>

                  <CellStyle HorizontalAlign="Center" Font-Bold="True" Font-Size="Small" ForeColor="#666666"></CellStyle>
              </dx:GridViewDataTextColumn>--%>


          </Columns>
        <%--<ClientSideEvents ToolbarItemClick="onToolbarItemClick" />--%>
        <Toolbars>
            <dx:GridViewToolbar Position="Top">
                <SettingsAdaptivity Enabled="true" EnableCollapseRootItemsToIcons="true" />
    <Items>
        <dx:GridViewToolbarItem Command="ExportToCsv">
        </dx:GridViewToolbarItem>
                                <dx:GridViewToolbarItem Command="ExportToXls"  Text="Exportar a Excel">
</dx:GridViewToolbarItem>
        <dx:GridViewToolbarItem Command="Custom">
         <Template>
                <%--<dx:ASPxButton ID="btnEdit" runat="server" Text="Editar" AutoPostBack="False">
                    <ClientSideEvents Click="function(s, e) { EditSelectedRow(); }" />
                </dx:ASPxButton>--%>
             <dx:ASPxButton ID="btnUpdateStatus" runat="server" Text="Actualizar Estado" AutoPostBack="False">
                <ClientSideEvents Click="function(s, e) { updateStatus(); }" />
            </dx:ASPxButton>
            </Template>
           
        </dx:GridViewToolbarItem>
          <%--<asp:Button ID="EditButton" runat="server" Text="Editar" OnClientClick="EditSelectedRow(); return false;" />--%>
    </Items>
            </dx:GridViewToolbar>   
        </Toolbars>

        <Styles>
            <SelectedRow BackColor="#CCCCCC" Font-Bold="True" ForeColor="#1F497D"></SelectedRow>

            <FocusedRow ForeColor="White"></FocusedRow>
        </Styles>
    </dx:ASPxGridView>
           
          <asp:SqlDataSource runat="server" ID="SqlDataTrasladados" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT * FROM [V_Usuarios] where Estado in (4,5) 
ORDER BY FechaExportado DESC"></asp:SqlDataSource>
          <asp:SqlDataSource ID="SqlDataSourcEstados" runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT * FROM [Estados] where Id_Estado in (4,5)"></asp:SqlDataSource>
           <asp:SqlDataSource ID="SqlDataSourcDependencia" runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT CompanyName FROM View_company ORDER BY CompanyName ASC "></asp:SqlDataSource>
           <%--<asp:SqlDataSource ID="SqlDataSourcDependencia" runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT CompanyName FROM View_company ORDER BY CompanyName ASC "></asp:SqlDataSource>--%>
      </asp:Panel>
</asp:Content>
