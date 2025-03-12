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
    public partial class Instituciones : System.Web.UI.Page
    {
        //protected void GridView_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        //{
        //    e.NewValues["Kind"] = 1;
        //    e.NewValues["Priority"] = 2;
        //    e.NewValues["Status"] = 1;
        //    e.NewValues["IsDraft"] = true;
        //    e.NewValues["IsArchived"] = false;
        //}
        //protected void GridView_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        //{

        //    if (e.Parameters == "delete")
        //    {


        //        ////List<int> selectedIds = GridView.GetSelectedFieldValues("Id_Institucion").ConvertAll(id => (int)id);

        //        //////DataProvider.DeleteIssues(selectedIds);
        //        ////GridView.DataBind();
    
        //    }

        
        //}
        protected void Page_Load(object sender, EventArgs e)
        {

            Form.Attributes.Add("autocomplete", "off");
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
                string sql = @"INSERT INTO tblTipoInstituciones (Tipo_Inst) VALUES ('" + Convert.ToString(txtTipo_Institucion.Text) + "')";
                SqlCommand cmdd = new SqlCommand(sql, con);

                cmdd.ExecuteNonQuery();
                //Usuario.DataBind();


                Tipo_Inst.ShowOnPageLoad = false;
                Response.Redirect("~/Mantenimiento/Instituciones.aspx");
            }

            catch (Exception)
            {
                if (IsPostBack)
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert",
                           @"<script type=""text/javascript"">alert('ERROR AL AGREGAR TIPO DE INSTITUCIÓN');</script>");
                Tipo_Inst.ShowOnPageLoad = false;
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
    }
        
}   

