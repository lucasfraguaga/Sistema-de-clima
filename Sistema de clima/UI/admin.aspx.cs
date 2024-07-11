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
    public partial class admin : System.Web.UI.Page
    {
        BLLConexion conexion = new BLLConexion();
        protected void Page_Load(object sender, EventArgs e)
        {

            Label1.Text = (BLL.BLLSesionManager.GetInstance).Usuario.Usu;
            Label2.Text = "WebMaster";
            //Label2.Text = (BLL.BLLSesionManager.GetInstance).Usuario.Roll.ToString();
            List<Bitacora> bitacora = new List<Bitacora>();
            List<Usuario> listUsuarios = new List<Usuario>();
            bitacora = conexion.listarBitacora();
            listUsuarios = conexion.ListarUsuario();

            string auxBitacora = "La tabla Bitacora tiene registros corruptos y son: ";
            string auxUsuario = "La tabla usuario tiene registros corruptos y son: ";
            bool valBitacora = false;
            bool valUsuario = false;
            foreach (var item in bitacora)
            {
                if(item.Corrupta == "true")
                {
                    valBitacora = true;
                    auxBitacora += item.ID.ToString() + " ";
                }
            }
            foreach (var item in listUsuarios)
            {
                if (item.Corrupto == "true")
                {
                    valUsuario = true;
                    auxBitacora += item.Id.ToString() + " ";
                }
            }
            string auxMensaje = "";
            if (valBitacora)
            {
                auxMensaje = auxBitacora;
            }
            if (valUsuario)
            {
                auxMensaje = auxUsuario;
            }
            
            if (valBitacora || valUsuario) 
            {
                ShowMessage(auxMensaje);
            }
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

        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "pantalla de usuarios abierta");
            //ShowMessage("Sesión cerrada correctamente");          
            Response.Redirect("PantallaUsuarios.aspx");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "pantalla de usuarios abierta");
            //ShowMessage("Sesión cerrada correctamente");          
            Response.Redirect("PantallaBitacora.aspx");
        }
    }
}