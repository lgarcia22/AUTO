using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;

namespace PREDJL
{
    /// <summary>
    /// Descripción breve de FileDownloadHandler
    /// </summary>

    public class SolicitudesHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";
            string fechaInicio = context.Request.QueryString["FechaInicio"];
            string fechaFin = context.Request.QueryString["FechaFin"];
            string company = context.Request.QueryString["Company"];

            try
            {
                var result = GetSolicitudesData(fechaInicio, fechaFin, company);

                JavaScriptSerializer js = new JavaScriptSerializer();
                string json = js.Serialize(result);
                context.Response.Write(json);

                // Log para depuración
                System.Diagnostics.Debug.WriteLine("JSON Response: " + json);
            }
            catch (Exception ex)
            {
                // Manejar la excepción y devolver un error adecuado
                context.Response.StatusCode = 500;
                context.Response.StatusDescription = ex.Message;
                context.Response.Write("{\"error\":\"" + ex.Message + "\"}");
            }
        }

        private List<Dictionary<string, object>> GetSolicitudesData(string fechaInicio, string fechaFin, string company)
        {
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("[gral].[sp_GetSolicitudesPorEstado]", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FechaInicio", string.IsNullOrEmpty(fechaInicio) ? (object)DBNull.Value : DateTime.Parse(fechaInicio));
                    cmd.Parameters.AddWithValue("@FechaFin", string.IsNullOrEmpty(fechaFin) ? (object)DBNull.Value : DateTime.Parse(fechaFin));
                    cmd.Parameters.AddWithValue("@Company", string.IsNullOrEmpty(company) ? (object)DBNull.Value : company);

                    conn.Open();
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        while (rdr.Read())
                        {
                            Dictionary<string, object> row = new Dictionary<string, object>();
                            for (int i = 0; i < rdr.FieldCount; i++)
                            {
                                row[rdr.GetName(i)] = rdr.GetValue(i);
                            }
                            rows.Add(row);
                        }
                    }
                }
            }
            return rows;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

    //public class SolicitudesHandler : IHttpHandler
    //{
    //    public void ProcessRequest(HttpContext context)
    //    {
    //        context.Response.ContentType = "application/json";
    //        string fechaInicio = context.Request.QueryString["FechaInicio"];
    //        string fechaFin = context.Request.QueryString["FechaFin"];
    //        string company = context.Request.QueryString["Company"];

    //        try
    //        {
    //            var result = GetSolicitudesData(fechaInicio, fechaFin, company);

    //            if (result == null || result.Count == 0)
    //            {
    //                context.Response.Write("[]"); // Devolver un array vacío si no hay datos
    //            }
    //            else
    //            {
    //                JavaScriptSerializer js = new JavaScriptSerializer();
    //                string json = js.Serialize(result);
    //                context.Response.Write(json);

    //                // Log para depuración
    //                System.Diagnostics.Debug.WriteLine("JSON Response: " + json);
    //            }
    //        }
    //        catch (Exception ex)
    //        {
    //            // Manejar la excepción y devolver un error adecuado
    //            context.Response.StatusCode = 500;
    //            context.Response.StatusDescription = ex.Message;
    //            context.Response.Write("{\"error\":\"" + ex.Message + "\"}");
    //        }
    //    }

    //    private List<Dictionary<string, object>> GetSolicitudesData(string fechaInicio, string fechaFin, string company)
    //    {
    //        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
    //        string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
    //        using (SqlConnection conn = new SqlConnection(connStr))
    //        {
    //            using (SqlCommand cmd = new SqlCommand("[gral].[sp_GetSolicitudesPorEstado]", conn))
    //            {
    //                cmd.CommandType = CommandType.StoredProcedure;
    //                cmd.Parameters.AddWithValue("@FechaInicio", string.IsNullOrEmpty(fechaInicio) ? (object)DBNull.Value : DateTime.Parse(fechaInicio));
    //                cmd.Parameters.AddWithValue("@FechaFin", string.IsNullOrEmpty(fechaFin) ? (object)DBNull.Value : DateTime.Parse(fechaFin));
    //                cmd.Parameters.AddWithValue("@Company", string.IsNullOrEmpty(company) ? (object)DBNull.Value : company);

    //                conn.Open();
    //                using (SqlDataReader rdr = cmd.ExecuteReader())
    //                {
    //                    while (rdr.Read())
    //                    {
    //                        Dictionary<string, object> row = new Dictionary<string, object>();
    //                        for (int i = 0; i < rdr.FieldCount; i++)
    //                        {
    //                            row[rdr.GetName(i)] = rdr.GetValue(i);
    //                        }
    //                        rows.Add(row);
    //                    }
    //                }
    //            }
    //        }
    //        return rows;
    //    }

    //    public bool IsReusable
    //    {
    //        get
    //        {
    //            return false;
    //        }
    //    }
    //}
}