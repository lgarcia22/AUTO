using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PREDJL.Model;
using DevExpress.Web;

namespace PREDJL.Mantenimiento
{
    public partial class Direcciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Form.Attributes.Add("autocomplete", "off");
            //if (!IsPostBack)
            //{

            //    if (HttpContext.Current.User.IsInRole("Administrador"))
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

        }

        protected void GV_Direcciones_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            GV_Direcciones.SettingsText.PopupEditFormCaption = "Nuevo ingreso de Dirección";
        }

        protected void GV_Direcciones_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {
            GV_Direcciones.SettingsText.PopupEditFormCaption = "Editar ingreso de Dirección";
        }

        protected void GV_Direcciones_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
        {

            if (e.Exception == null)
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateMessageDirecciones"] = "Datos actualizados  correctamente.";
                GV_Direcciones.DataBind();
            }
            else
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateMessageDirecciones"] = "Se produjo un error al intentar actualizar los datos";
                e.ExceptionHandled = true;

            }

        }

        protected void GV_Direcciones_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateMessageDirecciones"] = "Datos agregados correctamente.";
                GV_Direcciones.DataBind();
            }
            else
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateMessageDirecciones"] = "Se produjo un error al intentar actualizar los datos..";
                e.ExceptionHandled = true;

            }

        }
        //protected void ASPxGridView1_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        //{

        //    if (Convert.ToBoolean(Session["isUpdateConfirmed"]) == false)
        //    {

        //        e.Cancel = true;
        //        //Page.ClientScript.RegisterStartupScript(this.GetType(), "alert",
        //        //               @"<script type=""text/javascript"">alert ('Are you sure want to update?');</script>");
        //        ASPxPopupControl1.ShowOnPageLoad = true;

        //        string newVal = "";
        //        for (int i = 0; i < e.NewValues.Count; i++)
        //        {
        //            if (e.NewValues[i] != null)
        //            {
        //                newVal = newVal + e.NewValues[i].ToString() + "  /";
        //            }
        //        }
        //        ASPxLabel1.Text = newVal;


        //    }
        //}
        //protected void okButton_Click(object sender, EventArgs e)
        //{
        //    Session["isUpdateConfirmed"] = true;
        //    ASPxGridView1.UpdateEdit();
        //    ASPxPopupControl1.ShowOnPageLoad = false;
        //}
        //protected void ASPxGridView1_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
        //{
        //    Session["isUpdateConfirmed"] = false;
        //}
    }
}
