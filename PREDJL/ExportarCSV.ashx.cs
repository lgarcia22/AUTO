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
    public class ExportarCSV : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            // Obtener los IDs seleccionados de la sesión
            List<string> selectedIDs = (List<string>)context.Session["SelectedIDs"];

            if (selectedIDs != null && selectedIDs.Count > 0)
            {
                // Generar el archivo CSV
                StringBuilder csvContent = new StringBuilder();
                csvContent.AppendLine("ID,Nombre,Email,EmployeeId,UserId,Addres"); // Encabezados
             
                // Aquí deberías obtener los datos de la base de datos o de donde sea
                foreach (var id in selectedIDs)
                {
                    // Obtener los datos correspondientes al ID
                    var data = ObtenerDatosPorID(id);
                    csvContent.AppendLine($"{data.Id},{data.Nombre},{data.Email},{data.EmployeeId},{data.UserId},{data.Addres}");
                }

                // Configurar la respuesta HTTP
                context.Response.Clear();
                context.Response.ContentType = "text/csv";
                context.Response.AddHeader("Content-Disposition", "attachment; filename=usuarios.csv");
                context.Response.Write(csvContent.ToString());
                context.Response.End();
            }
        }

        private dynamic ObtenerDatosPorID(string id)
        {
            // Aquí deberías obtener los datos de la base de datos o de donde sea
            // Este es solo un ejemplo
            return new { Id = id, Nombre = "Nombre" + id, Email = "email" + id + "@example.com" };
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}