using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Office.Internal;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using Org.BouncyCastle.Bcpg;
using PREDJL.App_Start;

namespace PREDJL
{
    public partial class Clasificacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (HttpContext.Current.User.IsInRole("SAdmin") || HttpContext.Current.User.IsInRole("Gestor"))
                {
                    Panel_Content.Visible = true;
                    LoadStatuses();
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
            //if (IsPostBack)
            //{
            //    string eventTarget = Request["__EVENTTARGET"];
            //    if (eventTarget == "btnExportar")
            //    {
            //        // Obtener los IDs seleccionados en el GridView
            //        List<string> selectedIDs = new List<string>();
            //        foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
            //        {
            //            selectedIDs.Add(key.ToString());
            //        }

            //        // Ejecutar el procedimiento almacenado
            //        bool procedimientoExitoso = EjecutarProcedimientoAlmacenado(selectedIDs);

            //        // Si el procedimiento se ejecutó correctamente, exportar a CSV
            //        if (procedimientoExitoso)
            //        {
            //            // Exportar a CSV
            //            ExportToCSV(selectedIDs);

            //            // Actualizar el GridView
            //            GV_PreUsuarios.DataBind();

            //            // Forzar la actualización del GridView usando JavaScript
            //            string script = "setTimeout(function() { __doPostBack('', ''); }, 100);";
            //            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "refreshGrid", script, true);
            //        }
            //    }
            //}
            //if (!IsPostBack)
            //{
            
            //    LoadStatuses();
            //}

        }

        //protected void Page_PreRender(object sender, EventArgs e)
        //{
        //    if (IsPostBack)
        //    {
        //        if (Session["Name_user"] == null)
        //        {
        //            Response.RedirectLocation = "../TimeOutPage.aspx";
        //        }
        //    }
        //}
        private void LoadStatuses()
        {
            string connectionString = (ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString);
            string query = "SELECT Id_Estado, Descripcion_Estado FROM Estados WHERE Id_Estado IN (2, 3)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);

                cmbStatus.DataSource = dataTable;
                cmbStatus.DataBind();
            }
        }

        protected void ASPxCallback_PopupUpdate_Callback(object source, CallbackEventArgs e)
        {
            List<string> selectedIDs = new List<string>();
            foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
            {
                selectedIDs.Add(key.ToString());
            }

            if (selectedIDs.Count != 1)
            {
                return;
            }

            string selectedID = selectedIDs[0]; // Solo tomamos el primer (y único) ID
            string estado = cmbStatus.SelectedItem.Value.ToString();
            string observacion = txtObs.Text;

            // Ejecuta el procedimiento almacenado para actualizar el estado y la observación
            string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("[gral].[sp_gestion_estado_user]", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@IDUser", Convert.ToInt32(Session["User_id"]));
                        command.Parameters.AddWithValue("@IDs", selectedID);
                        command.Parameters.AddWithValue("@Estado", estado);
                        command.Parameters.AddWithValue("@Observacion", observacion);

                        SqlParameter mensParam = new SqlParameter("@MENS", SqlDbType.NVarChar, -1)
                        {
                            Direction = ParameterDirection.Output
                        };
                        SqlParameter retornoParam = new SqlParameter("@RETORNO", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };

                        command.Parameters.Add(mensParam);
                        command.Parameters.Add(retornoParam);

                        command.ExecuteNonQuery();

                        string mensaje = mensParam.Value.ToString();
                        int retorno = Convert.ToInt32(retornoParam.Value);

                        // Aquí puedes manejar el mensaje y el retorno según sea necesario
                    }
                }
                catch (Exception ex)
                {
                    // Manejar la excepción y registrar el error si es necesario
                    throw new Exception("Error al ejecutar el procedimiento almacenado: " + ex.Message);
                }
                finally
                {
                    if (connection.State == ConnectionState.Open)
                    {
                        connection.Close(); // Asegurarse de que la conexión se cierre
                    }
                }
            }
        }

        //protected void ASPxCallback_PopupUpdate_Callback(object source, CallbackEventArgs e)
        //{
        //    List<string> selectedIDs = new List<string>();
        //    foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
        //    {
        //        selectedIDs.Add(key.ToString());
        //    }

        //    if (selectedIDs.Count != 1)
        //    {
        //        return;
        //    }

        //    string selectedID = selectedIDs[0]; // Solo tomamos el primer (y único) ID
        //    string estado = cmbStatus.SelectedItem.Value.ToString();
        //    string observacion = txtObs.Text;

        //    // Ejecuta el procedimiento almacenado para actualizar el estado y la observación
        //    string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand command = new SqlCommand("[gral].[sp_gestion_estado_user]", connection))
        //        {
        //            int UserID = Convert.ToInt32(Session["User_id"]);
        //            command.CommandType = CommandType.StoredProcedure;
        //            command.Parameters.AddWithValue("@IDUser", UserID);
        //            command.Parameters.AddWithValue("@IDs", selectedID);
        //            command.Parameters.AddWithValue("@Estado", estado);
        //            command.Parameters.AddWithValue("@Observacion", observacion);
        //            SqlParameter mensParam = new SqlParameter("@MENS", SqlDbType.NVarChar, -1)
        //            {
        //                Direction = ParameterDirection.Output
        //            };
        //            SqlParameter retornoParam = new SqlParameter("@RETORNO", SqlDbType.Int)
        //            {
        //                Direction = ParameterDirection.Output
        //            };

        //            command.Parameters.Add(mensParam);
        //            command.Parameters.Add(retornoParam);

        //            connection.Open();
        //            command.ExecuteNonQuery();
        //            connection.Close();

        //            string mensaje = mensParam.Value.ToString();
        //            int retorno = Convert.ToInt32(retornoParam.Value);

        //        }
        //    }
        //}

        //protected void btnPopupUpdate_Click(object sender, EventArgs e)
        //{
        //    List<string> selectedIDs = new List<string>();
        //    foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
        //    {
        //        selectedIDs.Add(key.ToString());
        //    }

        //    if (selectedIDs.Count != 1)
        //    {
        //        // Mostrar mensaje de error o manejar la situación cuando no se selecciona exactamente una fila
        //        // Puedes usar un control de etiquetas o cualquier otro método para mostrar el mensaje
        //        //lblErrorMessage.Text = "Por favor, seleccione exactamente una fila.";
        //        return;
        //    }

        //    string selectedID = selectedIDs[0]; // Solo tomamos el primer (y único) ID
        //    string estado = cmbStatus.SelectedItem.Value.ToString();
        //    string observacion = txtObs.Text;

        //    // Ejecuta el procedimiento almacenado para actualizar el estado y la observación
        //    string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand command = new SqlCommand("[gral].[sp_gestion_estado_user]", connection))
        //        {
        //            int UserID = Convert.ToInt16(Session["User_id"]);
        //            command.CommandType = CommandType.StoredProcedure;
        //            command.Parameters.AddWithValue("@IDUser", SqlDbType.Int).Value = UserID;
        //            command.Parameters.AddWithValue("@IDs", selectedID);
        //            command.Parameters.AddWithValue("@Estado", estado);
        //            command.Parameters.AddWithValue("@Observacion", observacion);
        //            SqlParameter mensParam = new SqlParameter("@MENS", SqlDbType.NVarChar, -1)
        //            {
        //                Direction = ParameterDirection.Output
        //            };
        //            SqlParameter retornoParam = new SqlParameter("@RETORNO", SqlDbType.Int)
        //            {
        //                Direction = ParameterDirection.Output
        //            };

        //            command.Parameters.Add(mensParam);
        //            command.Parameters.Add(retornoParam);

        //            connection.Open();
        //            command.ExecuteNonQuery();
        //            connection.Close();

        //            string mensaje = mensParam.Value.ToString();
        //            int retorno = Convert.ToInt32(retornoParam.Value);

        //            // Opcional: Lógica para manejar el mensaje y retorno
        //            if (retorno == 1)
        //            {
        //                // Éxito
        //                GV_PreUsuarios.DataBind();
        //                //ScriptManager.RegisterStartupScript(this, GetType(), "closePopup", "closePopupAndClearFields();", true);
        //            }
        //            else
        //            {
        //                // Error
        //                GV_PreUsuarios.DataBind();
        //            }
        //        }
        //    }

        //    // Cierra el popup y refresca el grid
        //    //popupUpdateStatus.Hide();
        //    GV_PreUsuarios.DataBind();
        //}

        //private void LoadData()
        //{
        //    //GV_PreUsuarios.DataSource = GetFullDataTable(); // Obtiene los datos desde el método apropiado
        //    GV_PreUsuarios.DataBind();
        //}

        // Método para actualizar los datos en el GridView
        //private void ActualizarGridView()
        //{
        //    DataTable dt = GetData();

        //    GV_PreUsuarios.DataSource = dt;

        //    //DataBind();

        //}

        //private DataTable GetData()
        //{
        //    DataTable dataTable = new DataTable();


        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    {
        //        try
        //        {
        //            con.Open();
        //            string query = "SELECT * FROM [Users] where Traslado IS NULL"; // Ajusta esta consulta a tus necesidades
        //            using (SqlCommand cmd = new SqlCommand(query, con))
        //            {
        //                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
        //                {
        //                    adapter.Fill(dataTable);
        //                }
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            // Manejo de errores
        //            Console.WriteLine("Error obteniendo datos: " + ex.Message);
        //        }
        //    }

        //    return dataTable;
        //}

        //private void ExportToCSV(List<string> selectedIDs)
        //{
        //    StringBuilder csvContent = new StringBuilder();
        //    DataTable updatedData = new DataTable();

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    {
        //        string query = "SELECT * FROM Users WHERE Id IN ({0})";
        //        var parameters = new List<string>();
        //        var commandParameters = new List<SqlParameter>();
        //        for (int i = 0; i < selectedIDs.Count; i++)
        //        {
        //            string parameterName = "@id" + i;
        //            parameters.Add(parameterName);
        //            commandParameters.Add(new SqlParameter(parameterName, selectedIDs[i]));
        //        }
        //        query = string.Format(query, string.Join(",", parameters));

        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            cmd.Parameters.AddRange(commandParameters.ToArray());
        //            con.Open();
        //            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
        //            {
        //                adapter.Fill(updatedData);
        //            }
        //        }
        //    }

        //    // Columns to export
        //    List<string> selectedColumns = new List<string> { "FirstName", "LastName", "Email", "EmployeeId", "UserId", "Address" };

        //    // Filter columns
        //    var filteredData = new DataTable();
        //    foreach (var col in selectedColumns)
        //    {
        //        filteredData.Columns.Add(col, updatedData.Columns[col].DataType);
        //    }

        //    foreach (DataRow row in updatedData.Rows)
        //    {
        //        var newRow = filteredData.NewRow();
        //        foreach (var col in selectedColumns)
        //        {
        //            newRow[col] = row[col];
        //        }
        //        filteredData.Rows.Add(newRow);
        //    }

        //    csvContent.AppendLine(string.Join(",", filteredData.Columns.Cast<DataColumn>().Select(col => "\"" + col.ColumnName.Replace("\"", "\"\"") + "\"")));

        //    foreach (DataRow row in filteredData.Rows)
        //    {
        //        List<string> fields = new List<string>();
        //        foreach (var item in row.ItemArray)
        //        {
        //            fields.Add("\"" + item.ToString().Replace("\"", "\"\"") + "\"");
        //        }
        //        csvContent.AppendLine(string.Join(",", fields));
        //    }

        //    Response.Clear();
        //    Response.ContentType = "text/csv";
        //    Response.AddHeader("Content-Disposition", "attachment;filename=DatosActualizados.csv");
        //    Response.ContentEncoding = Encoding.UTF8;

        //    byte[] byteArray = Encoding.UTF8.GetBytes(csvContent.ToString());
        //    using (MemoryStream memoryStream = new MemoryStream(byteArray))
        //    {
        //        memoryStream.WriteTo(Response.OutputStream);
        //    }

        //    Response.End();
        //}



        protected void GV_PreUsuarios_BeforeExport(object sender, ASPxGridBeforeExportEventArgs e)
        {
            List<string> selectedIDs = new List<string>();
            foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
            {
                selectedIDs.Add(key.ToString());
            }

            if (!(GV_PreUsuarios.Selection.Count > 0))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertMessage", "alert('Por favor, seleccione las filas a exportar.');", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
            {
                try
                {
                    int UserID = Convert.ToInt32(Session["User_id"]);
                    using (SqlCommand cmd = new SqlCommand("[gral].[sp_gestion_exportado_user]", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IDUser", UserID);
                        cmd.Parameters.Add(new SqlParameter("@IDs", string.Join(",", selectedIDs)));

                        SqlParameter correoParam = new SqlParameter("@CorreoElectronico", SqlDbType.NVarChar, -1); // Use -1 for NVARCHAR(MAX)
                        correoParam.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(correoParam);

                        SqlParameter retornoParam = new SqlParameter("@RETORNO", SqlDbType.Int);
                        retornoParam.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(retornoParam);

                        SqlParameter mensajeEstadoParam = new SqlParameter("@MENS", SqlDbType.NVarChar, 255);
                        mensajeEstadoParam.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(mensajeEstadoParam);

                        con.Open();
                        cmd.ExecuteNonQuery();

                        string emailList = correoParam.Value != DBNull.Value ? correoParam.Value.ToString() : string.Empty;
                        string mensajeEstado = mensajeEstadoParam.Value != DBNull.Value ? mensajeEstadoParam.Value.ToString() : string.Empty;
                        int retorno = retornoParam.Value != DBNull.Value ? (int)retornoParam.Value : 0;

                        if (retorno == 1)
                        {
                            SampleUtil.SendEmails(emailList);
                            ExportToCSV(selectedIDs);

                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: " + mensajeEstado + "');", true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    ErrorLogger.LogError(ex);
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error al ejecutar el procedimiento almacenado: " + ex.Message + "');", true);
                    GV_PreUsuarios.Selection.UnselectAll();
                    GV_PreUsuarios.DataBind();
                }
                finally
                {
                    con.Close();
                    GV_PreUsuarios.DataBind();
                }
            }
        }

        protected void GV_PreUsuarios_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            GV_PreUsuarios.DataBind();
        }
        protected void ASPxCallback_Exportar_Callback(object source, CallbackEventArgs e)
        {
            // Obtener los IDs seleccionados en el GridView
            List<string> selectedIDs = new List<string>();
            foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
            {
                selectedIDs.Add(key.ToString());
            }

            // Ejecutar el procedimiento almacenado
            bool procedimientoExitoso = EjecutarProcedimientoAlmacenado(selectedIDs);

            // Si el procedimiento se ejecutó correctamente, exportar a CSV
            if (procedimientoExitoso)
            {
                // Actualizar el GridView
                //GV_PreUsuarios.DataBind();
                // Exportar a CSV
                ExportToCSV(selectedIDs);

            }
        }
        //protected void btnExportar_Click(object sender, EventArgs e)
        //{
        //    // Obtener los IDs seleccionados en el GridView
        //    List<string> selectedIDs = new List<string>();
        //    foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
        //    {
        //        selectedIDs.Add(key.ToString());
        //    }
        //     // Verificar si hay filas seleccionadas
        //    if (selectedIDs.Count == 0)
        //    {
        //        string script = "Swal.fire({ " +
        //                        "title: 'Atención', " +
        //                        "text: 'Por favor, seleccione la fila a exportar.', " +
        //                        "icon: 'warning', " +
        //                        //"confirmButtonText: 'Aceptar' " +
        //                        "confirmButtonColor: '#1F497D'" +
        //                        "});";
        //        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertMessage", script, true);
        //        return;
        //    }
        //    // Ejecutar el procedimiento almacenado
        //    bool procedimientoExitoso = EjecutarProcedimientoAlmacenado(selectedIDs);

        //    // Si el procedimiento se ejecutó correctamente, exportar a CSV
        //    if (procedimientoExitoso)
        //    {

        //        // Exportar a CSV
        //        ExportToCSV(selectedIDs);
        //        // Actualizar el GridView
        //        GV_PreUsuarios.DataBind();
        //    }
        //}

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            // Obtener los IDs seleccionados en el GridView
            List<string> selectedIDs = new List<string>();
            foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
            {
                selectedIDs.Add(key.ToString());
            }

            // Verificar si hay filas seleccionadas
            if (selectedIDs.Count == 0)
            {
                string script = "Swal.fire({ " +
                                "title: 'Atención', " +
                                "text: 'Por favor, seleccione la fila a exportar.', " +
                                "icon: 'warning', " +
                                "confirmButtonColor: '#1F497D'" +
                                "});";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertMessage", script, true);
                return;
            }

            //Ejecutar el procedimiento almacenado
                bool procedimientoExitoso = EjecutarProcedimientoAlmacenado(selectedIDs);

            // Si el procedimiento se ejecutó correctamente, exportar a CSV
            if (procedimientoExitoso)
            {

                // Exportar a CSV
                ExportToCSV(selectedIDs);
                // Actualizar el GridView
                GV_PreUsuarios.DataBind();
            }
        }


        //private bool EjecutarProcedimientoAlmacenado(List<string> selectedIDs)
        //{
        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    {
        //        try
        //        {
        //            int UserID = Convert.ToInt32(Session["User_id"]);
        //            using (SqlCommand cmd = new SqlCommand("[gral].[sp_gestion_exportado_user]", con))
        //            {
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                cmd.Parameters.AddWithValue("@IDUser", UserID);
        //                cmd.Parameters.Add(new SqlParameter("@IDs", string.Join(",", selectedIDs)));

        //                SqlParameter correoParam = new SqlParameter("@CorreoElectronico", SqlDbType.NVarChar, -1); // Use -1 for NVARCHAR(MAX)
        //                correoParam.Direction = ParameterDirection.Output;
        //                cmd.Parameters.Add(correoParam);

        //                SqlParameter retornoParam = new SqlParameter("@RETORNO", SqlDbType.Int);
        //                retornoParam.Direction = ParameterDirection.Output;
        //                cmd.Parameters.Add(retornoParam);

        //                SqlParameter mensajeEstadoParam = new SqlParameter("@MENS", SqlDbType.NVarChar, 255);
        //                mensajeEstadoParam.Direction = ParameterDirection.Output;
        //                cmd.Parameters.Add(mensajeEstadoParam);

        //                con.Open();
        //                cmd.ExecuteNonQuery();

        //                string emailList = correoParam.Value != DBNull.Value ? correoParam.Value.ToString() : string.Empty;
        //                string mensajeEstado = mensajeEstadoParam.Value != DBNull.Value ? mensajeEstadoParam.Value.ToString() : string.Empty;
        //                int retorno = retornoParam.Value != DBNull.Value ? (int)retornoParam.Value : 0;

        //                if (retorno == 1)
        //                {
        //                    SampleUtil.SendEmails(emailList);
        //                    return true; // Procedimiento exitoso
        //                                 // Actualizar el GridView

        //                }
        //                else
        //                {
        //                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: " + mensajeEstado + "');", true);
        //                    return false; // Procedimiento fallido
        //                }

        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            ErrorLogger.LogError(ex);
        //            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error al ejecutar el procedimiento almacenado: " + ex.Message + "');", true);
        //            return false; // Procedimiento fallido
        //        }
        //        finally
        //        {
        //            con.Close();
        //        }
        //    }
        //}

        private bool EjecutarProcedimientoAlmacenado(List<string> selectedIDs)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
            {
                try
                {
                    int UserID = Convert.ToInt32(Session["User_id"]);
                    using (SqlCommand cmd = new SqlCommand("[gral].[sp_gestion_exportado_user]", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IDUser", UserID);
                        cmd.Parameters.Add(new SqlParameter("@IDs", string.Join(",", selectedIDs)));

                        SqlParameter correoParam = new SqlParameter("@CorreoElectronico", SqlDbType.NVarChar, -1); // Use -1 for NVARCHAR(MAX)
                        correoParam.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(correoParam);

                        SqlParameter retornoParam = new SqlParameter("@RETORNO", SqlDbType.Int);
                        retornoParam.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(retornoParam);

                        SqlParameter mensajeEstadoParam = new SqlParameter("@MENS", SqlDbType.NVarChar, 255);
                        mensajeEstadoParam.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(mensajeEstadoParam);

                        con.Open();
                        cmd.ExecuteNonQuery();

                        string emailList = correoParam.Value != DBNull.Value ? correoParam.Value.ToString() : string.Empty;
                        string mensajeEstado = mensajeEstadoParam.Value != DBNull.Value ? mensajeEstadoParam.Value.ToString() : string.Empty;
                        int retorno = retornoParam.Value != DBNull.Value ? (int)retornoParam.Value : 0;

                        if (retorno == 1)
                        {
                            SampleUtil.SendEmails(emailList);
                            return true; // Procedimiento exitoso
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: " + mensajeEstado + "');", true);
                            return false; // Procedimiento fallido
                        }
                    }
                }
                catch (Exception ex)
                {
                    ErrorLogger.LogError(ex);
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error al ejecutar el procedimiento almacenado: " + ex.Message + "');", true);
                    return false; // Procedimiento fallido
                }
                finally
                {
                    con.Close();
                }
            }
        }
        private void ExportToCSV(List<string> selectedIDs)
        {
            DataTable updatedData = new DataTable();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
            {
                string query = "SELECT * FROM Users WHERE Id IN ({0})";
                var parameters = selectedIDs.Select((id, index) => "@id" + index).ToList();
                query = string.Format(query, string.Join(",", parameters));

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    for (int i = 0; i < selectedIDs.Count; i++)
                    {
                        cmd.Parameters.AddWithValue("@id" + i, selectedIDs[i]);
                    }

                    con.Open();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(updatedData);
                    }
                }
            }

            // Columnas a exportar
            List<string> selectedColumns = new List<string> { "FirstName", "LastName", "Email", "EmployeeId", "UserId", "Address" };

            // Filtrar columnas
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

            // Construir el contenido CSV
            StringBuilder csvContent = new StringBuilder();

            // Agregar encabezados
            csvContent.AppendLine(string.Join(",", filteredData.Columns.Cast<DataColumn>().Select(col => EscapeCsvValue(col.ColumnName))));

            // Agregar filas
            foreach (DataRow row in filteredData.Rows)
            {
                csvContent.AppendLine(string.Join(",", row.ItemArray.Select(item => EscapeCsvValue(item.ToString()))));
            }

            // Enviar el archivo CSV al cliente
            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition", "attachment;filename=DatosActualizados.csv");
            Response.ContentEncoding = Encoding.UTF8;
            Response.Write(csvContent.ToString());
            Response.Flush();
            Response.SuppressContent = true;
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }

        private string EscapeCsvValue(string value)
        {
            // Escapar comillas y caracteres especiales
            if (value.Contains(",") || value.Contains("\"") || value.Contains("\n") || value.Contains("\r"))
            {
                return "\"" + value.Replace("\"", "\"\"") + "\"";
            }
            return value;
        }

        //protected void GV_PreUsuarios_DataBinding(object sender, EventArgs e)
        //{
        //    GV_PreUsuarios.DataBind();
        //}

        //protected void ASPxCallback_BeforeExport_Callback(object source, CallbackEventArgs e)
        //{
        //    List<string> selectedIDs = new List<string>();
        //    foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
        //    {
        //        selectedIDs.Add(key.ToString());
        //    }

        //    if (!(GV_PreUsuarios.Selection.Count > 0))
        //    {
        //        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertMessage", "alert('Por favor, seleccione las filas a exportar.');", true);
        //        return;
        //    }

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    {
        //        try
        //        {
        //            int UserID = Convert.ToInt16(Session["User_id"]);
        //            using (SqlCommand cmd = new SqlCommand("[gral].[sp_gestion_exportado_user]", con))
        //            {
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                cmd.Parameters.Add(new SqlParameter("@IDUser", UserID));
        //                cmd.Parameters.Add(new SqlParameter("@IDs", string.Join(",", selectedIDs)));

        //                SqlParameter correoParam = new SqlParameter("@CorreoElectronico", SqlDbType.NVarChar, -1); // Use -1 for NVARCHAR(MAX)
        //                correoParam.Direction = ParameterDirection.Output;
        //                cmd.Parameters.Add(correoParam);

        //                SqlParameter retornoParam = new SqlParameter("@RETORNO", SqlDbType.Int);
        //                retornoParam.Direction = ParameterDirection.Output;
        //                cmd.Parameters.Add(retornoParam);

        //                SqlParameter mensajeEstadoParam = new SqlParameter("@MENS", SqlDbType.NVarChar, 255);
        //                mensajeEstadoParam.Direction = ParameterDirection.Output;
        //                cmd.Parameters.Add(mensajeEstadoParam);

        //                con.Open();
        //                cmd.ExecuteNonQuery();

        //                string emailList = correoParam.Value != DBNull.Value ? correoParam.Value.ToString() : string.Empty;
        //                string mensajeEstado = mensajeEstadoParam.Value != DBNull.Value ? mensajeEstadoParam.Value.ToString() : string.Empty;
        //                int retorno = retornoParam.Value != DBNull.Value ? (int)retornoParam.Value : 0;

        //                if (retorno == 1)
        //                {
        //                    SampleUtil.SendEmails(emailList);
        //                    ExportToCSV(selectedIDs);

        //                }
        //                else
        //                {
        //                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: " + mensajeEstado + "');", true);
        //                }
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            ErrorLogger.LogError(ex);
        //            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error al ejecutar el procedimiento almacenado: " + ex.Message + "');", true);
        //            GV_PreUsuarios.Selection.UnselectAll();
        //            GV_PreUsuarios.DataBind();
        //        }
        //        finally
        //        {
        //            con.Close();
        //            GV_PreUsuarios.DataBind();
        //        }
        //    }
        //}


        //protected void GV_PreUsuarios_BeforeExport(object sender, ASPxGridBeforeExportEventArgs e)
        //{
        //    List<string> selectedIDs = new List<string>();
        //    foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
        //    {
        //        selectedIDs.Add(key.ToString());
        //    }

        //    if (!(GV_PreUsuarios.Selection.Count > 0))
        //    {
        //        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertMessage", "alert('Por favor, seleccione las filas a exportar.');", true);
        //        return;
        //    }

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    {
        //        try
        //        {
        //            int UserID = Convert.ToInt16(Session["User_id"]);
        //            using (SqlCommand cmd = new SqlCommand("[gral].[sp_gestion_exportado_user]", con))
        //            {
        //                cmd.Parameters.Add(new SqlParameter("@IDUser", UserID));
        //                cmd.Parameters.Add(new SqlParameter("@IDs" , string.Join(",", selectedIDs)));

        //                SqlParameter correoParam = new SqlParameter("@CorreoElectronico", SqlDbType.VarChar, 255);
        //                correoParam.Direction = ParameterDirection.Output;
        //                cmd.Parameters.Add(correoParam);

        //                SqlParameter retornoParam = new SqlParameter("@RETORNO", SqlDbType.Int);
        //                retornoParam.Direction = ParameterDirection.Output;
        //                cmd.Parameters.Add(retornoParam);

        //                SqlParameter mensajeEstadoParam = new SqlParameter("@MENS", SqlDbType.VarChar, 255);
        //                mensajeEstadoParam.Direction = ParameterDirection.Output;
        //                cmd.Parameters.Add(mensajeEstadoParam);

        //                con.Open();
        //                cmd.ExecuteNonQuery();

        //                string email = correoParam.Value != DBNull.Value ? correoParam.Value.ToString() : string.Empty;
        //                string mensajeEstado = mensajeEstadoParam.Value != DBNull.Value ? mensajeEstadoParam.Value.ToString() : string.Empty;
        //                int retorno = retornoParam.Value != DBNull.Value ? (int)retornoParam.Value : 0;

        //                if (retorno == 1)
        //                {
        //                    ExportToCSV(selectedIDs);
        //                }
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            ErrorLogger.LogError(ex);
        //            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error al ejecutar el procedimiento almacenado: " + ex.Message + "');", true);
        //            GV_PreUsuarios.Selection.UnselectAll();
        //            GV_PreUsuarios.DataBind();
        //        }
        //        finally
        //        {
        //            con.Close();
        //            GV_PreUsuarios.DataBind();
        //        }
        //        GV_PreUsuarios.DataBind();
        //    }
        //    GV_PreUsuarios.DataBind();
        //}
        //private void ExportToCSV(List<string> selectedIDs)
        //{
        //    StringBuilder csvContent = new StringBuilder();
        //    DataTable updatedData = new DataTable();

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    {
        //        string query = "SELECT * FROM Users WHERE Id IN ({0})";
        //        var parameters = new List<string>();
        //        var commandParameters = new List<SqlParameter>();
        //        for (int i = 0; i < selectedIDs.Count; i++)
        //        {
        //            string parameterName = "@id" + i;
        //            parameters.Add(parameterName);
        //            commandParameters.Add(new SqlParameter(parameterName, selectedIDs[i]));
        //        }
        //        query = string.Format(query, string.Join(",", parameters));

        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            cmd.Parameters.AddRange(commandParameters.ToArray());
        //            con.Open();
        //            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
        //            {
        //                adapter.Fill(updatedData);
        //            }
        //        }
        //    }

        //    csvContent.AppendLine(string.Join(",", updatedData.Columns.Cast<DataColumn>().Select(col => "\"" + col.ColumnName.Replace("\"", "\"\"") + "\"")));

        //    foreach (DataRow row in updatedData.Rows)
        //    {
        //        List<string> fields = new List<string>();
        //        foreach (var item in row.ItemArray)
        //        {
        //            fields.Add("\"" + item.ToString().Replace("\"", "\"\"") + "\"");
        //        }
        //        csvContent.AppendLine(string.Join(",", fields));
        //    }

        //    Response.Clear();
        //    Response.ContentType = "text/csv";
        //    Response.AddHeader("Content-Disposition", "attachment;filename=DatosActualizados.csv");
        //    Response.ContentEncoding = Encoding.UTF8;

        //    byte[] byteArray = Encoding.UTF8.GetBytes(csvContent.ToString());
        //    using (MemoryStream memoryStream = new MemoryStream(byteArray))
        //    {
        //        memoryStream.WriteTo(Response.OutputStream);
        //    }

        //    Response.End();
        //}
        //protected void GV_PreUsuarios_BeforeExport(object sender, ASPxGridBeforeExportEventArgs e)
        //{
        //    List<string> selectedIDs = new List<string>();
        //    foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
        //    {
        //        selectedIDs.Add(key.ToString());
        //    }

        //    //if (selectedIDs.Count == 0)
        //    //{
        //    //    // Mostrar mensaje si no se han seleccionado filas
        //    //    string script = "window.onload = function() { alert('Por favor, seleccione las filas a exportar.'); };";
        //    //    ClientScript.RegisterStartupScript(this.GetType(), "alertMessage", script, true);
        //    //    return;
        //    //}
        //    if (!(GV_PreUsuarios.Selection.Count > 0))
        //    {
        //        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alertMessage", "alert('Por favor, seleccione las filas a exportar.');", true);
        //        return;
        //    }

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    {
        //        try
        //        {
        //            using (SqlCommand cmd = new SqlCommand("[gral].[sp_gestion_exportado_user]", con))
        //            {
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                cmd.Parameters.AddWithValue("@IDs", string.Join(",", selectedIDs));
        //                cmd.Parameters.Add("@MENS", SqlDbType.NVarChar, -1).Direction = ParameterDirection.Output;
        //                cmd.Parameters.Add("@RETORNO", SqlDbType.Int).Direction = ParameterDirection.Output;

        //                con.Open();
        //                cmd.ExecuteNonQuery();
        //                string Mens = cmd.Parameters["@MENS"].Value.ToString();
        //                int Retorno = Convert.ToInt32(cmd.Parameters["@RETORNO"].Value);

        //                if (Retorno == 1)
        //                {
        //                    ExportToCSV(selectedIDs);
        //                }
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            ErrorLogger.LogError(ex);
        //            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error al ejecutar el procedimiento almacenado: " + ex.Message + "');", true);
        //            GV_PreUsuarios.Selection.UnselectAll();
        //            GV_PreUsuarios.DataBind();
        //        }
        //        finally
        //        {
        //            con.Close();
        //            GV_PreUsuarios.DataBind();
        //        }
        //        GV_PreUsuarios.DataBind();
        //    }
        //    GV_PreUsuarios.DataBind();
        //}

        //--------------------------------------------------------------------------------------------------------------------

        //private void ExportToCSV(List<string> selectedIDs)
        //{
        //    StringBuilder csvContent = new StringBuilder();
        //    DataTable updatedData = new DataTable();

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    {
        //        string query = "SELECT * FROM Users WHERE Id IN ({0})";
        //        var parameters = new List<string>();
        //        var commandParameters = new List<SqlParameter>();
        //        for (int i = 0; i < selectedIDs.Count; i++)
        //        {
        //            string parameterName = "@id" + i;
        //            parameters.Add(parameterName);
        //            commandParameters.Add(new SqlParameter(parameterName, selectedIDs[i]));
        //        }
        //        query = string.Format(query, string.Join(",", parameters));

        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            cmd.Parameters.AddRange(commandParameters.ToArray());
        //            con.Open();
        //            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
        //            {
        //                adapter.Fill(updatedData);
        //            }
        //        }
        //    }

        //    csvContent.AppendLine(string.Join(",", updatedData.Columns.Cast<DataColumn>().Select(col => "\"" + col.ColumnName.Replace("\"", "\"\"") + "\"")));

        //    foreach (DataRow row in updatedData.Rows)
        //    {
        //        List<string> fields = new List<string>();
        //        foreach (var item in row.ItemArray)
        //        {
        //            fields.Add("\"" + item.ToString().Replace("\"", "\"\"") + "\"");
        //        }
        //        csvContent.AppendLine(string.Join(",", fields));
        //    }

        //    Response.Clear();
        //    Response.ContentType = "text/csv";
        //    Response.AddHeader("Content-Disposition", "attachment;filename=DatosActualizados.csv");
        //    Response.ContentEncoding = Encoding.UTF8;

        //    using (var memoryStream = new MemoryStream())
        //    {
        //        using (var writer = new StreamWriter(memoryStream))
        //        {
        //            writer.Write(csvContent.ToString());
        //            writer.Flush();
        //            memoryStream.WriteTo(Response.OutputStream);
        //        }
        //    }

        //    Response.End();
        //}

        //--------------------------------------------------------------------------------------------------------------------------------


        //protected void GV_PreUsuarios_BeforeExport(object sender, ASPxGridBeforeExportEventArgs e)
        //{
        //    List<string> selectedIDs = new List<string>();
        //    foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
        //    {
        //        selectedIDs.Add(key.ToString());
        //    }

        //    if (!(GV_PreUsuarios.Selection.Count > 0))
        //    {
        //        ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage",
        //            "alert('Por favor, seleccione las filas a exportar.');", true);
        //        return;  // Termina la ejecución del método si no hay filas seleccionadas
        //    }

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    {
        //        try
        //        {
        //            using (SqlCommand cmd = new SqlCommand("[gral].[sp_gestion_exportado_user]", con))
        //            {
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                cmd.Parameters.AddWithValue("@IDs", string.Join(",", selectedIDs));
        //                cmd.Parameters.Add("@MENS", SqlDbType.NVarChar, -1).Direction = ParameterDirection.Output;
        //                cmd.Parameters.Add("@RETORNO", SqlDbType.Int).Direction = ParameterDirection.Output;

        //                con.Open();
        //                cmd.ExecuteNonQuery();
        //                string Mens = cmd.Parameters["@MENS"].Value.ToString();
        //                int Retorno = Convert.ToInt32(cmd.Parameters["@RETORNO"].Value);

        //                if (Retorno == 1)
        //                {
        //                    ExportToCSV(selectedIDs);
        //                }
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error al ejecutar el procedimiento almacenado: " + ex.Message + "');", true);
        //            GV_PreUsuarios.Selection.UnselectAll();
        //        }
        //        finally
        //        {
        //            con.Close();
        //        }
        //    }
        //}

        //private void ExportToCSV(List<string> selectedIDs)
        //{
        //    StringBuilder csvContent = new StringBuilder();
        //    DataTable updatedData = QueryDatabaseForData(selectedIDs);

        //    // Agregar encabezados al archivo CSV
        //    csvContent.AppendLine(string.Join(",", updatedData.Columns.Cast<DataColumn>().Select(col => "\"" + col.ColumnName.Replace("\"", "\"\"") + "\"")));

        //    // Agregar filas al archivo CSV
        //    foreach (DataRow row in updatedData.Rows)
        //    {
        //        List<string> fields = new List<string>();
        //        foreach (var item in row.ItemArray)
        //        {
        //            fields.Add("\"" + item.ToString().Replace("\"", "\"\"") + "\"");
        //        }
        //        csvContent.AppendLine(string.Join(",", fields));
        //    }

        //    // Llama a la nueva función para manejar la respuesta HTTP
        //    WriteCsvToResponse(csvContent.ToString(), "DatosActualizados.csv");
        //}
        //private void WriteCsvToResponse(string csvContent, string fileName)
        //{
        //    try
        //    {
        //        Response.Clear();
        //        Response.ContentType = "text/csv";
        //        Response.ContentEncoding = Encoding.UTF8;
        //        Response.AddHeader("Content-Disposition", $"attachment;filename={fileName}");
        //        Response.Write(csvContent);
        //    }
        //    catch (HttpException ex)
        //    {
        //        // Aquí puedes manejar la excepción, por ejemplo, loguearla o mostrar un mensaje al usuario.
        //        Console.WriteLine("Error al enviar el archivo CSV: " + ex.Message);
        //        ErrorLogger.LogError(ex);
        //    }
        //    catch (IOException ex)
        //    {
        //        // Manejar excepciones específicas de E/S
        //        ErrorLogger.LogError(ex);
        //    }
        //    catch (Exception ex)
        //    {
        //        // Captura cualquier otro tipo de excepción
        //        ErrorLogger.LogError(ex);
        //    }
        //    finally
        //    {
        //        Response.Flush();
        //        Response.SuppressContent = true;  // Evita enviar contenido adicional
        //        HttpContext.Current.ApplicationInstance.CompleteRequest();
        //    }
        //}
        //private DataTable QueryDatabaseForData(List<string> selectedIDs)
        //{
        //    DataTable updatedData = new DataTable();
        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    {
        //        // Preparar la consulta SQL con parámetros
        //        string query = "SELECT * FROM Users WHERE Id IN ({0})";
        //        var parameters = new List<string>();
        //        var commandParameters = new List<SqlParameter>();
        //        for (int i = 0; i < selectedIDs.Count; i++)
        //        {
        //            string parameterName = "@id" + i;
        //            parameters.Add(parameterName);
        //            commandParameters.Add(new SqlParameter(parameterName, selectedIDs[i]));
        //        }
        //        query = string.Format(query, string.Join(",", parameters));

        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            // Agregar parámetros al comando SQL
        //            cmd.Parameters.AddRange(commandParameters.ToArray());

        //            con.Open();
        //            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
        //            {
        //                adapter.Fill(updatedData);
        //            }
        //        }
        //    }
        //    return updatedData;
        //}



        // -----------------------------------------------------------------------------------



        //private void ExportToCSV(List<string> selectedIDs)
        //{
        //    // Crear una instancia de StringBuilder para construir el contenido del archivo CSV
        //    StringBuilder csvContent = new StringBuilder();

        //    // Consultar la base de datos para obtener los datos actualizados
        //    DataTable updatedData = new DataTable();
        //    //using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    //{
        //    //    string query = "SELECT * FROM Users WHERE Id IN (" + string.Join(",", selectedIDs) + ")";
        //    //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    //    {
        //    //        con.Open();
        //    //        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
        //    //        {
        //    //            adapter.Fill(updatedData);
        //    //        }
        //    //    }
        //    //}

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //    {
        //        // Preparar la consulta SQL con parámetros
        //        string query = "SELECT * FROM Users WHERE Id IN ({0})";
        //        var parameters = new List<string>();
        //        var commandParameters = new List<SqlParameter>();
        //        for (int i = 0; i < selectedIDs.Count; i++)
        //        {
        //            string parameterName = "@id" + i;
        //            parameters.Add(parameterName);
        //            commandParameters.Add(new SqlParameter(parameterName, selectedIDs[i]));
        //        }
        //        query = string.Format(query, string.Join(",", parameters));

        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            // Agregar parámetros al comando SQL
        //            cmd.Parameters.AddRange(commandParameters.ToArray());

        //            con.Open();
        //            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
        //            {
        //                adapter.Fill(updatedData);
        //            }
        //        }
        //    }

        //    // Agregar encabezados al archivo CSV
        //    csvContent.AppendLine(string.Join(",", updatedData.Columns.Cast<DataColumn>().Select(col => "\"" + col.ColumnName.Replace("\"", "\"\"") + "\"")));

        //    // Agregar filas al archivo CSV
        //    foreach (DataRow row in updatedData.Rows)
        //    {
        //        List<string> fields = new List<string>();
        //        foreach (var item in row.ItemArray)
        //        {
        //            fields.Add("\"" + item.ToString().Replace("\"", "\"\"") + "\"");
        //        }
        //        csvContent.AppendLine(string.Join(",", fields));
        //    }

        //    // Configurar la respuesta HTTP para la descarga del archivo CSV
        //    //Response.Clear();
        //    //Response.ContentType = "text/csv";
        //    //Response.AddHeader("Content-Disposition", "attachment;filename=DatosActualizados.csv");
        //    //Response.ContentEncoding = Encoding.UTF8;

        //    //// Escribir el contenido del archivo CSV en la respuesta HTTP
        //    //Response.Write(csvContent.ToString());
        //    //Response.End();

        //    //Response.Clear();
        //    //Response.ContentType = "text/csv";
        //    //Response.AddHeader("Content-Disposition", "attachment;filename=DatosActualizados.csv");
        //    //Response.ContentEncoding = Encoding.UTF8;

        //    //// Escribir el contenido del archivo CSV en la respuesta HTTP
        //    //Response.Write(csvContent.ToString());
        //    //GV_PreUsuarios.DataBind();
        //    //Response.Flush();
        //    //Response.End();
        //    //GV_PreUsuarios.DataBind();
        //    try
        //    {
        //        Response.Clear();
        //        Response.ContentType = "text/csv";
        //        Response.ContentEncoding = Encoding.UTF8;
        //        Response.AddHeader("Content-Disposition", "attachment;filename=DatosActualizados.csv");
        //        Response.Write(csvContent.ToString());
        //    }
        //    catch (HttpException ex)
        //    {
        //        // Log the exception or handle it accordingly
        //    }
        //    finally
        //    {
        //        Response.Flush();
        //        Response.SuppressContent = true;  // Evita enviar contenido adicional
        //        HttpContext.Current.ApplicationInstance.CompleteRequest();
        //    }
        //}
        //------------------------------------------------------------------------------------------------------------
        //        private void ExportToCSV(List<string> selectedIDs)
        //{
        //    StringBuilder csvContent = new StringBuilder();
        //    DataTable updatedData = QueryDatabaseForData(selectedIDs); // Asumiendo que tienes una función que encapsula la lógica de la base de datos

        //    // Agregar encabezados al archivo CSV
        //    csvContent.AppendLine(string.Join(",", updatedData.Columns.Cast<DataColumn>().Select(col => "\"" + col.ColumnName.Replace("\"", "\"\"") + "\"")));

        //    // Agregar filas al archivo CSV
        //    foreach (DataRow row in updatedData.Rows)
        //    {
        //        List<string> fields = new List<string>();
        //        foreach (var item in row.ItemArray)
        //        {
        //            fields.Add("\"" + item.ToString().Replace("\"", "\"\"") + "\"");
        //        }
        //        csvContent.AppendLine(string.Join(",", fields));
        //    }

        //    // Llama a la nueva función para manejar la respuesta HTTP
        //    WriteCsvToResponse(csvContent.ToString(), "DatosActualizados.csv");
        //}
        //        private void WriteCsvToResponse(string csvContent, string fileName)
        //        {
        //            try
        //            {
        //                Response.Clear();
        //                Response.ContentType = "text/csv";
        //                Response.ContentEncoding = Encoding.UTF8;
        //                Response.AddHeader("Content-Disposition", $"attachment;filename={fileName}");
        //                Response.Write(csvContent);
        //            }
        //            catch (HttpException ex)
        //            {
        //                // Aquí puedes manejar la excepción, por ejemplo, loguearla o mostrar un mensaje al usuario.
        //                Console.WriteLine("Error al enviar el archivo CSV: " + ex.Message);
        //            }
        //            finally
        //            {
        //                Response.Flush();
        //                Response.SuppressContent = true;  // Evita enviar contenido adicional
        //                HttpContext.Current.ApplicationInstance.CompleteRequest();
        //            }
        //        }
        //protected void GV_PreUsuarios_BeforeExport(object sender, ASPxGridBeforeExportEventArgs e)
        //{
        //    // Variable para controlar si continuar con la exportación
        //    //bool continueExport = true;

        //    switch (e.ExportTarget)
        //    {
        //        case ExportTarget.Csv:
        //            // Obtener los IDs de los elementos seleccionados
        //            List<string> selectedIDs = new List<string>();
        //            foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
        //            {
        //                selectedIDs.Add(key.ToString());
        //            }

        //            // Llamar al procedimiento almacenado para actualizar los datos seleccionados
        //            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //            {
        //                try
        //                {
        //                    using (SqlCommand cmd = new SqlCommand("[gral].[sp_gestion_exportado_user]", con))
        //                    {
        //                        cmd.CommandType = CommandType.StoredProcedure;
        //                        cmd.Parameters.AddWithValue("@IDs", string.Join(",", selectedIDs)); // Convertir la lista de IDs en una cadena separada por comas
        //                        cmd.Parameters.Add("@MENS", SqlDbType.NVarChar, -1).Direction = ParameterDirection.Output;
        //                        cmd.Parameters.Add("@RETORNO", SqlDbType.Int).Direction = ParameterDirection.Output;

        //                        con.Open();
        //                        cmd.ExecuteNonQuery();
        //                        string Mens = cmd.Parameters["@MENS"].Value.ToString();
        //                        int Retorno = Convert.ToInt32(cmd.Parameters["@RETORNO"].Value);

        //                        con.Close();

        //                        if (Retorno == 1)
        //                        {

        //                            ExportToCSV(selectedIDs);

        //                        }
        //                        GV_PreUsuarios.DataBind();
        //                    }
        //                }
        //                catch (Exception ex)
        //                {
        //                    // Manejar el error aquí, por ejemplo, imprimir un mensaje de error o registrar el error en un archivo de registro
        //                    Console.WriteLine("Error al ejecutar el procedimiento almacenado: " + ex.Message);
        //                    //continueExport = false; 
        //                    // Detener la exportación si hay un error
        //                    GV_PreUsuarios.Selection.UnselectAll();
        //                    GV_PreUsuarios.DataBind();
        //                }
        //                GV_PreUsuarios.DataBind();
        //            }
        //            GV_PreUsuarios.DataBind();

        //            // Exportar los datos seleccionados actualizados a un archivo CSV solo si continueExport es true

        //            break;

        //        default:
        //            break;
        //    }
        //    GV_PreUsuarios.DataBind();


        //}

        //switch (e.ExportTarget)
        //{
        //    case ExportTarget.Csv:
        //        // Obtener los IDs de los elementos seleccionados
        //        List<string> selectedIDs = new List<string>();
        //        foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
        //        {
        //            selectedIDs.Add(key.ToString());
        //        }

        //        // Llamar al procedimiento almacenado para actualizar los datos seleccionados
        //        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //        {
        //            try
        //            {
        //                using (SqlCommand cmd = new SqlCommand("[gral].[sp_gestion_actualizar_traslado_user]", con))
        //                {
        //                    cmd.CommandType = CommandType.StoredProcedure;
        //                    cmd.Parameters.AddWithValue("@IDs", string.Join(",", selectedIDs)); // Convertir la lista de IDs en una cadena separada por comas
        //                    con.Open();
        //                    cmd.ExecuteNonQuery();
        //                }
        //            }
        //            catch (Exception ex)
        //            {
        //                // Manejar el error aquí, por ejemplo, imprimir un mensaje de error o registrar el error en un archivo de registro
        //                // Ejemplo: Console.WriteLine("Error al ejecutar el procedimiento almacenado: " + ex.Message);
        //            }
        //        }

        //        // Exportar los datos seleccionados actualizados a un archivo CSV
        //        // Suponiendo que tienes una función para exportar datos a CSV llamada "ExportToCSV"
        //        ExportToCSV(selectedIDs);

        //        // Detener la exportación normal para evitar que se exporten los datos no actualizados
        //        e.Cancel = true;
        //        break;

        //    default:
        //        break;
        //}

        //switch (e.ExportTarget)
        //{
        //    case ExportTarget.Csv:
        //        // Obtener los IDs de los elementos seleccionados
        //        List<string> selectedIDs = new List<string>();
        //        foreach (var key in GV_PreUsuarios.GetSelectedFieldValues("Id"))
        //        {
        //            selectedIDs.Add(key.ToString());
        //        }

        //        // Llamar al procedimiento almacenado para actualizar los datos seleccionados
        //        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString))
        //        {
        //            try
        //            {
        //                using (SqlCommand cmd = new SqlCommand("[gral].[sp_gestion_actualizar_traslado_user]", con))
        //                {
        //                    cmd.CommandType = CommandType.StoredProcedure;
        //                    cmd.Parameters.AddWithValue("@IDs", string.Join(",", selectedIDs)); // Convertir la lista de IDs en una cadena separada por comas
        //                    con.Open();
        //                    cmd.ExecuteNonQuery();
        //                }
        //            }
        //            catch (Exception ex)
        //            {
        //                // Manejar el error aquí, por ejemplo, imprimir un mensaje de error o registrar el error en un archivo de registro
        //                // Ejemplo: Console.WriteLine("Error al ejecutar el procedimiento almacenado: " + ex.Message);
        //            }
        //        }

        //        CsvExportOptions optionsCsv = e.ExportOptions as CsvExportOptions;
        //        optionsCsv.TextExportMode = TextExportMode.Text;
        //        optionsCsv.Separator = ","; // Asegurando que el delimitador es una coma
        //        optionsCsv.Encoding = Encoding.UTF8; // Esto es opcional, pero es útil si se esperan caracteres especiales
        //        break;

        //    default:
        //        break;
        //}

        //ASPxGridView1.Columns["ProductName"].Visible = false;
        //var selectedIds = GV_PreUsuarios.GetSelectedFieldValues("Id");

        //if (selectedIds != null && selectedIds.Count > 0)
        //{
        //    DataTable filteredData = GetFullDataTable(selectedIds);
        //    GV_PreUsuarios.DataSource = filteredData;
        //    GV_PreUsuarios.DataBind();
        //}

        //switch (e.ExportTarget)
        //{
        //    case ExportTarget.Csv:
        //        CsvExportOptions optionsCsv = e.ExportOptions as CsvExportOptions;
        //        optionsCsv.TextExportMode = TextExportMode.Text;
        //        optionsCsv.Separator = ","; // Asegurando que el delimitador es una coma
        //        optionsCsv.Encoding = Encoding.UTF8; // Esto es opcional, pero es útil si se esperan caracteres especiales
        //        break;
        //    default:
        //        break;
        //}

        //protected void GV_PreUsuarios_DataBinding(object sender, EventArgs e)
        //{

        //}




        //private DataTable GetFullDataTable(List<object> selectedIds = null)
        //{
        //    string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
        //    string query;

        //    if (selectedIds != null && selectedIds.Count > 0)
        //    {
        //        var ids = string.Join(",", selectedIds); // Convertimos la lista en una cadena separada por comas
        //        query = $"SELECT * FROM [Users] WHERE Id IN ({ids})";
        //    }
        //    else
        //    {
        //        query = "SELECT * FROM [Users] where Traslado IS NULL"; // Consulta para obtener todos los datos
        //    }

        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
        //            {
        //                DataTable dt = new DataTable();
        //                da.Fill(dt);
        //                return dt;
        //            }
        //        }
        //    }
        //}

        //private void ASPxGridView1_BeforeExport(object sender, DevExpress.Web.ASPxGridViewExportEventArgs e)
        //{
        //    if (e.ExportType == DevExpress.Export.ExportType.Csv)
        //    {
        //        var options = new DevExpress.XtraPrinting.CsvExportOptionsEx();
        //        options.Separator = ","; // Establecer coma como delimitador
        //        e.ExportOptions = options;
        //    }
        //}
    }
}