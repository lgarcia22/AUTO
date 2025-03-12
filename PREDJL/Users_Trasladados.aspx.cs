using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Office.Internal;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using Newtonsoft.Json;
using PREDJL.App_Start;

namespace PREDJL
{
    public partial class Users_Trasladados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string estado = "Procesando";  // O el valor que necesites filtrar
            GV_UsersTrasladados.FilterExpression = $"[Descripcion_Estado] = '{estado}'";
            if (!IsPostBack)
            {

                if (HttpContext.Current.User.IsInRole("SAdmin") || HttpContext.Current.User.IsInRole("Gestor"))
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
                    string target = Request["__EVENTTARGET"];
                    if (target == "UpdateStatus")
                    {
                        string argument = Request["__EVENTARGUMENT"];
                        List<int> ids = JsonConvert.DeserializeObject<List<int>>(argument);
                        ActualizarEstado(ids);
                    }

                    if (Session["Name_user"] == null || Session["User_id"] == null)
                    {
                        Response.RedirectLocation = "../TimeOutPage.aspx";
                    }
                    if (!User.Identity.IsAuthenticated)
                    {
                        Response.RedirectLocation = "/Account/Login.aspx";

                    }
                }
            }
            //string estado = "Procesando";  // O el valor que necesites filtrar
            //GV_UsersTrasladados.FilterExpression = $"[Descripcion_Estado] = '{estado}'";
            
            //if (IsPostBack)
            //{
                
            //    string target = Request["__EVENTTARGET"];
            //    if (target == "UpdateStatus")
            //    {
            //        string argument = Request["__EVENTARGUMENT"];
            //        List<int> ids = JsonConvert.DeserializeObject<List<int>>(argument);
            //        ActualizarEstado(ids);
            //    }
            //}
        }

        //protected void Page_PreRender(object sender, EventArgs e)
        //{
        //    //if (Session["Name_user"] == null)
        //    //{
        //    //    // Redirigir usando JavaScript si no es un postback
        //    //    if (!IsPostBack)
        //    //    {
        //    //        ClientScript.RegisterStartupScript(this.GetType(), "Redirect", "window.location.href='TimeOutPage.aspx';", true);
        //    //        return; // Detiene la ejecución posterior
        //    //    }
        //    //}
        //    if (IsPostBack)
        //    {
        //        if (Session["Name_user"] == null)
        //        {
        //            Response.RedirectLocation = "~/Account/Login.aspx";
        //        }
        //    }
        //}
        //protected void Page_Init(object sender, EventArgs e)
        //{
        //    this.PreRender += new EventHandler(Page_PreRender);
        //}


        //public void ActualizarEstado(List<int> ids)
        //{
        //    int UserID = Convert.ToInt32(Session["User_id"]);
        //    string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("gral.sp_gestion_registrado_user", con))
        //        {
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.AddWithValue("@IDUser", UserID);
        //            cmd.Parameters.AddWithValue("@IDs", String.Join(",", ids));
        //            SqlParameter mensParam = new SqlParameter("@MENS", SqlDbType.NVarChar, -1)
        //            {
        //                Direction = ParameterDirection.Output
        //            };
        //            SqlParameter retornoParam = new SqlParameter("@RETORNO", SqlDbType.Int)
        //            {
        //                Direction = ParameterDirection.Output
        //            };

        //            cmd.Parameters.Add(mensParam);
        //            cmd.Parameters.Add(retornoParam);

        //            con.Open();
        //            cmd.ExecuteNonQuery();
        //            con.Close();

        //            string mensaje = mensParam.Value.ToString();
        //            int retorno = Convert.ToInt32(retornoParam.Value);

        //            // Opcional: Logica para manejar el mensaje y retorno
        //            if (retorno == 1)
        //            {
        //                // Éxito
        //                GV_UsersTrasladados.DataBind();

        //            }
        //            else
        //            {
        //                // Error
        //                GV_UsersTrasladados.DataBind();
        //            }

        //        }

        //    }

        //}

        public void ActualizarEstado(List<int> ids)
        {
            // Obtener el ID del usuario desde la sesión
            int UserID = Convert.ToInt32(Session["User_id"]);

            // Obtener la cadena de conexión desde el archivo de configuración
            string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;

            // Usar una conexión SQL
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    // Crear un comando para ejecutar el procedimiento almacenado
                    using (SqlCommand cmd = new SqlCommand("gral.sp_gestion_registrado_user", con))
                    {
                        // Especificar que es un procedimiento almacenado
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Agregar parámetros de entrada
                        cmd.Parameters.AddWithValue("@IDUser", UserID);
                        cmd.Parameters.AddWithValue("@IDs", String.Join(",", ids)); // Convertir la lista de IDs a una cadena separada por comas

                        // Agregar parámetros de salida
                        SqlParameter mensParam = new SqlParameter("@MENS", SqlDbType.NVarChar, -1)
                        {
                            Direction = ParameterDirection.Output
                        };
                        SqlParameter retornoParam = new SqlParameter("@RETORNO", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };

                        cmd.Parameters.Add(mensParam);
                        cmd.Parameters.Add(retornoParam);

                        // Abrir la conexión
                        con.Open();

                        // Ejecutar el procedimiento almacenado
                        cmd.ExecuteNonQuery();

                        // Obtener los valores de los parámetros de salida
                        string mensaje = mensParam.Value != DBNull.Value ? mensParam.Value.ToString() : string.Empty;
                        int retorno = retornoParam.Value != DBNull.Value ? Convert.ToInt32(retornoParam.Value) : 0;

                        // Manejar el resultado del procedimiento almacenado
                        if (retorno == 1)
                        {
                            // Éxito: Actualizar el GridView
                            GV_UsersTrasladados.DataBind();
                            // Mostrar un mensaje de éxito
                            //ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{mensaje}');", true);
                        }
                        else
                        {
                            // Error: Actualizar el GridView (si es necesario)
                            GV_UsersTrasladados.DataBind();
                            // Mostrar un mensaje de error
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {mensaje}');", true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Manejar excepciones (por ejemplo, errores de conexión o ejecución del procedimiento)
                    ErrorLogger.LogError(ex); // Registrar el error en un archivo de logs
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error inesperado: {ex.Message}');", true);
                }
                finally
                {
                    // Asegurarse de que la conexión se cierre
                    if (con.State == ConnectionState.Open)
                    {
                        con.Close();
                    }
                }
            }
        }
        private void ExportToCSV(List<string> selectedIDs)
        {
            //if (selectedIDs == null || !selectedIDs.Any())
            //{
            //    // Registrar un script de JavaScript para mostrar un mensaje al usuario
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No se seleccionaron registros para exportar.');", true);
            //    return;
            //}

            StringBuilder csvContent = new StringBuilder();
            DataTable updatedData = new DataTable();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
            {
                string query = "SELECT * FROM Users WHERE Estado = 4 AND Id IN (" + string.Join(",", selectedIDs.Select(id => "'" + id + "'")) + ")";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(updatedData);
                    }
                }
            }

            // Columns to export
            List<string> selectedColumns = new List<string> { "FirstName", "LastName", "Email", "EmployeeId", "UserId", "Address" };

            // Filter columns
            var filteredData = new DataTable();
            foreach (var col in selectedColumns)
            {
                filteredData.Columns.Add(col, updatedData.Columns[col].DataType);
            }

            foreach (DataRow row in updatedData.Rows)
            {
                var newRow = filteredData.NewRow();
                foreach (var col in selectedColumns)
                {
                    newRow[col] = row[col];
                }
                filteredData.Rows.Add(newRow);
            }

            // Agregar encabezados al archivo CSV
            csvContent.AppendLine(string.Join(",", filteredData.Columns.Cast<DataColumn>().Select(col => "\"" + col.ColumnName.Replace("\"", "\"\"") + "\"")));

            // Agregar filas al archivo CSV
            foreach (DataRow row in filteredData.Rows)
            {
                List<string> fields = new List<string>();
                foreach (var item in row.ItemArray)
                {
                    fields.Add("\"" + item.ToString().Replace("\"", "\"\"") + "\"");
                }
                csvContent.AppendLine(string.Join(",", fields));
            }

            // Configurar la respuesta HTTP para la descarga del archivo CSV
            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition", "attachment;filename=DatosActualizados.csv");
            Response.ContentEncoding = Encoding.UTF8;

            // Escribir el contenido del archivo CSV en la respuesta HTTP
            byte[] byteArray = Encoding.UTF8.GetBytes(csvContent.ToString());
            using (MemoryStream memoryStream = new MemoryStream(byteArray))
            {
                memoryStream.WriteTo(Response.OutputStream);
            }

            Response.End();
        }
        protected void GV_PreUsuarios_BeforeExport(object sender, ASPxGridBeforeExportEventArgs e)
        {
            // Check if there are selected rows
            if (GV_UsersTrasladados.GetSelectedFieldValues("Id").Count == 0)
            {
                // Register a client-side script to show an alert message
                string script = "alert('Por favor, seleccione las filas a exportar.');";
                ClientScript.RegisterStartupScript(this.GetType(), "alertMessage", script, true);
                return;
            }

            // Proceed with export if the target is CSV and there are selected rows
            if (e.ExportTarget == ExportTarget.Csv)
            {
                // Get the IDs of the selected rows
                List<string> selectedIDs = new List<string>();
                foreach (var key in GV_UsersTrasladados.GetSelectedFieldValues("Id"))
                {
                    selectedIDs.Add(key.ToString());
                }

                // Export to CSV
                ExportToCSV(selectedIDs);
            }
        }


        //protected void GV_UsersTrasladados_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
        //{
        //    if (e.RowType == DevExpress.Web.GridViewRowType.Data)
        //    {
        //        var estado = e.GetValue("Estado");  // Asegúrate que "Estado" es correcto
        //        System.Diagnostics.Debug.WriteLine($"Estado: {estado}");  // Imprime el estado en la salida de depuración

        //        if (estado != null && estado.ToString() == "Registrado")
        //        {
        //            e.Row.Enabled = false;
        //            e.Row.Style.Add(HtmlTextWriterStyle.Color, "gray");
        //        }
        //    }
        //}

        protected void GV_UsersTrasladados_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType == DevExpress.Web.GridViewRowType.Data)
            {
                object estadoObj = e.GetValue("Descripcion_Estado");
                if (estadoObj != null)
                {
                    string estado = estadoObj.ToString();
                    if (estado == "Registrado") // Asumiendo que "Registrado" es uno de los textos visibles en el ComboBox
                    {
                        e.Row.Cells[0].Attributes.Add("style", "pointer-events: none; opacity: 0.5;");
                        e.Row.Enabled = false;
                     
                    }
                }
            }
        }

        protected void GV_UsersTrasladados_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i < GV_UsersTrasladados.VisibleRowCount; i++)
            {
                string estado = GV_UsersTrasladados.GetRowValues(i, "Descripcion_Estado") as string;  // Asegúrate de que "Estado" es el campo correcto
                if (estado == "Registrado")  // El estado que determina que la fila debe estar seleccionada
                {
                    GV_UsersTrasladados.Selection.SetSelection(i, true);
                }
            }
        }

        protected void GV_UsersTrasladados_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
        {
            //if (e.DataColumn.FieldName != "Descripcion_Estado") return;
            //if (Convert.ToString(e.CellValue) == "Registrado")
            //    e.Cell.BackColor = System.Drawing.Color.Aquamarine;
            //else if (Convert.ToString(e.CellValue) == "Procesando")
            //    e.Cell.BackColor = System.Drawing.Color.Salmon;
        }

        //protected void GV_UsersTrasladados_CustomButtonClick(object sender, ASPxGridViewCustomButtonCallbackEventArgs e)
        //{
        //    if (e.ButtonID == "CustomEdit")
        //    {
        //        GV_UsersTrasladados.StartEdit(e.VisibleIndex);
        //    }
        //}


    }
}