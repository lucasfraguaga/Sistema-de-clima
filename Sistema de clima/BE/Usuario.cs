using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BE
{
    public class Usuario
    {
        private string usuario;

        public string Usu
        {
            get { return usuario; }
            set { usuario = value; }
        }

        private string contrasena;

        public string Contrasena
        {
            get { return contrasena; }
            set { contrasena = value; }
        }

        private int roll;

        public int Roll
        {
            get { return roll; }
            set { roll = value; }
        }

        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }
        private string corrupto;

        public string Corrupto
        {
            get { return corrupto; }
            set { corrupto = value; }
        }


    }
}