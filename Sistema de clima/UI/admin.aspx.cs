using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;

namespace UI
{
    public partial class admin : System.Web.UI.Page
    {
        BLLConexion conexion = new BLLConexion();
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = (BLL.BLLSesionManager.GetInstance).Usuario.Usu;
            Label2.Text = (BLL.BLLSesionManager.GetInstance).Usuario.Roll.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "deslogeo de sesion");
            BLL.BLLSesionManager.logaut();
            //ShowMessage("Sesión cerrada correctamente");          
            string script = "window.onload = function(){ alert('Sesión cerrada correctamente'); window.location.href = 'Principal.aspx'; }";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            //Response.Redirect("Default.aspx");
        }

        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
        }
    }
}