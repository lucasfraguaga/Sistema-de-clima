using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BE;
using BLL;

namespace UI
{
    public partial class User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            usu.Text = BLLSesionManager.GetInstance.Usuario.Usu;
        }
        BLLConexion conexion = new BLLConexion();
        protected void Button1_Click(object sender, EventArgs e)
        {
           
                conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "deslogeo de sesion usuario");
                BLL.BLLSesionManager.logaut();
                //ShowMessage("Sesión cerrada correctamente");          
                string script = "window.onload = function(){ alert('Sesión cerrada correctamente'); window.location.href = 'Principal.aspx'; }";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                //Response.Redirect("Default.aspx");
            
        }
    }
}