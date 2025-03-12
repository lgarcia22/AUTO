<%@ Page Title="" Language="C#" MasterPageFile="~/Light.master" AutoEventWireup="true" CodeBehind="ResetPasswordConfirmation.aspx.cs" Inherits="PREDJL.Account.ResetPasswordConfirmation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
<div class="accountHeader" style="text-align:center; color:darkslategray; font-family:sans-serif;">
    <h2>Contraseña Cambiada</h2>
</div>
    <div class="accountHeader" style="text-align:center; color:black; font-family:sans-serif;">
<p >Se ha cambiado su contraseña. Haga Click
    <dx:ASPxHyperLink ID="login" runat="server" NavigateUrl="Login.aspx" Text="Aquí" /> para iniciar sesión </p>
</div>
</asp:Content>
