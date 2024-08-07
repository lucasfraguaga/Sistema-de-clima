USE [master]
GO
/****** Object:  Database [web]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[CalcularChecksum]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[CalcularChecksumBitacora]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 15/7/2024 17:14:31 ******/
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
SET IDENTITY_INSERT [dbo].[Bitacora] ON 

INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (210, 9, CAST(N'2024-07-11T01:02:31.000' AS DateTime), N'pantalla de usuarios abierta', N'掸盼튢䯨劯㵞ᶚ휷顺㝱盼�尞橊')
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
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'bitacora', N'47ef20207489b775fa4cdcac3c394b517ab22d7460237ae3df1ac0e8963699d6', 1, 8, N'ႇӊ�ព괗ᰊ�哬僘숚넉ꃍ⨮猏轇㞚', 0, NULL, 0)
INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'lucas', N'47ef20207489b775fa4cdcac3c394b517ab22d7460237ae3df1ac0e8963699d6', 1, 9, N'ᄅ醧⋡䒖ぬ왉퇅介鍄倻ㆬ絲꺙㨐㜢', 0, NULL, 0)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [validacionUsuario]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  StoredProcedure [dbo].[BackupDatabase]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  StoredProcedure [dbo].[BuscarUsuario]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  StoredProcedure [dbo].[guardarUsuario]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  StoredProcedure [dbo].[IncrementarIntentosFallidos]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertarBitacora]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarBitacora]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarUsuarios]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  StoredProcedure [dbo].[RegistrarUsuario]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  StoredProcedure [dbo].[ReiniciarIntentosFallidos]    Script Date: 15/7/2024 17:14:31 ******/
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
/****** Object:  StoredProcedure [dbo].[RestoreDatabase]    Script Date: 15/7/2024 17:14:31 ******/
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
USE [master]
GO
ALTER DATABASE [web] SET  READ_WRITE 
GO
