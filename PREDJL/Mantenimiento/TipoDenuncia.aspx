<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeBehind="TipoDenuncia.aspx.cs" Inherits="PREDJL.Mantenimiento.TipoDenuncia" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
     
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="PageToolbar" runat="server">
  
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="Content" runat="server">
    <asp:Panel ID="Panel_Content" runat="server">
    <div>
        <h1 style= "color: #006699; background-color: #FFFFFF; text-align:center "> Mantenimiento Tipo de Denuncias</h1>

        <dx:ASPxGridView ID="GV_TipoDenuncia" runat="server"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourceTipoDenuncia" KeyFieldName="ID_TipoDenuncia" Style="margin-left: auto; margin-right: auto;"
            OnInitNewRow="GV_TipoDenuncia_InitNewRow" OnStartRowEditing="GV_TipoDenuncia_StartRowEditing"
            OnRowUpdated="GV_TipoDenuncia_RowUpdated" OnRowInserted="GV_TipoDenuncia_RowInserted" Theme="Office365">
                      <ClientSideEvents 
        EndCallback="function(s, e) {
                        if (s.cpUpdateMessageTipoDenuncia) {
                            alert(s.cpUpdateMessageTipoDenuncia);
                                delete s.cpUpdateMessageTipoDenuncia;

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
                    <dx:GridViewColumnLayoutItem ColumnName="NOMBRE DE LA DENUNCIA" ColSpan="1"></dx:GridViewColumnLayoutItem>
                    <dx:GridViewColumnLayoutItem ColumnName="Activo" Caption="ACTIVO" ColSpan="1"></dx:GridViewColumnLayoutItem>
                    <dx:EditModeCommandLayoutItem ColSpan="1" VerticalAlign="Middle" HorizontalAlign="Center"></dx:EditModeCommandLayoutItem>
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
                <dx:GridViewDataTextColumn FieldName="ID_TipoDenuncia" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle ForeColor="#006699" HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="NOMBRE DE LA DENUNCIA" FieldName="Nombre" ShowInCustomizationForm="True" VisibleIndex="2" Width="200px" PropertiesTextEdit-MaxLength="100">
                    <PropertiesTextEdit Width="300px" NullText="Ingrese el tipo de Denuncia">
                        <ValidationSettings ErrorDisplayMode="ImageWithText" ErrorTextPosition="Bottom">
                            <RequiredField ErrorText="EL NOMBRE DE LA DENUNCIA ES REQUERIDA" IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle  HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Activo" VisibleIndex="3">
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle  HorizontalAlign="Center">
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
           <SettingsText PopupEditFormCaption="EDITAR DATOS DEL TIPO DE DENUNCIA"/>
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
        <asp:SqlDataSource ID="SqlDataSourceTipoDenuncia" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DB_PARTICIPACIONConnectionString %>" DeleteCommand="DELETE FROM [tblTipoDenuncia] WHERE [ID_TipoDenuncia ] = @original_ID_TipoDenuncia  AND (([Nombre] = @original_Nombre) OR ([Nombre] IS NULL AND @original_Nombre IS NULL))" InsertCommand="INSERT INTO [tblTipoDenuncia] ([Nombre]) VALUES (@Nombre)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [tblTipoDenuncia]
WHERE Activo=1"
            UpdateCommand="UPDATE [tblTipoDenuncia] SET [Nombre] = @Nombre WHERE [ID_TipoDenuncia] = @original_ID_TipoDenuncia AND (([Nombre] = @original_Nombre) OR ([Nombre] IS NULL AND @original_Nombre IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_ID_TipoDenuncia" />
                <asp:Parameter Name="original_Nombre" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Nombre" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Nombre" />
                <asp:Parameter Name="original_ID_TipoDenuncia" />
                <asp:Parameter Name="original_Nombre" />
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
          </asp:Panel>

</asp:Content>
