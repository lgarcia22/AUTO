using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;


namespace PREDJL
{
    public partial class menu : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TimeoutControl1.TimeOutUrl = "TimeOutPage.aspx";
            if (HttpContext.Current.User.IsInRole("SAdmin"))
            {
                nbMain.Groups[0].Visible = true;
                nbMain.Groups[1].Visible = true;
                nbMain.Groups[2].Visible = true;

            }
            else if (HttpContext.Current.User.IsInRole("Gestor"))
            {
                nbMain.Groups[0].Visible = true;
                nbMain.Groups[1].Visible = true;
                nbMain.Groups[2].Visible = false;
            }
            else
            {
                nbMain.Groups[0].Visible = true;
                nbMain.Groups[1].Visible = false;
                nbMain.Groups[2].Visible = false;
            }

        }
        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    if (!IsPostBack)
        //    {
        //        SetNavBarVisibility();
        //        //TimeoutControl1.TimeOutUrl = "~/Account/Login.aspx";
        //        TimeoutControl1.TimeOutUrl = "TimeOutPage.aspx";
        //    }
        //}
        //protected void Page_Load(object sender, EventArgs e)
        //{

        //    SetNavBarVisibility();
        //    TimeoutControl1.TimeOutUrl = "TimeOutPage.aspx";
        //    //if (IsPostBack)
        //    //{
        //    //    if (Session["Name_user"] == null)
        //    //    {
        //    //        Response.RedirectLocation = "../TimeOutPage.aspx";
        //    //    }
        //    //}
        //}
        private void SetNavBarVisibility()
        {
            string userName = HttpContext.Current.User.Identity.Name;

            string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                SqlCommand command = new SqlCommand("[gral].[sp_obtener_permisos]", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@UserName", userName);

                SqlDataReader reader = command.ExecuteReader();
                var groupPermissions = new List<string>();
                var itemPermissions = new List<string>();
                bool hasPermissions = false;
                string message = string.Empty;

                while (reader.Read())
                {
                    if (reader.FieldCount == 1 && reader.GetName(0) == "Message")
                    {
                        message = reader["Message"].ToString();
                    }
                    else
                    {
                        hasPermissions = true;
                        string type = reader["PermissionType"].ToString();
                        string permissionName = reader["PermissionName"].ToString();
                        if (type == "Group")
                        {
                            groupPermissions.Add(permissionName);
                        }
                        else if (type == "Item")
                        {
                            itemPermissions.Add(permissionName);
                        }
                    }
                }

                reader.Close();

                if (!hasPermissions)
                {
                    // Ocultar el menú
                    nbMain.Visible = false;

                    // Redirigir al login usando JavaScript
                    string redirectScript = "window.location.href = '/Account/Login.aspx';";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "redirectScript", redirectScript, true);

                    return;
                }
                else
                {
                    // Establecer visibilidad en función de los permisos de grupo
                    foreach (NavBarGroup group in nbMain.Groups)
                    {
                        group.Visible = groupPermissions.Contains(group.Name);

                        // Establecer visibilidad en función de los permisos de elementos
                        foreach (NavBarItem item in group.Items)
                        {
                            item.Visible = itemPermissions.Contains(item.Name);
                        }
                    }
                }
            }
        }

        //private void SetNavBarVisibility()
        //{
        //    string userName = HttpContext.Current.User.Identity.Name;

        //    string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        connection.Open();

        //        SqlCommand command = new SqlCommand("[gral].[sp_obtener_permisos]", connection);
        //        command.CommandType = System.Data.CommandType.StoredProcedure;
        //        command.Parameters.AddWithValue("@UserName", userName);

        //        SqlDataReader reader = command.ExecuteReader();
        //        var groupPermissions = new List<string>();
        //        var itemPermissions = new List<string>();
        //        bool hasPermissions = false;
        //        string message = string.Empty;

        //        while (reader.Read())
        //        {
        //            if (reader.FieldCount == 1 && reader.GetName(0) == "Message")
        //            {
        //                message = reader["Message"].ToString();
        //            }
        //            else
        //            {
        //                hasPermissions = true;
        //                string type = reader["PermissionType"].ToString();
        //                string permissionName = reader["PermissionName"].ToString();
        //                if (type == "Group")
        //                {
        //                    groupPermissions.Add(permissionName);
        //                }
        //                else if (type == "Item")
        //                {
        //                    itemPermissions.Add(permissionName);
        //                }
        //            }
        //        }

        //        reader.Close();

        //        if (!hasPermissions)
        //        {
        //            // Mostrar mensaje y redirigir al login
        //            //Response.Write($"<script>alert('{message}');</script>");
        //            nbMain.Visible = false; // Ocultar el menú
        //            Response.Redirect("~/Account/Login.aspx"); // Redirigir al login
        //            return; // Asegúrate de que el resto del código no se ejecute
        //        }
        //        else
        //        {
        //            // Establecer visibilidad en función de los permisos de grupo
        //            foreach (NavBarGroup group in nbMain.Groups)
        //            {
        //                group.Visible = groupPermissions.Contains(group.Name);

        //                // Establecer visibilidad en función de los permisos de elementos
        //                foreach (NavBarItem item in group.Items)
        //                {
        //                    item.Visible = itemPermissions.Contains(item.Name);
        //                }
        //            }
        //        }
        //    }
        //}

        //private void SetNavBarVisibility()
        //{
        //    string userName = HttpContext.Current.User.Identity.Name;

        //    string connectionString = ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString;
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        connection.Open();

        //        SqlCommand command = new SqlCommand("[gral].[Obtener_permisos]", connection);
        //        command.CommandType = System.Data.CommandType.StoredProcedure;
        //        command.Parameters.AddWithValue("@UserName", userName);

        //        SqlDataReader reader = command.ExecuteReader();
        //        var permissions = new List<string>();
        //        bool hasPermissions = false;
        //        string message = string.Empty;

        //        while (reader.Read())
        //        {
        //            if (reader.FieldCount == 1 && reader.GetName(0) == "Message")
        //            {
        //                message = reader["Message"].ToString();
        //            }
        //            else
        //            {
        //                permissions.Add(reader["PermissionName"].ToString());
        //                hasPermissions = true;
        //            }
        //        }

        //        reader.Close();

        //        if (!hasPermissions)
        //        {
        //            // Display message to user
        //            Response.Write($"<script>alert('{message}');</script>");
        //            nbMain.Visible = false;
        //        }
        //        else
        //        {
        //            // Set visibility based on permissions
        //            nbMain.Groups[0].Visible = permissions.Contains("Inicio");
        //            nbMain.Groups[1].Visible = permissions.Contains("Pre-Registro");
        //            nbMain.Groups[2].Visible = permissions.Contains("Mantenimiento");
        //        }
        //    }
        //}
    }
}

