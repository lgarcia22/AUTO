using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Text;

namespace PREDJL
{
    public class SolicitudesService
    {
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;

        public string GetSolicitudesPorEstado(DateTime? fechaInicio, DateTime? fechaFin, string company)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("gral.sp_GetSolicitudesPorEstado", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FechaInicio", fechaInicio.HasValue ? (object)fechaInicio.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@FechaFin", fechaFin.HasValue ? (object)fechaFin.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@Company", string.IsNullOrEmpty(company) ? (object)DBNull.Value : company);

                    conn.Open();
                    var jsonResult = new StringBuilder();
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            jsonResult.Append(reader.GetString(0));
                        }
                    }

                    // If the result is empty, return an empty JSON array
                    if (jsonResult.Length == 0)
                    {
                        return "[]";
                    }

                    return jsonResult.ToString();
                }
            }
        }
    }
}