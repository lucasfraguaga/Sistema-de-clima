<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PantallaBitacora.aspx.cs" Inherits="UI.PantallaBitacora" %>

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
        Bitacora:<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true">
        </asp:GridView>
            <br />
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Volver" Width="355px" />
            <br />
            <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Desconectarse" Width="355px" />
        </div>
    </form>
</body>
</html>
