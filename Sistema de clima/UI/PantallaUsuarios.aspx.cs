using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class PantallaUsuarios : System.Web.UI.Page
    {
        BLLConexion conexion = new BLLConexion();
        protected void Page_Load(object sender, EventArgs e)
        {
            //seteo de variables de la sesion, busqueda de los usuarios en base y seteo en vista
            Label1.Text = (BLL.BLLSesionManager.GetInstance).Usuario.Usu;
            Label2.Text = "WebMaster";
            List<Usuario> usuarios = new List<Usuario>();
            usuarios = conexion.ListarUsuario();
            GridView1.DataSource = usuarios;
            GridView1.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //desconexion e llenado del log
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "deslogeo de sesion admin");
            BLL.BLLSesionManager.logaut();       
            string script = "window.onload = function(){ alert('Sesión cerrada correctamente'); window.location.href = 'Principal.aspx'; }";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //vuelta a la pantalla de admin e ingreso a bitacora
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "vuelta a la pantalla de admin");        
            Response.Redirect("admin.aspx");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            //logica para quitar el bloqueo de un usuario con mensaje de si se pudo o no
            Usuario usuarios = new Usuario();
            usuarios.Id = int.Parse(txtNumeros.Text);
            if (conexion.ReiniciarIntentosFallidos(usuarios))
            {
                conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "se quito el bloqueo del usuario" + txtNumeros.Text);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "bloqueo quitado", "alert('bloqueo quitado.');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "no se pudo quitar el bloqueo al usuario dado", "alert('no se pudo quitar el bloqueo al usuario dado.');", true);
            }
        }
    }
}