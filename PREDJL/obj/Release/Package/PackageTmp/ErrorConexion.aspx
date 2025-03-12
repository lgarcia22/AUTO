<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorConexion.aspx.cs" Inherits="PREDJL.ErrorConexion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Error de Conexión</title>
    <style>
        body {
            text-align: center;
            font-family: Arial, sans-serif;
        }
        h1 {
            color: red;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%--<h1>Error al conectar a la base de datos</h1>--%>
    <img src="Content/Images/Mantenimiento.PNG" alt="Error de Conexión" style="width:1000px;" />
    <%--<p>Lo sentimos, no pudimos conectar con la base de datos en este momento. Por favor, intente de nuevo más tarde.</p>--%>
    
    <!-- Botón centrado -->
    <a href="https://www.tsc.gob.hn/index.php/sistema-para-la-declaracion-jurada-en-linea/" class="button">Volver al inicio</a>
</body>
</html>