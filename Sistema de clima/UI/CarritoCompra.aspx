<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CarritoCompra.aspx.cs" Inherits="UI.CarritoCompra" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Pestaña usuario:
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                    <h1>Lista de Productos</h1>
            <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" OnRowCommand="gvProductos_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:BoundField DataField="Nombre" HeaderText="Producto" />
                    <asp:BoundField DataField="Precio" HeaderText="Precio" />
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
                    <asp:ButtonField CommandName="Agregar" Text="Agregar al Carrito" />
                </Columns>
            </asp:GridView>

            <h2>Carrito de Compras</h2>
            <asp:GridView ID="gvCarrito" runat="server" AutoGenerateColumns="False" OnRowCommand="gvCarrito_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:BoundField DataField="Nombre" HeaderText="Producto" />
                    <asp:BoundField DataField="Precio" HeaderText="Precio"  />
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
                    <asp:ButtonField CommandName="Eliminar" Text="Eliminar" />
                </Columns>
            </asp:GridView>

            <asp:Label ID="lblTotal" runat="server" Text="Total: $0" Font-Bold="True"></asp:Label>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Pagar" Width="222px" />
            <br />
            <br />
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Volver" Width="221px" />
        </div>
    </form>
</body>
</html>
