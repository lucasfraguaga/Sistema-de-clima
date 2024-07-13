<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PantallaUsuarios.aspx.cs" Inherits="UI.PantallaUsuarios" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        El usuario ingresado es:
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <br />
        Su roll es:
        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        <br />
        <br />
        Bitacora:<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="ID" />
                <asp:BoundField DataField="Usu" HeaderText="Usuario" />
                <asp:BoundField DataField="Contrasena" HeaderText="Contraseña" />
                <asp:BoundField DataField="Roll" HeaderText="Roll" />
                <asp:BoundField DataField="Corrupto" HeaderText="Corrupto" />
                <asp:BoundField DataField="bloqueado" HeaderText="Bloqueado" />
            </Columns>
        </asp:GridView>
            <br />
            <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Quitar bloqueo" Width="356px" />
            <br />
            Id a quitar bloqueo:
            <asp:TextBox ID="txtNumeros" runat="server" />
            <asp:RegularExpressionValidator
                ID="RegexValidator"
                runat="server"
                ControlToValidate="txtNumeros"
                ErrorMessage="Este campo debe contener solo números."
                ValidationExpression="^\d+$"
                ForeColor="Red">
            </asp:RegularExpressionValidator>
            <br />
            <br />
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Volver" Width="356px" />
            <br />
            <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Desconectarse" Width="355px" />
        </div>
    </form>
</body>
</html>
