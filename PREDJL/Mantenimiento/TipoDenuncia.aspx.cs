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
    public partial class TipoDenuncia : System.Web.UI.Page
    {
        ////protected void GridView_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        ////{
        ////    if (e.Parameters == "delete")
        ////    {
        ////        //GridView.GetSelectedFieldValues("Id").ConvertAll(id => (long)id);
        ////        //GridView.DataBind();
        ////    }
        ////}
        protected void Page_Load(object sender, EventArgs e)
        {
            Form.Attributes.Add("autocomplete", "off");
            if (!IsPostBack)
            {

                if (HttpContext.Current.User.IsInRole("Administrador"))
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
                    if (Session["Name_user"] == null)
                    {
                        Response.RedirectLocation = "../TimeOutPage.aspx";
                    }
                    if (!User.Identity.IsAuthenticated)
                    {
                        Response.RedirectLocation = "/Account/Login.aspx";
                        //Response.Redirect("~/Account/Login.aspx");
                    }
                }
            }

        }

        protected void GV_TipoDenuncia_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            GV_TipoDenuncia.SettingsText.PopupEditFormCaption = "Nuevo ingreso de Tipo de Denuncia";
        }

        protected void GV_TipoDenuncia_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {
            GV_TipoDenuncia.SettingsText.PopupEditFormCaption = "Editar ingreso de Tipo de Denuncia";
        }

        protected void GV_TipoDenuncia_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
        {

            if (e.Exception == null)
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateMessageTipoDenuncia"] = "Datos actualizados  correctamente.";
            }
            else
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateMessageTipoDenuncia"] = "Se produjo un error al intentar actualizar los datos";
                e.ExceptionHandled = true;

            }

        }

        protected void GV_TipoDenuncia_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateMessageTipoDenuncia"] = "Datos agregados correctamente.";
            }
            else
            {
                ((ASPxGridView)sender).JSProperties["cpUpdateMessageTipoDenuncia"] = "Se produjo un error al intentar actualizar los datos..";
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