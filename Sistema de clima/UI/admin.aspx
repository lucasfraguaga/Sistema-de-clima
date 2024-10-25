<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="UI.admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/admin.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        #mapa {
            height: 224px;
            width: 348px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
        El usuario ingresado es:
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <br />
        Su roll es:
        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        <br />
        <br />
        Ir a
        Bitacora:<br />
        <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Bitacora" Width="360px" />
        <br />
        Ver usuarios con sus datos:<br />
        <asp:Button ID="Button3" runat="server" OnClick="Button2_Click" Text="Usuarios" Width="359px" />
        <br />
        Generar backup base de datos:<br />
        <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="Backup" Width="359px" />
        <br />
        Volver a ultima version de backup:<br />
        <asp:Button ID="Button6" runat="server" OnClick="Button6_Click" Text="Restaurar base" Width="358px" />
        <br />
        Ver estadisticos de ventas:<br />
        <asp:Button ID="Button7" runat="server" OnClick="Button7_Click" Text="Ventas" Width="358px" />
        <br />
        <br />
        Direccion oficinas:<br />
        <iframe id="mapa"></iframe>
        <script>
            navigator.geolocation.getCurrentPosition(localizame);
            function localizame(posicion) {
                const latitud = posicion.coords.latitud;
                const longitud = posicion.coords.longitud;
                document.getElementById('mapa').src = `https://maps.google.com/maps?q=${-34.6219656},${-58.3787757}&z=17&output=embed`;
            }
        </script>
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Desconectarse" Width="355px" />
            </div>
    </form>
</body>
</html>