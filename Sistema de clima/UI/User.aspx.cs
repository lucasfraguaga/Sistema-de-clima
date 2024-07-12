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
            // instancia de usuario a mostrar
            usu.Text = BLLSesionManager.GetInstance.Usuario.Usu;
        }
        BLLConexion conexion = new BLLConexion();
        protected void Button1_Click(object sender, EventArgs e)
        {
                //Deslogeo con guardado de bitacora y muestra de cartel de deslogeo satisfactorio 
                conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "deslogeo de sesion usuario");
                BLL.BLLSesionManager.logaut();        
                string script = "window.onload = function(){ alert('Sesión cerrada correctamente'); window.location.href = 'Principal.aspx'; }";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);           
        }
    }
}