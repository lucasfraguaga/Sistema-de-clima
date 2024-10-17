using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BE
{
    public class Venta
    {
        public int Id { get; set; }
        public int IdUsuario { get; set; }
        public int PrecioTotal { get; set; }
        public List<Producto> Productos { get; set; }

        public Venta()
        {
            Productos = new List<Producto>();
        }
    }
}