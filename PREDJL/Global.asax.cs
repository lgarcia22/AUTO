using System;
using PREDJL.App_Start;

namespace PREDJL {
    public class Global_asax : System.Web.HttpApplication {
        void Application_Start(object sender, EventArgs e)
        {
            DevExpress.XtraReports.Web.WebDocumentViewer.Native.WebDocumentViewerBootstrapper.SessionState = System.Web.SessionState.SessionStateBehavior.Required;

            DevExpress.Web.ASPxWebControl.CallbackError += new EventHandler(Application_Error);
            DevExpress.Security.Resources.AccessSettings.DataResources.SetRules(
                DevExpress.Security.Resources.DirectoryAccessRule.Allow(Server.MapPath("~/Content")),
                DevExpress.Security.Resources.UrlAccessRule.Allow()
            );
        }
        //void Application_Start(object sender, EventArgs e)
        //{
        //    DevExpress.XtraReports.Web.ASPxWebDocumentViewer.StaticInitialize();

        //}

        void Application_End(object sender, EventArgs e) {
            // Code that runs on application shutdown
            
        }
    
        void Application_Error(object sender, EventArgs e) {
            // Code that runs when an unhandled error occurs
            string ErrorMessage;

            ErrorMessage = "La descripción del error es la siguiente : " + Server.GetLastError();
            string toemail = "gitsc.2022@gmail.com";
            string StrSubject = "Error en el sitio PREDJL";
            string strBody = ErrorMessage;

            //SampleUtil.EnviarCorreo1("", StrSubject, toemail, strBody);
        }

        void Session_Start(object sender, EventArgs e) {
  
        }
    
        void Session_End(object sender, EventArgs e) {
            Session.Abandon();

        }
    }
}