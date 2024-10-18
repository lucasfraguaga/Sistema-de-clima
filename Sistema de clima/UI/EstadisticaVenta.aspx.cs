using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.IO;
using BE;

namespace UI
{
    public partial class EstadisticaVenta : System.Web.UI.Page
    {
        //path donde se guarda el xml
        private const string xmlAbsolutePath = @"C:\Users\lucas\Desktop\GIT\ventas.xml"; 
        //web service para sacar estadisticas
        WebServiceEstadisticoVenta estadisticoVenta = new WebServiceEstadisticoVenta();

        protected void Page_Load(object sender, EventArgs e)
        {
            //llamada a cargar ventas
            if (!IsPostBack)
            {
                CargarVentas();
            }
        }
        //funcion para levantar el xml y cargar las ventas en el controlador
        private void CargarVentas()
        {
            try
            {
                //validacion de que exista el archivo
                if (!File.Exists(xmlAbsolutePath))
                {
                    lblTotal.Text = "El archivo XML no se encuentra en la ruta especificada.";
                    return;
                }
                //abriendo archivo y separando los id
                XDocument xmlDoc = XDocument.Load(xmlAbsolutePath);

                var ventas = from venta in xmlDoc.Descendants("Venta")
                             select new
                             {
                                 Id = (int)venta.Element("Id")
                             };

                ddlVentas.DataSource = ventas;
                ddlVentas.DataTextField = "Id";
                ddlVentas.DataValueField = "Id";
                ddlVentas.DataBind();
            }
            catch (Exception ex)
            {
                lblTotal.Text = $"Error: {ex.Message}";
            }
        }
        //boton para mostrar productos, seleccionando un id
        protected void btnMostrarProductos_Click(object sender, EventArgs e)
        {
            try
            {
                if (!File.Exists(xmlAbsolutePath))
                {
                    lblTotal.Text = "El archivo XML no se encuentra en la ruta especificada.";
                    return;
                }

                XDocument xmlDoc = XDocument.Load(xmlAbsolutePath);
                int idVentaSeleccionada = int.Parse(ddlVentas.SelectedValue);

                var venta = xmlDoc.Descendants("Venta")
                                  .Where(v => (int)v.Element("Id") == idVentaSeleccionada)
                                  .FirstOrDefault();

                if (venta != null)
                {
                    var productos = venta.Element("Productos").Elements("Producto")
                                          .Select(p => new
                                          {
                                              IdProducto = (int)p.Element("IdProducto"),
                                              Nombre = (string)p.Element("Nombre"),
                                              Precio = (decimal)p.Element("Precio")
                                          }).ToList();

                    // Llenar el GridView con los productos
                    gvProductos.DataSource = productos;
                    gvProductos.DataBind();

                    // Mostrar el total de la venta
                    decimal precioTotal = (decimal)venta.Element("PrecioTotal");
                    lblTotal.Text = $"<b>Total de la venta:</b> ${precioTotal}";
                }
            }
            catch (Exception ex)
            {
                lblTotal.Text = $"Error: {ex.Message}";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //logica para mostrar al mejor cliente consumiendo el webservice
            ClienteGasto clienteGasto = new ClienteGasto();
            clienteGasto = estadisticoVenta.ObtenerClienteQueMasGasto(xmlAbsolutePath);
            Label1.Text = "El mejor cliente es: " + clienteGasto.IdUsuario + " habiendo gastado: " + clienteGasto.TotalGastado.ToString();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //redireccion a pantalla de admin
            Response.Redirect("admin.aspx");
        }
    }
}