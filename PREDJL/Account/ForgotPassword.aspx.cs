using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using PREDJL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PREDJL.Account
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Form.Attributes.Add("autocomplete", "off");
        }
            protected void Forgot(object sender, EventArgs e)
            {
                if (IsValid)
                {
                    // Validate the user's email address
                    var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                    ApplicationUser user = manager.FindByEmail(Email.Text);
                    if (user == null || !manager.IsEmailConfirmed(user.Id))
                    {
                        FailureText.Text = "El usuario no existe o no se ha confirmado su correo electrónico.";
                        return;
                    }
                    // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                    // Send email with the code and the redirect to reset password page
                    string code = manager.GeneratePasswordResetToken(user.Id);
                    //'agreado'
                    //code = HttpUtility.UrlEncode(code);
                    string callbackUrl = IdentityHelper.GetResetPasswordRedirectUrl(code, Request);
                    
                    string rutaplantilla = Server.MapPath("~/Restablecer.html");
                    StringBuilder plantilla = new StringBuilder();
                    plantilla.Append(llama_plantilla(rutaplantilla));
                    plantilla.Replace("$CallbackUrl$", callbackUrl);
                    manager.SendEmail(user.Id, "Restablecer Contrasena", plantilla.ToString());

                    loginForm.Visible = false;
                    DisplayEmail.Visible = true;
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
    }
}