using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BE;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.Configuration;
using System.Threading.Tasks;
using System.Web.UI;
using System.Security.Permissions;
using System.Data;

namespace DAL
{
    public class Conexion
    {
        //conexionstring de la base principal
        private string GetConnectionString()
        {
            var cs = new SqlConnectionStringBuilder();
            cs.IntegratedSecurity = true;
            cs.DataSource = @"LACUCA\SQLEXPRESS";
            cs.InitialCatalog = "web";
            return cs.ConnectionString;
        }
        //conexion string de la base master
        private string GetConnectionStringMaster()
        {
            var cs = new SqlConnectionStringBuilder();
            cs.IntegratedSecurity = true;
            cs.DataSource = @"LACUCA\SQLEXPRESS";
            cs.InitialCatalog = "master";
            return cs.ConnectionString;
        }
        //guardado de usuario con store procedure
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
        //logica para traer un usuario
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
                        bool bloqueado = reader.GetBoolean(4);
                        int intentos = reader.GetInt32(5);
                        //if (nombreUsuario == nom && contrasena == con)
                        //{
                        Usuario usu = new Usuario();
                        usu.Usu = nombreUsuario;
                        usu.Contrasena = contrasena;
                        usu.Roll = roll;
                        usu.Id = id;
                        usu.bloqueado = bloqueado;
                        usu.intentos = intentos;
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
        //logica para insertar en bitacora con store procedure
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
        //logica pra insertar bitacora con store procedure
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
        //logica para listar todos los usuarios
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
                        usu.bloqueado = reader.GetBoolean(6);
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
        //logica para insertar un usuario con store procedure
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
        //logica para generar el backup, asiganamos en que ruta se guarda el backup
        public bool generarBackup()
        {
            string backupPath = @"C:\Users\lucas\Desktop\GIT\web.bak"; //direccion de guardado de backup
            string connectionString = GetConnectionString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("BackupDatabase", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@backupPath", backupPath);

                    // Aumentar el tiempo de espera del comando a 600 segundos (10 minutos) ya que puede tirar time out
                    command.CommandTimeout = 600;

                    try
                    {
                        connection.Open();


                        command.ExecuteNonQuery();                       
                        return true;
                    }
                    catch (Exception ex)
                    {
   
                        return false;
                    }
                }
            }
        }
        //logica para restar la base
        public bool restaurarBase()
        {
            string backupPath = @"C:\Users\lucas\Desktop\GIT\web.bak"; // direccion donde esta el backup
            string connectionString = GetConnectionStringMaster();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("RestoreDatabase", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@backupPath", backupPath);

                    // Aumentar el tiempo de espera del comando a 600 segundos (10 minutos) por posible time out
                    command.CommandTimeout = 600;

                    try
                    {
                        connection.Open();

                        command.ExecuteNonQuery();
                        return true;
                    }
                    catch (Exception ex)
                    {

                        return false;
                    }
                }
            }
        }
        //logica para incrementar los intentos fallidos de un usuario
        public void IncrementarIntentosFallidos(Usuario usu)
        {
            try
            {
                var cnn = new SqlConnection(GetConnectionString());
                cnn.Open();
                var cmd = new SqlCommand("IncrementarIntentosFallidos");
                cmd.Connection = cnn;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                cmd.Parameters.Add(new SqlParameter("usuarioId", usu.Id));


                var id = cmd.ExecuteScalar();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        //logica para reiniciar los fallos e intentos de un usuario como el bloqueo
        public bool ReiniciarIntentosFallidos(Usuario usu)
        {
            bool success = false;
            try
            {
                string connectionString = GetConnectionString(); // Obtener cadena de conexión

                using (SqlConnection cnn = new SqlConnection(connectionString))
                {
                    cnn.Open();

                    SqlCommand cmd = new SqlCommand("ReiniciarIntentosFallidos", cnn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Parámetro de entrada
                    cmd.Parameters.AddWithValue("@usuarioId", usu.Id);

                    // Parámetro de salida
                    SqlParameter successParam = new SqlParameter("@success", SqlDbType.Bit);
                    successParam.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(successParam);

                    // Ejecutar el comando
                    cmd.ExecuteNonQuery();

                    // Obtener el valor de retorno
                    success = (bool)successParam.Value;
                }
            }
            catch (Exception e)
            {
                throw e;
            }

            return success;
        }
    }
}