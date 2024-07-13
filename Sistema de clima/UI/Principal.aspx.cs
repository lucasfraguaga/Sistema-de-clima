using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
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
        //variable para bloquear muchos intentos fallidos de usuario incorrecto
        static int bloqueoComun = 0;
        protected void Button1_Click(object sender, EventArgs e)
        {
            
            BLLEncriptado encriptado = new BLLEncriptado();
            //traer usuario de base de datos
            Usuario usu = conexion.ValidarUsuario(TextBox1.Text, TextBox2.Text);
            //if de bloqueo por 3 veces de usuario incorrecto
            if (bloqueoComun != 2) 
            { 
                //if por usuario no encontrado
                if (usu is null)
                {
                    //conexion.insertarBitacora(usu, "Usuario no encontrado");
                    ShowMessage("Usuario no encontrado");
                    bloqueoComun = bloqueoComun+1;
                }
                else
                {
                    //if por usuario bloqueado
                    if (!usu.bloqueado) 
                    { 
                        //if validado de usuario
                        if (encriptado.VerifyPassword(TextBox2.Text,usu.Contrasena))
                        {
                            //logeo de usuario, reinicio de intentos e log de bitacora, tambien se recetea el bloqueo comun
                            BLLSesionManager.login(usu);
                            conexion.ReiniciarIntentosFallidos(usu);
                            bloqueoComun = 0;
                            switch (usu.Roll)
                            {
                                case 1:
                                    conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "logeo de sesion admin");
                                    string script = "window.onload = function(){ alert('Sesión iniciada correctamente'); window.location.href = 'admin.aspx'; }";
                                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                                    break;
                                case 2:
                                    conexion.insertarBitacora((BLL.BLLSesionManager.GetInstance).Usuario, "logeo de sesion usuario");
                                    string script2 = "window.onload = function(){ alert('Sesión iniciada correctamente'); window.location.href = 'User.aspx'; }";
                                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script2, true);
                                    break;
                                default:
                                    ShowMessage("Roll no valido");
                                    break;
                            }
                        }
                        else
                        {
                            //log de bitacora de contraseña incorrecte e incremento de intentos fallidos, tambien se recetea el bloqueo comun
                            
                            if(usu.intentos == 2)
                            {
                                conexion.insertarBitacora(usu, "contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos");
                                ShowMessage("Contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos");
                            }
                            else
                            {
                                conexion.insertarBitacora(usu, "contraseña incorrecta");
                                ShowMessage("Contraseña incorrecta");
                            }
                            conexion.IncrementarIntentosFallidos(usu);
                            bloqueoComun = 0;
                            
                        }
                    }
                    else
                    {
                        //receteo de bloqueo comun e mensaje de usuario bloqueado
                        bloqueoComun = 0;
                        ShowMessage("el usuario esta bloqueado, contactese con un administrador");
                    }
                }
            }
            else
            {
                //mensaje de intentos comunes fallidos y bloqueo de acciones
                ShowMessage("intentaste ingresar un usuario invalido 3 veces segidas, se bloqueo la posibilidad de logear");
                Button1.Enabled = false;
                Button2.Enabled = false;
            }
        }
        //funcion para mostrar menssajes
        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //resgistro de log de ingreso a pantalla de registro e redireccion a la misma
            Usuario usuBitacora = new Usuario();
            usuBitacora.Id = 8;
            usuBitacora.Usu = "bitacora";
            usuBitacora.Roll = 1;
            conexion.insertarBitacora(usuBitacora, "ingreso a pantalla de registro");
            //ShowMessage("Sesión cerrada correctamente");          
            Response.Redirect("Registro.aspx");
        }
    }
}