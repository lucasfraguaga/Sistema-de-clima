using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BE;

namespace BLL
{
    public class BLLSesionManager
    {
        private Usuario usuario;
        public Usuario Usuario
        {
            get { return usuario; }
            set { usuario = value; }
        }
        private static BLLSesionManager _session;
        public static BLLSesionManager GetInstance
        {
            get
            {
                return _session;
            }
        }

        public static void login(Usuario usuario)
        {

            if (_session == null)
            {
                _session = new BLLSesionManager();
                _session.usuario = usuario;
            }
            else
            {
                throw new Exception("Sesion no iniciada");
            }
        }

        public static void logaut()
        {
            if (_session != null)
            {
                _session = null;
            }
            else
            {
                throw new Exception("Sesion no iniciada");
            }
        }
    }
}