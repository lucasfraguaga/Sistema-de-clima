CREATE DATABASE web;
GO
/****** Crea la bd, despues hacer el resto del script en la query de la bd web  ******/
USE [web]
GO
/****** Object:  Table [dbo].[Bitacora]    Script Date: 8/6/2024 18:01:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bitacora](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NULL,
	[Fecha] [datetime] NULL,
	[Mensaje] [nvarchar](400) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 8/6/2024 18:01:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[usuario] [nvarchar](50) NOT NULL,
	[contrasena] [nvarchar](255) NOT NULL,
	[roll] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bitacora] ON 

INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (1, 1, CAST(N'2024-06-04T22:13:50.903' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (2, 1, CAST(N'2024-06-04T22:29:42.200' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (3, 1, CAST(N'2024-06-04T22:31:00.343' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (4, 1, CAST(N'2024-06-04T22:31:02.510' AS DateTime), N'deslogeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (5, 1, CAST(N'2024-06-05T00:14:51.173' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (6, 1, CAST(N'2024-06-05T00:16:47.573' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (7, 1, CAST(N'2024-06-05T00:16:50.933' AS DateTime), N'deslogeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (8, 1, CAST(N'2024-06-05T00:20:01.270' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (9, 1, CAST(N'2024-06-05T00:20:24.483' AS DateTime), N'deslogeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (10, 1, CAST(N'2024-06-07T12:11:46.327' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (11, 1, CAST(N'2024-06-07T12:13:00.060' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (12, 1, CAST(N'2024-06-07T12:13:06.120' AS DateTime), N'deslogeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (13, 1, CAST(N'2024-06-07T12:13:51.990' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (14, 1, CAST(N'2024-06-07T12:14:07.560' AS DateTime), N'deslogeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (15, 1, CAST(N'2024-06-07T14:27:52.323' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (16, 1, CAST(N'2024-06-07T14:38:12.783' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (17, 1, CAST(N'2024-06-07T14:38:31.637' AS DateTime), N'deslogeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (18, 1, CAST(N'2024-06-07T14:46:06.370' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (19, 1, CAST(N'2024-06-07T14:46:14.303' AS DateTime), N'deslogeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (20, 1, CAST(N'2024-06-08T17:15:39.413' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (21, 1, CAST(N'2024-06-08T17:19:38.657' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (22, 1, CAST(N'2024-06-08T17:20:57.223' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (23, 1, CAST(N'2024-06-08T17:21:48.903' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (24, 1, CAST(N'2024-06-08T17:23:39.477' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (25, 1, CAST(N'2024-06-08T17:25:25.010' AS DateTime), N'logeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (27, 1, CAST(N'2024-06-08T17:39:45.863' AS DateTime), N'logeo de sesion admin')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (28, 1, CAST(N'2024-06-08T17:44:33.293' AS DateTime), N'logeo de sesion admin')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (29, 1, CAST(N'2024-06-08T17:45:33.953' AS DateTime), N'logeo de sesion admin')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (30, 1, CAST(N'2024-06-08T17:45:48.323' AS DateTime), N'deslogeo de sesion')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje]) VALUES (31, 4, CAST(N'2024-06-08T17:54:00.097' AS DateTime), N'logeo de sesion usuario')
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id]) VALUES (N'lucas', N'47ef20207489b775fa4cdcac3c394b517ab22d7460237ae3df1ac0e8963699d6', 1, 1)
INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id]) VALUES (N'santiago', N'564f3c99bd7a44e00b9fbc20f1133b2573e812fa8318899e6c1032235b2245e2', 2, 4)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [validacionUsuario]    Script Date: 8/6/2024 18:01:08 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [validacionUsuario] UNIQUE NONCLUSTERED 
(
	[usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bitacora]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([id])
GO
/****** Object:  StoredProcedure [dbo].[BuscarUsuario]    Script Date: 8/6/2024 18:01:08 ******/
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
/****** Object:  StoredProcedure [dbo].[guardarUsuario]    Script Date: 8/6/2024 18:01:08 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertarBitacora]    Script Date: 8/6/2024 18:01:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarBitacora]
    @idUsuario INT,
    @fecha DATETIME,
    @mensaje NVARCHAR(400)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Bitacora (idUsuario, fecha, mensaje)
    VALUES (@idUsuario, @fecha, @mensaje);
END;
GO
/****** Object:  StoredProcedure [dbo].[ListarBitacora]    Script Date: 8/6/2024 18:01:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarBitacora]
AS
BEGIN
    -- Selecciona todas las filas de la tabla Bitacora
    -- y las ordena de forma descendente por el campo Fecha
    SELECT *
    FROM Bitacora
    ORDER BY Fecha DESC;
END;
GO
