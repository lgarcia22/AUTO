<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PreRegistroSDJL.aspx.cs" Inherits="PREDJL.PreRegistroSDJL" %>

<%@ Register Assembly="DevExpress.XtraReports.v21.2.Web.WebForms, Version=21.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <!-- basic -->
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
       <meta name="viewport" content="width=device-width, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0" />
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
      <meta name="viewport" content="initial-scale=1, maximum-scale=1"/>
      <!-- site metas -->
      <title>AutoEnrolamiento</title>
      <meta name="keywords" content=""/>
      <meta name="description" content=""/>
      <meta name="author" content=""/>
      <!-- bootstrap css -->
      <link rel="icon" href="favicon.ico" type="image/x-icon"/>
       <link href="Content/Form.css" rel="stylesheet" />
       <link href="Content/Denuncia.css" rel="stylesheet" />
       <link href="Content/css/responsive.css" rel="stylesheet" />
       <link href="Content/css/owl.carousel.min.css" rel="stylesheet" />
       <link href="Content/Fontawesome/css/all.css" rel="stylesheet" />
       <link href="Content/Fontawesome/css/fontawesome.css" rel="stylesheet" />
       <link href="Content/css/bootstrap.min.css" rel="stylesheet" />
       <link href="Content/css/sweetalert2.min.css" rel="stylesheet" />
       <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
       <script src="Content/Registro.js"></script>
       <script src="Content/js/sweetalert2.all.min.js"></script>
<%--       <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>--%>
   </head>
   <!-- body -->
   <body class="main-layout">
       <%--<div id="list"></div>--%>
        <!-- loader  -->
<%-- <div class="loader_bg">
    <div class="loader"><img src="Content/Images/loading.gif" alt="#"/></div>
 </div>--%>
        <header class="header-area">
            <div class="container">
               <div class="row d_flex">
                  <div class=" col-md-3">
                     <div class="logo">
                        <a href="https://www.tsc.gob.hn/"> <img src="Content/Images/LOGO_TSC_2024_Logo.png"  alt="#"/>T<span>SC</span></a>
                     </div>
                  </div>
                  <div class="col-md-9 col-sm-12">
                    <div class="navbar-area">
                      <nav class="site-navbar">
                        <ul>
                            <li><a class="active" href="https://www.tsc.gob.hn/index.php/sistema-para-la-declaracion-jurada-en-linea/" target="_blank"><i class="fa fa-home"></i> Inicio</a></li>
                            <li><a href="Content/Manuales/Manual_de%20%20Usuario_Auto%20enrolamiento.pdf" target="_blank"><i class="fa fa-book"></i> Manual de Usuario</a></li>
                        </ul>
                        <button class="nav-toggler">
                          <span></span>
                        </button>
                      </nav>
                    </div>
                  </div>
                </div>
            </div>
         </header>
   
       <form id="form1" runat="server" >
    
           <div class="services">

        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <div class="titlepage text_align_left">
                <h2 style="text-align:center">FORMULARIO DE AUTO ENROLAMIENTO</h2>
                  <h3 style="text-align:center">PARA EL SISTEMA DE DECLARACIÓN JURADA EN LÍNEA</h3>
              </div>
            </div>
          </div>

            <asp:scriptmanager id="ScriptManager1" runat="server" />
            <asp:SqlDataSource runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT * FROM [View_company] ORDER BY CompanyName ASC" ID="SqlDataSource_Deptos"></asp:SqlDataSource>
            <%--<asp:SqlDataSource runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT * FROM [Company] ORDER BY CompanyName ASC" ID="SqlDataSource_Deptos"></asp:SqlDataSource>--%>
        <asp:PlaceHolder ID="phDenunciado" runat="server">
        <dx:ASPxFormLayout runat="server" ID="formDenuncia" CssClass="formLayout">
              <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700" />
            <Items>
                   <dx:LayoutItem ShowCaption="False" HorizontalAlign="Left">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <table>
                                        <tr>
                                           <td >
                                              Bienvenido al Formulario de Auto Enrolamiento de Declaración Jurada de Ingresos, Activos y Pasivos en Linea, favor llenar los siguientes campos para la solicitud de usuario.
                                             <br />
                                             <br />
                                              Los campos marcados con * son obligatorios.
                                           </td>
                                        </tr>
                                    </table>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                  </dx:LayoutItem>
                <dx:LayoutGroup Caption="1. DATOS DEL EMPLEADO *" ColCount="1" GroupBoxDecoration="HeadingLine" UseDefaultPaddings="false" Paddings-PaddingTop="10">
                   <GroupBoxStyle>
                        <Caption Font-Bold="true" Font-Size="15" />
                    </GroupBoxStyle>
                     <Items>
                         <dx:LayoutItem Caption="Nombres del Empleado" ColSpan="1" >
    <LayoutItemNestedControlCollection>
        <dx:LayoutItemNestedControlContainer runat="server">
<dx:ASPxTextBox ID="tbNombre" runat="server" NullText="Nombres del Empleado" ToolTip="Ingrese sus Nombres" 
    ClientInstanceName="tbNombre" CaptionSettings-RequiredMarkDisplayMode="Hidden">
    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" 
        SetFocusOnError="True" EnableCustomValidation="True">
        <RequiredField ErrorText="Los Nombres son requeridos." IsRequired="true"/>
    </ValidationSettings>
    <ClientSideEvents KeyUp="function(s, e) { 
        s.SetText(s.GetText().toUpperCase()); 
        CustomValidateNombre(s); 
    }" />
</dx:ASPxTextBox>
        </dx:LayoutItemNestedControlContainer>
    </LayoutItemNestedControlCollection>
</dx:LayoutItem>

<dx:LayoutItem ColSpan="1" Caption="Apellidos del Empleado">
    <LayoutItemNestedControlCollection>
        <dx:LayoutItemNestedControlContainer runat="server">
<dx:ASPxTextBox ID="tbApellido" runat="server" NullText="Apellidos del Empleado" ToolTip="Ingrese sus Apellidos" 
    ClientInstanceName="tbApellido">
    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" 
        SetFocusOnError="True" EnableCustomValidation="True">
        <RequiredField ErrorText="Los Apellidos son requeridos." IsRequired="true" />
    </ValidationSettings>
    <ClientSideEvents KeyUp="function(s, e) { 
        s.SetText(s.GetText().toUpperCase()); 
        CustomValidateApellido(s); 
    }" />
</dx:ASPxTextBox>
        </dx:LayoutItemNestedControlContainer>
    </LayoutItemNestedControlCollection>
</dx:LayoutItem>
     <dx:LayoutItem ColSpan="1" Caption="Número de identificación(Sin guiones)">
    <LayoutItemNestedControlCollection>
        <dx:LayoutItemNestedControlContainer runat="server">
            <dx:ASPxTextBox ID="tbDNI" runat="server" NullText="Número de identificación(Sin guiones)" ClientInstanceName="tbIdentidad"
                ToolTip="Ingresar el número de identificación nacional, número de pasaporte o carnet de residencia según aplique" onkeypress="javascript:return soloNumerosYLetras(event)" 
                Validation="tbDNI_Validation">
                <ValidationSettings ErrorDisplayMode="ImageWithTooltip" />
                <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" EnableCustomValidation="True"
                    ErrorDisplayMode="ImageWithText" CausesValidation="True">
                    <RequiredField ErrorText="El Número de identificación es requerida" IsRequired="true"/>
                </ValidationSettings>
                  <%--<ClientSideEvents KeyUp="function(s, e) { toUpperCase(s.GetInputElement().id); }" />--%>
                 <%--<ClientSideEvents KeyUp="function(s, e) { convierteTextoAMayusculas(s, e); }"  />--%>
<%--                                <ClientSideEvents KeyUp="function(s, e) {
    s.SetText(s.GetText().toUpperCase());
}" />--%>
                <ClientSideEvents Validation="function(s, e) { CustomValidateID(s, e); }" />
            </dx:ASPxTextBox>
        </dx:LayoutItemNestedControlContainer>
    </LayoutItemNestedControlCollection>
</dx:LayoutItem>


                           <dx:LayoutItem Caption="Correo Electrónico Personal" ColSpan="1">
    <LayoutItemNestedControlCollection>
        <dx:LayoutItemNestedControlContainer runat="server">
            <dx:ASPxTextBox ID="tbCorreo" runat="server" NullText="Correo Electrónico Personal" ClientInstanceName="tbCorreo" ToolTip="Ingresar su correo electrónico.">
                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" EnableCustomValidation="True" ErrorDisplayMode="ImageWithText" CausesValidation="True">
                    <RegularExpression ErrorText="El Correo Electrónico no es válido" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    <RequiredField ErrorText="El Correo Electrónico es requerida" IsRequired="true" />
                </ValidationSettings>
<%--                                <ClientSideEvents KeyUp="function(s, e) {
    s.SetText(s.GetText().toUpperCase());
}" />--%>
                 <%--<ClientSideEvents KeyUp="function(s, e) { convierteTextoAMayusculas(s, e); }"  />--%>
                <%--<ClientSideEvents KeyUp="function(s, e) { toUpperCase(s.GetInputElement().id); }" />--%>
                <ClientSideEvents />
            </dx:ASPxTextBox>
        </dx:LayoutItemNestedControlContainer>
    </LayoutItemNestedControlCollection>
</dx:LayoutItem>

<dx:LayoutItem Caption="Confirmar Correo Electrónico Personal" ColSpan="1">
    <LayoutItemNestedControlCollection>
        <dx:LayoutItemNestedControlContainer runat="server">
            <dx:ASPxTextBox ID="tbConfirmCorreo" runat="server" NullText="Confirmar Correo Electrónico Personal" ClientInstanceName="tbConfirmCorreo" ToolTip="Confirmar su correo electrónico.">
                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" EnableCustomValidation="True" ErrorDisplayMode="ImageWithText" CausesValidation="True">
                    <RegularExpression ErrorText="El Correo Electrónico no es válido" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    <RequiredField ErrorText="Se requiere confirmación Correo Electrónico Personal" IsRequired="true" />
                </ValidationSettings>
                <%--<ClientSideEvents KeyUp="function(s, e) { toUpperCase(s.GetInputElement().id); }" />--%>
                 <%--<ClientSideEvents KeyUp="function(s, e) { convierteTextoAMayusculas(s, e); }"  />--%>
<%--                                <ClientSideEvents KeyUp="function(s, e) {
    s.SetText(s.GetText().toUpperCase());
}" />--%>
                <ClientSideEvents Validation="function(s, e) {
                    var originalCorreo = tbCorreo.GetText();
                    var confirmCorreo = s.GetText();
                    e.isValid = (originalCorreo == confirmCorreo);
                    e.errorText = 'Correo Electrónico Personal deben coincidir.';
                }" />
            </dx:ASPxTextBox>
        </dx:LayoutItemNestedControlContainer>
    </LayoutItemNestedControlCollection>
</dx:LayoutItem>
                         <dx:LayoutItem ColSpan="1" Caption="Dependencia/Gerencia">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="tbDependencia" runat="server" NullText="Ingrese la Dependencia/Gerencia" ToolTip="Ingrese la Dependencia/Gerencia" ClientInstanceName="tbDependencia">
                                        
                                         <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" ErrorDisplayMode="ImageWithText">
                                             <RequiredField ErrorText="La Dependencia/Gerencia es requerida" IsRequired="true" />
                                        
                                        </ValidationSettings>
                                         <%--<ClientSideEvents KeyUp="function(s, e) { toUpperCase(s.GetInputElement().id); }" />--%>
                                         <%--<ClientSideEvents KeyUp="function(s, e) { convierteTextoAMayusculas(s, e); }"  />--%>
                                                        <ClientSideEvents KeyUp="function(s, e) {
    s.SetText(s.GetText().toUpperCase());
}" />
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                          <dx:LayoutItem ColSpan="1" Caption="Fecha de Ingreso al Cargo/Puesto">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="tbFechaIngreso" runat="server" NullText="Ingrese la Fecha de Ingreso al Cargo/Puesto" ToolTip="Fecha de Ingreso al Cargo/Puesto" ClientInstanceName="tbFechaIngreso" SettingsAdaptivity-Mode="Off"></dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                          <dx:LayoutItem Caption="Celular/Teléfono(Sin guiones)" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="tbCelular" runat="server" NullText="Celular/Teléfono(Sin guiones)" ToolTip="Ingresar su teléfono celular" 
    ValidationGroup="okButton" onkeypress="javascript:return solonumeros(event)" MaxLength="8" Size="8" 
    ClientInstanceName="tbCelular">
    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" 
        SetFocusOnError="True" ErrorDisplayMode="ImageWithText" EnableCustomValidation="True">
        <RequiredField ErrorText="El Teléfono es requerido" IsRequired="true" />
    </ValidationSettings>
    <ClientSideEvents Validation="function(s, e) { CustomValidateCelular(s, e); }" />
</dx:ASPxTextBox>

<%--                                    <dx:ASPxTextBox ID="tbCelular" runat="server" NullText="Celular/Teléfono" ToolTip="Ingresar su teléfono celular" ValidationGroup="okButton" onkeypress="javascript:return solonumeros(event)" MaxLength="8" Size="8" ClientInstanceName="tbCelular">
    <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" ErrorDisplayMode="ImageWithText">
        <RequiredField ErrorText="El Teléfono es requerido" IsRequired="true" />
    </ValidationSettings>
</dx:ASPxTextBox>--%>
                           <%--         <dx:ASPxTextBox ID="tbCelular" runat="server" NullText="Celular/Teléfono" ToolTip="Ingresar su teléfono celular" ValidationGroup="okButton" onkeypress="javascript:return solonumeros(event)" MaxLength="8" Size="8" ClientInstanceName="tbCelular">
                                       <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" ErrorDisplayMode="ImageWithText">
                                         <RequiredField ErrorText="El Teléfono es requerido" IsRequired="true" />

                                    </ValidationSettings>
                                    </dx:ASPxTextBox>--%>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                            <dx:LayoutItem ColSpan="1" Caption="Institución a la que labora">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox runat="server" ID="CmbCountry" ClientInstanceName="CmbCountry" DataSourceID="SqlDataSource_Deptos" TextField="CompanyName" ValueField="Id" NullText="Seleccione la Institución" ToolTip="Seleccionar la institución donde labora" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top" ListBoxStyle-HorizontalAlign="Left" SettingsAdaptivity-Mode="OnWindowInnerWidth" SettingsAdaptivity-SwitchToModalAtWindowInnerWidth="500" PopupHorizontalAlign="LeftSides" PopupVerticalAlign="Above" LoadDropDownOnDemand="True" ListBoxStyle-Wrap="True" ListBoxStyle-VerticalAlign="Top" ItemStyle-Wrap="True">

                                        <%--<ClientSideEvents SelectedIndexChanged="function(s,e){OnCountryChanged(s.GetSelectedItem().value.toString());}"/>--%>
                                        <ClearButton DisplayMode="OnHover"></ClearButton>

                                        <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" ErrorDisplayMode="ImageWithText">
                                             <RequiredField ErrorText="La Institución es requerida." IsRequired="true" />
                                        </ValidationSettings>
                                   </dx:ASPxComboBox> 
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                       <%-- <dx:LayoutItem ColSpan="1" Caption="Tipo de Declaración">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                   <dx:ASPxComboBox runat="server" ID="CmbTipoDeclaracion" ClientInstanceName="CmbTipoDeclaracion" NullText="Seleccione el tipo de Declaración" ToolTip="Seleccionar el Tipo de Declaración" ClearButton-ImagePosition="Left" ClearButton-DisplayMode="Auto" SettingsAdaptivity-Mode="Off" SettingsAdaptivity-SwitchToModalAtWindowInnerWidth="400">
                                       <Items>
                                           <dx:ListEditItem Text="Ingresar al cargo o al servicio público" Value="0" ></dx:ListEditItem>
                                           <dx:ListEditItem Text="Por llegar a la base salarial establecida" Value="1" ></dx:ListEditItem>
                                           <dx:ListEditItem Text="A requerimiento del Tribunal Superior de Cuentas (TSC)" Value="2" ></dx:ListEditItem>
                                           <dx:ListEditItem Text="Cesar en el cargo o servicio público" Value="3" ></dx:ListEditItem>
                                           <dx:ListEditItem Text="Actualización Anual" Value="4" ></dx:ListEditItem>

                                       </Items>

                                       <ClearButton DisplayMode="OnHover"></ClearButton>

                                       <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True" ErrorDisplayMode="ImageWithText">
                                             <RequiredField ErrorText="El Tipo de Declaración es requerido." IsRequired="true" />
                                        </ValidationSettings>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>--%>
                         <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center">
    <LayoutItemNestedControlCollection>
        <dx:LayoutItemNestedControlContainer runat="server">
            <dx:ASPxButton ID="btnEnviarCodigo" runat="server" Text="Enviar Código" AutoPostBack="False" UseSubmitBehavior="false" CssClass="btn" ClientInstanceName="btnEnviarCodigo">
               
                <ClientSideEvents Click="btnEnviarCodigo_Click" />
            </dx:ASPxButton>
            <dx:ASPxCallback ID="ASPxCallback_EnviarToken" runat="server" ClientInstanceName="ASPxCallback_EnviarToken" OnCallback="ASPxCallback_EnviarToken_Callback"></dx:ASPxCallback>
        </dx:LayoutItemNestedControlContainer>
    </LayoutItemNestedControlCollection>
</dx:LayoutItem>
                          <dx:LayoutItem ColSpan="1" ShowCaption="False" HorizontalAlign="Center">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
     
                                       <dx:ASPxCheckBox ID="ckPolitica" runat="server" EncodeHtml="false" ClientInstanceName="ckPolitica" ClientVisible="False"
                 Text="Acepto los términos y politicas del Tribunal Superior de Cuentas" ValidationSettings-CausesValidation="true"> 
                                            <ClientSideEvents CheckedChanged="Terminos" />
</dx:ASPxCheckBox>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                     </Items>
                </dx:LayoutGroup>
            </Items>
             <Items>
        <%--    <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center"><LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                    <table>
                                        <tr>
                                            <td style ="text-align:center" >
                                                 <div style ="text-align:center" >
                                                <br />
                                                <dx:ASPxLabel ID="AllowedTypesLabel" runat="server" Font-Size="Medium" Text="Tipos de archivos permitidos: pdf,jpe,jpeg,jpg,png" />
                                                <br />
                                                <dx:ASPxLabel ID="MaxFileSizeLabel" runat="server" Font-Size="Medium" Text="Solo se permite adjuntar como limite 5 archivos con un peso de 10 MB maximo cada archivo." ForeColor="Red"/>
                                     
                                                    <br />
                                                
                                                    <dx:ASPxLabel ID="Mens" runat="server" ClientInstanceName="Mens" Font-Size="X-Small">
                                                </dx:ASPxLabel>
                                                <br />
                                                    <br />
                                                      </div>
                                                    <div style ="text-align:center" >
                                                <dx:ASPxUploadControl ID="UploadControl" runat="server" AutoStartUpload="true" Width="100%" NullText="Seleccionar los documentos a subir"  OnFileUploadComplete="UploadControl_FileUploadComplete" ShowProgressPanel="true" UploadMode="Advanced" ToolTip="Seleccionar los documentos a subir" AddUploadButtonsHorizontalPosition="Center" Theme="Moderno" ValidationSettings-MaxFileCount="5" ValidationSettings-MaxFileSize="5" ValidationSettings-ShowErrors="False">
                                                <ValidationSettings AllowedFileExtensions=".pdf,.jpe,.jpeg,.jpg,.png" MaxFileSize="41943040" MaxFileCount="5" ShowErrors="False" />
                                                <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="True" EnableDragAndDrop="True" />
                                                <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                                                </dx:ASPxUploadControl>
                                                     <dx:ASPxLabel ID="ASPxLabel1" runat="server" ClientInstanceName="fileNameLabel" Font-Size="Medium">
                                                </dx:ASPxLabel>
                                                        <dx:ASPxButton ID="ASPxButton1" runat="server" RenderMode="Link" Text="Eliminar" Font-Size="Medium" ForeColor="#CC0000" ClientVisible="false" ClientInstanceName="deleteFileButton" AutoPostBack="false" >
                                                            <ClientSideEvents Click="onClick" />
                                                        </dx:ASPxButton>
                                                      <br />
                                                <dx:ASPxLabel ID="FileNameLabel" runat="server" ClientInstanceName="fileNameLabel" Font-Size="Medium">
                                                </dx:ASPxLabel>
                                                      
                                                      <dx:ASPxCallback ID="ASPxCallback_Guardar_Dctos" runat="server" OnCallback="ASPxCallback_Guardar_Dctos_Callback" ClientInstanceName="ASPxCallback_Guardar_Dctos">
                                                           
                                                        <ClientSideEvents CallbackComplete="Guardar_Dctos_Complete" />
                                                      </dx:ASPxCallback>
                                                    <dx:ASPxCallback ID="Callback" ClientInstanceName="callback" runat="server" OnCallback="Callback_Callback">
                                                    <ClientSideEvents CallbackComplete="onCallbackComplete" />
                                                </dx:ASPxCallback>
                                                     
                                                  <br />
                                                        <div id="fileListContainer"></div>
                                              </div>
                                            </td> 
                                        </tr>
                                    </table>
                                </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>--%>
                                </Items>
                      
            </dx:ASPxFormLayout>
        </asp:PlaceHolder>

              <dx:ASPxPopupControl ID="popupToken" runat="server" ClientInstanceName="popupToken" HeaderText="Verificación de Código" CloseAction="CloseButton" CloseOnEscape="true" CssClass="popup1"
    Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" MinWidth="310px" MinHeight="214px" Width="400px" Height="200px" SettingsAdaptivity-Mode="OnWindowInnerWidth" CloseAnimationType="None" AllowResize="False" AutoUpdatePosition="True" SettingsAdaptivity-VerticalAlign="WindowCenter" 
    AllowDragging="True" EnableViewState="False">
    <HeaderStyle CssClass="headerpopup" />
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <table class="dx-justification">
                <tr>
                    <td style="text-align:center;">
                        <dx:ASPxLabel ID="lblTokenPrompt" runat="server" Text="Ingrese el código enviado a su correo" />
                        <br /><br />
                        <dx:ASPxTextBox ID="tbToken" runat="server" NullText="Código de Verificación" ClientInstanceName="tbToken" Width="100%" />
                        <br /><br />
                        <dx:ASPxButton ID="btnVerificarToken" runat="server" Text="Verificar Código" AutoPostBack="False" UseSubmitBehavior="false" CssClass="btn" ClientInstanceName="btnVerificarToken">
                            <ClientSideEvents Click="btnVerificarToken_Click" />
                        </dx:ASPxButton>
                        <dx:ASPxCallback ID="ASPxCallback_VerificarToken" runat="server" ClientInstanceName="ASPxCallback_VerificarToken" OnCallback="ASPxCallback_VerificarToken_Callback">
    <ClientSideEvents CallbackComplete="function(s, e) { TokenVerificationComplete(e.result); }" />
</dx:ASPxCallback>
                    </td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
            <div class="container" >
                        <%--<dx:ASPxPopupControl ID="Enviar" runat="server" ClientInstanceName="Enviar" HeaderText="Políticas y Términos" CloseAction="CloseButton" CloseOnEscape="true" CssClass="container-fluid popup " 
                Modal="True"  PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AllowDragging="True" EnableViewState="False" AutoUpdatePosition="true" MinWidth="600px" MinHeight="800px"   SettingsAdaptivity-VerticalAlign="WindowCenter" SettingsAdaptivity-Mode="OnWindowInnerWidth" SettingsAdaptivity-HorizontalAlign="WindowCenter" ScrollBars="Vertical"            
                            PopupAnimationType="Fade">
                <HeaderStyle CssClass="headerpopup" />
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <div class="container" style="text-align: justify;">
                <p>
                    “Por medio de la presente solicito la incorporación al Sistema de Declaración Jurada de Ingresos, Activos y Pasivos en Línea, como un requisito obligatorio de conformidad con la Ley Orgánica del TSC y su Reglamento, y Declarando bajo juramento que toda la información utilizada en el Sistema de Declaraciones Juradas en Línea, será completada y aprobada por quien suscribe como responsable de la misma, la que será cierta, correcta y completa.
                </p>
                <p>
                    Es mi responsabilidad como servidor público obligado, mantener en estricta confidencialidad y reserva las credenciales de ingreso al Sistema en Línea, no debiendo compartirlas ni dejarlas al acceso de ninguna otra persona.
                </p>
                <p>
                    Adicionalmente, por este medio autorizo de forma expresa e irrevocable al Tribunal Superior de Cuentas para confirmar el contenido de las Declaraciones Juradas realizadas mediante el Sistema en Línea, en cualquier tiempo y lugar. Autorizando al mismo tiempo para que investigue las cuentas, depósitos bancarios, bienes, participación en sociedades situados en el país o en el extranjero y en general para que comparezcan ante quien corresponda a realizar la verificación de la Información contenida en las referidas Declaraciones.
                </p>
                <p>
                    La presente solicitud se fundamenta en los artículos 56, 57, 61, 67 y demás aplicables de la Ley Orgánica del Tribunal Superior de Cuentas; 59, 60, 61 y demás aplicables del Reglamento General de la Ley Orgánica del Tribunal Superior de Cuentas.
                </p>
                <p>
                    <strong>Al Honorable Tribunal Superior de Cuentas respetuosamente PIDO:</strong> Admitir el presente escrito, realizar la incorporación correspondiente al Sistema de Declaraciones Juradas en Línea, tener por autorizado al Tribunal para realizar la confirmación de los datos de las Declaraciones de Ingresos, Activos y Pasivos realizadas por medio del sistema y en general, resolver conforme con lo solicitado.”
                </p>
            </div>
            <br />
            <div class="dx-justification" style="text-align: center;">
                <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Enviar" AutoPostBack="False" UseSubmitBehavior="false" CausesValidation="true" CssClass="btn" HorizontalAlign="Right" Enabled="True" ClientVisible="True" ClientInstanceName="ASPxButton2" ClientEnabled="False">
                    <ClientSideEvents Click="BtnGuardar_Click" />
                </dx:ASPxButton>
                <dx:ASPxCallback ID="ASPxCallback_Guardar_Datos" runat="server" OnCallback="ASPxCallback_Guardar_Datos_Callback" ClientInstanceName="ASPxCallback_Guardar_Datos">
                    <ClientSideEvents CallbackComplete="Guardar_Datos_Complete" />
                </dx:ASPxCallback>
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>--%>


                            <dx:ASPxPopupControl ID="Enviar" runat="server" ClientInstanceName="Enviar" HeaderText="Políticas y Términos" CloseAction="CloseButton" CloseOnEscape="true" CssClass="container popup"
                Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" MinWidth="500px" MinHeight="114px" AllowDragging="True" EnableViewState="False" AutoUpdatePosition="true" SettingsAdaptivity-Mode="OnWindowInnerWidth" CloseAnimationType="None" AllowResize="False" SettingsAdaptivity-VerticalAlign="WindowCenter"
                PopupAnimationType="Fade" ScrollBars="Vertical" ShowViewportScrollbarWhenModal="True" ShowPageScrollbarWhenModal="True">
                <%--<HeaderStyle CssClass="headerpopup" />--%>
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <div class="container" style="text-align: justify;">
                <p>
                    “Por medio de la presente solicito la incorporación al Sistema de Declaración Jurada de Ingresos, Activos y Pasivos en Línea, como un requisito obligatorio de conformidad con la Ley Orgánica del TSC y su Reglamento, y Declarando bajo juramento que toda la información utilizada en el Sistema de Declaraciones Juradas en Línea, será completada y aprobada por quien suscribe como responsable de la misma, la que será cierta, correcta y completa.
                </p>
                <p>
                    Es mi responsabilidad como servidor público obligado, mantener en estricta confidencialidad y reserva las credenciales de ingreso al Sistema en Línea, no debiendo compartirlas ni dejarlas al acceso de ninguna otra persona.
                </p>
                <p>
                    Adicionalmente, por este medio autorizo de forma expresa e irrevocable al Tribunal Superior de Cuentas para confirmar el contenido de las Declaraciones Juradas realizadas mediante el Sistema en Línea, en cualquier tiempo y lugar. Autorizando al mismo tiempo para que investigue las cuentas, depósitos bancarios, bienes, participación en sociedades situados en el país o en el extranjero y en general para que comparezcan ante quien corresponda a realizar la verificación de la Información contenida en las referidas Declaraciones.
                </p>
                <p>
                    La presente solicitud se fundamenta en los artículos 56, 57, 61, 67 y demás aplicables de la Ley Orgánica del Tribunal Superior de Cuentas; 59, 60, 61 y demás aplicables del Reglamento General de la Ley Orgánica del Tribunal Superior de Cuentas.
                </p>
                <p>
                    <strong>Al Honorable Tribunal Superior de Cuentas respetuosamente PIDO:</strong> Admitir el presente escrito, realizar la incorporación correspondiente al Sistema de Declaraciones Juradas en Línea, tener por autorizado al Tribunal para realizar la confirmación de los datos de las Declaraciones de Ingresos, Activos y Pasivos realizadas por medio del sistema y en general, resolver conforme con lo solicitado.”
                </p>
            </div>
            <br />
            <div class="dx-justification" style="text-align: center;">
                <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Enviar" AutoPostBack="False" UseSubmitBehavior="false" CausesValidation="true" CssClass="btn" HorizontalAlign="Right" Enabled="True" ClientVisible="True" ClientInstanceName="ASPxButton2" ClientEnabled="False">
                    <ClientSideEvents Click="BtnGuardar_Click" />
                </dx:ASPxButton>
                <dx:ASPxCallback ID="ASPxCallback_Guardar_Datos" runat="server" OnCallback="ASPxCallback_Guardar_Datos_Callback" ClientInstanceName="ASPxCallback_Guardar_Datos">
                    <ClientSideEvents CallbackComplete="Guardar_Datos_Complete" />
                </dx:ASPxCallback>
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
                </div>
     

              <dx:ASPxPopupControl ID="Relacionado" runat="server" ClientInstanceName="Relacionado" 
                   AllowDragging="true" HeaderText="Auto Enrolamiento" 
             Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" CloseOnEscape="true" 
                  EnableViewState="False" AutoUpdatePosition="true" MinHeight="750px" SettingsAdaptivity-Mode="OnWindowInnerWidth" CloseAnimationType="None" AllowResize="False" SettingsAdaptivity-VerticalAlign="WindowCenter">
                   <ClientSideEvents Shown="popup_Shown_comprobante" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                                     <%-- <br />
                                        <dx:ASPxLabel ID="Lbl_msg" runat="server" ClientInstanceName="Lbl_msg" Text="">
                                            </dx:ASPxLabel>
                                                <br />
                                                <br />--%>
                  <dx:ASPxCallbackPanel runat="server" ID="callbackPane_comprobante" ClientInstanceName="callbackPane_comprobante"
                        OnCallback="callbackPane_comprobante_Callback" RenderMode="Table" Width="100%" SettingsCollapsing-Modal="True">
                               <PanelCollection> 
                 <dx:PanelContent runat="server">
<%--               
          <dx:ASPxWebDocumentViewer ID="ASPxWebDocumentViewer1" runat="server" Height="750px" RightToLeft="True" 
                     DisableHttpHandlerValidation="False" >

          </dx:ASPxWebDocumentViewer>--%>
                      

        <dx:ASPxWebDocumentViewer 
    ID="ASPxWebDocumentViewer1" 
    runat="server" 
    ClientInstanceName="ASPxWebDocumentViewer1" 
    Height="750px" 
    RightToLeft="True" 
    DisableHttpHandlerValidation="False"
   >
             <%--ClientSideEvents-Init="function(s, e) { onDocumentViewerInit(); }"--%>
</dx:ASPxWebDocumentViewer>


                      </dx:PanelContent>
                    </PanelCollection>
                                 </dx:ASPxCallbackPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ClientSideEvents CloseUp="ClosePopupRelacionado" />
    </dx:ASPxPopupControl>

        </div>
        </div>
           </form>
      <!-- end innva -->
      <!-- footer -->
      <footer>
    <div class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <ul class="conta">
                        <li> <span>Dirección</span> Centro civico Gubernamental, Bulevar Fuerzas Armadas <br /> Honduras, C.A </li>
                        <li> <span>Correo Eléctronico</span> <a href="mailto:dj@tsc.gob.hn">dj@tsc.gob.hn</a> <br/><a href="mailto:mesadeayudadj@tsc.gob.hn">mesadeayudadj@tsc.gob.hn</a>  </li>
                        <li> <span>Contacto</span> <a href="Javascript:void(0)">Tel(+504) 2230-8789</a> </li>
                    </ul>
                </div>
                <div class="col-md-12">
                    <div class="Informa">
                        <ul class="social_icon text_align_center">
                            <li> <a href="https://www.tsc.gob.hn/"> <i class="fa fa-solid fa-globe"></i></a></li>
                            <li> <a href="http://www.facebook.com/tschonduras"> <i class="fa-brands fa-facebook"></i></a></li>
                            <li> <a href="http://www.twitter.com/tschonduras">  <i class="fa-brands fa-x-twitter"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="copyright text_align_center">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <p> &copy; Copyright 2024 Informática | Tribunal Superior de Cuentas.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>
   </body>
</html>
