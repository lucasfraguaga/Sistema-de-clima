USE [master]
GO
/****** Object:  Database [web]    Script Date: 13/7/2024 02:01:32 ******/
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
/****** Object:  UserDefinedFunction [dbo].[CalcularChecksum]    Script Date: 13/7/2024 02:01:32 ******/
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
/****** Object:  UserDefinedFunction [dbo].[CalcularChecksumBitacora]    Script Date: 13/7/2024 02:01:32 ******/
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
/****** Object:  Table [dbo].[Bitacora]    Script Date: 13/7/2024 02:01:32 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 13/7/2024 02:01:32 ******/
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
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (249, 9, CAST(N'2024-07-13T01:27:43.000' AS DateTime), N'se restauro la base a la ultima version disponible', N'瑺脊䪰蹇ᨏힷ搋뎜࿗꒓曱셪�慱듦')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (250, 9, CAST(N'2024-07-13T01:27:47.000' AS DateTime), N'pantalla de usuarios abierta', N'麻窱脻偆쎃財虹轡硼䨌ꁡⲡ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (251, 9, CAST(N'2024-07-13T01:27:50.000' AS DateTime), N'vuelta a la pantalla de admin', N'콭ৱ�⟤黢屲污㴃黱矯嬝֬봎苋嶺ꡏ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (252, 9, CAST(N'2024-07-13T01:32:47.000' AS DateTime), N'logeo de sesion admin', N'ᰘ⅐렟᪒ꛖꎧ䉣驼翋갨恎哢ᏒჂᨑ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (253, 9, CAST(N'2024-07-13T01:32:49.000' AS DateTime), N'pantalla de usuarios abierta', N'풅ㅥ茑熹䉤迂㵐畹끄崄꯫웪�롑븵')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (254, 9, CAST(N'2024-07-13T01:32:52.000' AS DateTime), N'vuelta a la pantalla de admin', N'ꢼꌊ隣ሺ劚㴞铔잮⃇倌尬ດ災찑椛')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (255, 9, CAST(N'2024-07-13T01:32:54.000' AS DateTime), N'deslogeo de sesion admin', N'⧧簄웭㪯Ҟ癝몔⟕챶࠽毸☥燼뤿')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (256, 8, CAST(N'2024-07-13T01:32:56.000' AS DateTime), N'ingreso a pantalla de registro', N'ᩥ�᢯翳ࡆ䤢အ肭挂㷕呔锓మ謏')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (257, 8, CAST(N'2024-07-13T01:33:08.000' AS DateTime), N'se registro el usuario gaston', N'䀖蕍㲝淁蟞각甥鳉⛵됟ȍ歛궬糼꽓')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (258, 11, CAST(N'2024-07-13T01:33:14.000' AS DateTime), N'contraseña incorrecta', N'ʀ봂䏖ἳ꾝咂놌ᭆ꯲ᡔ誳씎ꝑ뽳')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (259, 11, CAST(N'2024-07-13T01:33:17.000' AS DateTime), N'contraseña incorrecta', N'滇蟟뒛鿫鲞흉颫襓㒬稂侊䕠㷮歟郸')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (260, 11, CAST(N'2024-07-13T01:33:20.000' AS DateTime), N'contraseña incorrecta', N'쑍溑默否瑥Ꭲ왫�વ蘿⿾┉')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (261, 9, CAST(N'2024-07-13T01:33:31.000' AS DateTime), N'logeo de sesion admin', N'㼻뤐鮟ń客捒놴顜❿䩨�媚䳌')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (262, 9, CAST(N'2024-07-13T01:33:33.000' AS DateTime), N'pantalla de usuarios abierta', N'么骶╗鳓噢羃Ꙍṇ컺ञ㣶ꛨ笣북⯃')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (263, 11, CAST(N'2024-07-13T01:36:03.000' AS DateTime), N'logeo de sesion usuario', N'羛꽥왔呏㊺앛⡱셖ᘁ黔粚镴톼䭤')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (264, 11, CAST(N'2024-07-13T01:36:26.000' AS DateTime), N'deslogeo de sesion usuario', N'抵攉꫗龰郎鱲㽎嫜ẅ䅡ೠ⠌鑶阝')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (265, 11, CAST(N'2024-07-13T01:36:31.000' AS DateTime), N'contraseña incorrecta', N'ᶪ㎡적ï늳⋴ᔊ뾥龾䚦啈ㆿ㤞')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (266, 11, CAST(N'2024-07-13T01:36:34.000' AS DateTime), N'contraseña incorrecta', N'蚲遣鸸ꌽ⿀쬁짨➿㭔㿃ꅂꨥ㭔囀磎絽')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (267, 11, CAST(N'2024-07-13T01:36:37.000' AS DateTime), N'contraseña incorrecta', N'㵌阧ᝁ㒗䏾虐൤뾮쁐ݲ茎⭥᲋迵릷')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (268, 11, CAST(N'2024-07-13T01:36:39.000' AS DateTime), N'contraseña incorrecta', N'昌馶스踗꾋戁೩ఝﻣ滅㹶咪鲲䋕疧')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (269, 11, CAST(N'2024-07-13T01:36:44.000' AS DateTime), N'logeo de sesion usuario', N'컬鮺铠ñ团Ὺ䊌䍎陀鍃痷戆ᢡ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (270, 11, CAST(N'2024-07-13T01:36:46.000' AS DateTime), N'deslogeo de sesion usuario', N'৘䑭➋滭㸊ﳏ몘涝㉌㌃מּ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (271, 11, CAST(N'2024-07-13T01:37:04.000' AS DateTime), N'logeo de sesion usuario', N'꾗隷Ῑㅬ晙莶ꋺ⥾颲쫇⭞蒗䴑葏')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (272, 11, CAST(N'2024-07-13T01:37:06.000' AS DateTime), N'deslogeo de sesion usuario', N'噀ҁᨀϣ为쩪趀챣ᗎ殴쉥劳⦻霩')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (273, 11, CAST(N'2024-07-13T01:37:11.000' AS DateTime), N'contraseña incorrecta', N'⓹޳炸̍㾁㦂૱퓢䨏欞쵄俭踆�')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (274, 11, CAST(N'2024-07-13T01:37:14.000' AS DateTime), N'contraseña incorrecta', N'鲀溽䠞ꇁ籫췝溩嚍髯梄Ü⌹⶿⨈⋋')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (275, 11, CAST(N'2024-07-13T01:37:17.000' AS DateTime), N'contraseña incorrecta', N'競穚挂呲룠蒰㥨斥◐达㠡ꀖ⥾౽')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (276, 11, CAST(N'2024-07-13T01:37:19.000' AS DateTime), N'contraseña incorrecta', N'켛껎閪밸Ť䵀슿ꑒﲌ孪ﴟ埝軇䎳㭺�')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (277, 11, CAST(N'2024-07-13T01:37:22.000' AS DateTime), N'contraseña incorrecta', N'༱䳸퐛츚⎏玒晉籝끫꛾﮴ﹼ犺㡁㡙騐')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (278, 9, CAST(N'2024-07-13T01:38:52.000' AS DateTime), N'logeo de sesion admin', N'蔔羨뾏⼂ຜ猵癑ꡙ柃㍠牣挓ӝ㳁')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (279, 9, CAST(N'2024-07-13T01:38:55.000' AS DateTime), N'pantalla de usuarios abierta', N'裧嗫੖쮦՘駔輤뽑訮縙ꟸ輪இ┤')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (280, 9, CAST(N'2024-07-13T01:40:20.000' AS DateTime), N'logeo de sesion admin', N'ഋ㐆᧠儀阏䱴㙈૦ʷ斖횏�彆賫䭘')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (281, 9, CAST(N'2024-07-13T01:40:22.000' AS DateTime), N'pantalla de usuarios abierta', N'秪뺶⾨馎ᡗ�뫋䠽㎓ﶶ䏘䦚䟞聻')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (282, 9, CAST(N'2024-07-13T01:40:26.000' AS DateTime), N'vuelta a la pantalla de admin', N'⋥旄ኴ〺⺙욅㳤툳㫕㣑㍫亝�')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (283, 9, CAST(N'2024-07-13T01:43:01.000' AS DateTime), N'logeo de sesion admin', N'�핱ଫᄺ悢倣꠯汉䯢Ή㔓ᄳ됽')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (284, 9, CAST(N'2024-07-13T01:45:24.000' AS DateTime), N'logeo de sesion admin', N'⅏鞟켊㒿杅ꑙ躹턑㎟먒☽熃ᩦ쀲樐')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (285, 9, CAST(N'2024-07-13T01:47:26.000' AS DateTime), N'logeo de sesion admin', N'㍰隟嚬㍡稜劜ཱི뛶�頇銨�迆扽⬁')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (286, 9, CAST(N'2024-07-13T01:47:27.000' AS DateTime), N'pantalla de usuarios abierta', N'亇儽詸⸹尕嘒审ᬱ恣鋞鬏鑁ῧ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (287, 9, CAST(N'2024-07-13T01:47:34.000' AS DateTime), N'se quito el bloqueo del usuario11', N'ﰸ卺凉﻾莯ᮔႿﲒ䗸힢潢믡ꉸ砛尬')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (288, 9, CAST(N'2024-07-13T01:47:36.000' AS DateTime), N'vuelta a la pantalla de admin', N'헶험�㭰ៃⱧ侷鄄읱煔㠌ᘼ�ㇶ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (289, 9, CAST(N'2024-07-13T01:47:37.000' AS DateTime), N'pantalla de usuarios abierta', N'缺鰻伞䉒ᏼꦟ퀘j☀嗝⌈䤇⑖鞖㮅閼')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (290, 9, CAST(N'2024-07-13T01:47:39.000' AS DateTime), N'vuelta a la pantalla de admin', N'玿쟃誋枲泶坩〮鸆盿ᅧ鉸퇚드')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (291, 9, CAST(N'2024-07-13T01:49:05.000' AS DateTime), N'logeo de sesion admin', N'䡗ꦢൔロ⫏鼺큰卡㿷즐鮌鿡풶ニ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (292, 9, CAST(N'2024-07-13T01:49:08.000' AS DateTime), N'pantalla de usuarios abierta', N'ꄋ몲镢ྟ⾆⥜픪쐲䘟ȑ睢빏苬ꑖ밹Ꜥ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (293, 9, CAST(N'2024-07-13T01:49:09.000' AS DateTime), N'vuelta a la pantalla de admin', N'ᰤℳ꣈촽斎爛၈촲雙ٞ鬫ꥍ휷᭗螡')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (294, 9, CAST(N'2024-07-13T01:49:11.000' AS DateTime), N'deslogeo de sesion admin', N'毉돱ﰄ䞈鍤ਂ銕籒裏�t萝䩪佞衶')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (295, 11, CAST(N'2024-07-13T01:49:19.000' AS DateTime), N'contraseña incorrecta', N'㧚ڧ⑂뱯᭴⥺䵄咾쏾阿콪꣙㛥')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (296, 11, CAST(N'2024-07-13T01:49:21.000' AS DateTime), N'contraseña incorrecta', N'蒼㈕�䠨࿜锿憡핽⥮켮䗟᝭⌛')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (297, 11, CAST(N'2024-07-13T01:49:24.000' AS DateTime), N'contraseña incorrecta', N'鰌ꅖ켊鬠룚糸᳌⨓漴㣀ꊗ륻完昳䬺')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (298, 9, CAST(N'2024-07-13T01:49:39.000' AS DateTime), N'logeo de sesion admin', N'퐕蠾蟝親⥺ቇꊠԡ৩ؤ賒穔蠣')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (299, 9, CAST(N'2024-07-13T01:49:41.000' AS DateTime), N'pantalla de usuarios abierta', N'게릫럮잍㱯佐飳䫢络尽鳖䪝鼗깆⾮苧')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (300, 9, CAST(N'2024-07-13T01:49:44.000' AS DateTime), N'se quito el bloqueo del usuario11', N'䩒詫ߒ꽥仜稥痠ཱི鸆敞䵉䗨ᩢ墩牍')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (301, 9, CAST(N'2024-07-13T01:50:26.000' AS DateTime), N'logeo de sesion admin', N'퓅ᗉꓢ艿鍈芾ꦎ튠爫췏藟廭糩')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (302, 9, CAST(N'2024-07-13T01:50:28.000' AS DateTime), N'pantalla de usuarios abierta', N'쌃醓৖桃ॽଚỠ㝎镾붲׻銂✐⸸X')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (303, 9, CAST(N'2024-07-13T01:50:29.000' AS DateTime), N'vuelta a la pantalla de admin', N'홁ꤲ⟆墄졂⾠敌㢩嵙ꮡጻ九ⱟ䖯')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (304, 9, CAST(N'2024-07-13T01:50:31.000' AS DateTime), N'deslogeo de sesion admin', N'秬㐎斤쮵싦떊ᙂど僚섙鿶斊㟘')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (305, 11, CAST(N'2024-07-13T01:51:00.000' AS DateTime), N'contraseña incorrecta', N'붒Ž꠬ጯ몳砍㩘繂处⸔῔娬匑៊')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (306, 11, CAST(N'2024-07-13T01:51:02.000' AS DateTime), N'contraseña incorrecta', N'뚺ᐩԹ鸸哚ݕ亁塋㈘칩㸕忙▅䨀彗ꠀ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (307, 11, CAST(N'2024-07-13T01:51:05.000' AS DateTime), N'contraseña incorrecta', N'쥝뱧닳㚔�ꢍ鋶緯䫲❀痦⑨ᠻ㛟孋蕿')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (308, 9, CAST(N'2024-07-13T01:51:13.000' AS DateTime), N'logeo de sesion admin', N'胭嵮ᦷᡓ衧钬蝯㇆麺ទ��ｙꛞ嶕')
GO
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (309, 9, CAST(N'2024-07-13T01:51:33.000' AS DateTime), N'pantalla de usuarios abierta', N'읒᭠䵱㷱懲ࣽ脍䐌䨧孙謌䯝쐘⳩�')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (310, 9, CAST(N'2024-07-13T01:51:37.000' AS DateTime), N'se quito el bloqueo del usuario11', N'몕ⲃ蘔㪤䐵뿱淒枱㈀ㄴ챒柵⤔♧')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (311, 9, CAST(N'2024-07-13T01:57:35.000' AS DateTime), N'logeo de sesion admin', N'퀛糀鹘◽嶺ꏯ留ꗩ붨⮚癆㩫旉몢')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (312, 9, CAST(N'2024-07-13T01:57:36.000' AS DateTime), N'pantalla de usuarios abierta', N'ꑧ鲛猓끘꧶书澔붡⩪▂浩棿煍꥚⦢')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (313, 9, CAST(N'2024-07-13T01:57:38.000' AS DateTime), N'deslogeo de sesion admin', N'﬐ﳰॏ떦˱웛㞭鈽꿙꨿쪩갸ㆎ蠬穛')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (314, 11, CAST(N'2024-07-13T01:57:42.000' AS DateTime), N'contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos', N'炤ϲ짨⼓ꙇ됖湾﹇᚞瞧옾샩塨ꨧ')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (315, 11, CAST(N'2024-07-13T01:57:44.000' AS DateTime), N'contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos', N'㔗횆耣柵丧뒲ឦ쏆鯱覣⟤跮쏑斫')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (316, 11, CAST(N'2024-07-13T01:57:47.000' AS DateTime), N'contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos', N'慙⦑㔵걺͔駫ऴ谀凅균꧐䲊㒐횢慠㸃')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (317, 9, CAST(N'2024-07-13T01:58:49.000' AS DateTime), N'logeo de sesion admin', N'飃催ꏼ靠㙠骯鴯㳼웁즶鋯ꢳ⹞')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (318, 9, CAST(N'2024-07-13T01:58:50.000' AS DateTime), N'pantalla de usuarios abierta', N'듐裧䖜ㅚ硢늋턻胲᳇埖ꤵ膽ඒ␹谮')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (319, 9, CAST(N'2024-07-13T01:58:53.000' AS DateTime), N'se quito el bloqueo del usuario11', N'獈�힋╠ჺ箞맨崫ꉼ뒣沒롙鳷ᰃ⧫')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (320, 9, CAST(N'2024-07-13T01:58:55.000' AS DateTime), N'deslogeo de sesion admin', N'䝝붨봂튢勯瓑绻똼뿑᳤�᫽')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (321, 11, CAST(N'2024-07-13T01:59:01.000' AS DateTime), N'contraseña incorrecta', N'픷ﯾ즵謬ꮌ洤泄�⽂뀯ḷ﷐釃')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (322, 11, CAST(N'2024-07-13T01:59:04.000' AS DateTime), N'contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos', N'횱厫걝쟰ⓜ⚙껭ㆁ⨢ﶜ渰灢볁')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (323, 11, CAST(N'2024-07-13T01:59:56.000' AS DateTime), N'logeo de sesion usuario', N'搘趁䒕偷㗞釛৲뜸㌾ꯋ昡㥭ܲ鵡㘷')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (324, 11, CAST(N'2024-07-13T01:59:58.000' AS DateTime), N'deslogeo de sesion usuario', N'命�⩧Ӟ✎糊⺌䌯쏎頴䗴ꕨ몑�奩')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (325, 11, CAST(N'2024-07-13T02:00:17.000' AS DateTime), N'contraseña incorrecta', N'禁鳑ᷢH곀⇠豪ᐗ劼㠤⠗㭶婦뀝')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (326, 11, CAST(N'2024-07-13T02:00:19.000' AS DateTime), N'contraseña incorrecta', N'˒둎隦鰀쟓뫠㢦䃬אָ䗀潄誟홁਀')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (327, 11, CAST(N'2024-07-13T02:00:22.000' AS DateTime), N'contraseña incorrecta y bloqueamos la cuenta por 3 intentos fallidos', N'汈俀襯茡꟝Ҷᳶᖩ︵뙛曗ߝ䲶ை㊽')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (328, 9, CAST(N'2024-07-13T02:00:33.000' AS DateTime), N'logeo de sesion admin', N'듏뭭洎⦳ቂ쭛৊蘣椺莆䂡뷘┹')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (329, 9, CAST(N'2024-07-13T02:00:35.000' AS DateTime), N'pantalla de usuarios abierta', N'Ꟗ稾␲ʪ녮ᇂﾕꑊ嘥晴ꞗ邻῵셼')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (330, 9, CAST(N'2024-07-13T02:00:37.000' AS DateTime), N'se quito el bloqueo del usuario11', N'�멢㛉᷐듼녱녘 瑃摟⢷᜚靸￻')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (331, 9, CAST(N'2024-07-13T02:00:40.000' AS DateTime), N'vuelta a la pantalla de admin', N'䑮蓧嫷歐휏凉衭뗗턇粲ꟛై뾧䘲욣樌')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (332, 9, CAST(N'2024-07-13T02:00:41.000' AS DateTime), N'pantalla de bitacora abierta', N'뚏㳬뎦圹坛碗搄퍡枅➂ࢫ蔇')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (333, 9, CAST(N'2024-07-13T02:00:43.000' AS DateTime), N'vuelta a la pantalla de admin', N'㩺䧸뒟惇奼ࠤ⺁᧜퐍㋺？妼瀓茞䈥')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (334, 9, CAST(N'2024-07-13T02:00:44.000' AS DateTime), N'pantalla de usuarios abierta', N'ꀁນᶨ⵼ﮝ橋ꅾ₆欳ﲹ໏퍢햇雄')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (335, 9, CAST(N'2024-07-13T02:00:45.000' AS DateTime), N'vuelta a la pantalla de admin', N'䷬┘鈰즃儬庂큑ꭳ�ﱍ₷왹ፗ鴍')
INSERT [dbo].[Bitacora] ([id], [idUsuario], [Fecha], [Mensaje], [Checksum]) VALUES (336, 9, CAST(N'2024-07-13T02:00:46.000' AS DateTime), N'deslogeo de sesion admin', N'櫛춝㱺㨢殕庻範ꟽѨꡯК飁蒮䆈')
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'bitacora', N'47ef20207489b775fa4cdcac3c394b517ab22d7460237ae3df1ac0e8963699d6', 1, 8, N'ႇӊ�ព괗ᰊ�哬僘숚넉ꃍ⨮猏轇㞚', 0, NULL, 0)
INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'lucas', N'47ef20207489b775fa4cdcac3c394b517ab22d7460237ae3df1ac0e8963699d6', 1, 9, N'ᄅ醧⋡䒖ぬ왉퇅介鍄倻ㆬ絲꺙㨐㜢', 0, NULL, 0)
INSERT [dbo].[Usuario] ([usuario], [contrasena], [roll], [id], [Checksum], [IntentosFallidos], [UltimoIntento], [CuentaBloqueada]) VALUES (N'gaston', N'47ef20207489b775fa4cdcac3c394b517ab22d7460237ae3df1ac0e8963699d6', 2, 11, N'垭䧜쮑璤鹴Ⱟ퓥죙氚劣큥�蹧펫', 0, NULL, 0)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [validacionUsuario]    Script Date: 13/7/2024 02:01:33 ******/
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
/****** Object:  StoredProcedure [dbo].[BackupDatabase]    Script Date: 13/7/2024 02:01:33 ******/
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
/****** Object:  StoredProcedure [dbo].[BuscarUsuario]    Script Date: 13/7/2024 02:01:33 ******/
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
/****** Object:  StoredProcedure [dbo].[guardarUsuario]    Script Date: 13/7/2024 02:01:33 ******/
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
/****** Object:  StoredProcedure [dbo].[IncrementarIntentosFallidos]    Script Date: 13/7/2024 02:01:33 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertarBitacora]    Script Date: 13/7/2024 02:01:33 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarBitacora]    Script Date: 13/7/2024 02:01:33 ******/
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
/****** Object:  StoredProcedure [dbo].[ListarUsuarios]    Script Date: 13/7/2024 02:01:33 ******/
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
        CuentaBloqueada
    FROM 
        Usuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[RegistrarUsuario]    Script Date: 13/7/2024 02:01:33 ******/
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
/****** Object:  StoredProcedure [dbo].[ReiniciarIntentosFallidos]    Script Date: 13/7/2024 02:01:33 ******/
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
/****** Object:  StoredProcedure [dbo].[RestoreDatabase]    Script Date: 13/7/2024 02:01:33 ******/
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
