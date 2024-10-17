using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.Services.Description;
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
            //llenado de datos de sesion
            Label1.Text = (BLL.BLLSesionManager.GetInstance).Usuario.Usu;
            Label2.Text = "WebMaster";
            //Label2.Text = (BLL.BLLSesionManager.GetInstance).Usuario.Roll.ToString();

            //verificado el estado de loss registros de bitacora e usuario y mensaje si estan corruptos o no
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
                    auxUsuario += item.Id.ToString() + " ";
                }
            }
            string auxMensaje = "";
            if (valBitacora)
            {
                auxMensaje += auxBitacora;
            }
            if (valUsuario)
            {
                auxMensaje += auxUsuario;
            }
            //registro de log si estan corruptos o no
            if (valBitacora || valUsuario) 
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "corrupto", $"alert('{auxMensaje}');", true);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //logica de desconexion e log
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "deslogeo de sesion admin");
            BLL.BLLSesionManager.logaut();        
            string script = "window.onload = function(){ alert('Sesión cerrada correctamente'); window.location.href = 'Principal.aspx'; }";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }
        //funcion para mostrar mensajes
        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //logica para ir a pantalla de usuario e log
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "pantalla de usuarios abierta");       
            Response.Redirect("PantallaUsuarios.aspx");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            //logica para ir a pantalla de bitacora e log
            conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "pantalla de bitacora abierta");         
            Response.Redirect("PantallaBitacora.aspx");
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            //logica para hacer el backup con mensaje si se pudo o no e logs
            if (conexion.generarBackup())
            {
                ShowMessage("Backup exitoso");
                conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "se genero un backup de la base de datos");
            }
            else
            {
                ShowMessage("Backup no exitoso");
                conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "no se genero un backup de la base de datos");
            }
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            //logica para hacer la restauracion de la base y log de si se pudo o no
            if (conexion.restaurarBase())
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "backupSuccess", "alert('Backup realizado correctamente.');", true);
                conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "se restauro la base a la ultima version disponible");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "backupError", $"alert('Error al realizar el backup');", true);
                conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "no se pudo restaurar la base");
            }
        }

        protected void Button7_Click(object sender, EventArgs e)
        {
            BLLGestorXML xml = new BLLGestorXML();
            xml.CrearXmlDeVentas(conexion.ObtenerVentasCompleto());           
        }
    }
}