<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NotFoundPage.aspx.cs" Inherits="PREDJL.ErrorConexion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Página no encontrada</title>
    <style>
        body {
            text-align: center;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        h1 {
            color: red;
            margin-top: 50px;
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
            margin-top: 20px;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <img src="Content/TSC/LOGO_TSC_2024.png" alt="Error de Conexión" style="width:500px;" />
    <h1>404 - Página no encontrada</h1>
    <p>Lo sentimos, la página que estás buscando no existe.</p>
    <%--<a href="https://www.tsc.gob.hn/index.php/sistema-para-la-declaracion-jurada-en-linea/" class="button">Volver al inicio</a>--%>
</body>
</html>