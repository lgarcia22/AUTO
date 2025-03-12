using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DevExpress.Web;

using System.Data.SqlClient;

using System.Web.UI;
using System.Web.UI.WebControls;
using PREDJL.App_Code;
using System.Configuration;
using System.Data;
using System.Text;

namespace PREDJL.App_Code
{
    /// <summary>
    /// Descripción breve de FileDownloadHandler
    /// </summary>

    public class CsvDownloadHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            // Recibir IDs como parámetro de la consulta, validar y sanitizar adecuadamente
            var selectedIDs = context.Request.QueryString["ids"].Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            StringBuilder csvContent = new StringBuilder();
            // Aquí agregarías la lógica para generar el contenido de csvContent basado en selectedIDs

            // Especificar el tipo de contenido para CSV
            context.Response.ContentType = "text/csv";
            context.Response.AddHeader("Content-Disposition", "attachment; filename=DatosActualizados.csv");
            context.Response.ContentEncoding = Encoding.UTF8;

            // Escribir el contenido CSV en la respuesta
            context.Response.Write(csvContent.ToString());
        }

        public bool IsReusable
        {
            get { return false; }
        }


    }
}