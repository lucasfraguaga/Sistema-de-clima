using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BE;
using static UI.CarritoCompra;

namespace UI
{
    public partial class Pago : System.Web.UI.Page
    {
        List<ProductoHardcodeado> productos;
        WebServicePago webservicePago = new WebServicePago();
        BLLConexion conexion = new BLLConexion();
        protected void Page_Load(object sender, EventArgs e)
        {
            // instancia de usuario a mostrar  
            Label1.Text = BLLSesionManager.GetInstance.Usuario.Usu;
            if (!IsPostBack)
            {
                // Cargar productos seleccionados en el GridView
                productos = (List<ProductoHardcodeado>)Session["Carrito"];
                gvProductosSeleccionados.DataSource = productos;
                gvProductosSeleccionados.DataBind();
            }
        }
        
        protected void btnConfirmarPago_Click(object sender, EventArgs e)
        {
            List<ProductoHardcodeado> carrito = (List<ProductoHardcodeado>)Session["Carrito"];
            int total = carrito.Sum(p => p.Precio);
            if (ValidarFormulario())
            {
                if (webservicePago.ValidarPago(txtNombreTarjeta.Text, txtNumeroTarjeta.Text, txtFechaExpiracion.Text, txtCVV.Text, total))
                {
                    // Aquí podrías procesar el pago o llamar a un servicio de pago externo
                    lblMensaje.Text = "Pago realizado con éxito.";
                    int idVenta = conexion.InsertarVenta(BLLSesionManager.GetInstance.Usuario.Id, total);
                    foreach (var item in carrito)
                    {
                        conexion.InsertarVentaxProducto(idVenta, item.Id, item.Precio);
                        conexion.InsertarUsuarioxProducto(BLLSesionManager.GetInstance.Usuario.Id, item.Id);
                    }
                    lblMensaje.ForeColor = System.Drawing.Color.Green;
                    string script = "window.onload = function(){ alert('Pago realizado con éxito.'); window.location.href = 'User.aspx'; }";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
                else
                {
                    lblMensaje.Text = "Pago rechazado, valide los datos.";
                }
            }
            else
            {
                lblMensaje.Text = "Por favor, completa todos los campos correctamente.";
            }      
        }
        // Validar que los campos del formulario estén completos
        private bool ValidarFormulario()
        {
            if (string.IsNullOrEmpty(txtNombreTarjeta.Text) ||
                string.IsNullOrEmpty(txtNumeroTarjeta.Text) ||
                string.IsNullOrEmpty(txtFechaExpiracion.Text) ||
                string.IsNullOrEmpty(txtCVV.Text))
            {
                return false;
            }

            // Validar que el número de tarjeta y CVV contengan solo números
            if (!long.TryParse(txtNumeroTarjeta.Text, out _) ||
                !int.TryParse(txtCVV.Text, out _))
            {
                return false;
            }

            return true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("User.aspx");
        }
    }
}