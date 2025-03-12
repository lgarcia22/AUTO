using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Collections.Generic;
using System.Configuration;
using Newtonsoft.Json;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web;

namespace PREDJL
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (HttpContext.Current.User.IsInRole("SAdmin") || HttpContext.Current.User.IsInRole("Gestor"))
                {
                    Panel_Content.Visible = true;
                    SolicitudesService dataAccess = new SolicitudesService();
                    string jsonData = dataAccess.GetSolicitudesPorEstado(null, null, null);
                    jsonData = jsonData.Replace("'", "\\'");
                    ScriptManager.RegisterStartupScript(this, GetType(), "renderChart", $"renderChart({jsonData});", true);
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
            //if (!IsPostBack)
            //{
            //    SolicitudesService dataAccess = new SolicitudesService();
            //    string jsonData = dataAccess.GetSolicitudesPorEstado(null, null, null);
            //    jsonData = jsonData.Replace("'", "\\'");
            //    ScriptManager.RegisterStartupScript(this, GetType(), "renderChart", $"renderChart({jsonData});", true);
            //    //SolicitudesService dataAccess = new SolicitudesService();
            //    //string jsonData = dataAccess.GetSolicitudesPorEstado(null, null, null);
            //    //ScriptManager.RegisterStartupScript(this, GetType(), "renderChart", "renderChart(" + jsonData + ");", true);
            //}
        }

        [WebMethod]
        public static string GetChartData(string fechaInicio, string fechaFin, string company)
        {
            try
            {
                SolicitudesService dataAccess = new SolicitudesService();
                DateTime? startDate = string.IsNullOrEmpty(fechaInicio) ? (DateTime?)null : DateTime.Parse(fechaInicio);
                DateTime? endDate = string.IsNullOrEmpty(fechaFin) ? (DateTime?)null : DateTime.Parse(fechaFin);
                string jsonData = dataAccess.GetSolicitudesPorEstado(startDate, endDate, company);

                // Log data for debugging
                System.Diagnostics.Debug.WriteLine($"Start Date: {startDate}, End Date: {endDate}, Company: {company}");
                System.Diagnostics.Debug.WriteLine($"JSON Data: {jsonData}");

                return jsonData;
            }
            catch (Exception ex)
            {
                // Log the exception
                System.Diagnostics.Debug.WriteLine($"Error: {ex.Message}");

                // Return a JSON error message
                return new JavaScriptSerializer().Serialize(new { error = ex.Message });
            }
        }

    }


    //protected void Page_Load(object sender, EventArgs e)
    //{

    //    if (!IsPostBack)
    //    {

    //        if (!User.Identity.IsAuthenticated)
    //        {

    //            Response.Redirect("~/Account/Login.aspx");
    //        }
    //    }
    //    else
    //    {
    //        if (IsPostBack)
    //        {
    //            if (Session["Name_user"] == null)
    //            {
    //                Response.RedirectLocation = "../TimeOutPage.aspx";
    //            }
    //            if (!User.Identity.IsAuthenticated)
    //            {
    //                Response.RedirectLocation = "/Account/Login.aspx";
    //                //Response.Redirect("~/Account/Login.aspx");
    //            }
    //        }
    //    }

    //}



}
