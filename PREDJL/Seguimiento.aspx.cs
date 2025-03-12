using DevExpress.Web;
using PREDJL.App_Start;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace PREDJL
{
    public partial class Seguimiento : System.Web.UI.Page
    {

        readonly ConexionBD conex = new ConexionBD();
        protected void Page_Load(object sender, EventArgs e)
        {
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
        public (string Email, string NombreUsuario, string MensajeEstado,string Obs, int Retorno) GetUserData(string numeroIdentidad)
        {
            string email = string.Empty;
            string nombreUsuario = string.Empty;
            string mensajeEstado = string.Empty;
            string obs = string.Empty;
            int retorno = 0;

            string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("[gral].[sp_consultar_usuario]", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@NumeroIdentidad", numeroIdentidad));

                    SqlParameter correoParam = new SqlParameter("@CorreoElectronico", SqlDbType.VarChar, 255);
                    correoParam.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(correoParam);

                    SqlParameter retornoParam = new SqlParameter("@Retorno", SqlDbType.Int);
                    retornoParam.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(retornoParam);

                    SqlParameter nombreParam = new SqlParameter("@NombreUsuario", SqlDbType.VarChar, 255);
                    nombreParam.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(nombreParam);

                    SqlParameter mensajeEstadoParam = new SqlParameter("@MensajeEstado", SqlDbType.VarChar, 255);
                    mensajeEstadoParam.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(mensajeEstadoParam);
                    
                    SqlParameter obsParam = new SqlParameter("@Obs", SqlDbType.VarChar, 255);
                    obsParam.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(obsParam);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    email = correoParam.Value != DBNull.Value ? correoParam.Value.ToString() : string.Empty;
                    nombreUsuario = nombreParam.Value != DBNull.Value ? nombreParam.Value.ToString() : string.Empty;
                    mensajeEstado = mensajeEstadoParam.Value != DBNull.Value ? mensajeEstadoParam.Value.ToString() : string.Empty;
                    obs = obsParam.Value != DBNull.Value ? obsParam.Value.ToString() : string.Empty;
                    retorno = retornoParam.Value != DBNull.Value ? (int)retornoParam.Value : 0;
                }
            }

            return (email, nombreUsuario, mensajeEstado, obs ,retorno);
        }



        protected void ASPxCallback_EnviarToken_Callback(object source, CallbackEventArgs e)
        {
            string numeroIdentidadStr = e.Parameter;
            Session["ID"] = numeroIdentidadStr;

            var userData = GetUserData(numeroIdentidadStr);

            if (userData.Retorno == 1)
            {
                string token = GenerateToken();
                Util.SetToken(token, DateTime.Now);
                SampleUtil.SendToken(userData.Email, token);
                e.Result = "Token enviado";
            }
            else
            {
                e.Result = userData.MensajeEstado;
            }
        }

        protected void ASPxCallback_VerificarToken_Callback(object source, CallbackEventArgs e)
        {
            string inputToken = e.Parameter;
            var (storedToken, tokenTimestamp) = Util.GetToken();

            if (storedToken != null && tokenTimestamp != null)
            {
                double elapsedMinutes = (DateTime.Now - tokenTimestamp.Value).TotalMinutes;
                if (elapsedMinutes <= 15)
                {
                    Util.SetToken(storedToken, tokenTimestamp.Value);
                    if (inputToken == storedToken)
                    {
                        string numeroIdentidadStr = Session["ID"].ToString();
                        var userData = GetUserData(numeroIdentidadStr);

                        var resultData = new
                        {
                            success = true,
                            nombreUsuario = userData.NombreUsuario,
                            estadoUsuario = userData.MensajeEstado,
                            obs = userData.Obs

                        };
                        e.Result = Newtonsoft.Json.JsonConvert.SerializeObject(resultData);
                    }
                    else
                    {
                        e.Result = "{\"success\": false, \"message\": \"Código de verificación incorrecto.\"}";
                    }
                }
                else
                {
                    e.Result = "{\"success\": false, \"message\": \"El código de verificación ha expirado.\"}";
                    HttpContext.Current.Session.Remove("VerificationToken");
                    HttpContext.Current.Session.Remove("TokenTimestamp");
                }
            }
            else
            {
                e.Result = "{\"success\": false, \"message\": \"Error en la verificación del código.\"}";
            }
        }






        //protected void ASPxCallback_EnviarToken_Callback(object source, CallbackEventArgs e)
        //{
        //    string email = e.Parameter;
        //    string token = GenerateToken();

        //    Util.SetToken(token, DateTime.Now);

        //    SampleUtil.SendToken(email, token);

        //    e.Result = "Token enviado";
        //}

        //protected void ASPxCallback_EnviarToken_Callback(object source, CallbackEventArgs e)
        //{
        //    string numeroIdentidadStr = e.Parameter;
        //    Session["ID"]=numeroIdentidadStr;
        //    string email = string.Empty;
        //    string mensajeEstado = string.Empty;
        //    int retorno = 0;

        //    string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("[gral].[sp_ConsultarUsuario]", conn))
        //        {
        //            cmd.CommandType = CommandType.StoredProcedure;

        //            cmd.Parameters.Add(new SqlParameter("@NumeroIdentidad", numeroIdentidadStr));

        //            SqlParameter correoParam = new SqlParameter("@CorreoElectronico", SqlDbType.VarChar, 255);
        //            correoParam.Direction = ParameterDirection.Output;
        //            cmd.Parameters.Add(correoParam);

        //            SqlParameter retornoParam = new SqlParameter("@Retorno", SqlDbType.Int);
        //            retornoParam.Direction = ParameterDirection.Output;
        //            cmd.Parameters.Add(retornoParam);

        //            SqlParameter nombreParam = new SqlParameter("@NombreUsuario", SqlDbType.VarChar, 255);
        //            nombreParam.Direction = ParameterDirection.Output;
        //            cmd.Parameters.Add(nombreParam);

        //            SqlParameter mensajeEstadoParam = new SqlParameter("@MensajeEstado", SqlDbType.VarChar, 255);
        //            mensajeEstadoParam.Direction = ParameterDirection.Output;
        //            cmd.Parameters.Add(mensajeEstadoParam);

        //            conn.Open();
        //            cmd.ExecuteNonQuery();

        //            email = correoParam.Value != DBNull.Value ? correoParam.Value.ToString() : string.Empty;
        //            mensajeEstado = mensajeEstadoParam.Value != DBNull.Value ? mensajeEstadoParam.Value.ToString() : string.Empty;
        //            retorno = retornoParam.Value != DBNull.Value ? (int)retornoParam.Value : 0;
        //        }
        //    }

        //    if (retorno == 1)
        //    {
        //        string token = GenerateToken();
        //        Util.SetToken(token, DateTime.Now);
        //        SampleUtil.SendToken(email, token);
        //        e.Result = "Token enviado";
        //    }
        //    else
        //    {
        //        e.Result = mensajeEstado;
        //    }
        //}

        //protected void ASPxCallback_VerificarToken_Callback(object source, CallbackEventArgs e)
        //{
        //    string inputToken = e.Parameter;
        //    var (storedToken, tokenTimestamp) = Util.GetToken();

        //    if (storedToken != null && tokenTimestamp != null)
        //    {
        //        double elapsedMinutes = (DateTime.Now - tokenTimestamp.Value).TotalMinutes;
        //        if (elapsedMinutes <= 15)
        //        {
        //            Util.SetToken(storedToken, tokenTimestamp.Value);
        //            if (inputToken == storedToken)
        //            {
        //                // Retrieve user data
        //                string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
        //                using (SqlConnection conn = new SqlConnection(connectionString))
        //                {
        //                    using (SqlCommand cmd = new SqlCommand("[gral].[sp_ConsultarUsuario]", conn))
        //                    {
        //                        cmd.CommandType = CommandType.StoredProcedure;
        //                        cmd.Parameters.Add(new SqlParameter("@NumeroIdentidad", Session["ID"]));

        //                        SqlParameter nombreParam = new SqlParameter("@NombreUsuario", SqlDbType.VarChar, 255);
        //                        nombreParam.Direction = ParameterDirection.Output;
        //                        cmd.Parameters.Add(nombreParam);

        //                        SqlParameter correoParam = new SqlParameter("@CorreoElectronico", SqlDbType.VarChar, 255);
        //                        correoParam.Direction = ParameterDirection.Output;
        //                        cmd.Parameters.Add(correoParam);

        //                        SqlParameter estadoParam = new SqlParameter("@MensajeEstado", SqlDbType.VarChar, 255);
        //                        estadoParam.Direction = ParameterDirection.Output;
        //                        cmd.Parameters.Add(estadoParam);

        //                        SqlParameter retornoParam = new SqlParameter("@Retorno", SqlDbType.Int);
        //                        retornoParam.Direction = ParameterDirection.Output;
        //                        cmd.Parameters.Add(retornoParam);

        //                        conn.Open();
        //                        cmd.ExecuteNonQuery();

        //                        // Debugging output
        //                        System.Diagnostics.Debug.WriteLine("NombreUsuario: " + (nombreParam.Value != DBNull.Value ? nombreParam.Value.ToString() : "NULL"));
        //                        System.Diagnostics.Debug.WriteLine("EstadoUsuario: " + (estadoParam.Value != DBNull.Value ? estadoParam.Value.ToString() : "NULL"));

        //                        // Construct the result string in JSON format
        //                        var resultData = new
        //                        {
        //                            success = true,
        //                            nombreUsuario = nombreParam.Value != DBNull.Value ? nombreParam.Value.ToString() : string.Empty,
        //                            estadoUsuario = estadoParam.Value != DBNull.Value ? estadoParam.Value.ToString() : string.Empty,

        //                        };
        //                        e.Result = Newtonsoft.Json.JsonConvert.SerializeObject(resultData);
        //                    }
        //                }
        //            }
        //            else
        //            {
        //                e.Result = "{\"success\": false, \"message\": \"Código de verificación incorrecto.\"}";
        //            }
        //        }
        //        else
        //        {
        //            e.Result = "{\"success\": false, \"message\": \"El código de verificación ha expirado.\"}";
        //            HttpContext.Current.Session.Remove("VerificationToken");
        //            HttpContext.Current.Session.Remove("TokenTimestamp");
        //        }
        //    }
        //    else
        //    {
        //        e.Result = "{\"success\": false, \"message\": \"Error en la verificación del código.\"}";
        //    }
        //}


        //protected void ASPxCallback_VerificarToken_Callback(object source, CallbackEventArgs e)
        //{
        //    string inputToken = e.Parameter;
        //    var (storedToken, tokenTimestamp) = Util.GetToken();

        //    if (storedToken != null && tokenTimestamp != null)
        //    {
        //        double elapsedMinutes = (DateTime.Now - tokenTimestamp.Value).TotalMinutes;
        //        System.Diagnostics.Debug.WriteLine($"Token age in minutes: {elapsedMinutes}");

        //        if (elapsedMinutes <= 15)
        //        {
        //            Util.SetToken(storedToken, tokenTimestamp.Value);

        //            if (inputToken == storedToken)
        //            {
        //                e.Result = "success";
        //                System.Diagnostics.Debug.WriteLine("Token verification successful.");
        //            }
        //            else
        //            {
        //                e.Result = "incorrect";
        //                System.Diagnostics.Debug.WriteLine("Token is incorrect.");
        //            }
        //        }
        //        else
        //        {
        //            e.Result = "expired";
        //            System.Diagnostics.Debug.WriteLine("Token has expired.");
        //            HttpContext.Current.Session.Remove("VerificationToken");
        //            HttpContext.Current.Session.Remove("TokenTimestamp");
        //        }
        //    }
        //    else
        //    {
        //        e.Result = "failure";
        //        System.Diagnostics.Debug.WriteLine("Token or timestamp missing.");
        //    }
        //}

        private string GenerateToken()
        {
            return new Random().Next(100000, 999999).ToString();
        }
    }
}