USE [master]
GO
/****** Object:  Database [web]    Script Date: 11/7/2024 01:04:28 ******/
CREATE DATABASE [web]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'web', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\web.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'web_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\web_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [web] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [web].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [web] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [web] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [web] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [web] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [web] SET ARITHABORT OFF 
GO
ALTER DATABASE [web] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [web] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [web] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [web] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [web] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [web] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [web] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [web] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [web] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [web] SET  DISABLE_BROKER 
GO
ALTER DATABASE [web] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [web] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [web] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [web] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [web] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [web] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [web] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [web] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [web] SET  MULTI_USER 
GO
ALTER DATABASE [web] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [web] SET DB_CHAINING OFF 
GO
ALTER DATABASE [web] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [web] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [web] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [web] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [web] SET QUERY_STORE = ON
GO
ALTER DATABASE [web] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [web]
GO
/****** Object:  UserDefinedFunction [dbo].[CalcularChecksum]    Script Date: 11/7/2024 01:04:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalcularChecksum]
(
    @nombre NVARCHAR(100),
    @contraseña NVARCHAR(250),
    @roll INT
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @Checksum NVARCHAR(100);

    -- Lógica para calcular el checksum (puedes ajustar según tus necesidades)
    SET @Checksum = HASHBYTES('SHA2_256', CONCAT(@nombre, @contraseña, @roll));

    RETURN @Checksum;
END;

GO
/****** Object:  UserDefinedFunction [dbo].[CalcularChecksumBitacora]    Script Date: 11/7/2024 01:04:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Crear la función para calcular el checksum de Bitacora
CREATE FUNCTION [dbo].[CalcularChecksumBitacora]
(
    @idUsuario INT,
    @fecha DATETIME,
    @mensaje NVARCHAR(400)
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @Checksum NVARCHAR(100);

    -- Lógica para calcular el checksum (puedes ajustar según tus necesidades)
    SET @Checksum = HASHBYTES('SHA2_256', CONCAT(CAST(@idUsuario AS NVARCHAR), CONVERT(NVARCHAR, @fecha, 121), @mensaje));

    RETURN @Checksum;
END;
GO
/****** Object:  Table [dbo].[Bitacora]    Script Date: 11/7/2024 01:04:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bitacora](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NULL,
	[Fecha] [datetime] NULL,
	[Mensaje] [nvarchar](400) NULL,
	[Checksum] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 11/7/2024 01:04:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[usuario] [nvarchar](50) NOT NULL,
	[contrasena] [nvarchar](255) NOT NULL,
	[roll] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Checksum] [nvarchar](100) NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bitacora] ON 

INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (209, 8, CAST(N'2024-07-11T01:02:29.000' AS DateTime), N'logeo de sesion admin', N'រ與࡯睩㈩鮛決ׯྣᱬ䠋琈甸ᄠ䄥')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (210, 9, CAST(N'2024-07-11T01:02:31.000' AS DateTime), N'pantalla de usuarios abierta', N'掸盼튢䯨劯㵞ᶚ휷顺㝱盼�尞橊')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (211, 9, CAST(N'2024-07-11T01:02:32.000' AS DateTime), N'vuelta a la pantalla de admin', N'К್ᬱ暦酑쟀♨➜᳨됩봁⧱Ὠ豺ਯ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (212, 9, CAST(N'2024-07-11T01:02:33.000' AS DateTime), N'pantalla de usuarios abierta', N'ஸ뚙Ⲇ诗⏼앀侜鵓弍୫뚀둰음ਟ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (213, 9, CAST(N'2024-07-11T01:02:34.000' AS DateTime), N'vuelta a la pantalla de admin', N'꼾곃쯓ᐶꮏ醤ᤝ귬刉賔Ｊ핿↰䉜⣤')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (214, 9, CAST(N'2024-07-11T01:02:58.000' AS DateTime), N'pantalla de usuarios abierta', N'먇뵭髲�㓊숟Ǽ붝鎊냙鈂㝪ᒁ헧蕝㡜')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (215, 9, CAST(N'2024-07-11T01:03:00.000' AS DateTime), N'vuelta a la pantalla de admin', N'㵙䟼蠽ག獗䁺떪┤铙�Ȕ鯟牾Ꟗ杅罦')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (216, 9, CAST(N'2024-07-11T01:03:05.000' AS DateTime), N'deslogeo de sesion admin', N'䷵�㶜퇋㳈륩ﴌ툿抇踳衧㡬堐ꑳ')
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum]) VALUES (N'bitacora', N'47ef20207489b775fa4cdcac3c394b517ab22d7460237ae3df1ac0e8963699d6', 1, 8, N'ႇӊ�ព괗ᰊ�哬僘숚넉ꃍ⨮猏轇㞚')
INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum]) VALUES (N'lucas', N'47ef20207489b775fa4cdcac3c394b517ab22d7460237ae3df1ac0e8963699d6', 1, 9, N'ᄅ醧⋡䒖ぬ왉퇅介鍄倻ㆬ絲꺙㨐㜢')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [validacionUsuario]    Script Date: 11/7/2024 01:04:28 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [validacionUsuario] UNIQUE NONCLUSTERED 
(
	[usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bitacora]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([id])
GO
/****** Object:  StoredProcedure [dbo].[BuscarUsuario]    Script Date: 11/7/2024 01:04:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarUsuario]
    @nombre NVARCHAR(50)
AS
BEGIN
    SELECT usuario, contrasena, roll, id
    FROM Usuario
    WHERE usuario = @nombre;
END;
GO
/****** Object:  StoredProcedure [dbo].[guardarUsuario]    Script Date: 11/7/2024 01:04:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[guardarUsuario]
    @nombre NVARCHAR(50),
    @contrasena NVARCHAR(50)
AS
BEGIN
    INSERT INTO Usuario (usuario, contrasena)
    VALUES (@nombre, @contrasena);
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarBitacora]    Script Date: 11/7/2024 01:04:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Modificar el procedimiento almacenado InsertarBitacora para incluir el checksum
CREATE PROCEDURE [dbo].[InsertarBitacora]
    @idUsuario INT,
    @fecha DATETIME,
    @mensaje NVARCHAR(400)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @checksum NVARCHAR(100);

    -- Calcular el checksum usando la función CalcularChecksumBitacora
    SET @checksum = dbo.CalcularChecksumBitacora(@idUsuario, @fecha, @mensaje);

    -- Insertar el registro en la tabla Bitacora incluyendo el dígito verificador calculado
    INSERT INTO Bitacora (idUsuario, fecha, mensaje, Checksum)
    VALUES (@idUsuario, @fecha, @mensaje, @checksum);
END;
GO
/****** Object:  StoredProcedure [dbo].[ListarBitacora]    Script Date: 11/7/2024 01:04:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Modificar el procedimiento almacenado ListarBitacora
CREATE PROCEDURE [dbo].[ListarBitacora]
AS
BEGIN
    SELECT 
        id,
        idUsuario,
        fecha,
        mensaje,
        Checksum,
        CASE WHEN Checksum = dbo.CalcularChecksumBitacora(idUsuario, Fecha, Mensaje) THEN 'false' ELSE 'true' END AS Corrupto
    FROM Bitacora
    ORDER BY id DESC;
END;


GO
/****** Object:  StoredProcedure [dbo].[ListarUsuarios]    Script Date: 11/7/2024 01:04:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarUsuarios]
AS
BEGIN
    -- Seleccionar todos los usuarios y verificar si están corruptos
    SELECT 
        usuario,
        contrasena,
        roll,
		id,
        Checksum,
        CASE WHEN Checksum = dbo.CalcularChecksum(usuario, contrasena, roll) THEN 'false' ELSE 'true' END AS Corrupto
    FROM 
        Usuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[RegistrarUsuario]    Script Date: 11/7/2024 01:04:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegistrarUsuario]
    @nombre NVARCHAR(100),
    @contraseña NVARCHAR(250),
    @roll INT
AS
BEGIN
    DECLARE @Checksum NVARCHAR(100);

    -- Insertar el nuevo usuario en la tabla Usuario
    INSERT INTO Usuario (usuario, contrasena, roll)
    VALUES (@nombre, @contraseña, @roll);

    -- Calcular el checksum (puedes ajustar la lógica según tus necesidades)
    SET @Checksum = HASHBYTES('SHA2_256', CONCAT(@nombre, @contraseña, @roll));

    -- Actualizar el campo Checksum en la misma fila
    UPDATE Usuario
    SET Checksum = @Checksum
    WHERE usuario = @nombre; -- Aquí deberías tener una condición única para identificar al usuario

    -- Puedes incluir más lógica aquí si es necesario

    -- Ejemplo de salida (puedes personalizar según tus necesidades)
    SELECT 'Usuario registrado exitosamente' AS Mensaje;
END;

GO
USE [master]
GO
ALTER DATABASE [web] SET  READ_WRITE 
GO
