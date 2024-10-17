using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace UI
{
    /// <summary>
    /// Descripción breve de WebServicePago
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class WebServicePago : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hola a todos";
        }
        public bool ValidarPago(string nombreTarjeta, string numeroTarjeta, string fechaTarjeta, string CVV, int precio)
        {
            if (string.IsNullOrEmpty(nombreTarjeta) ||
                string.IsNullOrEmpty(numeroTarjeta) ||
                string.IsNullOrEmpty(fechaTarjeta) ||
                string.IsNullOrEmpty(CVV))
            {
                return false;
            }

            // Validar que el número de tarjeta y CVV contengan solo números
            if (!long.TryParse(numeroTarjeta, out _) ||
                !int.TryParse(CVV, out _))
            {
                return false;
            }
            if (!ValidarFechaExpiracion(fechaTarjeta))
            {
                return false;
            }

            return true;
        }
        protected bool ValidarFechaExpiracion(string fecha)
        {
            string[] partes = fecha.Split('/');

            // Validar formato correcto (MM/YY)
            if (partes.Length != 2 || !int.TryParse(partes[0], out int mes) || !int.TryParse(partes[1], out int anio))
            {
                return false ;
            }

            // Convertir año al formato completo (por ejemplo, "24" => 2024)
            anio += 2000;

            // Validar que el mes esté entre 1 y 12
            if (mes < 1 || mes > 12)
            {
                return false;
            }

            // Crear la fecha del último día del mes de vencimiento
            DateTime fechaExpiracion = new DateTime(anio, mes, DateTime.DaysInMonth(anio, mes));

            // Comparar con la fecha actual (fin del día)
            if (fechaExpiracion < DateTime.Now)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
    }
}
