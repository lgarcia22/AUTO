<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeBehind="Puestos.aspx.cs" Inherits="PREDJL.Mantenimiento.Puestos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageToolbar" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Content" runat="server">
    <asp:Panel ID="Panel_Content" runat="server">
    <div>
        <h1 style= "color: #006699; background-color: #FFFFFF; text-align:center "> MANTENIMIENTO DE CARGOS DE USUARIO </h1>

        <dx:ASPxGridView ID="GV_Puestos" runat="server"
            AutoGenerateColumns="False" DataSourceID="SqlDataSourcePuestos" KeyFieldName="ID_Puesto" Style="margin-left: auto; margin-right: auto;"
            Theme="iOS" OnInitNewRow="GV_Puestos_InitNewRow" OnStartRowEditing="GV_Puestos_StartRowEditing"
            OnRowUpdated="GV_Puestos_RowUpdated" OnRowInserted="GV_Puestos_RowInserted" >
            <ClientSideEvents
                EndCallback="function(s, e) {
                        if (s.cpUpdateMessagePuesto) {
                            alert(s.cpUpdateMessagePuesto);
                                delete s.cpUpdateMessagePuesto;

                        }
                    }" />
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
                            <HoverStyle BackColor="#069BFF" Border-BorderColor="#0066FF" >
                            </HoverStyle >
                        </Style>
                    </Styles>
                </NewButton>
                <UpdateButton ButtonType="Button" RenderMode="Button">
                    <Image IconID="actions_apply_16x16">
                    </Image>
                    <Styles>
                        <Style BackColor="White" ForeColor="Black" Width="30px">
                            <HoverStyle BackColor="#069BFF" Border-BorderColor="#0066FF" >
                            </HoverStyle >
                        </Style>
                    </Styles>
                </UpdateButton>
                <CancelButton ButtonType="Button" RenderMode="Button">
                    <Image IconID="actions_cancel_16x16">
                    </Image>
                    <Styles>
                        <Style BackColor="White" ForeColor="Black" Width="30px">
                            <HoverStyle BackColor="#069BFF" Border-BorderColor="#0066FF" >
                            </HoverStyle >
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
            </SettingsPopup>

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
                <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0" ButtonRenderMode="Image" ButtonType="Image" Width="200px">
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle ForeColor="#006699" HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ID_Cargo" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle ForeColor="#006699" HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="NOMBRE DE PUESTO" FieldName="Nombre_Cargo" ShowInCustomizationForm="True" VisibleIndex="2" Width="200px" PropertiesTextEdit-MaxLength="100">
                             <PropertiesTextEdit Width="300px">
                        <ValidationSettings ErrorDisplayMode="ImageWithText" ErrorTextPosition="Bottom">
                            <RequiredField ErrorText="El nombre del puesto es requerido" IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle  HorizontalAlign="Center">
                    </CellStyle>
                </dx:GridViewDataTextColumn>
            </Columns>
             <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="WYSIWYG" />
            <Toolbars>
                <dx:GridViewToolbar Enabled="true">
                    <Items>
                        <dx:GridViewToolbarItem Command="ExportToXls"  Text="Exportar a Excel">
                        </dx:GridViewToolbarItem>
                    </Items>
                </dx:GridViewToolbar>
            </Toolbars>
           <SettingsText PopupEditFormCaption="Editar datos del puesto"/>
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
        <asp:SqlDataSource ID="SqlDataSourcePuestos" runat="server" ConnectionString='<%$ ConnectionStrings:DB_PARTICIPACIONConnectionString %>' OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT  ID_Cargo, Nombre_Cargo
FROM [tblCargos]
WHERE ID_Cargo in (1,2,3,4,5,6,7)">
        </asp:SqlDataSource>

        
       
    </div>
          </asp:Panel>
</asp:Content>

