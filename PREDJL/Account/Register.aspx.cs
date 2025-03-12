using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using PREDJL.Models;

namespace PREDJL {
    public partial class RegisterModule : System.Web.UI.Page {

        protected void Page_Load(object sender, EventArgs e)
        {
            //Form.Attributes.Add("autocomplete", "off");

            //if (IsPostBack)
            //{
            //    if (Session["Name_user"] == null)
            //    {
            //        Response.RedirectLocation = "../TimeOutPage.aspx";
            //    }
            //    if (!User.Identity.IsAuthenticated)
            //    {
            //        Response.RedirectLocation = "/Account/Login.aspx";
            //        //Response.Redirect("~/Account/Login.aspx");
            //    }
            //}
            Form.Attributes.Add("autocomplete", "off");
            if (!IsPostBack)
            {

                if (HttpContext.Current.User.IsInRole("SAdmin") )              
                {
                    Panel_Content.Visible = true;

                }
                else
                {
                    Response.Redirect("~/Account/Login.aspx");
                    Panel_Content.Visible = false;

                }

            }
            else
            {
                if (IsPostBack)
                {
                    if (Session["Name_user"] == null)
                    {
                        Response.RedirectLocation = "../TimeOutPage.aspx";
                    }
                    if (!User.Identity.IsAuthenticated)
                    {
                        Response.RedirectLocation = "/Account/Login.aspx";
                        //Response.Redirect("~/Account/Login.aspx");
                    }
                }
            }

        }

        protected void RegisterButton_Click(object sender, EventArgs e)
        {
            // DXCOMMENT: Your Registration logic 
            int a�o = DateTime.Now.Year;
            string Password = "Djl" + a�o + "*";

            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var user = new ApplicationUser() { UserName = RegisterUserNameTextBox.Text.ToUpper(), Email = EmailTextBox.Text, Nombre_Usuario = NameuserTextBox.Text };
            IdentityResult result = manager.Create(user, Password);
            if (result.Succeeded)
            {
                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                string code = manager.GenerateEmailConfirmationToken(user.Id);
                string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);

                try
                {
                    string rutaplantilla = Server.MapPath("~/Mensaje.html");
                    StringBuilder plantilla = new StringBuilder();
                    plantilla.Append(llama_plantilla(rutaplantilla));
                    plantilla.Replace("$Nombre$", Convert.ToString(NameuserTextBox.Text).ToUpper());
                    plantilla.Replace("$Usuario$", Convert.ToString(RegisterUserNameTextBox.Text).ToUpper());
                    plantilla.Replace("$Password$", Password);
                    plantilla.Replace("$CallbackUrl$", callbackUrl);

                    manager.SendEmail(user.Id, "Confirmar Cuenta", plantilla.ToString());
                }
                catch (Exception ex)
                {
                    this.ErrorMessage.Text = ex.Message;
                    // If there is an error sending the email, delete the user and show an error message
                    manager.Delete(user);
                    ErrorMessage.Text = "Se produjo un error al enviar el correo electr�nico de confirmaci�n. Por favor, int�ntelo de nuevo m�s tarde.";
                    return; // Exit the function to prevent further processing
                }


                if (user.EmailConfirmed)
                {
                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
                else
                {
                    ErrorMessage.Text = "Se ha enviado un correo electr�nico al usuario. Por favor, As�gne el Rol.";
                }
            }
            else
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }

        protected static string llama_plantilla(string mi_plantilla)
        {
            System.Text.ASCIIEncoding v_codigoAscii = new System.Text.ASCIIEncoding();
            System.Net.WebClient v_recibeDato = new System.Net.WebClient();
            byte[] v_recibe;
            string v_recibecadena;

            try
            {
                v_recibe = v_recibeDato.DownloadData(mi_plantilla);
                v_recibecadena = v_codigoAscii.GetString(v_recibe);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message.ToString() + ex.ToString());
            }

            return v_recibecadena;

        }

        //protected void Page_Load(object sender, EventArgs e) {
        //}

        //protected void RegisterButton_Click(object sender, EventArgs e) {
        //    // DXCOMMENT: Your Registration logic 
        //    var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
        //    var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
        //    var user = new ApplicationUser() { UserName = RegisterUserNameTextBox.Text, Email = EmailTextBox.Text, Nombre_Usuario = NameuserTextBox.Text };
        //    IdentityResult result = manager.Create(user, PasswordButtonEdit.Text);
        //    if (result.Succeeded)
        //    {
        //        // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
        //        string code = manager.GenerateEmailConfirmationToken(user.Id);
        //        string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);
        //        manager.SendEmail(user.Id, "Confirmar cuenta", "Para confirmar la cuenta, haga click <a href=\"" + callbackUrl + "\">aqu�</a>.");

        //        if (user.EmailConfirmed)
        //        {
        //            signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
        //            IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
        //        }
        //        else
        //        {
        //            ErrorMessage.Text = "Se ha enviado un correo electr�nico a su cuenta. Consulte el correo electr�nico y confirme su cuenta para completar el proceso de registro.";
        //        }
        //    }
        //    else
        //    {
        //        ErrorMessage.Text = result.Errors.FirstOrDefault();
        //    }
        //}

        //protected void RegisterButton_Click(object sender, EventArgs e)
        //{
        //    // DXCOMMENT: Your Registration logic 
        //    var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
        //    var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
        //    var user = new ApplicationUser() { UserName = RegisterUserNameTextBox.Text, Email = EmailTextBox.Text, Nombre_Usuario = NameuserTextBox.Text };
        //    IdentityResult result = manager.Create(user, PasswordButtonEdit.Text);
        //    if (result.Succeeded)
        //    {
        //        // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
        //        string code = manager.GenerateEmailConfirmationToken(user.Id);
        //        string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);

        //        try
        //        {
        //            // Try to send the email
        //            manager.SendEmail(user.Id, "Confirmar cuenta", "Para confirmar la cuenta, haga click <a href=\"" + callbackUrl + "\">aqu�</a>.");
        //        }
        //        catch (Exception ex)
        //        {
        //            // If there is an error sending the email, delete the user and show an error message
        //            manager.Delete(user);
        //            ErrorMessage.Text = "Se produjo un error al enviar el correo electr�nico de confirmaci�n. Por favor, int�ntelo de nuevo m�s tarde.";
        //            return; // Exit the function to prevent further processing
        //        }

        //        if (user.EmailConfirmed)
        //        {
        //            signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
        //            IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
        //        }
        //        else
        //        {
        //            ErrorMessage.Text = "Se ha enviado un correo electr�nico a su cuenta. Consulte el correo electr�nico y confirme su cuenta para completar el proceso de registro.";
        //        }
        //    }
        //    else
        //    {
        //        ErrorMessage.Text = result.Errors.FirstOrDefault();
        //    }
        //}
    }
}