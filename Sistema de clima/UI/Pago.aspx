<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pago.aspx.cs" Inherits="UI.Pago" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>&nbsp;Pestaña usuario:
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            </h2>
            <h2>&nbsp;Pantalla de Pago</h2>

            <!-- GridView para mostrar los productos seleccionados -->
            <asp:GridView ID="gvProductosSeleccionados" runat="server" AutoGenerateColumns="False"
                CssClass="gridview" BorderStyle="Solid" BorderWidth="1px" GridLines="Both">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID Producto" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Precio" HeaderText="Precio" />
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
                </Columns>
            </asp:GridView>

            <br />

            <!-- Formulario de datos de pago -->
            <asp:Label ID="lblNombreTarjeta" runat="server" CssClass="input-label" Text="Nombre en la Tarjeta"></asp:Label>
            &nbsp;<asp:TextBox ID="txtNombreTarjeta" runat="server" CssClass="input-box"></asp:TextBox>

            <br />

            <asp:Label ID="lblNumeroTarjeta" runat="server" CssClass="input-label" Text="Número de Tarjeta"></asp:Label>
            &nbsp;<asp:TextBox ID="txtNumeroTarjeta" runat="server" CssClass="input-box" MaxLength="16"></asp:TextBox>
            <!-- RegularExpressionValidator: Asegura que solo sean números -->
            <asp:RegularExpressionValidator 
                ID="revNumeroTarjeta" 
                runat="server" 
                ControlToValidate="txtNumeroTarjeta" 
                ValidationExpression="^\d{16}$" 
                ErrorMessage="El número de tarjeta debe tener exactamente 16 dígitos y ser numeros." 
                ForeColor="Red" 
                Display="Dynamic" />

            <br />

            <asp:Label ID="lblFechaExpiracion" runat="server" CssClass="input-label" Text="Fecha de Expiración (MM/YY)"></asp:Label>
            &nbsp;<asp:TextBox ID="txtFechaExpiracion" runat="server" MaxLength="5" Placeholder="MM/YY"></asp:TextBox>
            <!-- RegularExpressionValidator: Verifica que el formato sea MM/YY -->
            <asp:RegularExpressionValidator 
                ID="revFechaExpiracion" 
                runat="server" 
                ControlToValidate="txtFechaExpiracion" 
                ValidationExpression="^(0[1-9]|1[0-2])\/\d{2}$" 
                ErrorMessage="Formato inválido. Use MM/YY." 
                ForeColor="Red" 
                Display="Dynamic" />
            <br />

            <asp:Label ID="lblCVV" runat="server" CssClass="input-label" Text="CVV"></asp:Label>
            &nbsp;
            <asp:TextBox ID="txtCVV" runat="server" CssClass="input-box" MaxLength="3" TextMode="Password"></asp:TextBox>
            <asp:RegularExpressionValidator 
                ID="RegularExpressionValidator2" 
                runat="server" 
                ControlToValidate="txtCVV" 
                ValidationExpression="^\d{3}$" 
                ErrorMessage="Solo se pueden poner numeros y tinen que ser 3" 
                ForeColor="Red" 
                Display="Dynamic" />
            <br />
            <br />

            <asp:Button ID="btnConfirmarPago" runat="server" Text="Confirmar Pago" OnClick="btnConfirmarPago_Click" />
            <br />
            <asp:Label ID="lblMensaje" runat="server" CssClass="input-label" ForeColor="Red"></asp:Label>
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Cancelar compra" Width="133px" />
        </div>
    </form>
</body>
</html>
