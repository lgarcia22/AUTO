using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PREDJL.Account
{
    public partial class Confirm : System.Web.UI.Page
    {
        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    //string code = manager.GenerateEmailConfirmationToken(user.Id);
        //    //string code = IdentityHelper.GetCodeFromRequest(Request);
        //    string userId = IdentityHelper.GetUserIdFromRequest(Request);
        //    string code = IdentityHelper.GetCodeFromRequest(Request);
        //    //code = HttpUtility.UrlDecode(code);
        //    ////string code = Context.GetOwinContext().GetUserManager<ApplicationUserManager>().GenerateEmailConfirmationToken(userId);
        //    if (code != null && userId != null)
        //    {

        //        var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
        //        //Agregado
        //        //IdentityResult result;
        //        var result = manager.ConfirmEmail(userId, code);


        //        if (result.Succeeded)
        //        {
        //            successPanel.Visible = true;
        //            return;
        //        }
        //    }
        //    successPanel.Visible = false;
        //    errorPanel.Visible = true;
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            string userId = IdentityHelper.GetUserIdFromRequest(Request);
            string code = IdentityHelper.GetCodeFromRequest(Request);

            if (code != null && userId != null)
            {
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                var result = manager.ConfirmEmail(userId, code);

                if (result.Succeeded)
                {
                    successPanel.Visible = true;
                    errorPanel.Visible = false; // Ocultar el panel de error si la confirmación tiene éxito.
                }
                else
                {
                    // Manejar el error y mostrar un mensaje de error adecuado al usuario.
                    errorPanel.Visible = true;
                    //errorMessageLabel.Text = "Ha ocurrido un error al confirmar el correo electrónico.";
                }
            }
            else
            {
                successPanel.Visible = false;
                errorPanel.Visible = true;
                //errorMessageLabel.Text = "El código o el usuario son nulos, no se puede realizar la confirmación.";
            }
        }

    }
    
}