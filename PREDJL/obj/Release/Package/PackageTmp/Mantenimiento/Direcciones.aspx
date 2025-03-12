<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeBehind="Direcciones.aspx.cs" Inherits="PREDJL.Mantenimiento.Direcciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageToolbar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Content" runat="server">
    <%--<asp:Panel ID="Panel_Content" runat="server">--%>
    <div>
        <h1 style= "color: #006699; background-color: #FFFFFF; text-align:center "> Mantenimiento de Traslado/Direcciones</h1>

        <dx:ASPxGridView ID="GV_Direcciones" runat="server"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourceDirecciones" KeyFieldName="ID_Traslado" Style="margin-left: auto; margin-right: auto;"
            OnInitNewRow="GV_Direcciones_InitNewRow" OnStartRowEditing="GV_Direcciones_StartRowEditing"
            OnRowUpdated="GV_Direcciones_RowUpdated" OnRowInserted="GV_Direcciones_RowInserted" Theme="Office365">
                      <ClientSideEvents 
        EndCallback="function(s, e) {
                        if (s.cpUpdateMessageDirecciones) {
                            alert(s.cpUpdateMessageDirecciones);
                                delete s.cpUpdateMessageDirecciones;

                        }
                    }"
    />
<SettingsAdaptivity>
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>

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
                <UpdateButton ButtonType="Button" RenderMode="Button">
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
                <CancelButton ButtonType="Button" RenderMode="Button">
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

            <EditFormLayoutProperties>
                <Items>
                    <dx:GridViewColumnLayoutItem ColumnName="DIRECCI&#211;N" ColSpan="1"></dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColumnName="ACTIVO" ColSpan="1"></dx:GridViewColumnLayoutItem>
                    <dx:EditModeCommandLayoutItem ColSpan="1" HorizontalAlign="Center"></dx:EditModeCommandLayoutItem>
                </Items>
            </EditFormLayoutProperties>
            <EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
                      <SettingsPager PageSize="8">
                      </SettingsPager>
             <SettingsEditing Mode="PopupEditForm">
            </SettingsEditing>
           <%--   <SettingsPopup>
            <EditForm  Modal="True">
            </EditForm>
        </SettingsPopup>--%>
            <Columns>
                <dx:GridViewCommandColumn ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0" ButtonRenderMode="Image" ButtonType="Image" Width="200px">
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle ForeColor="#006699" HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ID_Traslado" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle ForeColor="#006699" HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="DIRECCI&#211;N" FieldName="Nombre_Traslado" ShowInCustomizationForm="True" VisibleIndex="2" Width="200px" PropertiesTextEdit-MaxLength="100">
                    <PropertiesTextEdit Width="300px" NullText="Ingrese la Direcci&#243;n">
                        <ValidationSettings ErrorDisplayMode="ImageWithText" ErrorTextPosition="Bottom">
                            <RequiredField ErrorText="EL NOMBRE DE LA DIRECCIÓN ES REQUERIDA" IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="3" Caption="ACTIVO">
                     <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataCheckColumn>
            </Columns>
             <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
            <Toolbars>
                <dx:GridViewToolbar Enabled="true">
                    <Items>
                        <dx:GridViewToolbarItem Command="ExportToXls"  Text="EXPORTAR A EXCEL">
                        </dx:GridViewToolbarItem>
                    </Items>
                </dx:GridViewToolbar>
            </Toolbars>
           <SettingsText PopupEditFormCaption="EDITAR DATOS DE LA DIRECCIÓN"/>
             <Settings ShowFooter="True" />
             <Styles>
                  <RowHotTrack BackColor="#def7ff">
                  </RowHotTrack>
            <AlternatingRow Enabled="true" />
                  <EditFormDisplayRow BackColor="#def7ff"></EditFormDisplayRow>
                  <EditForm BackColor="#def7ff">
                  </EditForm>
        </Styles>
            <Border BorderColor="Aqua" BorderStyle="Double" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSourceDirecciones" runat="server" ConnectionString="<%$ ConnectionStrings:DB_PARTICIPACIONConnectionString %>" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [tblDireccion_Traslado]
WHERE Activo=1"
            DeleteCommand="DELETE FROM [tblDireccion_Traslado] WHERE [ID_Traslado] = @original_ID_Traslado" InsertCommand="INSERT INTO [tblDireccion_Traslado] ([Nombre_Traslado], [Activo]) VALUES (@Nombre_Traslado, @Activo)" UpdateCommand="UPDATE [tblDireccion_Traslado] SET [Nombre_Traslado] = @Nombre_Traslado, [Activo] = @Activo WHERE [ID_Traslado] = @original_ID_Traslado">
            <DeleteParameters>
                <asp:Parameter Name="original_ID_Traslado" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Nombre_Traslado" Type="String"></asp:Parameter>
                <asp:Parameter Name="Activo" Type="Boolean"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Nombre_Traslado" Type="String"></asp:Parameter>
                <asp:Parameter Name="Activo" Type="Boolean"></asp:Parameter>
                <asp:Parameter Name="original_ID_Traslado" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
        <%--<dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server"  AllowDragging="True"
        ClientInstanceName="popup" Text="¿Está seguro de guardar los siguientes datos editados?" Theme="iOS" Width="350px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="Adventencia" Modal="True" >  
            <HeaderImage IconID="status_warning_32x32">
            </HeaderImage>
            <HeaderStyle ForeColor="Black" />
        <ContentCollection>  
<dx:PopupControlContentControl runat="server">  
    <br />
   
    <table style="width: 309px">  
  <tr>  
    <td style="text-align: center;">  
        <dx:ASPxLabel ID="ASPxLabel1" runat="server" ForeColor="#3366FF">
        </dx:ASPxLabel>
    </td>  
  </tr>  
        <tr>
            <td style="width: 140px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 140px">&nbsp;</td>
        </tr>
        </table>
         <table>
        <tr>
            <td style="width: 159px">
                <dx:ASPxButton ID="okButton" runat="server" AutoPostBack="false" style="margin-left: 4px"  Width="139px"  
            OnClick="okButton_Click" Text="Aceptar">  
                    <Image IconID="actions_apply_16x16">
                    </Image>
      </dx:ASPxButton>  </td>
            <td style="width: 159px">
                <dx:ASPxButton ID="cancelButton" runat="server" AutoPostBack="False" style="margin-left: 4px" Text="Cancelar" Width="139px">
                    <ClientSideEvents Click="function(s, e) {  
    popup.Hide();  
}" />
                    <Image IconID="spreadsheet_removepivotfield_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
        </tr>
</table>  
</dx:PopupControlContentControl>  
</ContentCollection>  
 </dx:ASPxPopupControl>--%>
    </div>
          <%--</asp:Panel>--%>
</asp:Content>
