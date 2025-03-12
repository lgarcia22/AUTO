using DevExpress.XtraReports.UI;
using PREDJL.App_Start;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PREDJL
{
    public partial class DocumentoPdf : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ConexionBD conexionBD = new ConexionBD();

            if (!conexionBD.abrirConexion())
            {
                // Redirige a la página de error si falla la conexión
                Response.Redirect("ErrorConexion.aspx");
                return; // Detén la ejecución
            }

            // Lógica para cuando la conexión es exitosa
            conexionBD.cerrarConexion();
            //if (!IsPostBack)
            //{
            //    int documentId;
            //    if (int.TryParse(Request.QueryString["id"], out documentId))
            //    {
            //        // Suponiendo que tienes un método para obtener el stream del documento
            //        Stream documentoStream = ObtenerDocumentoStream(documentId);

            //        ASPxWebDocumentViewer1.OpenReport(new XtraReport() { DataSource = documentoStream });

            //    }
            //    else
            //    {
            //        // Manejo de error: ID no válido o documento no encontrado
            //        Response.Write("Documento no encontrado o ID inválido.");
            //    }
            //}
            //if (!IsPostBack)
            //{
            //    int documentId;
            //    if (int.TryParse(Request.QueryString["id"], out documentId))
            //    {
            //        // Obtiene el stream del documento usando el ID proporcionado
            //        using (Stream documentoStream = ObtenerDocumentoStream(documentId))
            //        {
            //            if (documentoStream != null)
            //            {
            //                // Asegurarse de que el stream esté en la posición inicial
            //                documentoStream.Position = 0;
            //                XtraReport report = new XtraReport();
            //                report.DataSource = documentoStream;
            //                ASPxWebDocumentViewer1.OpenReport(report);
            //            }
            //            else
            //            {
            //                // Notificar al usuario que el documento no pudo ser cargado
            //                Response.Write("El documento no pudo ser cargado o está vacío.");
            //            }
            //        }
            //    }
            //    else
            //    {
            //        // Manejo de error: ID no válido o documento no encontrado
            //        Response.Write("Documento no encontrado o ID inválido.");
            //    }
            //}

            //if (!IsPostBack)
            //{
            //    int documentId;
            //    if (int.TryParse(Request.QueryString["id"], out documentId))
            //    {
            //        byte[] documentoBytes = ObtenerDocumentoBytes(documentId);
            //        if (documentoBytes != null)
            //        {
            //            Response.ContentType = "application/pdf";
            //            Response.BinaryWrite(documentoBytes);
            //            Response.End();
            //        }
            //        else
            //        {
            //            Response.Write("El documento no pudo ser cargado o está vacío.");
            //        }
            //    }
            //    else
            //    {
            //        Response.Write("Documento no encontrado o ID inválido.");
            //    }
            //}
            //if (!IsPostBack)
            //{
            //    string encryptedDocumentId = Request.QueryString["id"];
            //    if (!string.IsNullOrEmpty(encryptedDocumentId))
            //    {
            //        string decryptedDocumentIdString;
            //        int documentId;
            //        try
            //        {
            //            decryptedDocumentIdString = Util.Decrypt(encryptedDocumentId);
            //            if (int.TryParse(decryptedDocumentIdString, out documentId))
            //            {
            //                byte[] documentoBytes = ObtenerDocumentoBytes(documentId);
            //                if (documentoBytes != null)
            //                {
            //                    Response.ContentType = "application/pdf";
            //                    Response.BinaryWrite(documentoBytes);
            //                    Response.End();
            //                }
            //                else
            //                {
            //                    Response.Write("El documento no pudo ser cargado o está vacío.");
            //                }
            //            }
            //            else
            //            {
            //                Response.Write("Documento no encontrado o ID inválido.");
            //            }
            //        }
            //        catch (FormatException)
            //        {
            //            Response.Write("Error de formato en el ID del documento.");
            //        }
            //        catch (ArgumentException)
            //        {
            //            Response.Write("Argumento inválido al desencriptar el ID.");
            //        }
            //    }
            //    else
            //    {
            //        Response.Write("No se proporcionó ningún ID de documento.");
            //    }
            //}
            //    // ultima
            //if (!IsPostBack)
            //{
            //    string encryptedDocumentId = Request.QueryString["id"];
            //    if (!string.IsNullOrEmpty(encryptedDocumentId))
            //    {
            //        try
            //        {
            //            string decryptedDocumentIdString = Util.Decrypt(encryptedDocumentId);
            //            // Log the output for debugging
            //            System.Diagnostics.Debug.WriteLine("Decrypted ID: " + decryptedDocumentIdString);

            //            if (int.TryParse(decryptedDocumentIdString, out int documentId))
            //            {
            //                byte[] documentoBytes = ObtenerDocumentoBytes(documentId);
            //                if (documentoBytes != null)
            //                {
            //                    Response.ContentType = "application/pdf";
            //                    Response.BinaryWrite(documentoBytes);
            //                    Response.End();
            //                }
            //                else
            //                {
            //                    Response.Write("El documento no pudo ser cargado o está vacío.");
            //                }
            //            }
            //            else
            //            {
            //                Response.Write("Documento no encontrado o ID inválido.");
            //            }
            //        }
            //        catch (Exception ex)  // General exception catch to capture any unexpected errors
            //        {
            //            Response.Write("Error al procesar el ID: " + ex.Message);
            //        }
            //    }
            //    else
            //    {
            //        Response.Write("No se proporcionó ningún ID de documento.");
            //    }
            //}
            if (!IsPostBack)
            {
                string encryptedDocumentId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(encryptedDocumentId))
                {
                    try
                    {
                        string decryptedDocumentIdString = Util.Decrypt(encryptedDocumentId);
                        System.Diagnostics.Debug.WriteLine("Decrypted ID: " + decryptedDocumentIdString);

                        if (int.TryParse(decryptedDocumentIdString, out int documentId))
                        {
                            byte[] documentoBytes = ObtenerDocumentoBytes(documentId);
                            if (documentoBytes != null)
                            {
                                Response.ContentType = "application/pdf";
                                Response.BinaryWrite(documentoBytes);
                                Response.Flush(); // Asegura que todo el contenido se ha enviado al cliente.
                                HttpContext.Current.ApplicationInstance.CompleteRequest(); // Finaliza la solicitud de manera adecuada sin lanzar ThreadAbortException.
                            }
                            else
                            {
                                Response.Write("El documento no pudo ser cargado o está vacío.");
                            }
                        }
                        else
                        {
                            Response.Write("Documento no encontrado o ID inválido.");
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write("Error al procesar el ID: " + ex.Message);
                    }
                }
                else
                {
                    Response.Write("No se proporcionó ningún ID de documento.");
                }
            }


        }

        private byte[] ObtenerDocumentoBytes(int id)
        {
            string conexionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
            using (SqlConnection conexion = new SqlConnection(conexionString))
            {
                conexion.Open();
                using (SqlCommand comando = new SqlCommand("SELECT Documento FROM Solicitud_Usuario WHERE Id_User = @DocumentoId", conexion))
                {
                    comando.Parameters.AddWithValue("@DocumentoId", id);
                    using (SqlDataReader reader = comando.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            byte[] documentoData = reader["Documento"] as byte[];
                            return documentoData;
                        }
                    }
                }
            }
            return null;
        }

        //private Stream ObtenerDocumentoStream(int id)
        //{
        //    // Definir la cadena de conexión a la base de datos
        //    string conexionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;

        //    // Crear la conexión a la base de datos
        //    using (SqlConnection conexion = new SqlConnection(conexionString))
        //    {
        //        // Abrir la conexión
        //        conexion.Open();

        //        // Crear el comando SQL para obtener el documento
        //        using (SqlCommand comando = new SqlCommand("SELECT Documento FROM Users WHERE Id = @DocumentoId", conexion))
        //        {
        //            // Añadir el parámetro del ID del documento
        //            comando.Parameters.Add(new SqlParameter("@DocumentoId", SqlDbType.Int));
        //            comando.Parameters["@DocumentoId"].Value = id;

        //            // Ejecutar el comando y obtener el resultado
        //            using (SqlDataReader reader = comando.ExecuteReader())
        //            {
        //                // Si hay un documento, leerlo
        //                if (reader.Read())
        //                {
        //                    // Obtener los datos del documento como un array de bytes
        //                    byte[] documentoData = reader["Documento"] as byte[];
        //                    if (documentoData != null)
        //                    {
        //                        // Convertir el array de bytes a un MemoryStream y retornarlo
        //                        return new MemoryStream(documentoData);
        //                    }
        //                }
        //            }
        //        }
        //    }

        //    // Si no se encuentra el documento o hay un error, retornar null
        //    return null;
        //}

    }
}