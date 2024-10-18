using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BE
{
    public class ClienteGasto
    {
        //clase para mostrar estadisticas de gastos del cliente
        public int IdUsuario { get; set; }
        public decimal TotalGastado { get; set; }
    }
}