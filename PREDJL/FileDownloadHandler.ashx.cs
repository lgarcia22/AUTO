using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DevExpress.Web;

using System.Data.SqlClient;

using System.Web.UI;
using System.Web.UI.WebControls;
using PREDJL.App_Code;
using System.Configuration;
using System.Data;


namespace PREDJL.App_Code
{
    /// <summary>
    /// Descripción breve de FileDownloadHandler
    /// </summary>

    public class FileDownloadHandler : IHttpHandler
    {
        private string SessionOriginalFileName;
        private string tipo_doc;
        public void ProcessRequest(HttpContext context)
        {
            string id = context.Request["id"];
            //string numbercase = context.Request.QueryString["Numbercase"];
            string numbercase = context.Request["Numbercase"];

            if (numbercase == "1") {
                byte[] fileBytes = GetFileBytesByKey1(context, id);
                if (fileBytes != null)
                    //ExportToResponse(context, fileBytes, SessionOriginalFileName + id, "pdf", false);
                    ExportToResponse(context, fileBytes, SessionOriginalFileName + id, tipo_doc, false);
            }
            else if (numbercase == "2")
            {
                byte[] fileBytes = GetFileBytesByKey2(context, id);
                if (fileBytes != null)
                    //        //ExportToResponse(context, fileBytes, "file_" + id, "pdf", false);

                    ExportToResponse(context, fileBytes, SessionOriginalFileName + id, tipo_doc, false);
            }
            else
            {
                byte[] fileBytes = GetFileBytesByKey(context, id);

                if (fileBytes != null)
                    //ExportToResponse(context, fileBytes, "file_" + id, "pdf", false);
                    //ExportToResponse(context, fileBytes, "file_" + id, "pdf", false);
                    ExportToResponse(context, fileBytes, SessionOriginalFileName + id, "pdf", false);
                //else
                //    context.Response.Redirect("~/login.aspx");
            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        private byte[] GetFileBytesByKey1(HttpContext context, object key)
        {
            int value;
            if (key == null || !Int32.TryParse(key.ToString(), out value)) return null;
            SqlDataSource ds = new SqlDataSource();

            ds.ConnectionString = ConfigurationManager.ConnectionStrings["DB_PARTICIPACIONConnectionString"].ConnectionString;
            //ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            ds.ProviderName = ConfigurationManager.ConnectionStrings["DB_PARTICIPACIONConnectionString"].ProviderName;
            ds.SelectCommand = "SELECT DocBytes, FileName FROM UploaderFiles WHERE [Fileid] = " + key.ToString();

            DataTable dt = ((DataView)ds.Select(DataSourceSelectArguments.Empty)).Table;
            byte[] file = null;
            if (dt.Rows.Count > 0)
            {
                file = dt.Rows[0]["DocBytes"] as byte[];
                SessionOriginalFileName = dt.Rows[0]["FileName"] as string;
                tipo_doc = SessionOriginalFileName.Substring(SessionOriginalFileName.IndexOf(".") + 1);
            }
            return file;
            //return strOriginalFileName;
        }


        private byte[] GetFileBytesByKey2(HttpContext context, object key)
        {
            int value;
            if (key == null || !Int32.TryParse(key.ToString(), out value)) return null;
            SqlDataSource ds = new SqlDataSource();

            ds.ConnectionString = ConfigurationManager.ConnectionStrings["DB_PARTICIPACIONConnectionString"].ConnectionString;
            //ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            ds.ProviderName = ConfigurationManager.ConnectionStrings["DB_PARTICIPACIONConnectionString"].ProviderName;
            ds.SelectCommand = "SELECT DocBytes, OriginalFileName FROM tblDocumentos WHERE [Id] = " + key.ToString();

            DataTable dt = ((DataView)ds.Select(DataSourceSelectArguments.Empty)).Table;
            byte[] file = null;
            if (dt.Rows.Count > 0)
            {
                file = dt.Rows[0]["DocBytes"] as byte[];
                SessionOriginalFileName = dt.Rows[0]["OriginalFileName"] as string;
                tipo_doc = SessionOriginalFileName.Substring(SessionOriginalFileName.IndexOf(".") + 1);
            }
            return file;
            //return strOriginalFileName;
        }
        private byte[] GetFileBytesByKey(HttpContext context, object key)
        {
            int value;
            if (key == null || !Int32.TryParse(key.ToString(), out value)) return null;
            SqlDataSource ds = new SqlDataSource();

            ds.ConnectionString = ConfigurationManager.ConnectionStrings["DB_PARTICIPACIONConnectionString"].ConnectionString;
            //ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            ds.ProviderName = ConfigurationManager.ConnectionStrings["DB_PARTICIPACIONConnectionString"].ProviderName;
            ds.SelectCommand = "SELECT DocBytes, FileName FROM UploaderFiles WHERE [Fileid] = " + key.ToString();

            DataTable dt = ((DataView)ds.Select(DataSourceSelectArguments.Empty)).Table;
            byte[] file = null;
            if (dt.Rows.Count > 0)
            {
                file = dt.Rows[0]["DocBytes"] as byte[];
                SessionOriginalFileName = dt.Rows[0]["FileName"] as string;
                //string resultado = SessionOriginalFileName.Split('(', ')');
                //tipo_doc = SessionOriginalFileName.Substring(SessionOriginalFileName.IndexOf(".") + 1);
            }
            return file;
            //return strOriginalFileName;
        }

        public void ExportToResponse(HttpContext context, byte[] content, string fileName, string fileType, bool inline)
        {
            context.Response.Clear();
            context.Response.ContentType = "application/" + fileType;
            context.Response.AddHeader("Content-Disposition", string.Format("{0}; filename={1}.{2}", inline ? "Inline" : "Attachment",
            fileName, fileType));
            context.Response.AddHeader("Content-Length", content.Length.ToString());
            context.Response.BinaryWrite(content);
            context.Response.Flush();
            context.Response.Close();
            context.Response.End();
        }



    }
}