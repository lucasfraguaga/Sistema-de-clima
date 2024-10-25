<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="UI.User" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/CorritoCompra.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    
</head>
<body>
        <link rel="stylesheet" type="text/css" href="Usuario.css" />

    <form id="form1" runat="server">
        <div class="container" id="h1usu">
            Pestaña usuario: <asp:Label ID="usu" runat="server" Text="Label"></asp:Label>
            <%--Pestaña usuario: Santiago.--%>
        
        <h1>Servicios comprados:</h1>
        <h1>&nbsp;<asp:GridView ID="GridView1" runat="server" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Font-Name="Arial" Font-Size="16px" ForeColor="#333" GridLines="Both" BorderStyle="Solid" BorderWidth="1px">
            </asp:GridView>
        </h1>
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Comprar equipos" Width="356px" />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Desconectarse" Width="355px" />
</div>
    </form>
</body>
</html>
