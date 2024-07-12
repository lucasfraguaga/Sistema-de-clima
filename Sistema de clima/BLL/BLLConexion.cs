using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using BE;
using DAL;

namespace BLL
{
    //paso intermedio entre ui y dal
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
        public bool generarBackup()
        {
            return conexion.generarBackup();
        }
        public bool restaurarBase()
        {
            return conexion.restaurarBase();
        }
        public void IncrementarIntentosFallidos(Usuario usu)
        {
            conexion.IncrementarIntentosFallidos(usu);
        }
        public bool ReiniciarIntentosFallidos(Usuario usu)
        {
            return conexion.ReiniciarIntentosFallidos(usu);
        }
    }
}