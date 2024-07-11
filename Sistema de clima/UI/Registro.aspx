<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="UI.Registro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pantalla de registro<br />
            <br />
            Usuario:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBox1" runat="server" Width="140px"></asp:TextBox>
            <br />
            Contraseña:&nbsp;&nbsp;
            <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" Width="137px"></asp:TextBox>
            <asp:RegularExpressionValidator
                ID="RegexValidator"
                runat="server"
                ControlToValidate="TextBox2"
                ErrorMessage="El texto debe contener al menos una letra, un número y tener un mínimo de 8 caracteres."
                ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
                ForeColor="Red">
            </asp:RegularExpressionValidator>
            <br />
            <asp:RadioButton ID="rbShowPassword" runat="server" Text="Show Password" GroupName="passwordOption" OnClick="togglePasswordVisibility(this)" />
            <asp:RadioButton ID="rbHidePassword" runat="server" Text="Hide Password" GroupName="passwordOption" OnClick="togglePasswordVisibility(this)" Checked="true" />
            <script type="text/javascript">
                function togglePasswordVisibility(radioButton) {
                    var passwordTextBox = document.getElementById('<%= TextBox2.ClientID %>');
                    if (radioButton.id === '<%= rbShowPassword.ClientID %>') {
                        passwordTextBox.type = 'text';
                    } else if (radioButton.id === '<%= rbHidePassword.ClientID %>') {
                        passwordTextBox.type = 'password';
                    }
                }
            </script>
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server" Height="22px" Width="232px">
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Registrar" Width="234px" />
            <br />
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click1" Text="Volver" Width="234px" />
            <br />
        </div>
    </form>
</body>
</html>
