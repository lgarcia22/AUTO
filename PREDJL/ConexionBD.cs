using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace PREDJL
{
    public class ConexionBD
    {
        public string error;
        //string cadena = (ConfigurationManager.ConnectionStrings["DB_PARTICIPACIONConnectionString"].ConnectionString);
        string cadena = (ConfigurationManager.ConnectionStrings["PreRegistro_DJLConnectionString"].ConnectionString);
        public SqlConnection conexion = new SqlConnection();

        public ConexionBD()
        {
            conexion.ConnectionString = cadena;
        }
        public bool abrirConexion()
        {
            try
            {
                conexion.Open();
                return true;
            }
            catch (Exception ex)
            {
                error = ex.Message;
                return false;
            }
         
        }

        public void cerrarConexion()
        {

            conexion.Close();
        }
    }

}
