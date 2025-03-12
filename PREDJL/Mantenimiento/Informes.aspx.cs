using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PREDJL.Model;
using DevExpress.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;



namespace PREDJL.Mantenimiento
{
    public partial class Informes : System.Web.UI.Page
    {
        
        readonly ConexionBD conex = new ConexionBD();
        private const string SessionKey = "UploadedFile";
        protected void Page_Load(object sender, EventArgs e)
        {
            //Form.Attributes.Add("autocomplete", "off");
            //if (!IsPostBack)
            //{

            //    if (HttpContext.Current.User.IsInRole("Admin"))
            //    {
            //        Panel_Content.Visible = true;
            //    }
            //    else
            //    {
            //        Response.Redirect("~/Account/Login.aspx");
            //        Panel_Content.Visible = false;

            //    }

            //}
            //else
            //{
            //    if (IsPostBack)
            //    {
            //        if (Session["Name_user"] == null)
            //        {
            //            Response.RedirectLocation = "../TimeOutPage.aspx";
            //        }
            //        if (!User.Identity.IsAuthenticated)
            //        {
            //            Response.RedirectLocation = "/Account/Login.aspx";
            //            //Response.Redirect("~/Account/Login.aspx");
            //        }
            //    }
            //}
            GV_Instituciones.DataBind();
        }

        protected void btnGuarda_Tipo_Institucion_Click(object sender, EventArgs e)
        {
            try
            {
                string constr = ConfigurationManager.ConnectionStrings["DB_PARTICIPACIONConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(constr);

                con.Open();
                string sql = @"INSERT INTO tblAños (Año) VALUES ('" + Convert.ToString(txtAño.Text) + "')";
                SqlCommand cmdd = new SqlCommand(sql, con);

                cmdd.ExecuteNonQuery();
                //Usuario.DataBind();


                //Tipo_Inst.ShowOnPageLoad = false;
                Response.Redirect("~/Mantenimiento/Informes.aspx");
            }

            catch (Exception)
            {
                if (IsPostBack)
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert",
                           @"<script type=""text/javascript"">alert('ERROR AL AGREGAR AÑO');</script>");
                //Tipo_Inst.ShowOnPageLoad = false;
            }

        }

        protected void GV_Instituciones_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            GV_Instituciones.SettingsText.PopupEditFormCaption = "Nuevo ingreso de Institución";
        }

        protected void GV_Instituciones_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateInstit"] = "Datos actualizados correctamente.";
            }
            else
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateInstit"] = "Se produjo un error al intentar actualizar los datos.";
                e.ExceptionHandled = true;

            }

        }

        protected void GV_Instituciones_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {
            GV_Instituciones.SettingsText.PopupEditFormCaption = "Editar datos de la Institución";

        }

        protected void GV_Instituciones_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateInstit"] = "Datos agregados correctamente.";
            }
            else
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateInstit"] = "Se produjo un error al intentar actualizar los datos.";
                e.ExceptionHandled = true;


            }
        }

        protected void Callback_Callback(object source, CallbackEventArgs e)
        {
            Session.Remove(SessionKey);
            e.Result = "OK";
        }

        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {

            if (e.IsValid)
            {

                Session[SessionKey] = e.UploadedFile.FileBytes;
                e.CallbackData = e.UploadedFile.FileName;
                Session["OriginalName"] = e.UploadedFile.FileName;

                //GV_Instituciones.DataBind();
                //returnMessage = "" + Men_salida.ToString() + "";
                //ASPxGridView1.DataBind();

                //SqlCommand cmd = new SqlCommand();
                //cmd.CommandType = CommandType.StoredProcedure;
                //cmd.CommandText = "[dbo].[SP_INFORMES]";
                //cmd.Parameters.Add("@FileName", SqlDbType.NVarChar).Value = Session["OriginalName"];
                //cmd.Parameters.Add("@DocBytes", SqlDbType.Binary).Value = Session[SessionKey];
                
                //cmd.Parameters.Add("@Id_Informe", SqlDbType.Int).Direction = ParameterDirection.Output;
                //cmd.Parameters.Add("@MENS", SqlDbType.VarChar, 150).Direction = ParameterDirection.Output;
                //cmd.Connection = conex.conexion;
                //conex.abrirConexion();
                //cmd.ExecuteNonQuery();
                //string Men_salida = cmd.Parameters["@MENS"].Value.ToString();
                //conex.cerrarConexion();

            }


        }

        protected void ASPxCallback_Guardar_Dctos_Callback(object source, CallbackEventArgs e)
        {

            //if (System.Web.HttpContext.Current.Session["dt1"] != null) 
            //    //Dim session("dt1") As DataTable
            //    Session["dt1"] = Gvdoc;




            //using (Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, 0))
            //{
            //    socket.Connect("8.8.8.8", 65530);
            //    IPEndPoint endPoint = socket.LocalEndPoint as IPEndPoint;
            //    Session["IP"] = endPoint.Address.ToString();
            //}

            ////string returnMessage = "";
            ////try
            ////{

            ////if (Session["Parent"] == null)
            ////{
            ////    Session["Parent"] = GetParentId();
            ////}


            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[dbo].[SP_INFORMES]";
            cmd.Parameters.Add("@FileName", SqlDbType.NVarChar).Value = Session["OriginalName"];
            cmd.Parameters.Add("@DocBytes", SqlDbType.Binary).Value = Session[SessionKey];
            cmd.Parameters.Add("@Id_Informe", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.Add("@MENS", SqlDbType.VarChar, 150).Direction = ParameterDirection.Output;
            cmd.Connection = conex.conexion;
            conex.abrirConexion();
            cmd.ExecuteNonQuery();
            string Men_salida = cmd.Parameters["@MENS"].Value.ToString();
            conex.cerrarConexion();
            //returnMessage = "" + Men_salida.ToString() + "";
            //ASPxGridView1.DataBind();


            //ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('" + Men_salida.ToString() + "');", true);

            //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
            //    "swal('Men_salida','success')");



            ////}

            ////catch (Exception ex)
            ////{
            ////    returnMessage = String.Format("Hubo un problema al guardar los archivos. El mensaje de error fue '{0}'", ex.Message);

            ////}
            ////e.Result = returnMessage;


            ////catch (Exception ex)
            ////{
            ////    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert",
            ////                   @"<script type=""text/javascript"">alert('" + ex + "');</script>");
            ////}

        }
    }

}

