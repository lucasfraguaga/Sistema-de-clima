using System;
using System.Collections.Generic;
using System.Linq;
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
            Usuario usu = conexion.ValidarUsuario(TextBox1.Text, TextBox2.Text);
            if (usu is null)
            {
                ShowMessage("Usuario no encontrado");
            }
            else
            {
                if (TextBox2.Text == usu.Contrasena)
                {
                    BLLSesionManager.login(usu);
                    switch (usu.Roll)
                    {
                        case 1:
                            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "logeo de sesion");
                            string script = "window.onload = function(){ alert('Sesión iniciada correctamente'); window.location.href = 'admin.aspx'; }";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                            break;
                        default:
                            ShowMessage("Roll no valido");
                            break;
                    }
                }
                else
                {
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