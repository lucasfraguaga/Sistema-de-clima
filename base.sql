USE [master]
GO
/****** Object:  Database [web]    Script Date: 18/10/2024 16:20:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[CalcularChecksum]    Script Date: 18/10/2024 16:20:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[CalcularChecksumBitacora]    Script Date: 18/10/2024 16:20:02 ******/
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 18/10/2024 16:20:02 ******/
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
/****** Object:  Table [dbo].[Producto]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[precio] [int] NOT NULL,
	[descripcion] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 18/10/2024 16:20:03 ******/
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
	[IntentosFallidos] [int] NOT NULL,
	[UltimoIntento] [datetime] NULL,
	[CuentaBloqueada] [bit] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioxProducto]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioxProducto](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[Precio] [int] NOT NULL,
 CONSTRAINT [PK_Venta] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VentaxProducto]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VentaxProducto](
	[IdVenta] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Precio] [int] NOT NULL,
 CONSTRAINT [PK_VentaxProducto] PRIMARY KEY CLUSTERED 
(
	[IdVenta] ASC,
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bitacora] ON 

INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (211, 9, CAST(N'2024-07-11T01:02:32.000' AS DateTime), N'vuelta a la pantalla de admin', N'К್ᬱ暦酑쟀♨➜᳨됩봁⧱Ὠ豺ਯ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (212, 9, CAST(N'2024-07-11T01:02:33.000' AS DateTime), N'pantalla de usuarios abierta', N'ஸ뚙Ⲇ诗⏼앀侜鵓弍୫뚀둰음ਟ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (213, 9, CAST(N'2024-07-11T01:02:34.000' AS DateTime), N'vuelta a la pantalla de admin', N'꼾곃쯓ᐶꮏ醤ᤝ귬刉賔Ｊ핿↰䉜⣤')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (214, 9, CAST(N'2024-07-11T01:02:58.000' AS DateTime), N'pantalla de usuarios abierta', N'먇뵭髲�㓊숟Ǽ붝鎊냙鈂㝪ᒁ헧蕝㡜')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (215, 9, CAST(N'2024-07-11T01:03:00.000' AS DateTime), N'vuelta a la pantalla de admin', N'㵙䟼蠽ག獗䁺떪┤铙�Ȕ鯟牾Ꟗ杅罦')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (216, 9, CAST(N'2024-07-11T01:03:05.000' AS DateTime), N'deslogeo de sesion admin', N'䷵�㶜퇋㳈륩ﴌ툿抇踳衧㡬堐ꑳ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (217, 9, CAST(N'2024-07-11T21:50:25.000' AS DateTime), N'logeo de sesion admin', N'嗹ꄁﺲ鲴벡嗟궴砙ׯ꼶Ὠ띙㿴꬯⫵⧦')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (218, 9, CAST(N'2024-07-11T21:50:29.000' AS DateTime), N'pantalla de usuarios abierta', N'╰ﱚᎢ㧏塭媝偕羷ꤘ꯮盲ᡧ䴔�嶡')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (219, 9, CAST(N'2024-07-11T21:50:34.000' AS DateTime), N'vuelta a la pantalla de admin', N'ᳳ䕆쭮᎛⮆ᤃ�࡛棸鹧㟀�伏響ꭤ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (220, 9, CAST(N'2024-07-11T21:51:20.000' AS DateTime), N'logeo de sesion admin', N'쯥ﲆ賧繌휑狂ၣ埾袽碏嶻䅋')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (221, 9, CAST(N'2024-07-11T21:51:23.000' AS DateTime), N'pantalla de usuarios abierta', N'珛窻➳浕㵝뭋멃ꀴ㖆릡쮪殮켽䛍')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (222, 9, CAST(N'2024-07-11T21:51:25.000' AS DateTime), N'vuelta a la pantalla de admin', N'껠ꏏ퍛쁲驅㸌ﺩ䔕퓏炷ꗍᒤ흽ᾚ踱Ѩ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (223, 9, CAST(N'2024-07-11T21:51:26.000' AS DateTime), N'se genero un backup de la base de datos', N'舶咩⫓毽똺᳚贕赿ꅰ؃匐肋ᙍ寥퓡䗳')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (224, 9, CAST(N'2024-07-11T21:57:57.000' AS DateTime), N'logeo de sesion admin', N'⹃㽭ꢱᖒꄅᯚ㡃峧맜䮽牤ೖ⢯恁뾊⿯')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (225, 9, CAST(N'2024-07-11T22:53:59.000' AS DateTime), N'logeo de sesion admin', N'븕า찮ⓡ죯⊜졹棰옒礓㬶砓궯')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (226, 9, CAST(N'2024-07-11T22:55:25.000' AS DateTime), N'pantalla de usuarios abierta', N'匂猥瑄ꭆꩰ嘏窻㓩㣉彣奾괕楥춫턂苃')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (227, 9, CAST(N'2024-07-11T22:55:27.000' AS DateTime), N'vuelta a la pantalla de admin', N'촳﹣뿇㙕ꑚ뉩⼑ᗳ᮫祁䇷䓄༨')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (228, 9, CAST(N'2024-07-11T22:55:29.000' AS DateTime), N'pantalla de usuarios abierta', N'襞譥车퍿䀥幪崀䕉竑័遑ў㯔セ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (229, 9, CAST(N'2024-07-11T22:55:30.000' AS DateTime), N'vuelta a la pantalla de admin', N'醱뛰惗ᰁ㠕�䡗疨뛊懅︆餥⃪⭔Ĩ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (230, 9, CAST(N'2024-07-11T22:56:33.000' AS DateTime), N'logeo de sesion admin', N'㸯于騽躞렓릃쟢ࡡ瀦廬텣쐀㤙㋾')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (231, 9, CAST(N'2024-07-11T22:57:44.000' AS DateTime), N'pantalla de usuarios abierta', N'潪ྺភꖁ⦨濢遇╙㉬緸臇Ѻꕙ적㕭ᝩ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (232, 9, CAST(N'2024-07-11T22:57:46.000' AS DateTime), N'vuelta a la pantalla de admin', N'빡㘧໘檐쥇㧷ꇡ৾啇꣩徹縤碉橱')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (233, 9, CAST(N'2024-07-11T22:57:49.000' AS DateTime), N'pantalla de usuarios abierta', N'燽シ༝㇇⍾ꕩ젂駽㞆쑨牳佗㎻ꍁ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (234, 9, CAST(N'2024-07-11T22:57:50.000' AS DateTime), N'vuelta a la pantalla de admin', N'綸劝䋴簚蹐ꍘ旾뽙ﯶ꡶〧⢌⩵㍐')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (235, 9, CAST(N'2024-07-11T22:58:32.000' AS DateTime), N'pantalla de usuarios abierta', N'㴸ʸﰂ肼퇙釋캖⓯㎜ꬨ⎉跠輚鯇')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (236, 9, CAST(N'2024-07-11T22:58:34.000' AS DateTime), N'vuelta a la pantalla de admin', N'ᇿ쌬冈㟾�刺ᴃ軇׋俻﹊椂ꊃ枱䞕')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (237, 9, CAST(N'2024-07-11T22:58:35.000' AS DateTime), N'pantalla de usuarios abierta', N'䅫몑㭞穘黙�奘긞Ꮋᄊꈂ벤튱굜縺')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (238, 9, CAST(N'2024-07-11T22:58:37.000' AS DateTime), N'vuelta a la pantalla de admin', N'赓︊ꯦ쏣뚓ꄮ쿧钥桔䢚忈蛎㖆')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (239, 9, CAST(N'2024-07-11T23:20:49.000' AS DateTime), N'logeo de sesion admin', N'Ɵ都ꭣ楉褵쵥幯仄憙Ꝼ큊�嫞ፒ藶戯')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (240, 9, CAST(N'2024-07-12T01:18:22.000' AS DateTime), N'se restauro la base a la ultima version disponible', N'耫筽訄ᗞ賑熴◬茦吆垧䔶楿䢂쓜䕒')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (241, 9, CAST(N'2024-07-12T01:18:24.000' AS DateTime), N'pantalla de usuarios abierta', N'�訮�㩥､俏렵ꙕᓞ᪂ὠ넀瑮௔')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (242, 9, CAST(N'2024-07-12T01:18:26.000' AS DateTime), N'vuelta a la pantalla de admin', N'쭹䐌퐈跞深偂㫆熕�✎倯㈛')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (243, 9, CAST(N'2024-07-12T01:18:29.000' AS DateTime), N'pantalla de usuarios abierta', N'舀银萂撶早裰擎୤ࡆꁂ㨎ӟ싈Щ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (244, 9, CAST(N'2024-07-12T01:18:32.000' AS DateTime), N'vuelta a la pantalla de admin', N'좈☋谄၇쵔ꛠ㴰ᷡ넴ኲ眀ᛋ뗆')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (245, 9, CAST(N'2024-07-12T01:18:34.000' AS DateTime), N'deslogeo de sesion admin', N'侪䡝娭ጞꟹ䗄�뇾煙ꂇꈬ⪐誆殦')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (246, 8, CAST(N'2024-07-13T00:47:29.000' AS DateTime), N'ingreso a pantalla de registro', N'됴쁭춃⬾ꮓ몐˖妢況엋鶳ᶫᨆ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (247, 8, CAST(N'2024-07-13T00:47:31.000' AS DateTime), N'vuelta de pantalla de registro sin registrar', N'듀뇨赥朋ꗐ꼱☌鼾뭱�㾛ⱟ⃤ꂉ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (248, 9, CAST(N'2024-07-13T01:09:16.000' AS DateTime), N'logeo de sesion admin', N'䯪�벞�⏵ﷹ諾둳ֵ㒇紗♀欋䕂ᴩ೰')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (249, 9, CAST(N'2024-07-14T17:58:05.000' AS DateTime), N'se restauro la base a la ultima version disponible', N'㷧뙱㎯긄컥쩅쓃᡻向㦠뭽ኍ逯漺큣Ѭ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (250, 9, CAST(N'2024-07-14T18:02:25.000' AS DateTime), N'logeo de sesion admin', N'轩왿㞚陳䬩㍿퓕✺伥⁈䢽蒸啸ⷑꍻ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (251, 9, CAST(N'2024-07-14T18:03:35.000' AS DateTime), N'logeo de sesion admin', N'壩ⱱ씏뵯皹ఛ呫뻙ᨎﮙ灎微ᒆᥛ翍艾')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (252, 9, CAST(N'2024-07-14T18:03:38.000' AS DateTime), N'pantalla de usuarios abierta', N'Ƭ뉥꜠뱉ʔﯱᘛⰧ�ⶻᄾ꽞䳉搣ꇵ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (253, 9, CAST(N'2024-07-14T18:03:39.000' AS DateTime), N'vuelta a la pantalla de admin', N'林䊀◬쨓ᡤ䭲玮⦌㙻᠅ ퟛ۲�ꣴ쬑')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (254, 9, CAST(N'2024-07-14T18:03:40.000' AS DateTime), N'pantalla de bitacora abierta', N'厺喘賅腫쪸㭎섅쯱⟶⨘撮ﲚ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (255, 9, CAST(N'2024-07-14T18:03:42.000' AS DateTime), N'vuelta a la pantalla de admin', N'桼䵵蔗坪绣뢃�ꢳ廜팜컷춪')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (256, 9, CAST(N'2024-07-14T18:03:44.000' AS DateTime), N'deslogeo de sesion admin', N'幯鿏◠윓쨾袿滤와ᷡ쫢뾕軃豭࣒')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (257, 9, CAST(N'2024-07-14T18:04:59.000' AS DateTime), N'contraseña incorrecta', N'ᚷ굳쌺돌ᔵ롤롯৒⁃ꊟŬ춤螃ⲗ뷠')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (258, 9, CAST(N'2024-07-14T18:05:02.000' AS DateTime), N'contraseña incorrecta', N'藑൒뉎Ꮷꥑ䓉ಓ垀㞼ᡕ恈쬋Ꝍ馚ᏺ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (259, 9, CAST(N'2024-07-14T18:05:05.000' AS DateTime), N'contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos', N'␲ᑄ䴏ꌪꎌﳣ᪟噾垻垻鶙侬ᛈ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (260, 8, CAST(N'2024-07-14T18:05:29.000' AS DateTime), N'logeo de sesion admin', N'妦觃䥞䃶薻ભ뽛걐㧑鯠숲ᬛ뜧믛땰')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (261, 8, CAST(N'2024-07-14T18:05:32.000' AS DateTime), N'pantalla de usuarios abierta', N'茳蕬筵Ⓜ俸ᚽ귗꟔幓єﶼ躷멤㷔輿')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (262, 8, CAST(N'2024-07-14T18:05:38.000' AS DateTime), N'se quito el bloqueo del usuario9', N'ꜭᶈ㎧ɿ㼱湨鵞ﱌ⚬㟓㵖ॿ媮檼䱦�')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (263, 8, CAST(N'2024-07-14T18:05:54.000' AS DateTime), N'vuelta a la pantalla de admin', N'鮴瀣꯷繒隥鶽啪�뙩⧧➗講귻ᵵ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (264, 9, CAST(N'2024-07-15T17:16:39.000' AS DateTime), N'logeo de sesion admin', N'拼ꢼꦊ쮽躴䷻䐓ާ襳雛笢칱⤳擣䞮')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (265, 9, CAST(N'2024-07-15T17:16:42.000' AS DateTime), N'pantalla de usuarios abierta', N'ﳻ䱀ロῡ䵱輀䬕幥Ҿ྅⤗')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (266, 9, CAST(N'2024-07-15T17:16:46.000' AS DateTime), N'vuelta a la pantalla de admin', N'潻埭馓婪貽⣿奾ꨱ勞囝ᥔ䀚객')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (267, 9, CAST(N'2024-07-15T17:16:48.000' AS DateTime), N'deslogeo de sesion admin', N'≏韝ി館륩ა쥜穄ꂪ觷忴뇆၀')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (268, 9, CAST(N'2024-07-15T17:16:56.000' AS DateTime), N'contraseña incorrecta', N'則簃탽펲볉㤓ꮚ⤕⸾욵ಥ墡撴ͫ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (269, 9, CAST(N'2024-07-15T17:16:59.000' AS DateTime), N'contraseña incorrecta', N'鳕鵳ᛶ若옮剛�럙ງ럇뽢빛�曭')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (270, 9, CAST(N'2024-07-15T17:17:01.000' AS DateTime), N'contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos', N'膃ᜪጱꀙ‰䬙闬坕䧢体뭲䊊�')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (271, 8, CAST(N'2024-07-15T17:17:08.000' AS DateTime), N'logeo de sesion admin', N'斪ᷝヨ瑕惔㤑혃��뚰Ś䱨硝ꔬ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (272, 8, CAST(N'2024-07-15T17:17:11.000' AS DateTime), N'pantalla de usuarios abierta', N'鹥ꖬ칞⟫ㅀ림鑗厱팎⟣ጠ쮡ㅔ薺䢉')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (273, 8, CAST(N'2024-07-15T17:17:16.000' AS DateTime), N'se quito el bloqueo del usuario8', N'徖䆞꿃⼛㻴炔塾襪睇꾛麔䢅⟼䟀')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (274, 8, CAST(N'2024-07-15T17:17:26.000' AS DateTime), N'se quito el bloqueo del usuario9', N'窱飳胏Ꝫ꿃쬄ᱴ랫৚₷ᛓ竓㹓욥榎獳')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (275, 8, CAST(N'2024-07-15T17:17:28.000' AS DateTime), N'vuelta a la pantalla de admin', N'ង㳯㉻㕎擵፫ऴ瓫燱꽞訓㕩☜贴ꓞ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (276, 8, CAST(N'2024-07-15T17:17:29.000' AS DateTime), N'se genero un backup de la base de datos', N'玛婔݀넗勺㊼ꊹ럟틔�ቯᘼ㴲뮐醷')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (277, 8, CAST(N'2024-07-15T17:17:47.000' AS DateTime), N'se restauro la base a la ultima version disponible', N'�ꄾ㮈螚楅甠樚鳈둜５甮쉏ኑ淝')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (278, 8, CAST(N'2024-07-15T17:17:50.000' AS DateTime), N'pantalla de usuarios abierta', N'㎐釜蹿ᕉὶࡉ瓴⧽샳㢻錁鷨붅揣퐚')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (279, 8, CAST(N'2024-07-15T17:17:52.000' AS DateTime), N'vuelta a la pantalla de admin', N'聱⬴蕾㖛흒퐊剟ᱨ沘ᵊ쫰ᥔ뺂મ嘊旳')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (280, 8, CAST(N'2024-07-15T17:17:54.000' AS DateTime), N'deslogeo de sesion admin', N'滒輘鬖◇䆋쭱챟攌豏뤍�炍ᖽᵿ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (281, 9, CAST(N'2024-07-15T17:17:58.000' AS DateTime), N'contraseña incorrecta', N'鮛칗ꤢ那힝ꣲ즥葨⚄隷뙕秂湷⚏')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (282, 9, CAST(N'2024-07-15T17:18:00.000' AS DateTime), N'contraseña incorrecta', N'퐺㱑겚䊅ᳵ鲥緆栒ₒ菉䱋酱ᇫ꒚')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (283, 9, CAST(N'2024-07-15T17:18:03.000' AS DateTime), N'contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos', N'権괇銯㸨搀뺅⨅㣎聩ꓻᷣ辝劙簂둡')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (284, 8, CAST(N'2024-07-15T17:18:08.000' AS DateTime), N'logeo de sesion admin', N'್臧ᅽ䂯쯵鑯뾢ᔠ헇Աジ㋳聏퉪㟩밐')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (285, 8, CAST(N'2024-07-15T17:18:12.000' AS DateTime), N'pantalla de usuarios abierta', N'‸Ꮋ끿�黉颈ꃎ㣼䫝䳢鎽딹ऌ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (286, 8, CAST(N'2024-07-15T17:18:16.000' AS DateTime), N'se quito el bloqueo del usuario9', N'菴轉lꪸￃ菧ꏁహ犚抖矣๰뚵뢊')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (287, 8, CAST(N'2024-07-15T17:18:18.000' AS DateTime), N'deslogeo de sesion admin', N'惶龃㌚လﶧ汥உ比䐛茎㮣跃쉩')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (288, 9, CAST(N'2024-07-18T19:43:49.000' AS DateTime), N'logeo de sesion admin', N'砎荧લꙿች긃춟㏲鈼飪࿌ꊥ�⋑⸠')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (289, 9, CAST(N'2024-07-18T19:43:54.000' AS DateTime), N'pantalla de bitacora abierta', N'⻛䆍ༀ雰䡃輩�᯹⎔괸뒵̒囈')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (290, 9, CAST(N'2024-07-18T19:44:09.000' AS DateTime), N'vuelta a la pantalla de admin', N'铤鱽룭꼻㘂넶釱㱋폑뇻존璺�巫')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (291, 9, CAST(N'2024-07-18T19:44:10.000' AS DateTime), N'pantalla de usuarios abierta', N'㸦㤑曑蠫࿾뱷骷籩뒌괆ℵ偄᥄ᘀ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (292, 9, CAST(N'2024-07-18T19:44:22.000' AS DateTime), N'deslogeo de sesion admin', N'蜈絥꺿Ⰹ暼ዋ狸曹ほ鼌齃솇᷵')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (293, 9, CAST(N'2024-07-18T19:44:28.000' AS DateTime), N'logeo de sesion admin', N'㒊獫ᓬĲ⻏暂빘皍烶쏸甶坫㻖舢')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (294, 9, CAST(N'2024-07-18T19:47:08.000' AS DateTime), N'se restauro la base a la ultima version disponible', N'ḋ࿯횏裺꿪윹큂誳鳉⠷괘泦䚭鞍❫')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (295, 9, CAST(N'2024-07-18T19:47:16.000' AS DateTime), N'pantalla de bitacora abierta', N'ﬂꪻ䌢㗼ᦤﰅ�嚚඲�퀹�쨻㵖')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (296, 9, CAST(N'2024-07-18T19:47:22.000' AS DateTime), N'vuelta a la pantalla de admin', N'狕숧୳몼据맘믁푊﫿夡౽䛒ᠦ䐞')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (297, 9, CAST(N'2024-07-18T19:47:23.000' AS DateTime), N'pantalla de usuarios abierta', N'鮮�鶦뿝녊ヵ閳誳ꂔ荊픏첝뿥狴ಠ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (298, 9, CAST(N'2024-07-18T19:47:30.000' AS DateTime), N'vuelta a la pantalla de admin', N'㣙擗⧺�酷⣍챂蹻੒⢁認팂ϱ⫷')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (299, 9, CAST(N'2024-07-18T19:48:12.000' AS DateTime), N'pantalla de bitacora abierta', N'䧽ࡾ産逇ꤙ鷂뭒⫄㰈�ꧾ�릹᰸')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (300, 9, CAST(N'2024-07-18T19:48:16.000' AS DateTime), N'vuelta a la pantalla de admin', N'㖲ূ㕅萒槗⒎쌠ⱴ⸦羟끌닅⏈壞㚥')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (301, 9, CAST(N'2024-07-18T19:48:42.000' AS DateTime), N'se restauro la base a la ultima version disponible', N'楞ᡉ韵䓆飊舃Ẉ鑈᛿浗╋䟐타�᳏')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (302, 9, CAST(N'2024-07-18T19:48:46.000' AS DateTime), N'pantalla de bitacora abierta', N'죲 뽐��稉覠岗䑶쑍㨵먴皸뇢븡ぃ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (303, 9, CAST(N'2024-07-18T19:48:55.000' AS DateTime), N'vuelta a la pantalla de admin', N'뜬ꌎ綠੒谥�㫵᷁첹줙ꏚ�⏵倮')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (304, 9, CAST(N'2024-07-18T19:49:16.000' AS DateTime), N'pantalla de bitacora abierta', N'뵊Ë迧欨ڳࢡ憴墹巄ퟚ婽過닫Ꚋ롌')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (305, 9, CAST(N'2024-07-18T19:49:20.000' AS DateTime), N'vuelta a la pantalla de admin', N'䑊겺譑訃뗀囗㭏ꇋ脑겟䋭矼ꬲ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (306, 9, CAST(N'2024-07-18T19:50:37.000' AS DateTime), N'logeo de sesion admin', N'볂표麺穟뀽罇ᏻ挡媏퉨ᕿ涷섻ꎵ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (307, 9, CAST(N'2024-07-18T19:50:39.000' AS DateTime), N'se genero un backup de la base de datos', N'鯽毠ᢘ渌�悗闺㚵�⮓ꚏ䐖⡑쁴�')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (308, 9, CAST(N'2024-07-18T19:50:42.000' AS DateTime), N'se genero un backup de la base de datos', N'㴜䐿镎ꌄ崓袾㒉俗鯞Áᮍ鷫')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (309, 9, CAST(N'2024-07-18T19:50:44.000' AS DateTime), N'pantalla de bitacora abierta', N'ԨỜ昤ﮒ꽀翳稳鹇鎾㠃羡㣖牂ᆎ剳')
GO
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (310, 9, CAST(N'2024-07-18T19:50:46.000' AS DateTime), N'vuelta a la pantalla de admin', N'퐾⥯ꉽﻜ̲ａ䖱襆ത㤉ꨂ쨭楕ꐖ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (311, 9, CAST(N'2024-07-18T19:50:53.000' AS DateTime), N'se restauro la base a la ultima version disponible', N'ঁ﷩켭瑃픓껧Ӡ쐹櫄�ߪ넽姮鐗')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (312, 8, CAST(N'2024-07-18T19:53:21.000' AS DateTime), N'ingreso a pantalla de registro', N'濚셂ᠹ喍寶᧖찢䮝䆛麰佲⭯ᬳ엏ㅲ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (313, 8, CAST(N'2024-07-18T19:53:36.000' AS DateTime), N'vuelta de pantalla de registro sin registrar', N'쭗鲷렍ﰓ눒滙兡匓㱫붘洛⥣ꂲ䢄')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (314, 9, CAST(N'2024-07-18T19:53:43.000' AS DateTime), N'contraseña incorrecta', N'⠨핀숭堶郟겇囨⎶냘䵨䕾Ⓓ㉪⯥꣩')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (315, 9, CAST(N'2024-07-18T19:53:46.000' AS DateTime), N'contraseña incorrecta', N'ꚅ賎�᜺顺茮臀硦巿䵁ᔚ되䴽䩯猨')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (316, 9, CAST(N'2024-07-18T19:53:58.000' AS DateTime), N'logeo de sesion admin', N'㑕淨뚿蔥쇐ꗋꍔ㹅죕�녞&ٱ಺�')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (317, 9, CAST(N'2024-07-18T19:54:19.000' AS DateTime), N'deslogeo de sesion admin', N'䷝뜛돱䖿罙ꬎ趁㷐ﶝퟩ৪쫯詫鸣')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (318, 9, CAST(N'2024-07-18T19:54:24.000' AS DateTime), N'contraseña incorrecta', N'嵞ᡬ㸽λ瑟詺�傏ꏚ쫍ꑪௗ档꣩媧')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (319, 9, CAST(N'2024-07-18T19:54:26.000' AS DateTime), N'contraseña incorrecta', N'ꛬ㎪��塩묾냦䎙熎啿텡쟴諉杪Ｌ䐢')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (320, 9, CAST(N'2024-07-18T19:54:29.000' AS DateTime), N'contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos', N'鳔ꑆﰰ잶쫅�闤嶢ᱷ塞辒붼᪴⤄')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (321, 8, CAST(N'2024-07-18T19:54:55.000' AS DateTime), N'logeo de sesion admin', N'郭䃧湕⪦�글�ឳඊ孹텨䮮춎ퟜ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (322, 8, CAST(N'2024-07-18T19:54:58.000' AS DateTime), N'pantalla de usuarios abierta', N'騶吁麿춺�侼ѕꯣ╜兘鄴➣秣')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (323, 8, CAST(N'2024-07-18T19:55:15.000' AS DateTime), N'se quito el bloqueo del usuario9', N'ຶᄭ䵥ࢣ갍殎脴단�ꐝ⟯怠굕돼뒖')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (324, 8, CAST(N'2024-07-18T19:55:47.000' AS DateTime), N'vuelta a la pantalla de admin', N'泻韷匤ੁ虅┛ࣔ貐�ꑡ郸즗陥딈彌')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (325, 8, CAST(N'2024-07-18T19:55:53.000' AS DateTime), N'deslogeo de sesion admin', N'툱눎脵掚䐌颌쪧պꂇ綮훻횦滛᫿')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (326, 8, CAST(N'2024-07-18T19:55:55.000' AS DateTime), N'ingreso a pantalla de registro', N'圝Ⴛ㡯烧駤벇錏冺ⴤ齽銹뛖⽪笟椰')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (327, 8, CAST(N'2024-07-18T19:56:05.000' AS DateTime), N'se registro el usuario dante', N'垵꯱檭铆낌ﰀ別Ż돶�ᡦ眲뵋꟔')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (328, 11, CAST(N'2024-07-18T19:56:10.000' AS DateTime), N'logeo de sesion usuario', N'勞฀飐讝䊧蓱ᳲ㣾ᯇ솋鬍䯘ﮱ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (329, 11, CAST(N'2024-07-18T20:04:30.000' AS DateTime), N'logeo de sesion usuario', N'ᴫꊍ륲ﴴ☀ທ鞸ማ師⣀⼈랶壭玜찼')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (330, 11, CAST(N'2024-07-18T20:04:34.000' AS DateTime), N'el usuario intento entrar ilegalmente a las bitacoras', N'⸾滰⑁㫆㉠쩖炵︩蠬ዡᾏ舏規髡植')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (331, 9, CAST(N'2024-07-18T20:58:29.000' AS DateTime), N'logeo de sesion admin', N'獦詍櫎⬣鶦૙㲾䌃㟊½痔䂮욖퀤湌')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (332, 9, CAST(N'2024-07-18T21:02:07.000' AS DateTime), N'logeo de sesion admin', N'땴뀣冈崧㕏茒趇_䙙㲡醐ᦝﮣຸ伯Ý')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (333, 9, CAST(N'2024-07-18T21:02:09.000' AS DateTime), N'pantalla de bitacora abierta', N'�풃鈠篞㱰ㆎ酶ꈵⓌ㙙얡㼜㎿ꝴ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (334, 9, CAST(N'2024-07-18T21:04:42.000' AS DateTime), N'logeo de sesion admin', N'凲㈺⡊ɟ끶禷毯齜権榊㈘忊縫⮆栤쳤')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (335, 9, CAST(N'2024-07-18T21:04:45.000' AS DateTime), N'pantalla de usuarios abierta', N'嶊뷾⤁厤븉༁⢰ਿ솾쉍욻턯큻랻촽')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (336, 8, CAST(N'2024-07-18T21:07:40.000' AS DateTime), N'ingreso a pantalla de registro', N'霛䏃ꚫ㹑ꊴ젽។⻹顣劢ꌲ윺蠾祿')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (337, 11, CAST(N'2024-07-18T21:10:15.000' AS DateTime), N'logeo de sesion usuario', N'৸⒔옋ắ῕讻軲㔈族饜䁰眙鮩䯯뢐ᝁ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (338, 9, CAST(N'2024-07-18T21:27:22.000' AS DateTime), N'contraseña incorrecta', N'Ꞻ硆穓綬⺱ሩউ小䧶ㅚ킎겓佯㔝')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (339, 9, CAST(N'2024-07-18T21:27:25.000' AS DateTime), N'contraseña incorrecta', N'黲铨蟸泵瓌诩藺珈캌꩷齫垚ꑸ횧꟠')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (340, 9, CAST(N'2024-07-18T21:27:27.000' AS DateTime), N'contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos', N'ᵂꯊณ쨹᫘沯┯쵤鶊胒庹糽伤ꚲʏ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (341, 8, CAST(N'2024-07-18T21:27:53.000' AS DateTime), N'logeo de sesion admin', N'⤥풫狗䇮㴽蒪쇕ᆅ뽍鐮聛ꕱỵ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (342, 8, CAST(N'2024-07-18T21:28:03.000' AS DateTime), N'pantalla de usuarios abierta', N'�锧ધ㇘㣩ղ뉰つ櫁ዿ��崸')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (343, 8, CAST(N'2024-07-18T21:28:06.000' AS DateTime), N'se quito el bloqueo del usuario9', N'�逮㻼諥侼놻�Ꮖ㲕ﾊ愄칾譙䠯ሲ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (344, 8, CAST(N'2024-07-18T21:28:08.000' AS DateTime), N'deslogeo de sesion admin', N'ഄ喪ோ㟼녠䌫ꊕᤣ닜᧣⹶皿')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (345, 11, CAST(N'2024-07-18T21:33:01.000' AS DateTime), N'logeo de sesion usuario', N'䬠홒棻줙葜늯�횏핿ⶽ㋌뮾뼂꾱')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (346, 11, CAST(N'2024-07-18T21:33:09.000' AS DateTime), N'el usuario intento entrar ilegalmente a las bitacoras', N'ꌺ앧뭝顿⬃⊉楗⹲穔᝕遠㔑㩆흓')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (347, 8, CAST(N'2024-07-18T21:34:28.000' AS DateTime), N'logeo de sesion admin', N'㲙븳膇鵍⬅⃡保䕏硋梜㋇ꁅ湞羜辿ꎻ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (348, 11, CAST(N'2024-08-21T21:41:24.000' AS DateTime), N'logeo de sesion usuario', N'퇓㵚˗츇餠媬쥗놦ࡃ䕬�较 驣')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (349, 9, CAST(N'2024-10-16T20:51:33.000' AS DateTime), N'contraseña incorrecta', N'ઇ댢㊳Χ燞풞薑㦤﩯⎅댚흼漡即')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (350, 8, CAST(N'2024-10-16T20:52:46.000' AS DateTime), N'ingreso a pantalla de registro', N'浬霞鎠륾ᆥ㨣狹牸貢嗚䪈銨')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (351, 8, CAST(N'2024-10-16T20:52:57.000' AS DateTime), N'se registro el usuario lucas1', N'鈅吿촞�虡鈴禆謮遅きꚦ鍄螗')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (352, 12, CAST(N'2024-10-16T20:53:03.000' AS DateTime), N'logeo de sesion admin', N'ᗺ뵃㔼蟵ﺿ䐇㥻墈놅专䆤➜ᛛ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (353, 12, CAST(N'2024-10-16T20:53:16.000' AS DateTime), N'se genero un backup de la base de datos', N'찱묵䗌㣈띪҉秨伎ෆ耾阳�珫')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (354, 12, CAST(N'2024-10-16T20:53:18.000' AS DateTime), N'pantalla de usuarios abierta', N'棝Ṕ않䯱鋣弟㗏㗗퓪밺䓇쁻쟵筵耯')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (355, 12, CAST(N'2024-10-16T20:53:23.000' AS DateTime), N'vuelta a la pantalla de admin', N'￘쁜夾焝쓙槜�旒ຟያ胛⚇ཫ䄕톡∘')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (356, 8, CAST(N'2024-10-16T21:27:40.000' AS DateTime), N'ingreso a pantalla de registro', N'冾⤆㻇✒鉧�ᅂﾙꌄጧ澓勍혭穏䃣')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (357, 8, CAST(N'2024-10-16T21:27:59.000' AS DateTime), N'se registro el usuario usuario', N'䬛౗ઽ봇�죛ꮲ銢ჵྨ툍н癄�')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (358, 13, CAST(N'2024-10-16T21:28:07.000' AS DateTime), N'logeo de sesion usuario', N'특滘㝁盕쥏䥸᱾⼜훧읧詷Դ녦')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (359, 13, CAST(N'2024-10-16T21:48:44.000' AS DateTime), N'logeo de sesion usuario', N'௢ᘓ溿얠Ɑ懻ㆍ漌䩏뼨퇙⸀ႊ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (360, 13, CAST(N'2024-10-16T21:49:31.000' AS DateTime), N'logeo de sesion usuario', N'醗斂ꂃ�蹢螲쐎꼱뤿媆鷰ٹ깖罫')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (361, 13, CAST(N'2024-10-16T21:52:35.000' AS DateTime), N'logeo de sesion usuario', N'걅礋ष黅⭛踀獚基뿧씝塖䳎蕍쵒⍼')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (362, 13, CAST(N'2024-10-16T21:56:05.000' AS DateTime), N'logeo de sesion usuario', N'녕䊦伟棐䃟껇捡龲緲蛋ᇪ硧䞥')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (363, 13, CAST(N'2024-10-16T21:57:09.000' AS DateTime), N'logeo de sesion usuario', N'쇜爮躤ﾟ鵝�셛䗘₾麙熹뢿᠂쁭')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (364, 13, CAST(N'2024-10-16T21:57:36.000' AS DateTime), N'logeo de sesion usuario', N'釆忭巓꿥®婯䮠䣰᳠껡鴉䉗厨顣')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (365, 8, CAST(N'2024-10-16T21:58:27.000' AS DateTime), N'ingreso a pantalla de registro', N'볞䚟젍ϝ砠蝾쯰〼嫊㰥癎ᢅ읎蒶')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (366, 8, CAST(N'2024-10-16T21:58:35.000' AS DateTime), N'se registro el usuario usuario1', N'㶴㲂㋁鏓꘵䣓껟퍒༫Ⱖ㧠₴ᚑ삊')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (367, 14, CAST(N'2024-10-16T21:58:41.000' AS DateTime), N'logeo de sesion usuario', N'畤㕺ᱤ祷틛盐ꏘ�汤㫩ೱ類쮄ݚ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (368, 14, CAST(N'2024-10-16T22:15:54.000' AS DateTime), N'logeo de sesion usuario', N'秛䄫햵雭䟽胗큨�ꪕ骢毩왖⣚㛬')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (369, 14, CAST(N'2024-10-16T22:18:38.000' AS DateTime), N'logeo de sesion usuario', N'㎏㇁༄붏㉄⫫㇒㾦濻뻙醃錫죾')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (370, 14, CAST(N'2024-10-16T22:20:25.000' AS DateTime), N'logeo de sesion usuario', N'윃ꍥ⁋媯뀧顬�▎燋崄颺뷦迮늴풲')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (371, 14, CAST(N'2024-10-16T22:23:29.000' AS DateTime), N'logeo de sesion usuario', N'鬃鵳ꉻ悞ਕ洞䛕썗�쓎릲ⵑﺓ啦ℴ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (372, 14, CAST(N'2024-10-16T22:24:34.000' AS DateTime), N'logeo de sesion usuario', N'莼궄곸ቛ쯌墭⚓ꐬ㿢蓁锷渌芳')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (373, 14, CAST(N'2024-10-16T22:25:14.000' AS DateTime), N'logeo de sesion usuario', N'↸霢쐋ᾙ걒挼쫯竲鯄�ￓ싐Ἕබ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (374, 14, CAST(N'2024-10-16T22:25:54.000' AS DateTime), N'logeo de sesion usuario', N'৒꫁Ɔ�⿪䤕턺隚谸㲻髒ᘕ떶䚁ශ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (375, 14, CAST(N'2024-10-16T22:45:29.000' AS DateTime), N'logeo de sesion usuario', N'햳속濦ᓑﬡ器࿼齤％鈣㑦ꆾ堀飝룏')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (376, 14, CAST(N'2024-10-16T22:46:27.000' AS DateTime), N'logeo de sesion usuario', N'쉒犰뽈鄤㹉枠૒묃슱⟖ũ὎푝�鮸')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (377, 14, CAST(N'2024-10-16T22:50:41.000' AS DateTime), N'logeo de sesion usuario', N'砄︐➢㇮嶸낅ꎷ鋲꽍쇔ᤜ嘆܄')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (378, 14, CAST(N'2024-10-16T22:51:30.000' AS DateTime), N'logeo de sesion usuario', N'헟妖奬攦Ặ⼤襏귵࠮ꪻ䲈먥ᓦ⳰」�')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (379, 14, CAST(N'2024-10-16T22:52:36.000' AS DateTime), N'logeo de sesion usuario', N'ㄕ㦆໢ﻍ┠뤷㖜ጀ፛㉈▣弜访ꤍ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (380, 14, CAST(N'2024-10-16T22:53:13.000' AS DateTime), N'logeo de sesion usuario', N'‒៼騵⦈ε꼕ቿ熎㪢⮙狡뤚糲彨')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (381, 14, CAST(N'2024-10-16T22:54:54.000' AS DateTime), N'logeo de sesion usuario', N'썭擽ᠿ䌚굁䓹랚忢捂창맆쫵�朵鋱')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (382, 14, CAST(N'2024-10-16T22:55:45.000' AS DateTime), N'logeo de sesion usuario', N'졪탉邕菐妆䢁ဤ迶㽾肗맛ℱ鎇䋭誓')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (383, 14, CAST(N'2024-10-16T22:57:15.000' AS DateTime), N'logeo de sesion usuario', N'䩒骙裛楶ꃏ緁銘蒆跊ꨒ䪀겿Ἷ퓜⩀䏦')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (384, 14, CAST(N'2024-10-16T22:59:12.000' AS DateTime), N'logeo de sesion usuario', N'�￪簆诛뾣㕐屣㲋�꠹叇ћ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (385, 14, CAST(N'2024-10-16T23:05:22.000' AS DateTime), N'logeo de sesion usuario', N'坷쑳欀䷑෽舒⴪煴᫟Ƀ㨘៽鱔蕤')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (386, 14, CAST(N'2024-10-16T23:06:09.000' AS DateTime), N'logeo de sesion usuario', N'磲ꎓ훠ۊ傉ₖ쯣픓䒋彩錘꒤쐳城ȯ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (387, 14, CAST(N'2024-10-16T23:10:11.000' AS DateTime), N'logeo de sesion usuario', N'睠饹쨭㽰䇄௲ꐺ斤灡富䤼遙㱞෋苶ㅳ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (388, 14, CAST(N'2024-10-16T23:12:56.000' AS DateTime), N'logeo de sesion usuario', N'⎒圯�力ﺹ얤跘좙悤窿Ꞡ泜솙쫋濠')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (389, 14, CAST(N'2024-10-16T23:14:14.000' AS DateTime), N'logeo de sesion usuario', N'ꂕ᭛낕칞舱ᾟ燊ᣊᣈ搌㷞⺌萀騵྆䔯')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (390, 14, CAST(N'2024-10-16T23:18:05.000' AS DateTime), N'logeo de sesion usuario', N'펚瀇戅ޟ┠锺⑙ଐ貟㒞擠㘫埥')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (391, 14, CAST(N'2024-10-16T23:24:08.000' AS DateTime), N'logeo de sesion usuario', N'왌₭쑕�䒏厐䗮棨䆃仺⃐ち蜅꾤')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (392, 14, CAST(N'2024-10-16T23:29:10.000' AS DateTime), N'logeo de sesion usuario', N'뉅齺�䒗⑁⺍傳䀢뎟瀶▚ⰵ遣踎')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (393, 14, CAST(N'2024-10-16T23:30:46.000' AS DateTime), N'logeo de sesion usuario', N'槔ན혮毬뽩늶⌧ꦞ쿇촵뻪䶥⎠떇')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (394, 14, CAST(N'2024-10-16T23:31:07.000' AS DateTime), N'logeo de sesion usuario', N'䲤胪ᎊ堘䷎须ꆯI쑄㔊꺷䡄釮혈↛')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (395, 14, CAST(N'2024-10-16T23:34:09.000' AS DateTime), N'logeo de sesion usuario', N'ⱗ쉀䌥줣ⱒ�⟾伶࠘퇍㧌嶟컴䊅')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (396, 14, CAST(N'2024-10-16T23:35:09.000' AS DateTime), N'logeo de sesion usuario', N'ꮾ面捔०ᴯñ凓ꅎ�ꃯ見ꥲ㩈ₕ流')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (397, 14, CAST(N'2024-10-16T23:36:53.000' AS DateTime), N'logeo de sesion usuario', N'敘㻺꒍ᣔ䳬Ϧ⫲޵ऱ㦯㢚䪵㮺翠')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (398, 14, CAST(N'2024-10-16T23:47:40.000' AS DateTime), N'logeo de sesion usuario', N'�齆誒繋܎䮔羔趬鈈㲌㺵烅㰏')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (399, 14, CAST(N'2024-10-17T00:13:40.000' AS DateTime), N'logeo de sesion usuario', N'娙굕�坢桱༲볏䧲ⷨꢚ흭앭᷇丒')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (400, 14, CAST(N'2024-10-17T00:15:59.000' AS DateTime), N'logeo de sesion usuario', N'뽞ᇓ⽛ᖓ伦쿲ʷ瓇郤꼼쬦᫝쵷ᕃ蔧')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (401, 8, CAST(N'2024-10-17T01:00:56.000' AS DateTime), N'ingreso a pantalla de registro', N'᜿쮁鍑ඐµ䧊璩䋽晤됟㷂簕䄚駥瀖둯')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (402, 8, CAST(N'2024-10-17T01:01:02.000' AS DateTime), N'se registro el usuario admin1', N'痢ꦩ㟬ኍ涋盝짹玴ᢕ狡쌄塹轧')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (403, 15, CAST(N'2024-10-17T01:01:07.000' AS DateTime), N'logeo de sesion admin', N'䗵뺦ᜋ旍솇遍듲Ꚗﴮ阾璑閟㧩嫃㻠')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (404, 15, CAST(N'2024-10-17T01:02:22.000' AS DateTime), N'logeo de sesion admin', N'ʳ脽ᄡ㦢됫䋿딤豝囆體奨臀燷㊕솕存')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (405, 15, CAST(N'2024-10-17T01:05:00.000' AS DateTime), N'logeo de sesion admin', N'⫔쁠�䡩㱘ꋕ遊偑麠⺳斖㡩힪酁旰')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (406, 15, CAST(N'2024-10-17T01:06:36.000' AS DateTime), N'logeo de sesion admin', N'ᗙ擬⑏⌝䷹喟ݐ䞑쇿䖂嗠縻섘௝ꭒ�')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (407, 14, CAST(N'2024-10-18T12:20:43.000' AS DateTime), N'logeo de sesion usuario', N'揎꩔乽魈⬕檊腺㚒箷�㡋㘏�ꯒ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (408, 14, CAST(N'2024-10-18T12:20:48.000' AS DateTime), N'deslogeo de sesion usuario', N'ݶ穭벻絋䬾쓟铠�점㧳啪含䄺')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (409, 15, CAST(N'2024-10-18T12:20:52.000' AS DateTime), N'logeo de sesion admin', N'␻彪鼈팟媔ꢲȉ﹝螧ﯣഅᶷ푃鞮')
GO
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (410, 15, CAST(N'2024-10-18T12:22:46.000' AS DateTime), N'logeo de sesion admin', N'蒤騃犡鲒窴��篍㬈蟘曲땨䗜ﭣ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (411, 15, CAST(N'2024-10-18T12:24:49.000' AS DateTime), N'logeo de sesion admin', N'䥊┕렂얖畹ᏽᰶቜ╔鞧ⓑᩞ嚮Ӑ⨆ﱋ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (412, 15, CAST(N'2024-10-18T12:25:54.000' AS DateTime), N'logeo de sesion admin', N'縳ꕹⷴ웖뛜䣽㗣샷炻୓猞×톣碅�悁')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (413, 15, CAST(N'2024-10-18T12:29:51.000' AS DateTime), N'logeo de sesion admin', N'엊ꅺ燾ᯊ긫柍ǔ킪ⶰᩍ蓎벆㚥䴹퐰唿')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (414, 15, CAST(N'2024-10-18T12:34:42.000' AS DateTime), N'logeo de sesion admin', N'➜檮驙ࢹೞ臻늘⋳섗橣忚⃂࿎潏')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (415, 15, CAST(N'2024-10-18T12:40:32.000' AS DateTime), N'logeo de sesion admin', N'熡ꅭ蠊ب߭釫遲闯⯘巒簕餶眳')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (416, 15, CAST(N'2024-10-18T12:42:10.000' AS DateTime), N'logeo de sesion admin', N'䣞憀㐮ꌀשׁ瓨⛔礀圭쫆胣䂓絍⯢')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (417, 15, CAST(N'2024-10-18T12:42:24.000' AS DateTime), N'deslogeo de sesion admin', N'虌枔鲟启ಗ颪ޒ卂踣墼涳㬅Ꚛ芊䑃')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (418, 8, CAST(N'2024-10-18T14:38:43.000' AS DateTime), N'ingreso a pantalla de registro', N'䂀譾㐙授䆸鞠넠蛠ꔤ獍춖ꭒ�㟆ꫫ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (419, 8, CAST(N'2024-10-18T14:39:29.000' AS DateTime), N'vuelta de pantalla de registro sin registrar', N'핓Ԙ蚏阥ඔ뗱촀侻㝯墀ᚸ欤뮅៙泄')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (420, 14, CAST(N'2024-10-18T14:39:30.000' AS DateTime), N'logeo de sesion usuario', N'鉡晁룻簤쓇垭쿉왴ॷ襦뻹ং菕䉕')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (421, 14, CAST(N'2024-10-18T14:41:08.000' AS DateTime), N'deslogeo de sesion usuario', N'璣ㅺ롸更錷궳鴘䰒䉱鏷ꔭ鿼ᗒ鱠')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (422, 15, CAST(N'2024-10-18T14:41:11.000' AS DateTime), N'logeo de sesion admin', N'ජ䠁ᇄ뜷鈹具뭔ꏥ뚊汾ꗇఒൊႂ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (423, 15, CAST(N'2024-10-18T14:41:42.000' AS DateTime), N'pantalla de bitacora abierta', N'�鹖䝈炘琈곮넏㉒䵼엒ཋ䃏ࡲ掛')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (424, 15, CAST(N'2024-10-18T14:42:24.000' AS DateTime), N'vuelta a la pantalla de admin', N'轉ꩣꁕ䵾㐬覻酈䡪ಳ鳚늘牷雈耂륒졫')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (425, 15, CAST(N'2024-10-18T14:42:32.000' AS DateTime), N'pantalla de usuarios abierta', N'�鿹⽲ා횯疺樁碏ꪇֺ呍凝戯捚')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (426, 15, CAST(N'2024-10-18T14:43:10.000' AS DateTime), N'vuelta a la pantalla de admin', N'吗퉄ᖩﲄ㈳枩䛨幽ꉖ뫶帮ຜ椒踷攰倭')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (427, 15, CAST(N'2024-10-18T14:43:13.000' AS DateTime), N'se genero un backup de la base de datos', N'㫬楪픖阓寤斑ꑱⲈ홯섁튕䤈揞篙毪둱')
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
GO
INSERT [dbo].[Producto] ([id], [nombre], [precio], [descripcion]) VALUES (1, N'Equipo1', 100, N'equipo con 1 controlador de agua y 1 sensor de humedad')
INSERT [dbo].[Producto] ([id], [nombre], [precio], [descripcion]) VALUES (2, N'Equipo2', 150, N'equipo con 2 controladores de agua y 1 sensor de humedad')
INSERT [dbo].[Producto] ([id], [nombre], [precio], [descripcion]) VALUES (3, N'Equipo3', 200, N'equipo con 3 controladores de agua y 2 sensores de humedad')
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'bitacora', N'47ef20207489b775fa4cdcac3c394b517ab22d7460237ae3df1ac0e8963699d6', 1, 8, N'ႇӊ�ព괗ᰊ�哬僘숚넉ꃍ⨮猏轇㞚', 0, NULL, 0)
INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'lucas', N'47ef20207489b775fa4cdcac3c394b517ab22d7460237ae3df1ac0e8963699d6', 1, 9, N'ᄅ醧⋡䒖ぬ왉퇅介鍄倻ㆬ絲꺙㨐㜢', 1, CAST(N'2024-10-16T20:51:33.950' AS DateTime), 0)
INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'dante', N'47ef20207489b775fa4cdcac3c394b517ab22d7460237ae3df1ac0e8963699d6', 2, 11, N'�簉䩷䇆瓉쮾傸淤ﮦᷱ蝖姊၇宖阋忢', 0, NULL, 0)
INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'lucas1', N'2285877fbec4bb1ad6466a6d3596f3a369646db03a02d4f74a2616a50d457a0c', 1, 12, N'臱ꕶ濔�ᾝ傀꿣櫨宔⌬跸꾀꽜䨈엡', 0, NULL, 0)
INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'usuario', N'2285877fbec4bb1ad6466a6d3596f3a369646db03a02d4f74a2616a50d457a0c', 2, 13, N'ﯗ앉칖㽕〲殮퐘庝葒컢륩暯줌֖㫩', 0, NULL, 0)
INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'usuario1', N'2285877fbec4bb1ad6466a6d3596f3a369646db03a02d4f74a2616a50d457a0c', 2, 14, N'芦⧨퇦͊⾧⬀ᯘ樂ᨭ࿆娛だ﬩퉎퉤', 0, NULL, 0)
INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'admin1', N'2285877fbec4bb1ad6466a6d3596f3a369646db03a02d4f74a2616a50d457a0c', 1, 15, N'Ⅾꄕ㍫ᐡࡤ颷峁溹쬮䗗펋㒉絯ﺇ篌', 0, NULL, 0)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET IDENTITY_INSERT [dbo].[UsuarioxProducto] ON 

INSERT [dbo].[UsuarioxProducto] ([Id], [IdUsuario], [IdProducto], [Estado]) VALUES (3, 13, 1, 1)
INSERT [dbo].[UsuarioxProducto] ([Id], [IdUsuario], [IdProducto], [Estado]) VALUES (4, 14, 1, 1)
INSERT [dbo].[UsuarioxProducto] ([Id], [IdUsuario], [IdProducto], [Estado]) VALUES (5, 14, 2, 1)
INSERT [dbo].[UsuarioxProducto] ([Id], [IdUsuario], [IdProducto], [Estado]) VALUES (6, 14, 3, 1)
INSERT [dbo].[UsuarioxProducto] ([Id], [IdUsuario], [IdProducto], [Estado]) VALUES (7, 14, 1, 1)
SET IDENTITY_INSERT [dbo].[UsuarioxProducto] OFF
GO
SET IDENTITY_INSERT [dbo].[Venta] ON 

INSERT [dbo].[Venta] ([Id], [IdUsuario], [Precio]) VALUES (1, 14, 450)
INSERT [dbo].[Venta] ([Id], [IdUsuario], [Precio]) VALUES (2, 14, 100)
SET IDENTITY_INSERT [dbo].[Venta] OFF
GO
INSERT [dbo].[VentaxProducto] ([IdVenta], [IdProducto], [Precio]) VALUES (1, 1, 100)
INSERT [dbo].[VentaxProducto] ([IdVenta], [IdProducto], [Precio]) VALUES (1, 2, 150)
INSERT [dbo].[VentaxProducto] ([IdVenta], [IdProducto], [Precio]) VALUES (1, 3, 200)
INSERT [dbo].[VentaxProducto] ([IdVenta], [IdProducto], [Precio]) VALUES (2, 1, 100)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [validacionUsuario]    Script Date: 18/10/2024 16:20:03 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [validacionUsuario] UNIQUE NONCLUSTERED 
(
	[usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT ((0)) FOR [IntentosFallidos]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT ((0)) FOR [CuentaBloqueada]
GO
ALTER TABLE [dbo].[Bitacora]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([id])
GO
ALTER TABLE [dbo].[UsuarioxProducto]  WITH CHECK ADD  CONSTRAINT [FK_Producto] FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Producto] ([id])
GO
ALTER TABLE [dbo].[UsuarioxProducto] CHECK CONSTRAINT [FK_Producto]
GO
ALTER TABLE [dbo].[UsuarioxProducto]  WITH CHECK ADD  CONSTRAINT [FK_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([id])
GO
ALTER TABLE [dbo].[UsuarioxProducto] CHECK CONSTRAINT [FK_Usuario]
GO
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([id])
GO
ALTER TABLE [dbo].[Venta] CHECK CONSTRAINT [FK_Venta_Usuario]
GO
ALTER TABLE [dbo].[VentaxProducto]  WITH CHECK ADD  CONSTRAINT [FK_VentaxProducto_Producto] FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Producto] ([id])
GO
ALTER TABLE [dbo].[VentaxProducto] CHECK CONSTRAINT [FK_VentaxProducto_Producto]
GO
ALTER TABLE [dbo].[VentaxProducto]  WITH CHECK ADD  CONSTRAINT [FK_VentaxProducto_Venta] FOREIGN KEY([IdVenta])
REFERENCES [dbo].[Venta] ([Id])
GO
ALTER TABLE [dbo].[VentaxProducto] CHECK CONSTRAINT [FK_VentaxProducto_Venta]
GO
/****** Object:  StoredProcedure [dbo].[BackupDatabase]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BackupDatabase]
    @backupPath NVARCHAR(500)
AS
BEGIN
    DECLARE @backupCommand NVARCHAR(1000);
    SET @backupCommand = 'BACKUP DATABASE [web] TO DISK = ''' + @backupPath + ''' WITH FORMAT, NAME = ''web-Full Database Backup''';
    EXEC sp_executesql @backupCommand;
END;
GO
/****** Object:  StoredProcedure [dbo].[BuscarUsuario]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarUsuario]
    @nombre NVARCHAR(50)
AS
BEGIN
    SELECT usuario, contrasena, roll, id, CuentaBloqueada, IntentosFallidos
    FROM Usuario
    WHERE usuario = @nombre;
END;
GO
/****** Object:  StoredProcedure [dbo].[guardarUsuario]    Script Date: 18/10/2024 16:20:03 ******/
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
/****** Object:  StoredProcedure [dbo].[IncrementarIntentosFallidos]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IncrementarIntentosFallidos]
    @usuarioId INT
AS
BEGIN
    DECLARE @intentosFallidos INT;
    DECLARE @maxIntentos INT = 3; -- Número máximo de intentos fallidos permitidos

    -- Obtener el número actual de intentos fallidos para el usuario
    SELECT @intentosFallidos = IntentosFallidos
    FROM Usuario
    WHERE id = @usuarioId;

    -- Incrementar el contador de intentos fallidos
    SET @intentosFallidos = @intentosFallidos + 1;

    -- Actualizar la tabla de IntentosLogin
    UPDATE Usuario
    SET IntentosFallidos = @intentosFallidos,
        UltimoIntento = GETDATE(),
        CuentaBloqueada = CASE WHEN @intentosFallidos >= @maxIntentos THEN 1 ELSE CuentaBloqueada END
    WHERE id = @usuarioId;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarBitacora]    Script Date: 18/10/2024 16:20:03 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarBitacora]    Script Date: 18/10/2024 16:20:03 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarUsuarios]    Script Date: 18/10/2024 16:20:03 ******/
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
        CASE WHEN Checksum = dbo.CalcularChecksum(usuario, contrasena, roll) THEN 'false' ELSE 'true' END AS Corrupto,
		CuentaBloqueada,
		IntentosFallidos
    FROM 
        Usuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[ObtenerProductosPorUsuario]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerProductosPorUsuario]
    @IdUsuario INT
AS
BEGIN
    -- Asegurar que los errores se manejen correctamente
    SET NOCOUNT ON;

    SELECT 
        up.Id AS IdRelacion,
        p.id AS IdProducto,
        p.nombre AS Producto,
		p.precio,
        p.descripcion,
        up.Estado
    FROM UsuarioxProducto up
    JOIN Producto p ON up.IdProducto = p.id
    WHERE up.IdUsuario = @IdUsuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[RegistrarUsuario]    Script Date: 18/10/2024 16:20:03 ******/
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
/****** Object:  StoredProcedure [dbo].[ReiniciarIntentosFallidos]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReiniciarIntentosFallidos]
    @usuarioId INT,
    @success BIT OUTPUT -- Parámetro de salida para indicar éxito o fracaso
AS
BEGIN
    SET NOCOUNT ON;

    -- Variable para verificar si se realizó la actualización correctamente
    DECLARE @result INT;

    BEGIN TRY
        -- Verificar si el usuario existe antes de actualizar
        IF EXISTS (SELECT 1 FROM Usuario WHERE id = @usuarioId)
        BEGIN
            -- Reiniciar los intentos fallidos y desbloquear la cuenta
            UPDATE Usuario
            SET IntentosFallidos = 0,
                UltimoIntento = NULL,
                CuentaBloqueada = 0
            WHERE id = @usuarioId;

            -- Si llegamos aquí, la actualización fue exitosa
            SET @result = 1;
        END
        ELSE
        BEGIN
            -- Si no se encontró el usuario, la actualización no fue exitosa
            SET @result = 0;
        END
    END TRY
    BEGIN CATCH
        -- Si hubo algún error, la actualización no fue exitosa
        SET @result = 0;
    END CATCH;

    -- Asignar el valor de @result al parámetro de salida @success
    SET @success = @result;

    -- Devolver el valor de @success como resultado
    SELECT @success AS Success;
END;

GO
/****** Object:  StoredProcedure [dbo].[RestoreDatabase]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RestoreDatabase]
    @backupPath NVARCHAR(500)
AS
BEGIN
    DECLARE @restoreCommand NVARCHAR(1000);
    
    -- Asegurarse de que la base de datos está en modo de un solo usuario para la restauración
    SET @restoreCommand = 'ALTER DATABASE [web] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;';
    EXEC sp_executesql @restoreCommand;
    
    -- Comando de restauración
    SET @restoreCommand = 'RESTORE DATABASE [web] FROM DISK = ''' + @backupPath + ''' WITH REPLACE;';
    EXEC sp_executesql @restoreCommand;

    -- Volver a modo multiusuario
    SET @restoreCommand = 'ALTER DATABASE [web] SET MULTI_USER;';
    EXEC sp_executesql @restoreCommand;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarUsuarioxProducto]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertarUsuarioxProducto]
    @IdUsuario INT,
    @IdProducto INT,
    @Estado BIT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Insertar registro en la tabla UsuarioxProducto
        INSERT INTO UsuarioxProducto (IdUsuario, IdProducto, Estado)
        VALUES (@IdUsuario, @IdProducto, @Estado);

        -- Confirmación de inserción exitosa
        SELECT SCOPE_IDENTITY() AS NuevoId;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarVenta]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertarVenta]
    @IdUsuario INT,
    @Precio INT,
    @NuevoIdVenta INT OUTPUT  -- Parámetro de salida
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Insertar una nueva venta
        INSERT INTO Venta (IdUsuario, Precio)
        VALUES (@IdUsuario, @Precio);

        -- Asignar el ID generado al parámetro de salida
        SET @NuevoIdVenta = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarVentaxProducto]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertarVentaxProducto]
    @IdVenta INT,
    @IdProducto INT,
    @Precio INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Insertar un producto en una venta específica
        INSERT INTO VentaxProducto (IdVenta, IdProducto, Precio)
        VALUES (@IdVenta, @IdProducto, @Precio);
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerVentasCompleto]    Script Date: 18/10/2024 16:20:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROCEDURE [dbo].[sp_ObtenerVentasCompleto]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT 
            V.Id AS IdVenta,
            V.IdUsuario,
            V.Precio AS PrecioTotal,
            VP.IdProducto,
            P.Nombre AS NombreProducto,
            VP.Precio AS PrecioProducto
        FROM Venta V
        LEFT JOIN VentaxProducto VP ON V.Id = VP.IdVenta
        LEFT JOIN Producto P ON VP.IdProducto = P.Id
        ORDER BY V.Id;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO
USE [master]
GO
ALTER DATABASE [web] SET  READ_WRITE 
GO
