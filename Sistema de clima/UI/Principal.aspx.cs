using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BE;
using BLL;

namespace UI
{
    public partial class Principal : System.Web.UI.Page
    {
        BLLConexion conexion = new BLLConexion();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            BLLEncriptado encriptado = new BLLEncriptado();
            Usuario usu = conexion.ValidarUsuario(TextBox1.Text, TextBox2.Text);
            if (usu is null)
            {
                //conexion.insertarBitacora(usu, "Usuario no encontrado");
                ShowMessage("Usuario no encontrado");
            }
            else
            {
                if (encriptado.VerifyPassword(TextBox2.Text,usu.Contrasena))
                {
                    BLLSesionManager.login(usu);
                    switch (usu.Roll)
                    {
                        case 1:
                            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "logeo de sesion admin");
                            string script = "window.onload = function(){ alert('Sesión iniciada correctamente'); window.location.href = 'admin.aspx'; }";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                            break;
                        case 2:
                            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "logeo de sesion usuario");
                            string script2 = "window.onload = function(){ alert('Sesión iniciada correctamente'); window.location.href = 'User.aspx'; }";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", script2, true);
                            break;
                        default:
                            ShowMessage("Roll no valido");
                            break;
                    }
                }
                else
                {
                    conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "contraseña incorrecta");
                    ShowMessage("Contraseña incorrecta");
                }
            }
        }
        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
        }


    }
}