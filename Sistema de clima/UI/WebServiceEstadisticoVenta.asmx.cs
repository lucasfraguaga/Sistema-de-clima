using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml.Linq;
using BE;

namespace UI
{
    /// <summary>
    /// Descripción breve de WebServiceEstadisticoVenta
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class WebServiceEstadisticoVenta : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hola a todos";
        }
        public ClienteGasto ObtenerClienteQueMasGasto(string filePath)
        {
            try
            {
                // Cargar el documento XML
                XDocument xmlDoc = XDocument.Load(filePath);

                // Crear un diccionario para almacenar el total gastado por cada cliente
                Dictionary<int, decimal> gastosPorCliente = new Dictionary<int, decimal>();

                // Iterar sobre cada venta en el XML
                foreach (var venta in xmlDoc.Descendants("Venta"))
                {
                    int idUsuario = (int)venta.Element("IdUsuario");
                    decimal precioTotal = (decimal)venta.Element("PrecioTotal");

                    // Sumar el gasto al cliente correspondiente
                    if (gastosPorCliente.ContainsKey(idUsuario))
                    {
                        gastosPorCliente[idUsuario] += precioTotal;
                    }
                    else
                    {
                        gastosPorCliente[idUsuario] = precioTotal;
                    }
                }

                // Determinar el cliente que más ha gastado
                var clienteConMasGasto = gastosPorCliente
                    .OrderByDescending(x => x.Value)
                    .FirstOrDefault();

                // Devolver el resultado
                return new ClienteGasto
                {
                    IdUsuario = clienteConMasGasto.Key,
                    TotalGastado = clienteConMasGasto.Value
                };
            }
            catch (Exception e)
            {
                // Manejo de errores
                Console.WriteLine("Error al procesar el XML: " + e.Message);
                return null; 
            }
        }
    }
}
