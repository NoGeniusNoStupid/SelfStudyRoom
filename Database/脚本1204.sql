USE [master]
GO
/****** Object:  Database [SelfStudyRoom]    Script Date: 2018-12-4 16:59:55 ******/
CREATE DATABASE [SelfStudyRoom]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SelfStudyRoom', FILENAME = N'F:\项目数据库\自习室座位管理系统\SelfStudyRoom.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SelfStudyRoom_log', FILENAME = N'F:\项目数据库\自习室座位管理系统\SelfStudyRoom_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SelfStudyRoom] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SelfStudyRoom].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SelfStudyRoom] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET ARITHABORT OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SelfStudyRoom] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SelfStudyRoom] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SelfStudyRoom] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SelfStudyRoom] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SelfStudyRoom] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET RECOVERY FULL 
GO
ALTER DATABASE [SelfStudyRoom] SET  MULTI_USER 
GO
ALTER DATABASE [SelfStudyRoom] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SelfStudyRoom] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SelfStudyRoom] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SelfStudyRoom] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SelfStudyRoom', N'ON'
GO
USE [SelfStudyRoom]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 2018-12-4 16:59:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Admin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AdminName] [varchar](50) NULL,
	[AdminPwd] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Tel] [varchar](20) NULL,
	[Image] [varchar](50) NULL,
	[State] [varchar](20) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Seat]    Script Date: 2018-12-4 16:59:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Seat](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NULL,
	[SeatNo] [varchar](20) NULL,
	[State] [varchar](20) NULL,
	[SaveTime] [datetime] NULL,
 CONSTRAINT [PK_Seat] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SeatDetail]    Script Date: 2018-12-4 16:59:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SeatDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SeatId] [int] NULL,
	[UserId] [int] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[State] [varchar](10) NULL,
 CONSTRAINT [PK_SeatDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StuRoom]    Script Date: 2018-12-4 16:59:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StuRoom](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[SeatNum] [int] NULL,
	[Empty_Seat] [int] NULL,
	[Addr] [varchar](20) NULL,
	[IsAir] [varchar](10) NULL,
	[State] [varchar](10) NULL,
	[AddTime] [datetime] NULL,
	[Detail] [varchar](500) NULL,
 CONSTRAINT [PK_StuRoom] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 2018-12-4 16:59:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StuNo] [varchar](20) NULL,
	[Password] [varchar](20) NULL,
	[Name] [varchar](20) NULL,
	[Sex] [varchar](2) NULL,
	[Grade] [varchar](10) NULL,
	[Dormitory] [varchar](20) NULL,
	[Image] [varchar](50) NULL,
	[Tel] [varchar](20) NULL,
	[Email] [varchar](20) NULL,
	[RegTime] [datetime] NULL,
 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([Id], [AdminName], [AdminPwd], [Name], [Tel], [Image], [State]) VALUES (1, N'admin', N'123456', N'周明', N'15260966227', N'/File/face2.jpg', N'超级管理员')
INSERT [dbo].[Admin] ([Id], [AdminName], [AdminPwd], [Name], [Tel], [Image], [State]) VALUES (3, N'xuexueqin', N'123456', N'薛雪钦', N'15672647134', N'/File/face20.jpg', N'普通管理员')
SET IDENTITY_INSERT [dbo].[Admin] OFF
SET IDENTITY_INSERT [dbo].[Seat] ON 

INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (1, 2, N'1', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (2, 2, N'2', N'使用中', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (3, 2, N'3', N'使用中', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (4, 2, N'4', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (5, 2, N'5', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (6, 2, N'6', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (7, 2, N'7', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (8, 2, N'8', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (9, 2, N'9', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (10, 2, N'10', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (11, 2, N'11', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (12, 2, N'12', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (13, 2, N'13', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (14, 2, N'14', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (15, 2, N'15', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (16, 2, N'16', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (17, 2, N'17', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (18, 2, N'18', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (19, 2, N'19', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (20, 2, N'20', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (21, 2, N'21', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (22, 2, N'22', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (23, 2, N'23', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (24, 2, N'24', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (25, 2, N'25', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (26, 2, N'26', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (27, 2, N'27', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (28, 2, N'28', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (29, 2, N'29', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (30, 2, N'30', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (31, 3, N'1', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (32, 3, N'2', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (33, 3, N'3', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (34, 3, N'4', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (35, 3, N'5', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (36, 3, N'6', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (37, 3, N'7', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (38, 3, N'8', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (39, 3, N'9', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (40, 3, N'10', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (41, 3, N'11', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (42, 3, N'12', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (43, 3, N'13', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (44, 3, N'14', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (45, 3, N'15', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (46, 3, N'16', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (47, 3, N'17', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (48, 3, N'18', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (49, 3, N'19', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (50, 3, N'20', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (51, 3, N'21', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (52, 3, N'22', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (53, 3, N'23', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (54, 3, N'24', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (55, 3, N'25', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (56, 3, N'26', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (57, 3, N'27', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (58, 3, N'28', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (59, 3, N'29', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (60, 3, N'30', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (61, 3, N'31', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (62, 3, N'32', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (63, 3, N'33', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (64, 3, N'34', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (65, 3, N'35', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (66, 3, N'36', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (67, 3, N'37', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (68, 3, N'38', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (71, 4, N'1', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (72, 4, N'2', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (73, 4, N'3', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (74, 4, N'4', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (75, 4, N'5', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (76, 4, N'6', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (77, 4, N'7', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (78, 4, N'8', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (79, 4, N'9', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (80, 4, N'10', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (81, 4, N'11', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (82, 4, N'12', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (83, 4, N'13', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (84, 4, N'14', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (85, 4, N'15', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (86, 4, N'16', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (87, 4, N'17', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (88, 4, N'18', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (89, 4, N'19', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (90, 4, N'20', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (91, 5, N'1', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (92, 5, N'2', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (93, 5, N'3', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (94, 5, N'4', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (95, 5, N'5', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (96, 5, N'6', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (97, 5, N'7', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (98, 5, N'8', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (99, 5, N'9', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (100, 5, N'10', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (101, 5, N'11', N'空闲', NULL)
GO
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (102, 5, N'12', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (103, 5, N'13', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (104, 5, N'14', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (105, 5, N'15', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (106, 5, N'16', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (107, 5, N'17', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (108, 5, N'18', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (109, 5, N'19', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (110, 5, N'20', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (111, 5, N'21', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (112, 5, N'22', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (113, 5, N'23', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (114, 5, N'24', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (115, 5, N'25', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (116, 5, N'26', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (117, 5, N'27', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (118, 5, N'28', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (119, 5, N'29', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (120, 5, N'30', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (121, 6, N'1', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (122, 6, N'2', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (123, 6, N'3', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (124, 6, N'4', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (125, 6, N'5', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (126, 6, N'6', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (127, 6, N'7', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (128, 6, N'8', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (129, 6, N'9', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (130, 6, N'10', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (131, 6, N'11', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (132, 6, N'12', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (133, 6, N'13', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (134, 6, N'14', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (135, 6, N'15', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (136, 6, N'16', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (137, 6, N'17', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (138, 6, N'18', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (139, 6, N'19', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (140, 6, N'20', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (141, 6, N'21', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (142, 6, N'22', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (143, 6, N'23', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (144, 6, N'24', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (145, 6, N'25', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (146, 6, N'26', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (147, 6, N'27', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (148, 6, N'28', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (149, 6, N'29', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (150, 6, N'30', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (151, 7, N'1', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (152, 7, N'2', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (153, 7, N'3', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (154, 7, N'4', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (155, 7, N'5', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (156, 7, N'6', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (157, 7, N'7', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (158, 7, N'8', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (159, 7, N'9', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (160, 7, N'10', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (161, 7, N'11', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (162, 7, N'12', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (163, 7, N'13', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (164, 7, N'14', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (165, 7, N'15', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (166, 7, N'16', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (167, 7, N'17', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (168, 7, N'18', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (169, 7, N'19', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (170, 7, N'20', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (171, 7, N'21', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (172, 7, N'22', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (173, 7, N'23', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (174, 7, N'24', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (175, 7, N'25', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (176, 7, N'26', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (177, 7, N'27', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (178, 7, N'28', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (179, 7, N'29', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (180, 7, N'30', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (181, 7, N'31', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (182, 7, N'32', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (183, 7, N'33', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (184, 7, N'34', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (185, 7, N'35', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (186, 7, N'36', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (187, 7, N'37', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (188, 7, N'38', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (189, 7, N'39', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (190, 7, N'40', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (191, 8, N'1', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (192, 8, N'2', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (193, 8, N'3', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (194, 8, N'4', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (195, 8, N'5', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (196, 8, N'6', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (197, 8, N'7', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (198, 8, N'8', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (199, 8, N'9', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (200, 8, N'10', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (201, 8, N'11', N'空闲', NULL)
GO
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (202, 8, N'12', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (203, 8, N'13', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (204, 8, N'14', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (205, 8, N'15', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (206, 8, N'16', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (207, 8, N'17', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (208, 8, N'18', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (209, 8, N'19', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (210, 8, N'20', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (211, 8, N'21', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (212, 8, N'22', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (213, 8, N'23', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (214, 8, N'24', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (215, 8, N'25', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (216, 8, N'26', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (217, 8, N'27', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (218, 8, N'28', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (219, 8, N'29', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (220, 8, N'30', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (221, 8, N'31', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (222, 8, N'32', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (223, 8, N'33', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (224, 8, N'34', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (225, 8, N'35', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (226, 8, N'36', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (227, 8, N'37', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (228, 8, N'38', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (229, 8, N'39', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (230, 8, N'40', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (231, 8, N'41', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (232, 8, N'42', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (233, 8, N'43', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (234, 8, N'44', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (235, 8, N'45', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (236, 8, N'46', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (237, 8, N'47', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (238, 8, N'48', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (239, 8, N'49', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (240, 8, N'50', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (246, 3, N'39', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (247, 3, N'40', N'空闲', NULL)
INSERT [dbo].[Seat] ([Id], [RoomId], [SeatNo], [State], [SaveTime]) VALUES (248, 3, N'41', N'空闲', NULL)
SET IDENTITY_INSERT [dbo].[Seat] OFF
SET IDENTITY_INSERT [dbo].[SeatDetail] ON 

INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (4, 30, 1, CAST(0x0000A9A701070964 AS DateTime), CAST(0x0000A9A800C1DA47 AS DateTime), N'离座')
INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (6, 30, 1, CAST(0x0000A9A9001BBD06 AS DateTime), CAST(0x0000A9A9001C19F4 AS DateTime), N'离座')
INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (7, 30, 1, CAST(0x0000A9A9001CCF06 AS DateTime), CAST(0x0000A9A9001D2C03 AS DateTime), N'离座')
INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (8, 30, 1, CAST(0x0000A9A9001DD015 AS DateTime), CAST(0x0000A9A9001E08F3 AS DateTime), N'离座')
INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (9, 30, 1, CAST(0x0000A9A9001EA37A AS DateTime), CAST(0x0000A9A9001F224F AS DateTime), N'离座')
INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (10, 30, 1, CAST(0x0000A9A900211BB8 AS DateTime), CAST(0x0000A9A90021612D AS DateTime), N'离座')
INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (1006, 30, 1, CAST(0x0000A9AA00A6C6EE AS DateTime), CAST(0x0000A9AB00DE81A4 AS DateTime), N'离座')
INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (1007, 1, 3, CAST(0x0000A9AB00B502DD AS DateTime), CAST(0x0000A9AB00D9C3B7 AS DateTime), N'离座')
INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (1008, 2, 2, CAST(0x0000A9AB00B51763 AS DateTime), NULL, N'正常')
INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (1009, 3, 4, CAST(0x0000A9AB00B56949 AS DateTime), NULL, N'正常')
INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (1010, 4, 3, CAST(0x0000A9AB00D9CF3D AS DateTime), CAST(0x0000A9AB00D9DD95 AS DateTime), N'离座')
INSERT [dbo].[SeatDetail] ([Id], [SeatId], [UserId], [StartTime], [EndTime], [State]) VALUES (1011, 1, 1, CAST(0x0000A9AB00DE8F20 AS DateTime), CAST(0x0000A9AB00DEDAC2 AS DateTime), N'离座')
SET IDENTITY_INSERT [dbo].[SeatDetail] OFF
SET IDENTITY_INSERT [dbo].[StuRoom] ON 

INSERT [dbo].[StuRoom] ([Id], [Name], [SeatNum], [Empty_Seat], [Addr], [IsAir], [State], [AddTime], [Detail]) VALUES (2, N'圆梦', 30, 29, N'勤奋楼一层', N'有', N'正常', CAST(0x0000A9A600F8924C AS DateTime), NULL)
INSERT [dbo].[StuRoom] ([Id], [Name], [SeatNum], [Empty_Seat], [Addr], [IsAir], [State], [AddTime], [Detail]) VALUES (3, N'乘风', 41, 41, N'勤奋楼二层', N'有', N'正常', CAST(0x0000A9A60107449F AS DateTime), NULL)
INSERT [dbo].[StuRoom] ([Id], [Name], [SeatNum], [Empty_Seat], [Addr], [IsAir], [State], [AddTime], [Detail]) VALUES (4, N'彼岸', 20, 20, N'勤奋楼三层', N'有', N'正常', CAST(0x0000A9A6010772B4 AS DateTime), NULL)
INSERT [dbo].[StuRoom] ([Id], [Name], [SeatNum], [Empty_Seat], [Addr], [IsAir], [State], [AddTime], [Detail]) VALUES (5, N'自勉', 30, 30, N'文博楼一层', N'有', N'正常', CAST(0x0000A9A6010793CE AS DateTime), NULL)
INSERT [dbo].[StuRoom] ([Id], [Name], [SeatNum], [Empty_Seat], [Addr], [IsAir], [State], [AddTime], [Detail]) VALUES (6, N'奔跑', 30, 30, N'文博楼二层', N'有', N'正常', CAST(0x0000A9A60107BD1A AS DateTime), NULL)
INSERT [dbo].[StuRoom] ([Id], [Name], [SeatNum], [Empty_Seat], [Addr], [IsAir], [State], [AddTime], [Detail]) VALUES (7, N'梦想', 40, 40, N'文博楼三层', N'有', N'正常', CAST(0x0000A9A60107EAEF AS DateTime), NULL)
INSERT [dbo].[StuRoom] ([Id], [Name], [SeatNum], [Empty_Seat], [Addr], [IsAir], [State], [AddTime], [Detail]) VALUES (8, N'留香', 50, 50, N'文博楼四层', N'有', N'正常', CAST(0x0000A9A60108272A AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[StuRoom] OFF
SET IDENTITY_INSERT [dbo].[UserInfo] ON 

INSERT [dbo].[UserInfo] ([Id], [StuNo], [Password], [Name], [Sex], [Grade], [Dormitory], [Image], [Tel], [Email], [RegTime]) VALUES (1, N'651499253@qq.com', N'123456', N'雪雪', N'女', N'20', N'福建省福州市工程学院', N'/File/63679173430460.jpeg', N'15260966227', N'651499253@qq.com', CAST(0x0000A9A50110A60C AS DateTime))
INSERT [dbo].[UserInfo] ([Id], [StuNo], [Password], [Name], [Sex], [Grade], [Dormitory], [Image], [Tel], [Email], [RegTime]) VALUES (2, N'13625022070', N'123456', N'匿名', NULL, NULL, NULL, N'/File/face5.jpg', N'13625022070', NULL, CAST(0x0000A9AB00B420D9 AS DateTime))
INSERT [dbo].[UserInfo] ([Id], [StuNo], [Password], [Name], [Sex], [Grade], [Dormitory], [Image], [Tel], [Email], [RegTime]) VALUES (3, N'445214697@qq.com', N'123456', N'谢大大', N'男', N'24', NULL, N'/File/face27.jpg', N'13860626309', N'445214697@qq.com', CAST(0x0000A9AB00B4D6EC AS DateTime))
INSERT [dbo].[UserInfo] ([Id], [StuNo], [Password], [Name], [Sex], [Grade], [Dormitory], [Image], [Tel], [Email], [RegTime]) VALUES (4, N'13696865836', N'123456', N'匿名', NULL, NULL, NULL, N'/File/face7.jpg', N'13696865836', NULL, CAST(0x0000A9AB00B54695 AS DateTime))
SET IDENTITY_INSERT [dbo].[UserInfo] OFF
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD  CONSTRAINT [FK_Seat_StuRoom] FOREIGN KEY([RoomId])
REFERENCES [dbo].[StuRoom] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Seat] CHECK CONSTRAINT [FK_Seat_StuRoom]
GO
ALTER TABLE [dbo].[SeatDetail]  WITH CHECK ADD  CONSTRAINT [FK_SeatDetail_Seat] FOREIGN KEY([SeatId])
REFERENCES [dbo].[Seat] ([Id])
GO
ALTER TABLE [dbo].[SeatDetail] CHECK CONSTRAINT [FK_SeatDetail_Seat]
GO
ALTER TABLE [dbo].[SeatDetail]  WITH CHECK ADD  CONSTRAINT [FK_SeatDetail_UserInfo] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserInfo] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SeatDetail] CHECK CONSTRAINT [FK_SeatDetail_UserInfo]
GO
USE [master]
GO
ALTER DATABASE [SelfStudyRoom] SET  READ_WRITE 
GO
