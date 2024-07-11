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
    public partial class PantallaBitacora : System.Web.UI.Page
    {
        BLLConexion conexion = new BLLConexion();
        protected void Page_Load(object sender, EventArgs e)
        {
            //https://localhost:44325/PantallaBitacora
            if(BLLSesionManager.GetInstance == null)
            {
                string script = "window.onload = function(){ alert('Estas intentando entrar en las bitacoras ilegalmente'); window.location.href = 'Principal.aspx'; }";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            }
            else
            {
                if (BLLSesionManager.GetInstance.Usuario.Roll != 1)
                {

                    conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "el usuario intento entrar ilegalmente a las bitacoras");
                    BLL.BLLSesionManager.logaut();
                    string script = "window.onload = function(){ alert('Estas intentando entrar en las bitacoras ilegalmente, se te cerrara la sesion y queda guardado para un futuro analisis.'); window.location.href = 'Principal.aspx'; }";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
                else
                {
                    Label1.Text = (BLL.BLLSesionManager.GetInstance).Usuario.Usu;
                    Label2.Text = "WebMaster";
                    List<Bitacora> bitacora = new List<Bitacora>();
                    bitacora = conexion.listarBitacora();
                    GridView1.DataSource = bitacora;
                    GridView1.DataBind();
                }
            }    
        }

        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
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