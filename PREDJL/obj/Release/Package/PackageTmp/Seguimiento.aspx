<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Seguimiento.aspx.cs" Inherits="PREDJL.Seguimiento" %>



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
    <title>Seguimiento</title>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <!-- bootstrap css -->
    <link rel="icon" href="favicon.ico" type="image/x-icon"/>
    <link href="Content/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/Form.css" rel="stylesheet" />
    <link href="Content/Consulta.css" rel="stylesheet" />
    <link href="Content/css/responsive.css" rel="stylesheet" />
    <link href="Content/css/owl.carousel.min.css" rel="stylesheet" />
    <link href="Content/Fontawesome/css/all.css" rel="stylesheet" />
    <link href="Content/Fontawesome/css/fontawesome.css" rel="stylesheet" />
    <link href="Content/css/bootstrap.css" rel="stylesheet" />
    <link href="Content/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/css/sweetalert2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
    <script src="Content/Consulta.js"></script>
     <script src="Content/js/sweetalert2.all.min.js"></script>
</head>
<!-- body -->
<body class="main-layout">
    <header class="header-area">
        <div class="container">
            <div class="row d_flex">
                <div class="col-md-3">
                    <div class="logo">
                        <a href="https://www.tsc.gob.hn/"> <img src="Content/Images/LOGO_TSC_2024_Logo.png" alt="#"/>T<span>SC</span></a>
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
    <form id="form1" runat="server" class="content">
        <div class="services">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="titlepage text_align_left">
                            <h2 style="text-align:center">SEGUIMIENTO DE CREACIÓN DE USUARIO</h2>
                            <h3 style="text-align:center">PARA EL SISTEMA DE DECLARACIÓN JURADA EN LINEA</h3>
                        </div>
                    </div>
                </div>

                <asp:scriptmanager id="ScriptManager1" runat="server" />
                <asp:SqlDataSource runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT * FROM [Company]" ID="SqlDataSource_Deptos"></asp:SqlDataSource>
                <asp:PlaceHolder ID="phDenunciado" runat="server">
                    <dx:ASPxFormLayout runat="server" ID="formDenuncia" CssClass="formLayout">
    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700" />
    <Items>
        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Left">
            <LayoutItemNestedControlCollection>
                <dx:LayoutItemNestedControlContainer>
                    <table>
                        <tr>
                            <td>
                                Seguimiento de creación de usuario para la Declaración Jurada de Ingresos, Activos y Pasivos en Linea, favor llenar el siguiente campo para realizar la consulta.
                                <br />
                                <br />
                                <br />
                                Los campos marcados con * son obligatorios.
                                <br />
                                <br />
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
            </Items>
        </dx:LayoutGroup>
    </Items>
</dx:ASPxFormLayout>
                </asp:PlaceHolder>
                            <dx:ASPxPopupControl ID="popupToken" runat="server" ClientInstanceName="popupToken" HeaderText="Verificación de Código" CloseAction="CloseButton" CloseOnEscape="true" CssClass="popup"
    Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" MinWidth="250px" MinHeight="214px" Width="300px" Height="200px" SettingsAdaptivity-Mode="OnWindowInnerWidth" CloseAnimationType="None" AllowResize="False" AutoUpdatePosition="False" SettingsAdaptivity-VerticalAlign="WindowCenter"
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
<dx:ASPxPopupControl ID="popupUserStatus" runat="server" ClientInstanceName="popupUserStatus" HeaderText="Información de Usuario" CloseAction="CloseButton" CloseOnEscape="true" CssClass="popup"
 Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" MinWidth="350px" MinHeight="250px" Width="450px" Height="250px" SettingsAdaptivity-Mode="OnWindowInnerWidth" CloseAnimationType="None" AllowResize="False" AutoUpdatePosition="True" SettingsAdaptivity-VerticalAlign="WindowCenter"
 AllowDragging="True" EnableViewState="False">
    <HeaderStyle CssClass="headerpopup" />
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <div class="text-center">
                <span class="icon-wrap icon-wrap-xs icon-circle alert-icon">
                    <i class="fa fa-exclamation-circle fa-4x" aria-hidden="true" style="color: #0072C6;"></i>
                </span>
                <div class="mt-3">
                    <dx:ASPxLabel ID="AlertHeading" runat="server" Text="Atención" CssClass="alert-heading mt-0 attention-text"></dx:ASPxLabel>
                </div>
            </div>
            <div class="d-flex mt-3">
              <div class="flex-grow-1 ms-3">
    <p>Estimado(a) <strong>
        <dx:ASPxLabel ID="lblNombreUsuario" runat="server" ClientIDMode="Static" Text="" CssClass="font-weight-bold"></dx:ASPxLabel>
    </strong></p>
    <p>Su Auto Enrolamiento tiene el estado :<strong>
        <dx:ASPxLabel ID="lblEstadoUsuario" runat="server" ClientIDMode="Static" Text="" CssClass="font-weight-bold"></dx:ASPxLabel>
    </strong></p>
    <p><dx:ASPxLabel ID="lblObservacion" runat="server" Text="Observación:" CssClass="font-weight-bold"></dx:ASPxLabel>
    <dx:ASPxLabel ID="lblObs" runat="server" ClientIDMode="Static" Text=""></dx:ASPxLabel></p>
    <p>Atentamente.</p>
    <div id="progress-container" class="mt-3" style="width: 100%; height: 30px; background: lightgray; border-radius: 5px; position: relative;">
        <div id="progress-bar-fill" style="height: 100%; width: 0%; border-radius: 5px; text-align: right; color: white; font-weight: bold; padding-right: 10px; position: relative;"></div>
    </div>
    <hr/>
    <div class="mt-3">Simbología:</div>
    <dl class="mt-3">
    <dt style="color: gray;">Pre-Registrado</dt>
    <dd class="ms-3">Su información está en revisión.</dd>
    <dt style="color: #FAC21A;" class="mt-2">Procesando</dt>
    <dd class="ms-3">Su solicitud de creación de usuario se está procesando, por favor revisar su correo y estar al pendiente.</dd>
    <dt style="color: orangered;" class="mt-2">Requiere Documentación</dt>
    <dd class="ms-3">Su solicitud de creación de usuario necesita aportar documentación adicional.</dd>
    <dt style="color: red;" class="mt-2">Rechazado</dt>
    <dd class="ms-3">Su solicitud de creación de usuario ha sido rechazada.</dd>
   <%-- <dt style="color: green;" class="mt-2">Registrado</dt>
    <dd class="ms-3">Su usuario ha sido creado en el Sistema de Declaración Jurada en Línea.</dd>--%>
    </dl>
</div>

            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>





            </div>
        </div>
    </form>


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


