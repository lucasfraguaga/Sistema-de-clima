<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="UI.User" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    
</head>
<body>
        <link rel="stylesheet" type="text/css" href="Usuario.css" />

    <form id="form1" runat="server">
        <div id="h1usu">
            Pestaña usuario: <asp:Label ID="usu" runat="server" Text="Label"></asp:Label>
            <%--Pestaña usuario: Santiago.--%>
        </div>
        <h1>Servicios alquilados: </h1>
        <asp:Image ID="mapa1" ImageUrl="Media/GranjaCirculosSantiago.drawio.png" runat="server" />
        <asp:Image ID="mapa2" ImageUrl="Media/GranjaCirculosSanti2.png" runat="server" />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Desconectarse" Width="355px" />

    </form>
</body>
</html>
