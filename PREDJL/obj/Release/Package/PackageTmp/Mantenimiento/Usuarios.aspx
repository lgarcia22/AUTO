﻿<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="PREDJL.Mantenimiento.Usuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">
</asp:Content>--%>
<asp:Content ID="Content3" ContentPlaceHolderID="PageToolbar" runat="server">
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="Content" runat="server">
     <%--<asp:Panel ID="Panel_Content" runat="server">--%>
        <script type="text/javascript">
            if (window.history.replaceState) {
                window.history.replaceState(null, null, window.location.href);
            }

            function ShowRolesWindow() {
            Roles_Usuario.Show();
            }
            function ShowCargoWindow() {
                PopupCargos.Show();
            }
        </script>
      <div>
            <h1 style= "color: #006699; background-color: #FFFFFF; text-align:center ">
                <dx:ASPxImage ID="ASPxImage1" runat="server" ShowLoadingImage="true">
                    <EmptyImage IconID="people_usergroup_32x32">
                    </EmptyImage>
                </dx:ASPxImage>
&nbsp;Mantenimiento de Usuarios</h1>
                       
              <div>

                  <div style="display: flex;
                        justify-content: center;">
                        <div style="padding: 10px; margin: 10px; ">
                                     <dx:ASPxButton ID="PopupRoles_Usuario" runat="server" AutoPostBack="false" Text="AGREGAR ROL AL USUARIO" UseSubmitBehavior="false"  BackColor="#1F497D" Font-Bold="True" ForeColor="White">
                                         <ClientSideEvents Click="function(s, e) { ShowRolesWindow(); }" />
                                         <Image IconID="people_role_16x16">
                                        </Image>
                                    </dx:ASPxButton>
                            </div>
                     <%--   <div style="padding: 10px; margin: 10px; ">
                      <dx:ASPxButton ID="Btn_Cargos" runat="server" AutoPostBack="false" Text="MANTENIMIENTOS DE CARGOS" UseSubmitBehavior="false"  BackColor="#3498DB" Font-Bold="True" ForeColor="White">
                                         <ClientSideEvents Click="function(s, e) { ShowCargoWindow(); }" />
                                         <Image IconID="businessobjects_bo_position_v92_svg_16x16">
                                        </Image>
                                    </dx:ASPxButton>
                            </div>--%>
                        </div>
                                </div>
 <div>
     <dx:ASPxGridView ID="Usuario" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceUser" KeyFieldName="Id"
           Style="margin-left: auto; margin-right: auto;" OnStartRowEditing="Usuario_StartRowEditing" Theme="Office365" OnRowUpdated="Usuario_RowUpdated" >
                              <ClientSideEvents 
        EndCallback="function(s, e) {
                        if (s.cpUpdateMessageUser) {
                            alert(s.cpUpdateMessageUser);
                                delete s.cpUpdateMessageUser;

                        }
                    }"
    />
<SettingsAdaptivity>
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>
             <SettingsEditing Mode="PopupEditForm" >
            </SettingsEditing>
                              <Settings ShowFilterRow="True" />
            <SettingsBehavior ConfirmDelete="True" EnableRowHotTrack="True" />
            <SettingsCommandButton>
                <NewButton>
                    <Image IconID="actions_add_16x16">
                    </Image>
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
     
         <SettingsSearchPanel Visible="True" />
          
<EditFormLayoutProperties ColCount="1">
    <Items>
        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="USUARIO">
        </dx:GridViewColumnLayoutItem>
        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="NOMBRE COMPLETO">
        </dx:GridViewColumnLayoutItem>
        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="CORREO CONFIRMADO">
        </dx:GridViewColumnLayoutItem>
        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="CORREO ELECTRÓNICO">
        </dx:GridViewColumnLayoutItem>
        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="USUARIO HABILITADO">
        </dx:GridViewColumnLayoutItem>
     <%--   <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="Puesto">
        </dx:GridViewColumnLayoutItem>--%>
        <dx:GridViewColumnLayoutItem ColSpan="1" ColumnName="ROL">
        </dx:GridViewColumnLayoutItem>
        <dx:EditModeCommandLayoutItem ColSpan="1" HorizontalAlign="Right">
        </dx:EditModeCommandLayoutItem>
    </Items>
         </EditFormLayoutProperties>
         <Columns>
             <dx:GridViewDataTextColumn FieldName="Id" ReadOnly="True" VisibleIndex="1" Visible="False">
             </dx:GridViewDataTextColumn>
             <dx:GridViewDataTextColumn FieldName="UserName" VisibleIndex="2" Caption="USUARIO">
                 <HeaderStyle BackColor="#1F497D" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                 <CellStyle HorizontalAlign="Center">
                 </CellStyle>
             </dx:GridViewDataTextColumn>
             <dx:GridViewDataTextColumn FieldName="Email" VisibleIndex="5" Caption="CORREO ELECTRÓNICO">
                 <HeaderStyle BackColor="#1F497D" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                 <CellStyle HorizontalAlign="Center">
                 </CellStyle>
             </dx:GridViewDataTextColumn>
             <dx:GridViewDataCheckColumn FieldName="EmailConfirmed" VisibleIndex="6" Caption="CORREO CONFIRMADO" ReadOnly="True">
                 <HeaderStyle BackColor="#1F497D" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                 <CellStyle HorizontalAlign="Center">
                 </CellStyle>
             </dx:GridViewDataCheckColumn>
             <dx:GridViewDataCheckColumn FieldName="LockoutEnabled" VisibleIndex="7" Caption="USUARIO HABILITADO">
                 <HeaderStyle BackColor="#1F497D" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                 <CellStyle HorizontalAlign="Center">
                 </CellStyle>
             </dx:GridViewDataCheckColumn>
             <dx:GridViewDataTextColumn FieldName="Nombre_Usuario" VisibleIndex="3" Caption="NOMBRE COMPLETO" PropertiesTextEdit-MaxLength="100">
                 <PropertiesTextEdit MaxLength="100">
                     <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithText" ErrorTextPosition="Bottom" SetFocusOnError="True">
                         <RequiredField ErrorText="EL NOMBRE DE USUARIO ES REQUERIDO." IsRequired="True" />
                     </ValidationSettings>
                 </PropertiesTextEdit>

                 <HeaderStyle BackColor="#1F497D" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                 <CellStyle HorizontalAlign="Center">
                 </CellStyle>
             </dx:GridViewDataTextColumn>
           <%--  <dx:GridViewDataComboBoxColumn Caption="CARGO" FieldName="Puesto" VisibleIndex="4">
                 <PropertiesComboBox MaxLength="100" DataSourceID="SqlDataSource_Puesto" TextField="Nombre_Cargo" ValueField="ID_Cargo">
                     <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithText" ErrorTextPosition="Bottom" SetFocusOnError="True">
                         <RequiredField ErrorText="El puesto es requerido" IsRequired="True" />
                     </ValidationSettings>
                 </PropertiesComboBox>
                 <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                 <CellStyle HorizontalAlign="Center">
                 </CellStyle>
             </dx:GridViewDataComboBoxColumn>--%>
             <dx:GridViewDataComboBoxColumn FieldName="RoleId" VisibleIndex="8" Caption="ROL">
                 <PropertiesComboBox DataSourceID="SqlDataSource_Codigo_roles" TextField="Name" ValueField="Id">
                 </PropertiesComboBox>
                 <HeaderStyle BackColor="#1F497D" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                 <CellStyle HorizontalAlign="Center">
                 </CellStyle>
             </dx:GridViewDataComboBoxColumn>
             <dx:GridViewCommandColumn ShowEditButton="True" ShowClearFilterButton="True" ButtonRenderMode="Image" ButtonType="Image" ShowInCustomizationForm="True" Caption="ACCI&#211;N" VisibleIndex="0">
                 <HeaderStyle HorizontalAlign="Center" BackColor="#1F497D" Font-Bold="True" ForeColor="White"></HeaderStyle>

                 <CellStyle HorizontalAlign="Center"></CellStyle>
             </dx:GridViewCommandColumn>
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
          <SettingsText PopupEditFormCaption="EDITAR USUARIOS DEL SISTEMA"/>
           <Styles>
                  <RowHotTrack BackColor="#def7ff">
                  </RowHotTrack>

<AlternatingRow Enabled="True"></AlternatingRow>

<EditFormDisplayRow BackColor="#def7ff"></EditFormDisplayRow>

<%--                  <EditForm BackColor="#def7ff">
                  </EditForm>--%>
        </Styles>
         <SettingsPager PageSize="5">
         </SettingsPager>
       <%--  <SettingsEditing UseFormLayout="True" Mode="EditForm" EditFormColumnCount="3" />
                                                       <Styles>
                                                <AlternatingRow Enabled="true" />
                                                        <EditForm BackColor="#f0f9f4">
                                                        </EditForm>
                                                                <EditFormDisplayRow BackColor="Aqua">
                                                                </EditFormDisplayRow>
                 
                                                             </Styles>--%>

          <Border BorderColor="Aqua" />
     </dx:ASPxGridView>
    <%-- <asp:SqlDataSource ID="SqlDataSource_Puesto" runat="server" ConnectionString='<%$ ConnectionStrings:DB_PARTICIPACIONConnectionString %>' SelectCommand="SELECT  ID_Cargo, Nombre_Cargo
FROM [tblCargos] 
WHERE Activo=1
"></asp:SqlDataSource>--%>
     <asp:SqlDataSource ID="SqlDataSource_Codigo_roles" runat="server" ConnectionString="<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>" SelectCommand="SELECT [Id], [Name] 
FROM [AspNetRoles]
"></asp:SqlDataSource>
          </div>
          <asp:SqlDataSource ID="SqlDataSourceUser" runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT AspNetUsers.Id, AspNetUsers.UserName, AspNetUsers.Puesto, AspNetUsers.Email, AspNetUsers.EmailConfirmed, AspNetUsers.LockoutEnabled, AspNetUsers.Nombre_Usuario, R.RoleId FROM AspNetUsers LEFT OUTER JOIN AspNetUserRoles AS R ON AspNetUsers.Id = R.UserId
"
              UpdateCommand="BEGIN TRANSACTION
BEGIN TRY
        UPDATE [AspNetUsers]
        SET LockoutEnabled = @LockoutEnabled, UserName =@UserName, Nombre_Usuario = @Nombre_Usuario, Email=@Email
        WHERE Id = @Id

        UPDATE [AspNetUserRoles]
        SET RoleId=@RoleId
         WHERE UserId = @Id;

        COMMIT TRANSACTION
END TRY
BEGIN CATCH
        ROLLBACK TRANSACTION
END CATCH"
              DeleteCommand="DELETE FROM [AspNetUsers] WHERE [Id] = @Id">
              <DeleteParameters>
                  <asp:Parameter Name="Id" Type="String" />
              </DeleteParameters>
              <UpdateParameters>
                  <asp:Parameter Name="LockoutEnabled" Type="Boolean" />
                  <asp:Parameter Name="UserName" />
                  <asp:Parameter Name="Nombre_Usuario" />
                  <asp:Parameter Name="Email"></asp:Parameter>
                  <asp:Parameter Name="Id" Type="String"></asp:Parameter>
                  <asp:Parameter Name="RoleId"></asp:Parameter>
              </UpdateParameters>
          </asp:SqlDataSource>

<%-- HeaderText="Traslado" AllowDragging="True" PopupAnimationType="None" AutoUpdatePosition="true" EnableViewState="False" Height="254px" >--%>

                  <%--<dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server"  AllowDragging="True"
        ClientInstanceName="popup" Text="¿Está seguro de guardar los datos editados?" Theme="iOS" Width="350px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="Adventencia" Modal="True" >  
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

     <dx:ASPxPopupControl ID="Roles_Usuario" runat="server" Width="400px"  Modal="True" CloseAction="CloseButton" CloseOnEscape="true"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"   ClientInstanceName="Roles_Usuario"
        HeaderText="ROL DE USUARIO" AllowDragging="True" PopupAnimationType="None"  EnableViewState="False" Height="200px" AutoUpdatePosition="true">
      <%-- HeaderText="Traslado" AllowDragging="True" PopupAnimationType="None" AutoUpdatePosition="true" EnableViewState="False" Height="254px" >--%>
         <%--<ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroup'); Roles_Usuario.Focus(); }" />--%>
      <%--   <ClientSideEvents CloseUp =
                    "function (s, e) {
                        window.location.reload (true);
                    }" />--%>
          <ClientSideEvents Closing="function(s, e) {
        ASPxClientEdit.ClearEditorsInContainerById('PopupCollection');
    }" />
        <ContentCollection>
               
            <dx:PopupControlContentControl runat="server">
                <div id="PopupCollection">
                <%--<dx:ASPxPanel ID="ASPxPanel_Roles" runat="server" DefaultButton="btnGuarda_Rol_Usuario">--%>
                    <%--<PanelCollection>--%>
                        <%--<dx:PanelContent runat="server">--%>
                            <div style="text-align: left">
                                <asp:SqlDataSource ID="SqlDataSource_Rol_Usuario" runat="server" ConnectionString="<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>"
                                    SelectCommand="SELECT  [Id]
                                                          ,[Name]
                                                   FROM [dbo].[AspNetRoles]">
                                </asp:SqlDataSource>
                                <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="1">
                                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700">
                                    </SettingsAdaptivity>
                                    <Items>
                                        <dx:LayoutGroup Caption="" ColCount="1" ColSpan="1">
                                            <Items>
                                                <dx:LayoutItem Caption="USUARIO:" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxComboBox ID="Cbx_Usuario" runat="server" TextField="UserName" ValueField="Id" DataSourceID="SqlDataSource_Usuarios">
                                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom">
                                                                    <RequiredField ErrorText="EL USUARIO ES REQUERIDO." IsRequired="True" />
                                                                </ValidationSettings>
                                                            </dx:ASPxComboBox>
                                                            <asp:SqlDataSource ID="SqlDataSource_Usuarios" runat="server" ConnectionString="<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>" SelectCommand="SELECT U.Id ,U.UserName, R.RoleId
	FROM AspNetUsers AS U
	LEFT JOIN AspNetUserRoles R ON U.Id=R.UserId
	where RoleId is null"></asp:SqlDataSource>
                                                        </dx:LayoutItemNestedControlContainer>
                                                    </LayoutItemNestedControlCollection>
                                                </dx:LayoutItem>
                                                <dx:LayoutItem Caption="ROL:" ColSpan="1">
                                                    <LayoutItemNestedControlCollection>
                                                        <dx:LayoutItemNestedControlContainer runat="server">
                                                            <dx:ASPxComboBox ID="Cbx_Rol" runat="server" TextField="Name" ValueField="Id" DataSourceID="SqlDataSource_Rol_Usuario">
                                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom">
                                                                    <RequiredField ErrorText="EL ROL ES REQUERIDO." IsRequired="True" />
                                                                </ValidationSettings>
                                                            </dx:ASPxComboBox>
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
                            <dx:ASPxButton ID="btnGuarda_Rol_Usuario" runat="server" AutoPostBack="True" Style="float: left; margin-right: 8px" Text="Guardar" Width="170px"
                                 OnClick="btnGuarda_Rol_Usuario_Click" >
                                    <ClientSideEvents Click="function(s, e){ e.processOnServer = confirm('¿Esta seguro de asignar rol al usuario?');
                                                                                    }" />
                             <Image IconID="actions_apply_16x16">
                                </Image>

                            </dx:ASPxButton>
                                </td>
                                <td style="width: 159px; text-align: right;">
                                    <dx:ASPxButton ID="Cancelar" runat="server" AutoPostBack="False" Style="float: left; margin-right: 8px" Text="Cancelar" Width="170px">
                        <%--                ClientSideEvents-Click="function(s, e) { ClientPopupControl.PerformCallback(); }">--%>
                                        <%--<ClientSideEvents  Click =
                                                "function (s, e) {
                                                  window.location.reload (true);        }" />--%>
                                      <%--  <ClientSideEvents  Click =
                                                "function (s, e) {(closedBy, returnValue) { Roles_Usuario.Hide();}"
                                            />--%>
                                      <%--  <ClientSideEvents Click="function(s, e) { Roles_Usuario.Hide(); }" />--%>
                                        <ClientSideEvents Click="function(s, e) {
                                                 ASPxClientEdit.ClearEditorsInContainer(null);
                                                                 }" />
                                        <ClientSideEvents Click="function(s, e) { Roles_Usuario.Hide(); }" />
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
                      <%--  </dx:PanelContent>
                        
                    </PanelCollection>
                </dx:ASPxPanel>--%>
                    </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
            <HeaderImage IconID="people_role_32x32">
            </HeaderImage>
        <ContentStyle>
            <Paddings PaddingBottom="7px" />
        </ContentStyle>
    </dx:ASPxPopupControl>

          <dx:ASPxPopupControl ID="PopupCargos" runat="server" HeaderText="Cargos de los usuarios"
              CloseAction="CloseButton" CloseOnEscape="true" Modal="true"
            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"   ClientInstanceName="PopupCargos"
            AllowDragging="True" PopupAnimationType="None"  EnableViewState="False" Height="300px" Width="600px" AutoUpdatePosition="true">
              <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxGridView ID="GV_Cargos" runat="server" 
                     AutoGenerateColumns="False" EnableTheming="True" KeyFieldName="ID_Cargo"
                     OnRowUpdated="GV_Cargos_RowUpdated" OnRowInserted="GV_Cargos_RowInserted"  Style="margin-left: auto; margin-right: auto;">
                     <ClientSideEvents 
        EndCallback="function(s, e) {
                        if (s.cpUpdateMessageCargo) {
                            alert(s.cpUpdateMessageCargo);
                                delete s.cpUpdateMessageCargo;

                        }
                    }"
    />
                     <SettingsPager PageSize="5">
                     </SettingsPager>
            <SettingsBehavior ConfirmDelete="True" EnableRowHotTrack="True" />
            <SettingsCommandButton>
                <NewButton ButtonType="Button" RenderMode="Button" Text="Nuevo Cargo">
                    <Image IconID="actions_add_16x16">
                    </Image>
                    <Styles>
                        <Style BackColor="White" ForeColor="Black" Width="20px">
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
                        <Style BackColor="White" ForeColor="Black" Width="20px">
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
                        <Style BackColor="White" ForeColor="Black" Width="20px">
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
                        <FilterControl AutoUpdatePosition="False">
                        </FilterControl>
                    </SettingsPopup>
                     <SettingsSearchPanel Visible="True" />
                    <Columns>
                        <dx:GridViewCommandColumn ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" ButtonRenderMode="Image" ButtonType="Image" VisibleIndex="0">
                         <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle  HorizontalAlign="Center">
                    </CellStyle>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ID_Cargo" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Nombre_Cargo" ShowInCustomizationForm="True" VisibleIndex="2" Caption="NOMBRE CARGO">
                              <PropertiesTextEdit>
                                  <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithText" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                      <RequiredField ErrorText="El nombre del cargo es requerido." IsRequired="True" />
                                  </ValidationSettings>
                              </PropertiesTextEdit>
                              <HeaderStyle BackColor="#3498DB" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <CellStyle HorizontalAlign="Center">
                    </CellStyle>
                        </dx:GridViewDataTextColumn>
                    </Columns>
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
                <%--<asp:SqlDataSource ID="SqlDataSource_Cargos" runat="server" ConnectionString='<%$ ConnectionStrings:DB_PARTICIPACIONConnectionString %>' DeleteCommand="DELETE tblCargos WHERE ID_Cargo=@ID_Cargo" InsertCommand="INSERT INTO tblCargos  (Nombre_Cargo)
VALUES (@Nombre_Cargo)"
                    SelectCommand="	SELECT  ID_Cargo, 
                                            Nombre_Cargo
                                    FROM [tblCargos]
                                    WHERE Activo =1"
                    UpdateCommand="UPDATE tblCargos SET Nombre_Cargo=@Nombre_Cargo
WHERE ID_Cargo=@ID_Cargo">
                    <DeleteParameters>
                        <asp:Parameter Name="ID_Cargo" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Nombre_Cargo" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Nombre_Cargo" />
                        <asp:Parameter Name="ID_Cargo" />
                        </UpdateParameters>
                </asp:SqlDataSource>--%>
                    </dx:PopupControlContentControl>
        </ContentCollection>
          </dx:ASPxPopupControl>

    </div>
            <%--</asp:Panel>--%>
</asp:Content>
