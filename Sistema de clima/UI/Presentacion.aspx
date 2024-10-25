<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Presentacion.aspx.cs" Inherits="UI.Presentacion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Sobre Nosotros</title>
    <style>
        body {
            margin: 0; /* Sin márgenes */
            padding: 0; /* Sin padding */
            height: 100vh; /* Altura completa de la ventana */
            background-image: url('Content/fondo.jpg'); /* Cambia la ruta según la ubicación de la imagen */
            background-size: cover; /* Asegúrate que la imagen cubre el fondo */
            background-position: center; /* Centra la imagen */
            background-repeat: no-repeat; /* Evita que la imagen se repita */
        }

        .container {
            height: 100%; /* Ocupa toda la altura disponible */
            display: flex; /* Para centrar contenido */
            flex-direction: column; /* Organiza el contenido en columna */
            justify-content: center; /* Centra verticalmente el contenido */
            align-items: center; /* Centra horizontalmente el contenido */
            background-color: rgba(255, 255, 255, 0.8); /* Fondo blanco semi-transparente */
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 800px; /* Ancho máximo del contenedor */
            align-items: center;
            margin: auto; /* Centra horizontalmente el contenedor */
            padding: 20px; /* Espaciado interno */
            margin-top: 100px; /* Ajusta este valor según lo necesites */
        }

        h1, h2, p {
            text-align: center; /* Centra el texto */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>RIEGOTech</h1>
            <img src="Content/logo.jpg" alt="Logo de la Empresa" style="max-width: 50px; height: auto;" />
            <h1>Quiénes Somos</h1>
            <p>
                Somos una empresa dedicada a ofrecer soluciones innovadoras para mejorar tu experiencia. Nuestra misión es proporcionar un servicio que permita el riego autonomo y la toma de datos.</p>

            <h2>Qué Ofrecemos</h2>
            <p>
                Ofrecemos equipos que resuelvan la neceidad del riego autonomo y la toma de datos, y un servicio para poder visualizar estos datos sacandole todo el potencial que tienen.</p>
            <p>
                &nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="iniciar sesion" Width="406px" />
            </p>
        </div>
    </form>
</body>
</html>