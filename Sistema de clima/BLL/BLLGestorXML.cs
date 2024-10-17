using BE;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Linq;

namespace BLL
{
    public class BLLGestorXML
    {
        public void CrearXmlDeVentas(List<Venta> ventas)
        {
            try
            {
                // Crear el documento XML
                XDocument xmlDoc = new XDocument(
                    new XElement("Ventas", // Raíz del documento
                                           // Agregar cada venta
                        new List<XElement>(ventas.ConvertAll(venta =>
                            new XElement("Venta",
                                new XElement("Id", venta.Id),
                                new XElement("IdUsuario", venta.IdUsuario),
                                new XElement("PrecioTotal", venta.PrecioTotal),
                                new XElement("Productos",
                                    // Agregar cada producto
                                    new List<XElement>(venta.Productos.ConvertAll(producto =>
                                        new XElement("Producto",
                                            new XElement("IdProducto", producto.IdProducto),
                                            new XElement("Nombre", producto.Nombre),
                                            new XElement("Precio", producto.Precio)
                                        ))
                                    )
                                )
                            )
                        ))
                    )
                );

                // Guardar el documento XML en el archivo
                xmlDoc.Save(@"C:\Users\lucas\Desktop\GIT\ventas.xml");
            }
            catch (Exception e)
            {
                // Manejo de errores
                Console.WriteLine("Error al crear el XML: " + e.Message);
            }
        }
    }
}