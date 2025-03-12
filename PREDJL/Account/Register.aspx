<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Root.master" CodeBehind="Register.aspx.cs" Inherits="PREDJL.RegisterModule" Title="Register" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <link href="../Content/SignInRegister%20-%20Copia.css" rel="stylesheet" />
    <%--<link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/SignInRegister - Copia.css") %>' />--%>
    <style>

        .formLayout-container {
            background-color: white;
            width: 395px;
            box-shadow: 0 0 15px 10px #E1E1E1;
            border: 2px solid #E1E1E1;
            border-radius: 20px;
            padding: 15px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 395px;
        }
    </style>
  <%--  <script type="text/javascript" src='<%# ResolveUrl("~/Content/SignInRegister - Copia.js") %>'></script>--%>
    <script src="../Content/SignInRegister%20-%20Copia.js"></script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="server">
    <asp:Panel ID="Panel_Content" runat="server">
   <div class="formLayout-verticalAlign">
        <div class="formLayout-container">
            <br />
            <div style="text-align:center" >
            <dx:ASPxImage ID="ASPxImage1"  runat="server" ShowLoadingImage="true"  ImageUrl="~/Content/TSC/LOGO_TSC_2024V1.png" ></dx:ASPxImage>    
         </div>
            <div style="text-align:center" >
         </div> 
            <dx:ASPxFormLayout runat="server" ID="FormLayout" ClientInstanceName="formLayout" CssClass="formLayout" UseDefaultPaddings="false">
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                <SettingsItemCaptions Location="Top" />
                <Styles LayoutGroup-Cell-Paddings-Padding="0" LayoutItem-Paddings-PaddingBottom="8" >
<LayoutItem>
<Paddings PaddingBottom="8px"></Paddings>
</LayoutItem>

<LayoutGroup>
<Cell>
<Paddings Padding="0px"></Paddings>
</Cell>
</LayoutGroup>
                </Styles>
                <Items>
                    <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="None" Paddings-Padding="16">
<Paddings Padding="16px"></Paddings>
                        <Items>
                           <dx:LayoutItem ShowCaption="False" ColSpan="1" HorizontalAlign="Center"><LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                            <table>
                             <tr>
                               <td style="font-size:18px;">
                                <strong> Registrar Nuevo Usuario </strong>
                               </td>
                             </tr>
                            </table>
                        </dx:LayoutItemNestedControlContainer>
                    </LayoutItemNestedControlCollection>
                  </dx:LayoutItem>
                            <dx:LayoutItem Caption="Usuario">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox ID="RegisterUserNameTextBox" runat="server" Width="100%" CssClass="Texbox" NullText="Usuario">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Usuario es Requerido" />
                                            </ValidationSettings>
                                            <ClientSideEvents Init="function(s, e){ s.Focus(); }" />
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Nombre del Usuario" CssClass="Texbox">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox ID="NameuserTextBox" runat="server" Width="100%" CssClass="Texbox" NullText="Nombre Completo del Usuario">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Nombre de Usuario es Requerido" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                               <%-- <dx:LayoutItem Caption="First name">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox ID="FirstNameTextBox" runat="server" Width="100%">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="First name is required" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Last name">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox ID="LastNameTextBox" runat="server" Width="100%">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Last name is required" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>--%>

                        <%--     <dx:LayoutItem Caption="Puesto">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                         <dx:ASPxComboBox ID="tbPuesto" Width="100%" runat="server" CssClass="Texbox" NullText="Puesto" Theme="iOS" DataSourceID="SqlDataSource_Puestos" TextField="Nombre_Cargo" ValueField="ID_Cargo" >
                                     <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                         <RequiredField ErrorText="Se requiere el nombre del puesto" IsRequired="True" />
                                     </ValidationSettings>
                                 </dx:ASPxComboBox>
                                        <asp:SqlDataSource ID="SqlDataSource_Puestos" runat="server" ConnectionString='<%$ ConnectionStrings:PreRegistro_DJLConnectionString %>' SelectCommand="SELECT * FROM [tblCargos]"></asp:SqlDataSource>
                                               </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>--%>

                            <dx:LayoutItem Caption="Correo Eléctronico">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox ID="EmailTextBox" runat="server" Width="100%" CssClass="Texbox" NullText="Correo Eléctronico">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                <RequiredField IsRequired="true" ErrorText="Correo Elétronico es Requerido" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                           <%-- <dx:LayoutItem Caption="Contraseña">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButtonEdit ID="PasswordButtonEdit" runat="server" ClientInstanceName="passwordButtonEdit" Width="100%" Password="true" ClearButton-DisplayMode="Never">
                                            <ButtonStyle Border-BorderWidth="0" Width="6" CssClass="eye-button" HoverStyle-BackColor="Transparent" PressedStyle-BackColor="Transparent">
                                            </ButtonStyle>
                                            <ButtonTemplate>
                                                <div></div>
                                            </ButtonTemplate>
                                            <Buttons>
                                                <dx:EditButton>
                                                </dx:EditButton>
                                            </Buttons>
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Contraseña es Requerida" />
                                            </ValidationSettings>
                                            <ClientSideEvents ButtonClick="onPasswordButtonEditButtonClick" Validation="onPasswordValidation" />
                                        </dx:ASPxButtonEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Confirmar Contraseña">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButtonEdit ID="ConfirmPasswordButtonEdit" runat="server" ClientInstanceName="confirmPasswordButtonEdit" Width="100%" Password="true" ClearButton-DisplayMode="Never">
                                            <ButtonStyle Border-BorderWidth="0" Width="6" CssClass="eye-button" HoverStyle-BackColor="Transparent" PressedStyle-BackColor="Transparent">
                                            </ButtonStyle>
                                            <ButtonTemplate>
                                                <div></div>
                                            </ButtonTemplate>
                                            <Buttons>
                                                <dx:EditButton>
                                                </dx:EditButton>
                                            </Buttons>
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Confirmar tu Contraseña" />
                                            </ValidationSettings>
                                            <ClientSideEvents ButtonClick="onPasswordButtonEditButtonClick" Validation="onPasswordValidation" />
                                        </dx:ASPxButtonEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>--%>
                        </Items>
                    </dx:LayoutGroup>
                    <dx:LayoutGroup GroupBoxDecoration="HeadingLine" ShowCaption="False">
                        <Paddings PaddingTop="13" PaddingBottom="13" />
                        <GroupBoxStyle CssClass="formLayout-groupBox" />
                        <Items>
                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-Padding="0">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                       <asp:Literal runat="server" ID="ErrorMessage" />
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>

<Paddings Padding="0px"></Paddings>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                    <dx:LayoutGroup GroupBoxDecoration="HeadingLine" ShowCaption="False">
                        <Paddings PaddingTop="13" PaddingBottom="13" />
                        <GroupBoxStyle CssClass="formLayout-groupBox" />
                        <Items>
                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-Padding="0">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButton ID="RegisterButton" runat="server" Width="200" Text="Crear Usuario" CssClass="btn" OnClick="RegisterButton_Click"></dx:ASPxButton>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>

<Paddings Padding="0px"></Paddings>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
                <Items>

                </Items>
            </dx:ASPxFormLayout>
        </div>
    </div>
        </asp:Panel>
</asp:Content>




<%--<asp:Content runat="server" ContentPlaceHolderID="Head">
    <link rel="stylesheet" type="text/css" href='<%# ResolveUrl("~/Content/SignInRegister.css") %>' />
    <script type="text/javascript" src='<%# ResolveUrl("~/Content/SignInRegister.js") %>'></script>
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <div class="formLayout-verticalAlign">
        <div class="formLayout-container">
            <div style="text-align:center">     
                                                        <br />
                                                    <dx:ASPxHyperLink runat="server" NavigateUrl="~/Default.aspx" Text="Menù Principal"  />
                                                    </div>
            <dx:ASPxFormLayout runat="server" ID="FormLayout" ClientInstanceName="formLayout" CssClass="formLayout" UseDefaultPaddings="false">
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                <SettingsItemCaptions Location="Top" />
                <Styles LayoutGroup-Cell-Paddings-Padding="0" LayoutItem-Paddings-PaddingBottom="8" />
                <Items>
                    <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="None" Paddings-Padding="16">
                        <Items>
                            <dx:LayoutItem Caption="Usuario">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox ID="RegisterUserNameTextBox" runat="server" Width="100%">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Usuario es Requerido" />
                                            </ValidationSettings>
                                            <ClientSideEvents Init="function(s, e){ s.Focus(); }" />
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Nombre del Usuario">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox ID="NameuserTextBox" runat="server" Width="100%">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Nombre de Usuario es Requerido" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                                <dx:LayoutItem Caption="First name">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox ID="FirstNameTextBox" runat="server" Width="100%">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="First name is required" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Last name">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox ID="LastNameTextBox" runat="server" Width="100%">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Last name is required" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Correo Elétronico">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxTextBox ID="EmailTextBox" runat="server" Width="100%">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                                <RequiredField IsRequired="true" ErrorText="Correo Elétronico es Requerido" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Contraseña">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButtonEdit ID="PasswordButtonEdit" runat="server" ClientInstanceName="passwordButtonEdit" Width="100%" Password="true" ClearButton-DisplayMode="Never">
                                            <ButtonStyle Border-BorderWidth="0" Width="6" CssClass="eye-button" HoverStyle-BackColor="Transparent" PressedStyle-BackColor="Transparent">
                                            </ButtonStyle>
                                            <ButtonTemplate>
                                                <div></div>
                                            </ButtonTemplate>
                                            <Buttons>
                                                <dx:EditButton>
                                                </dx:EditButton>
                                            </Buttons>
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Contraseña es Requerida" />
                                            </ValidationSettings>
                                            <ClientSideEvents ButtonClick="onPasswordButtonEditButtonClick" Validation="onPasswordValidation" />
                                        </dx:ASPxButtonEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Confirmar Contraseña">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButtonEdit ID="ConfirmPasswordButtonEdit" runat="server" ClientInstanceName="confirmPasswordButtonEdit" Width="100%" Password="true" ClearButton-DisplayMode="Never">
                                            <ButtonStyle Border-BorderWidth="0" Width="6" CssClass="eye-button" HoverStyle-BackColor="Transparent" PressedStyle-BackColor="Transparent">
                                            </ButtonStyle>
                                            <ButtonTemplate>
                                                <div></div>
                                            </ButtonTemplate>
                                            <Buttons>
                                                <dx:EditButton>
                                                </dx:EditButton>
                                            </Buttons>
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Confirmar tu Contraseña" />
                                            </ValidationSettings>
                                            <ClientSideEvents ButtonClick="onPasswordButtonEditButtonClick" Validation="onPasswordValidation" />
                                        </dx:ASPxButtonEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                    <dx:LayoutGroup GroupBoxDecoration="HeadingLine" ShowCaption="False">
                        <Paddings PaddingTop="13" PaddingBottom="13" />
                        <GroupBoxStyle CssClass="formLayout-groupBox" />
                        <Items>
                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-Padding="0">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                       <asp:Literal runat="server" ID="ErrorMessage" />
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                    <dx:LayoutGroup GroupBoxDecoration="HeadingLine" ShowCaption="False">
                        <Paddings PaddingTop="13" PaddingBottom="13" />
                        <GroupBoxStyle CssClass="formLayout-groupBox" />
                        <Items>
                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-Padding="0">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButton ID="RegisterButton" runat="server" Width="200" Text="Crear una Cuenta" CssClass="btn" OnClick="RegisterButton_Click"></dx:ASPxButton>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
                <Items>

                </Items>
            </dx:ASPxFormLayout>
        </div>
    </div>

</asp:Content>--%>