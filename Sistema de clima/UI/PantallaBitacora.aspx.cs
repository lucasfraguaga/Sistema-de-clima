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
            //logica para que no se pueda acceder a la bitacora mediante el link e mensajes de aviso
            //https://localhost:44325/PantallaBitacora
            if(BLLSesionManager.GetInstance == null)
            {
                string script = "window.onload = function(){ alert('Estas intentando entrar en las bitacoras ilegalmente'); window.location.href = 'Principal.aspx'; }";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            }
            else
            {
                //logica para no acceder si no es admin
                if (BLLSesionManager.GetInstance.Usuario.Roll != 1)
                {

                    conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "el usuario intento entrar ilegalmente a las bitacoras");
                    BLL.BLLSesionManager.logaut();
                    string script = "window.onload = function(){ alert('Estas intentando entrar en las bitacoras ilegalmente, se te cerrara la sesion y queda guardado para un futuro analisis.'); window.location.href = 'Principal.aspx'; }";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
                else
                {
                    //llenado de datos de bitacora e sesion, aca se logro entrar
                    Label1.Text = (BLL.BLLSesionManager.GetInstance).Usuario.Usu;
                    Label2.Text = "WebMaster";
                    List<Bitacora> bitacora = new List<Bitacora>();
                    bitacora = conexion.listarBitacora();
                    GridView1.DataSource = bitacora;
                    GridView1.DataBind();
                }
            }    
        }
        //funcion para mostrar cartel
        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //logica de desconeccion con log
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "deslogeo de sesion admin");
            BLL.BLLSesionManager.logaut();        
            string script = "window.onload = function(){ alert('Sesión cerrada correctamente'); window.location.href = 'Principal.aspx'; }";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //logica para volver atras con log
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "vuelta a la pantalla de admin");       
            Response.Redirect("admin.aspx");
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            CargarDatos(); // Método para volver a cargar los datos en el GridView
        }
        private void CargarDatos()
        {
            // Suponiendo que tienes un método ObtenerDatos() que obtiene los datos de la base de datos
            var datos = conexion.listarBitacora();
            GridView1.DataSource = datos;
            GridView1.DataBind();
        }
    }
}