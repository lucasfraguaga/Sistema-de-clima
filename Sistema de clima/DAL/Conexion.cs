using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BE;
using System.Data.SqlClient;
using System.Drawing;

namespace DAL
{
    public class Conexion
    {
        private string GetConnectionString()
        {
            var cs = new SqlConnectionStringBuilder();
            cs.IntegratedSecurity = true;
            cs.DataSource = @"LACUCA\SQLEXPRESS";
            cs.InitialCatalog = "web";
            return cs.ConnectionString;
        }

        public void guardarUsuario(string nom, string con)
        {
            try
            {
                var cnn = new SqlConnection(GetConnectionString());
                cnn.Open();
                var cmd = new SqlCommand("guardarUsuario");
                cmd.Connection = cnn;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                cmd.Parameters.Add(new SqlParameter("nombre", nom));
                cmd.Parameters.Add(new SqlParameter("contrasena", con));

                var id = cmd.ExecuteScalar();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public Usuario validadUsuario(string nom, string con)
        {
            try
            {
                var cnn = new SqlConnection(GetConnectionString());
                cnn.Open();
                var cmd = new SqlCommand("BuscarUsuario");
                cmd.Connection = cnn;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                cmd.Parameters.Add(new SqlParameter("nombre", nom));

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string nombreUsuario = reader.GetString(0);
                        string contrasena = reader.GetString(1);
                        int roll = reader.GetInt32(2);
                        int id = reader.GetInt32(3);
                        //if (nombreUsuario == nom && contrasena == con)
                        //{
                        Usuario usu = new Usuario();
                        usu.Usu = nombreUsuario;
                        usu.Contrasena = contrasena;
                        usu.Roll = roll;
                        usu.Id = id;
                        return usu;
                        //}
                        //else
                        //{
                        //    return null;
                        //}
                    }
                    else
                    {
                        Console.WriteLine("Usuario no encontrado.");
                        return null;
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void insertarBitacora(Usuario usu, string mensaje)
        {
            try
            {
                var cnn = new SqlConnection(GetConnectionString());
                cnn.Open();
                var cmd = new SqlCommand("InsertarBitacora");
                cmd.Connection = cnn;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                cmd.Parameters.Add(new SqlParameter("idUsuario", usu.Id));
                cmd.Parameters.Add(new SqlParameter("mensaje", mensaje));
                cmd.Parameters.Add(new SqlParameter("fecha", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));


                var id = cmd.ExecuteScalar();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public List<Bitacora> listarBitacora()
        {
            List<Bitacora> listBit = new List<Bitacora>();
            try
            {
                var cnn = new SqlConnection(GetConnectionString());
                cnn.Open();
                var cmd = new SqlCommand("ListarBitacora");
                cmd.Connection = cnn;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
           

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Bitacora bitacora = new Bitacora();
                        bitacora.ID = reader.GetInt32(0);
                        bitacora.IdUsuario = reader.GetInt32(1);
                        bitacora.Fecha = reader.GetDateTime(2);
                        bitacora.Mensaje = reader.GetString(3);
                        bitacora.Corrupta = reader.GetString(5);
                        listBit.Add(bitacora);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return listBit;
        }
        public List<Usuario> ListarUsuarios()
        {
            List<Usuario> listBit = new List<Usuario>();
            try
            {
                var cnn = new SqlConnection(GetConnectionString());
                cnn.Open();
                var cmd = new SqlCommand("ListarUsuarios");
                cmd.Connection = cnn;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Usuario usu = new Usuario();
                        usu.Usu = reader.GetString(0);
                        usu.Contrasena = reader.GetString(1);
                        usu.Roll = reader.GetInt32(2);
                        usu.Id = reader.GetInt32(3);
                        usu.Corrupto = reader.GetString(5);
                        listBit.Add(usu);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return listBit;
        }

        public void insertarUsuario(Usuario usu)
        {
            try
            {
                var cnn = new SqlConnection(GetConnectionString());
                cnn.Open();
                var cmd = new SqlCommand("RegistrarUsuario");
                cmd.Connection = cnn;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                cmd.Parameters.Add(new SqlParameter("nombre", usu.Usu));
                cmd.Parameters.Add(new SqlParameter("contraseña", usu.Contrasena));
                cmd.Parameters.Add(new SqlParameter("roll", usu.Roll));


                var id = cmd.ExecuteScalar();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}