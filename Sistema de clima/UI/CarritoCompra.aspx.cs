using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BE;

namespace UI
{
    public partial class CarritoCompra : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // instancia de usuario a mostrar  
            Label1.Text = BLLSesionManager.GetInstance.Usuario.Usu;
            if (!IsPostBack)
            {
                gvProductos.DataSource = ObtenerProductos();
                gvProductos.DataBind();

                // Inicializar el carrito en sesión si no existe
                if (Session["Carrito"] == null)
                    Session["Carrito"] = new List<ProductoHardcodeado>();

                ActualizarCarrito();
            }                   
        }
        public class ProductoHardcodeado
        {
            public int Id { get; set; }
            public string Nombre { get; set; }
            public int Precio { get; set; }
            public string Descripcion { get; set; }
        }
        private List<ProductoHardcodeado> ObtenerProductos()
        {
            return new List<ProductoHardcodeado>
        {
            new ProductoHardcodeado { Id = 1, Nombre = "Equipo1", Precio = 100, Descripcion = "Equipo con 1 controlador de agua y 1 sensor de humedad" },
            new ProductoHardcodeado { Id = 2, Nombre = "Equipo2", Precio = 150, Descripcion = "Equipo con 2 controladores de agua y 1 sensor de humedad" },
            new ProductoHardcodeado { Id = 3, Nombre = "Equipo3", Precio = 200, Descripcion = "Equipo con 3 controladores de agua y 2 sensores de humedad" }
        };
        }
        // Método para agregar productos al carrito
        protected void gvProductos_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Agregar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int idProducto = index + 1;
                ProductoHardcodeado producto = ObtenerProductos().FirstOrDefault(p => p.Id == idProducto);

                if (producto != null)
                {
                    List<ProductoHardcodeado> carrito = (List<ProductoHardcodeado>)Session["Carrito"];
                    carrito.Add(producto);
                    Session["Carrito"] = carrito;

                    ActualizarCarrito();
                }
            }
        }
        // Método para eliminar productos del carrito
        protected void gvCarrito_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                List<ProductoHardcodeado> carrito = (List<ProductoHardcodeado>)Session["Carrito"];
                carrito.RemoveAt(index);
                Session["Carrito"] = carrito;

                ActualizarCarrito();
            }
        }
        // Método para actualizar el GridView del carrito y el total
        private void ActualizarCarrito()
        {
            List<ProductoHardcodeado> carrito = (List<ProductoHardcodeado>)Session["Carrito"];
            gvCarrito.DataSource = carrito;
            gvCarrito.DataBind();

            int total = carrito.Sum(p => p.Precio);
            lblTotal.Text = $"Total: {total:C}";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            List<ProductoHardcodeado> carrito = (List<ProductoHardcodeado>)Session["Carrito"];
            if (carrito.Count == 0)
            {
                ShowMessage("Ingrese productos al carrito para pagar");
            }
            else
            {
                Response.Redirect("Pago.aspx");
            }          
        }
        //funcion para mostrar mensajes
        private void ShowMessage(string message)
        {
            string script = $"alert('{message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("User.aspx");
        }
    }
}