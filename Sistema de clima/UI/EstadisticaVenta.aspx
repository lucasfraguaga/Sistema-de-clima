<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EstadisticaVenta.aspx.cs" Inherits="UI.EstadisticaVenta" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ventas</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="btnMostrarProductos" runat="server" Text="Mostrar Productos" OnClick="btnMostrarProductos_Click" />
            <asp:DropDownList ID="ddlVentas" runat="server"></asp:DropDownList>
            <br />
            <br />
            <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="true" HeaderStyle-BackColor="LightGray" />
            <br />
            <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Mostrar estadisticas" Width="156px" />
            <br />
            <br />
            <asp:Label ID="Label1" runat="server"></asp:Label>
            <br />
            <br />
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" style="height: 26px" Text="Volver" Width="155px" />
        </div>
    </form>
</body>
</html>