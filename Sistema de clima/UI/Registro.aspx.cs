using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using BE;
using BLL;

namespace UI
{
    public partial class Registro : System.Web.UI.Page
    {
        BLLConexion conexion = new BLLConexion();
        BLLEncriptado encriptado = new BLLEncriptado();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if para ver si la pagina se recargo por una respuesta de datos
            if (!IsPostBack)
            {
                // Obtener los valores del enum
                var roles = Enum.GetValues(typeof(Rol));

                // Asignar los valores al CheckBoxList
                foreach (var role in roles)
                {
                    DropDownList1.Items.Add(role.ToString());
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //registro de usuario tomando los datos de los controladores e insertado en bitacora
            Usuario usuario = new Usuario();
            usuario.Usu = TextBox1.Text;
            usuario.Contrasena = encriptado.HashPassword(TextBox2.Text);
            usuario.Id = 8;
            //switch para tener nombres envez de numeros
            switch (DropDownList1.SelectedItem.ToString())
            {
                case "admin":
                    usuario.Roll = 1;
                    break;
                case "usuario":
                    usuario.Roll = 2;
                    break;
                default:
                    break;
            }
            conexion.insertarUsuario(usuario);
            conexion.insertarBitacora(usuario, "se registro el usuario " + usuario.Usu);
            //redireccion a principal despues de registrar
            Response.Redirect("Principal.aspx");
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {
            //vuelta a principal sin registrar un usuario, genera un log en la bitacora
            Usuario usuBitacora = new Usuario();
            usuBitacora.Id = 8;
            usuBitacora.Usu = "bitacora";
            usuBitacora.Roll = 1;
            conexion.insertarBitacora(usuBitacora, "vuelta de pantalla de registro sin registrar");        
            Response.Redirect("Principal.aspx");
        }
    }
}