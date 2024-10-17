using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BE
{
    public class Producto
    {
		private int id;

		public int ID
		{
			get { return id; }
			set { id = value; }
		}
		private int idProducto;

		public int IdProducto
		{
			get { return idProducto; }
			set { idProducto = value; }
		}

		private string nombre;

		public string Nombre
		{
			get { return nombre; }
			set { nombre = value; }
		}

		private int precio;

		public int Precio
		{
			get { return precio; }
			set { precio = value; }
		}
		private string descripcion;

		public string Descripcion
		{
			get { return descripcion; }
			set { descripcion = value; }
		}
		private bool estado;

		public bool Estado
		{
			get { return estado; }
			set { estado = value; }
		}


	}
}