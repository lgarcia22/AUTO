<%@ Page Title="" Language="C#" MasterPageFile="~/Light.master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="PREDJL.Account.ForgotPassword" %>

<asp:content id="Content1" contentplaceholderid="MainContent" runat="server">
     <!--
<div class="accountHeader">-->
    <style>
        .btn{
              -webkit-border-radius: 35px;
    -moz-border-radius: 35px;
    border-radius: 35px;
    /*background: #3498DB;*/
        }
    </style>
    <div style="text-align:center; color:darkslategray; font-family:sans-serif;">
    <h2 style="color:darkslategray">Contraseña olvidada</h2>
            <hr style="color:aquamarine" />
        </div>
        <br />
     <div style="width: 25%;  margin: 0px auto;">
<asp:PlaceHolder id="loginForm" runat="server">
    <h4>¿Olvidó su contraseña?</h4>
    <p style="color:red"><asp:Literal runat="server" ID="FailureText" /></p>
    <dx:ASPxTextBox runat="server" ID="Email" Caption="Correo electrónico" CssClass="btn" NullText="Correo electrónico" Width="280px" >
        <ValidationSettings Display="Dynamic"  ErrorTextPosition="Bottom">
            <RequiredField IsRequired="true" ErrorText="El campo de correo electrónico es requerido" />
        </ValidationSettings>
    </dx:ASPxTextBox><br />

    <dx:ASPxButton ID="btnSubmit" runat="server" Text="Enviar enlace al correo electrónico para restablecer su contraseña " CssClass="btn" OnClick="Forgot"  />
</asp:PlaceHolder>
<asp:PlaceHolder runat="server" ID="DisplayEmail" Visible="false">
    <p style="text-align:center">Por favor revise su correo electrónico para restablecer su contraseña.</p>
</asp:PlaceHolder>
            
   </div>
 </asp:Content>
