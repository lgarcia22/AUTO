<%@ Page Title="" Language="C#" MasterPageFile="~/menu.master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="PREDJL.Account.ChangePassword" %>
<asp:Content ID="Content" ContentPlaceHolderID="Head" runat="server">
    <link href="../Content/SignInRegister%20-%20Copia.css" rel="stylesheet" />
    <link href="../Content/css/sweetalert2.min.css" rel="stylesheet" />
    <script src="../Content/js/sweetalert2.all.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">
</asp:Content>
<%--<asp:Content ID="Content3" ContentPlaceHolderID="PageToolbar" runat="server">
</asp:Content>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
        <div  style="   background-color: white;
                        width: 495px;
	                    box-shadow: 0 0 15px 10px #E1E1E1;
                        border: 2px solid #E1E1E1;
                        border-radius: 20px;
                        padding: 15px;
	                    position: absolute;
	                    top: 50%;
	                    left: 50%;
	                    transform: translate(-50%, -50%);
                        background-color: white;">

            <div style="text-align:center">
         <dx:ASPxImage ID="ASPxImage1"  runat="server" ShowLoadingImage="true"  ImageUrl="~/Content/TSC/LOGO_TSC_2024V1.png" ></dx:ASPxImage>    
             </div>
     <div class="accountHeader" style="text-align:center;color:darkslategray; font-family:sans-serif;">
     <h2 runat="server" ID="PageHeader">Formulario para cambiar su contraseña</h2>
    <p runat="server" ID="PageDescription">Utilice el siguiente formulario para cambiar su contraseña.</p>
         <br />
    <h4 style="color:#FA5858">
      <asp:Literal runat="server" ID="ErrorMessage" />
    </h4>
</div>
             <div style="margin-right:auto;  margin-left: 69px;" >
<dx:ASPxTextBox ID="tbCurrentPassword" runat="server" ClientInstanceName="tbCurrentPassword"  Caption="Contraseña actual" NullText="Contraseña actual" Password="true" Width="350px" Theme="iOS" CssClass="Texbox">
    <CaptionSettings Position="Top" />
    <ValidationSettings ValidationGroup="ChangeUserPasswordValidationGroup" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
          <RequiredField ErrorText="Se requiere la contraseña actual." IsRequired="true" />
      </ValidationSettings>
</dx:ASPxTextBox>
<dx:ASPxTextBox ID="tbPassword" ClientInstanceName="Password" Caption="Nueva contraseña" NullText="Nueva contraseña" Password="true" runat="server" CssClass="Texbox"
      Width="350px" Theme="iOS">
    <CaptionSettings Position="Top" />
      <ValidationSettings ValidationGroup="ChangeUserPasswordValidationGroup" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
          <RequiredField ErrorText="Se requiere la contraseña nueva." IsRequired="true" />
      </ValidationSettings>
</dx:ASPxTextBox>
<dx:ASPxTextBox ID="tbConfirmPassword" Password="true" ClientInstanceName="tbConfirmPassword"  Caption="Confirmar la nueva contraseña" NullText="Confirmar la nueva contraseña" runat="server" Width="350px" Theme="iOS" CssClass="Texbox">
    <CaptionSettings Position="Top" />
      <ValidationSettings ValidationGroup="ChangeUserPasswordValidationGroup" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
          <RequiredField ErrorText="Se requiere confirmación de la contraseña nueva." IsRequired="true" />
      </ValidationSettings>
      <ClientSideEvents Validation="function(s, e) {
        var originalPasswd = Password.GetText();
        var currentPasswd = s.GetText();
        e.isValid = (originalPasswd  == currentPasswd );
        e.errorText = 'La contraseña y la contraseña de confirmación deben coincidir.';
    }" />
</dx:ASPxTextBox>
<br />

         </div>
             <div style="text-align:center">
                 <dx:ASPxButton ID="btnChangePassword" runat="server" Text="Cambiar contraseña" ValidationGroup="ChangeUserPasswordValidationGroup" CssClass="btn"
    OnClick="btnChangePassword_Click" Theme="iOS" Height="34px">
                  <ClientSideEvents Click="function(s, e){ 
e.processOnServer = confirm('¿Esta seguro de cambiar su contraseña?');
}" />





</dx:ASPxButton>

<%--<dx:ASPxButton ID="btnChangePassword" runat="server" Text="Cambiar contraseña" ValidationGroup="ChangeUserPasswordValidationGroup" CssClass="btn"
    OnClick="btnChangePassword_Click" Theme="iOS" Height="34px">
    <ClientSideEvents Click='function(s, e){ 
        e.processOnServer = false; // Detenemos el proceso del lado del servidor
        Swal.fire({
            title: "¿Está seguro de cambiar su contraseña?",
            text: "Este cambio no se puede deshacer",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Sí, cambiarla",
            cancelButtonText: "Cancelar"
        }).then(function(result) {
            if (result.isConfirmed) {
                // Si el usuario confirma, procesamos en el servidor
                e.processOnServer = true;
                // Forzar el postback para llamar al evento en el servidor
                s.DoClick();
            }
        });
    }' />
</dx:ASPxButton>--%>


<dx:ASPxButton ID="btnSetPassword" runat="server" Text="Set Password" Visible="false" ValidationGroup="ChangeUserPasswordValidationGroup" CssClass="btn"
    OnClick="btnSetPassword_Click">
      <PressedStyle>
        <BorderBottom BorderColor="#CCCCCC" />
    </PressedStyle>
    <HoverStyle BackColor="#069BFF" Border-BorderColor="#0066FF">
    </HoverStyle>
</dx:ASPxButton>
             </div>
             <br />
             <br />
         </div>
</asp:Content>
