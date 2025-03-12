using DevExpress.XtraReports.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace PREDJL.Reportes
{
    public partial class ReportDenuncia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DenunciaReport report = new DenunciaReport();

            //report.Parameters["Denuncia"].Value = Session["Id_Denuncia"];
            report.Parameters["Registro"].Value = Session["Registro"];

            ASPxWebDocumentViewer1.OpenReport(new CachedReportSourceWeb(report));

        }

        
    }
}