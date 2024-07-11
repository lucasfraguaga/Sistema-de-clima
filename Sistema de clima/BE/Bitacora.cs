using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BE
{
    public class Bitacora
    {
		private int id;

		public int ID
		{
			get { return id; }
			set { id = value; }
		}

		private int idUsuario;

		public int IdUsuario
		{
			get { return idUsuario; }
			set { idUsuario = value; }
		}

		private DateTime fecha;

		public DateTime Fecha
		{
			get { return fecha; }
			set { fecha = value; }
		}

		private string mensaje;

		public string Mensaje
		{
			get { return mensaje; }
			set { mensaje = value; }
		}

		private string corrupta;

		public string Corrupta
		{
			get { return corrupta; }
			set { corrupta = value; }
		}


	}
}