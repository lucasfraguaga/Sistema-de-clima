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
        BLLEncriptado BLLEncriptado = new BLLEncriptado();
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = (BLL.BLLSesionManager.GetInstance).Usuario.Usu;
            Label2.Text = "WebMaster";
            List<Usuario> usuarios = new List<Usuario>();
            usuarios = conexion.ListarUsuario();
            GridView1.DataSource = usuarios;
            GridView1.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "deslogeo de sesion admin");
            BLL.BLLSesionManager.logaut();
            //ShowMessage("Sesión cerrada correctamente");          
            string script = "window.onload = function(){ alert('Sesión cerrada correctamente'); window.location.href = 'Principal.aspx'; }";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            //Response.Redirect("Default.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "vuelta a la pantalla de admin");
            //ShowMessage("Sesión cerrada correctamente");          
            Response.Redirect("admin.aspx");
        }
    }
}