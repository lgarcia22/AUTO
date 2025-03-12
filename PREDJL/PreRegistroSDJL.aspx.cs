using DevExpress.Web;
using PREDJL.App_Start;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using DevExpress.XtraReports.UI;
using DevExpress.XtraPrinting.BarCode;
using System.Web;
using System.Drawing;
using DevExpress.XtraPrinting;
using System.Configuration;



namespace PREDJL
{
    public partial class PreRegistroSDJL : System.Web.UI.Page
    {
        readonly ConexionBD conex = new ConexionBD();
        private const string SessionKey = "UploadedFile";
        string cadena = (ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString);
        public string MyDir { get; private set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    // Inicializar el ASPxTextBox si es necesario
            //}
            //else
            //{
            //    // Convertir el texto a mayúsculas después de un postback
            //    tbNombre.Text = tbNombre.Text.ToUpper();
            //    tbApellido.Text = tbApellido.Text.ToUpper();
            //    tbCorreo.Text = tbCorreo.Text.ToUpper();
            //    tbConfirmCorreo.Text = tbConfirmCorreo.Text.ToUpper();
            //    tbDNI.Text = tbDNI.Text.ToUpper();
            //    tbDependencia.Text = tbDependencia.Text.ToUpper();
            //}
            Form.Attributes.Add("autocomplete", "off");
            phDenunciado.Visible = true;
          



        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            //// Verificar si la conexión no es exitosa y redirigir
            //if (!conex.abrirConexion())
            //{
            //    // Redirige a la página de error si falla la conexión
            //    if (!IsPostBack) // Asegura que no sea un postback
            //    {
            //        Response.RedirectLocation = "../ErrorConexion.aspx";
            //        //Response.Redirect("ErrorConexion.aspx", true);
            //        return; // Detén la ejecución del código posterior
            //    }
            //}

            //// Si la conexión es exitosa, ciérrala
            //conex.cerrarConexion();
        }

        protected void tbDNI_Validation(object sender, DevExpress.Web.ValidationEventArgs e)
        {
            string id = e.Value.ToString();
            if (!IsValidID(id))
            {
                e.IsValid = false;
                e.ErrorText = "El Número de identificación es incorrecto.";
            }
        }

        protected void tbcampo_Validation(object sender, DevExpress.Web.ValidationEventArgs e)
        {
            string valor = e.Value.ToString();
            if (!IsValidValor(valor))
            {
                e.IsValid = false;
                e.ErrorText = "El valor ingresado es incorrecto.";
            }
        }


        private bool IsValidValor(string valor)
        {
            // Validación para el Documento Nacional de Identificación (DNI)
            if (IsLettersAndSpecialChars(valor))
            {
                return true;
            }
            return false;
        }

        private bool IsLettersAndSpecialChars(string value)
        {
            foreach (char c in value)
            {
                // Verifica si el carácter es una letra, un guion (-) o una barra (/)
                if (!char.IsLetter(c) && c != '-' && c != '/')
                {
                    return false; // Si no es válido, retorna false
                }
            }
            return true; // Si todos los caracteres son válidos, retorna true
        }

        private bool IsValidID(string id)
        {
            // Validación para el Documento Nacional de Identificación (DNI)
            if (id.Length == 13 && IsNumeric(id))
            {
                return true;
            }
            // Validación para el pasaporte
            else if (id.Length >= 6 && id.Length <= 9 && IsAlphanumeric(id))
            {
                return true;
            }
            // Validación para el carnet de residencia
            else if (id.Length == 9 && IsAlphanumeric(id))
            {
                return true;
            }
            return false;
        }

        private bool IsNumeric(string value)
        {
            foreach (char c in value)
            {
                if (!char.IsDigit(c))
                    return false;
            }
            return true;
        }

        private bool IsAlphanumeric(string value)
        {
            foreach (char c in value)
            {
                if (!char.IsLetterOrDigit(c))
                    return false;
            }
            return true;
        }

        //protected void tbCelular_Validation(object sender, DevExpress.Web.ValidationEventArgs e)
        //{
        //    string celular = e.Value.ToString();
        //    if (!IsValidCelular(celular))
        //    {
        //        e.IsValid = false;
        //        e.ErrorText = "El campo debe contener números y 8 dígitos.";
        //    }
        //}

        //private bool IsValidCelular(string celular)
        //{
        //    // Verifica que el valor solo contenga números y tenga al menos 8 dígitos
        //    if (celular.Length >= 8 && IsNumeric(celular))
        //    {
        //        return true;
        //    }
        //    return false;
        //}

        protected void tbNombre_Validation(object sender, DevExpress.Web.ValidationEventArgs e)
        {
            string nombre = e.Value.ToString();
            if (!IsValidNombreApellido(nombre))
            {
                e.IsValid = false;
                e.ErrorText = "El campo solo puede contener letras y espacios.";
            }
        }

        protected void tbApellido_Validation(object sender, DevExpress.Web.ValidationEventArgs e)
        {
            string apellido = e.Value.ToString();
            if (!IsValidNombreApellido(apellido))
            {
                e.IsValid = false;
                e.ErrorText = "El campo solo puede contener letras y espacios.";
            }
        }

        private bool IsValidNombreApellido(string value)
        {
            // Verifica que el valor solo contenga letras y espacios
            foreach (char c in value)
            {
                if (!char.IsLetter(c) && c != ' ')
                {
                    return false; // Si no es válido, retorna false
                }
            }
            return true; // Si todos los caracteres son válidos, retorna true
        }
        protected void FillCityCombo(string country)
        {
            if (string.IsNullOrEmpty(country)) return;

        }

        protected void CmbCity2_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            FillCityCombo2(e.Parameter);
        }

        protected void FillCityCombo2(string country)
        {
            if (string.IsNullOrEmpty(country)) return;

        }

        protected void CmbCity_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            FillCityCombo(e.Parameter);
        }

        protected void Callback_Callback(object source, CallbackEventArgs e)
        {
            Session.Remove(SessionKey);
            e.Result = "OK";
        }

        protected static string llama_plantilla(string mi_plantilla)
        {
            System.Text.ASCIIEncoding v_codigoAscii = new System.Text.ASCIIEncoding();
            System.Net.WebClient v_recibeDato = new System.Net.WebClient();
            byte[] v_recibe;
            string v_recibecadena;

            try
            {
                v_recibe = v_recibeDato.DownloadData(mi_plantilla);
                v_recibecadena = v_codigoAscii.GetString(v_recibe);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message.ToString() + ex.ToString());
            }

            return v_recibecadena;

        }

        protected void OK_Click(object sender, EventArgs e)
        {

            Response.Redirect("http://localhost:63127/AutoenrolamientoDJL.aspx");
        }

        //protected void tbNombre_TextChanged(object sender, EventArgs e)
        //{
        //    // Obtener el control ASPxTextBox
        //    ASPxTextBox tbNombre = sender as ASPxTextBox;

        //    // Convertir el texto a mayúsculas
        //    if (tbNombre != null)
        //    {
        //        tbNombre.Text = tbNombre.Text.ToUpper();
        //    }
        //}

        public class UploadedFile
        {
            public string FileId { get; set; }
            public string FileName { get; set; }
            public byte[] FileBytes { get; set; }
            // Puedes agregar más propiedades según sea necesario
        }
        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            int maxAllowedFiles = 5; // Cambia este valor según tus necesidades

            if (e.IsValid)
            {
                // Verifica la cantidad de archivos ya cargados
                List<UploadedFile> uploadedFilesList = (List<UploadedFile>)Session["UploadedFilesList"] ?? new List<UploadedFile>();

                if (uploadedFilesList.Count <= maxAllowedFiles)
                {
                    // Aún no se ha alcanzado el límite, por lo que puedes procesar el archivo
                    UploadedFile uploadedFile = new UploadedFile
                    {
                        FileId = Guid.NewGuid().ToString(),
                        FileName = e.UploadedFile.FileName,
                        FileBytes = e.UploadedFile.FileBytes
                        // Puedes agregar más propiedades según sea necesario
                    };

                    // Agrega el archivo a la lista temporal
                    uploadedFilesList.Add(uploadedFile);
                    Session["UploadedFilesList"] = uploadedFilesList;

                    // Construye una cadena con la lista de archivos y asigna al CallbackData
                    string fileList = string.Join("|", uploadedFilesList.Select(file => file.FileName));
                    e.CallbackData = fileList;

                }
                else
                {
                    // Se ha alcanzado el límite, así que marca el archivo como inválido
                    e.ErrorText = "No se permiten más de " + maxAllowedFiles + " archivos simultáneamente.";
                    e.IsValid = false;
                }


            }

        }

        protected void ASPxCallback_EnviarToken_Callback(object source, CallbackEventArgs e)
        {
            string email = e.Parameter;
            string token = GenerateToken();

            Util.SetToken(token, DateTime.Now);

            SampleUtil.SendToken(email, token);

            e.Result = "Token enviado";
        }

        protected void ASPxCallback_VerificarToken_Callback(object source, CallbackEventArgs e)
        {
            string inputToken = e.Parameter;
            var (storedToken, tokenTimestamp) = Util.GetToken();

            if (storedToken != null && tokenTimestamp != null)
            {
                double elapsedMinutes = (DateTime.Now - tokenTimestamp.Value).TotalMinutes;
                System.Diagnostics.Debug.WriteLine($"Antigüedad del token en minutos: {elapsedMinutes}");

                if (elapsedMinutes <= 15)
                {
                    Util.SetToken(storedToken, tokenTimestamp.Value); 

                    if (inputToken == storedToken)
                    {
                        e.Result = "success";
                        System.Diagnostics.Debug.WriteLine("La verificación del token fue exitosa.");
                    }
                    else
                    {
                        e.Result = "incorrect";
                        System.Diagnostics.Debug.WriteLine("Token is incorrecto.");
                    }
                }
                else
                {
                    e.Result = "expired";
                    System.Diagnostics.Debug.WriteLine("Token ha expirado.");
                    HttpContext.Current.Session.Remove("VerificationToken");
                    HttpContext.Current.Session.Remove("TokenTimestamp");
                }
            }
            else
            {
                e.Result = "failure";
                System.Diagnostics.Debug.WriteLine("Falta token o marca de tiempo.");
            }
        }

        private string GenerateToken()
        {
            return new Random().Next(100000, 999999).ToString();
        }


        //protected void ASPxCallback_Guardar_Datos_Callback(object source, CallbackEventArgs e)
        //{
        //    SqlTransaction transaction = null;

        //    try
        //    {
        //        using (SqlConnection conn = new SqlConnection(cadena))
        //        {
        //            conn.Open();
        //            transaction = conn.BeginTransaction();

        //            SqlCommand cmd = SetupCommand(conn, transaction);
        //            PopulateParameters(cmd);
        //            ExecuteDatabaseCommand(cmd);

        //            PrepareResponse(e, cmd);

        //            if (CheckForSuccess(cmd))
        //            {
        //                ManageReportCreationAndEmailing(cmd);
        //            }

        //            // If everything is successful, commit the transaction
        //            transaction.Commit();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // Rollback the transaction if any error occurs
        //        transaction?.Rollback();
        //        HandleException(e, ex);
        //    }
        //}
        protected void ASPxCallback_Guardar_Datos_Callback(object source, CallbackEventArgs e)
        {
            try
            {
                SqlCommand cmd = SetupCommand();
                PopulateParameters(cmd);
                ExecuteDatabaseCommand(cmd);
                PrepareResponse(e, cmd);
                if (CheckForSuccess(cmd))
                {
                    ManageReportCreationAndEmailing(cmd);
                }
            }
            catch (Exception ex)
            {
                HandleException(e, ex);
            }
        }

        private void PrepareResponse(CallbackEventArgs e, SqlCommand cmd)
        {
            var responseObj = new
            {
                Retorno = Convert.ToInt32(cmd.Parameters["@RETORNO"].Value),
                Mensaje = cmd.Parameters["@MENS"].Value.ToString(),
            };
            e.Result = JsonConvert.SerializeObject(responseObj);
        }

        //private SqlCommand SetupCommand(SqlConnection conn, SqlTransaction transaction)
        //{
        //    SqlCommand cmd = new SqlCommand("[gral].[sp_gestion_PreRegistro]", conn, transaction);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    return cmd;
        //}
        private SqlCommand SetupCommand()
        {
            var cmd = new SqlCommand
            {
                CommandType = CommandType.StoredProcedure,
                CommandText = "[gral].[sp_gestion_PreRegistro]",
                Connection = conex.conexion
            };
            return cmd;
        }
        private void PopulateParameters(SqlCommand cmd)
        {
            string email = tbCorreo.Text.ToUpper();
            string DNI = tbDNI.Text.ToUpper();
            string FirstName = tbNombre.Text.ToUpper();
            string LastName = tbApellido.Text.ToUpper();
            string Address = tbDependencia.Text.ToUpper();
            DateTime? FechaIngreso = tbFechaIngreso.Value as DateTime?;
            string Company = CmbCountry.Text.ToUpper();
            string Phone = !string.IsNullOrEmpty(tbCelular.Text) ? tbCelular.Text.Trim() : null;
            //string TypeDeclaration = CmbTipoDeclaracion.Text;

            Session["FirstName"] = FirstName + " " + LastName;

            bool Policy = ckPolitica.Checked;
            cmd.Parameters.Add("@pcEmail", SqlDbType.NVarChar, 500).Value = email.ToUpper();
            cmd.Parameters.Add("@pnDNI", SqlDbType.NVarChar, 500).Value = DNI.ToUpper();
            cmd.Parameters.Add("@pcFirstName", SqlDbType.NVarChar, 500).Value = FirstName.ToUpper();
            cmd.Parameters.Add("@pcLastName", SqlDbType.NVarChar, 500).Value = LastName.ToUpper();
            cmd.Parameters.Add("@pnAddress", SqlDbType.NVarChar, 500).Value = Address.ToUpper();
            cmd.Parameters.Add("@pdFechaIngreso", SqlDbType.DateTime).Value = FechaIngreso;
            cmd.Parameters.Add("@pcCompany", SqlDbType.NVarChar, 500).Value = Company;
            cmd.Parameters.Add("@pnPhone", SqlDbType.NVarChar, 500).Value = Phone;
            //cmd.Parameters.Add("@pcTypeDeclaration", SqlDbType.NVarChar, 500).Value = TypeDeclaration;
            cmd.Parameters.Add("@pbPolitica", SqlDbType.Bit).Value = Policy;
            cmd.Parameters.Add("@MENS", SqlDbType.NVarChar, -1).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@RETORNO", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Direction = ParameterDirection.Output;

        }

        private void ExecuteDatabaseCommand(SqlCommand cmd)
        {
            try
            {
                conex.abrirConexion(); 
                cmd.ExecuteNonQuery();
                string Mens = cmd.Parameters["@MENS"].Value.ToString();
                int Retorno = Convert.ToInt32(cmd.Parameters["@RETORNO"].Value);
                Session["Id"] = Convert.ToInt32(cmd.Parameters["@Id"].Value);

            }
            finally
            {
                conex.cerrarConexion(); 
            }
        }

        private bool CheckForSuccess(SqlCommand cmd)
        {
            int retorno = Convert.ToInt32(cmd.Parameters["@RETORNO"].Value);
            return retorno == 1;
        }


        private void ManageReportCreationAndEmailing(SqlCommand cmd)
        {
            try
            {
                string encryptedId = Util.Encrypt(Session["Id"].ToString());
                Reportes.Comprobante report = GenerarReporte(encryptedId);
                AgregarCodigoQRAlReporte(report, encryptedId);

                byte[] pdfDocument = ExportReportToPDF(report);
                if (pdfDocument != null && pdfDocument.Length > 0)
                {
                    SavePDFToDatabase(pdfDocument);
                    SendEmailWithPDFAttachment(pdfDocument);
                }
            }
            catch
            {
                throw new Exception("\r\n54 / 5,000\r\nSe produjo un error al crear el informe o enviar el correo electrónico.");
            }
        }
        //private void ManageReportCreationAndEmailing(SqlCommand cmd)
        //{
        //    string encryptedId = Util.Encrypt(Session["Id"].ToString());
        //    Reportes.Comprobante report = GenerarReporte(encryptedId);
        //    AgregarCodigoQRAlReporte(report, encryptedId);

        //    byte[] pdfDocument = ExportReportToPDF(report);
        //    if (pdfDocument != null && pdfDocument.Length > 0)
        //    {
        //        SavePDFToDatabase(pdfDocument);
        //        SendEmailWithPDFAttachment(pdfDocument);
        //    }
        //}

        private void HandleException(CallbackEventArgs e, Exception ex)
        {
            var responseObj = new
            {
                Retorno = 0,
                Mensaje = "Error: " + ex.Message
            };
            e.Result = JsonConvert.SerializeObject(responseObj);
        }
        private byte[] ExportReportToPDF(Reportes.Comprobante report)
        {
            using (MemoryStream stream = new MemoryStream())
            {
                report.ExportToPdf(stream);
                return stream.ToArray(); // Convierte el stream a un arreglo byte directamente.
            }
        }

        private int SavePDFToDatabase(byte[] pdfDocument)
        {
            using (SqlCommand cmd = new SqlCommand("[gral].[sp_guardar_pdf]", conex.conexion))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = Session["Id"];
                cmd.Parameters.Add("@pdfDocument", SqlDbType.VarBinary).Value = pdfDocument;
                cmd.Parameters.Add("@MENS", SqlDbType.NVarChar, -1).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@RETORNO", SqlDbType.Int).Direction = ParameterDirection.Output;

                conex.abrirConexion();
                cmd.ExecuteNonQuery();
                conex.cerrarConexion();

                return Convert.ToInt32(cmd.Parameters["@RETORNO"].Value);
            }
        }
        private void SendEmailWithPDFAttachment(byte[] pdfDocument)
        {
            string emailTemplatePath = Server.MapPath("~/Mensaje_Registro.html");
            string emailBody = File.ReadAllText(emailTemplatePath);
            string subject = "Auto Enrolamiento Exitosamente";
            string ccEmail = null;

            using (var pdfStream = new MemoryStream(pdfDocument))
            {
                // Store values in session variables
                Session["Usuario"] = tbNombre.Text + " " + tbApellido.Text;

                string Usuario = Session["Usuario"].ToString();
                string attachmentName = $"{Usuario}.pdf";

                SampleUtil.EnviarCorreo(pdfStream, subject, tbCorreo.Text, emailBody, ccEmail, attachmentName);
            }
        }

        protected void callbackPane_comprobante_Callback(object sender, CallbackEventArgsBase e)
        {
            Session["EncryptedId"] = Util.Encrypt(Session["Id"].ToString());
            string encryptedId = Session["EncryptedId"]?.ToString();
            if (!string.IsNullOrEmpty(encryptedId))
            {
                Reportes.Comprobante report = GenerarReporte(encryptedId);

                // Agregar el código QR al reporte
                AgregarCodigoQRAlReporte(report, encryptedId);

                // Mostrar el reporte en el visor
                ASPxWebDocumentViewer1.OpenReport(report);
            }
            else
            {
                // Manejar el caso en el que el valor de la sesión no está disponible
                // Por ejemplo, redirigir a una página de error o mostrar un mensaje de error
            }
        }

        protected Reportes.Comprobante GenerarReporte(string encryptedId)
        {
            Reportes.Comprobante report = new Reportes.Comprobante();
            report.Parameters["Id"].Value = Util.Decrypt(encryptedId);
            return report;
        }

        protected void AgregarCodigoQRAlReporte(Reportes.Comprobante report, string encryptedId)
        {
            XRBarCode xrBarCode = new XRBarCode
            {
                Symbology = new QRCodeGenerator
                {
                    CompactionMode = QRCodeCompactionMode.Byte,
                    ErrorCorrectionLevel = QRCodeErrorCorrectionLevel.H,
                    Version = QRCodeVersion.Version4
                },
                Text = "https://www.tsc.gob.hn:8035/SolicitudUsuario.aspx?id=" + encryptedId,
                ShowText = false,
                AutoModule = true,
                WidthF = 176.46f,
                HeightF = 179.58f,
                LocationF = new PointF(235.42f, 19.79f),
                Module = 2,
                Padding = new PaddingInfo(10, 10, 10, 10)
            };
            report.Bands["GroupFooter1"].Controls.Add(xrBarCode);
        }
    }
}



