using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BE;
using DAL;

namespace BLL
{
    public class BLLConexion
    {
        Conexion conexion = new Conexion();

        public void guardarUsuario(string usuario, string contrasena)
        {
            conexion.guardarUsuario(usuario, contrasena);
        }

        public Usuario ValidarUsuario(string nombre, string contrasena)
        {
            BLLEncriptado encriptado = new BLLEncriptado();
            return conexion.validadUsuario(nombre, encriptado.HashPassword(contrasena));
        }

        public void insertarBitacora(Usuario usu, string mensaje)
        {
            conexion.insertarBitacora(usu, mensaje);
        }

        public List<Bitacora> listarBitacora()
        {
            return conexion.listarBitacora();
        }
        public List<Usuario> ListarUsuario()
        {
            return conexion.ListarUsuarios();
        }
        public void insertarUsuario(Usuario usu)
        {
            conexion.insertarUsuario(usu);
        }
    }
}