USE [master]
GO
/****** Object:  Database [ECO]    Script Date: 6/6/2021 3:39:20 AM ******/
CREATE DATABASE [ECO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BanOto', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ECO.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BanOto_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ECO_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ECO] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ECO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ECO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ECO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ECO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ECO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ECO] SET ARITHABORT OFF 
GO
ALTER DATABASE [ECO] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ECO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ECO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ECO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ECO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ECO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ECO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ECO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ECO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ECO] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ECO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ECO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ECO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ECO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ECO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ECO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ECO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ECO] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ECO] SET  MULTI_USER 
GO
ALTER DATABASE [ECO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ECO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ECO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ECO] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ECO] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ECO] SET QUERY_STORE = OFF
GO
USE [ECO]
GO
/****** Object:  Table [dbo].[chi_tiet_hoa_don]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chi_tiet_hoa_don](
	[ma_chi_tiet] [varchar](50) NOT NULL,
	[ma_hoa_don] [varchar](50) NULL,
	[item_id] [varchar](50) NULL,
	[so_luong] [int] NULL,
 CONSTRAINT [PK_chi_tiet_hoa_don] PRIMARY KEY CLUSTERED 
(
	[ma_chi_tiet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hoa_don]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hoa_don](
	[ma_hoa_don] [varchar](50) NOT NULL,
	[ho_ten] [nvarchar](150) NULL,
	[dia_chi] [nvarchar](250) NULL,
 CONSTRAINT [PK_hoa_don] PRIMARY KEY CLUSTERED 
(
	[ma_hoa_don] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[item]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[item](
	[item_id] [varchar](50) NOT NULL,
	[item_group_id] [varchar](50) NULL,
	[item_name] [nvarchar](150) NULL,
	[item_image] [varchar](250) NULL,
	[item_price] [float] NULL,
	[item_description] [nvarchar](max) NULL,
	[item_content] [nvarchar](max) NULL,
 CONSTRAINT [PK_item] PRIMARY KEY CLUSTERED 
(
	[item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[item_group]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[item_group](
	[parent_item_group_id] [varchar](50) NULL,
	[item_group_id] [varchar](50) NOT NULL,
	[item_group_name] [nvarchar](250) NULL,
	[seq_num] [smallint] NULL,
	[url] [varchar](150) NULL,
 CONSTRAINT [PK_item_group] PRIMARY KEY CLUSTERED 
(
	[item_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[user_id] [varchar](50) NOT NULL,
	[hoten] [nvarchar](150) NULL,
	[diachi] [nvarchar](250) NULL,
	[email] [varchar](150) NULL,
	[taikhoan] [varchar](30) NULL,
	[matkhau] [varchar](60) NULL,
	[image_url] [varchar](300) NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[chi_tiet_hoa_don] ([ma_chi_tiet], [ma_hoa_don], [item_id], [so_luong]) VALUES (N'28422ea0-6d3b-4261-8603-c922b1c88ea3', N'dc6111e9-acda-46e0-813a-f370b13903d2', N'd5385f29-7da4-4c10-8103-5b502a12dfc9', 5)
INSERT [dbo].[chi_tiet_hoa_don] ([ma_chi_tiet], [ma_hoa_don], [item_id], [so_luong]) VALUES (N'653e6d28-9ff9-46ac-b172-ed2e11f4d06d', N'3f0c5ff5-b54e-481a-9372-a2fc302cd5f4', N'5845f819-72ac-4cda-929f-e8f906de7ba1', 5)
INSERT [dbo].[chi_tiet_hoa_don] ([ma_chi_tiet], [ma_hoa_don], [item_id], [so_luong]) VALUES (N'77476c39-f907-4564-ac14-6caf10af3fdc', N'ba8e40d9-d93c-41a5-a88b-6779996b3942', N'f9b7996b-eea9-4b16-812c-b75c12102582', 2)
INSERT [dbo].[chi_tiet_hoa_don] ([ma_chi_tiet], [ma_hoa_don], [item_id], [so_luong]) VALUES (N'89b1b37c-f311-4186-8f82-ad36dc19c8d4', N'dc6111e9-acda-46e0-813a-f370b13903d2', N'f9b7996b-eea9-4b16-812c-b75c12102582', 7)
INSERT [dbo].[chi_tiet_hoa_don] ([ma_chi_tiet], [ma_hoa_don], [item_id], [so_luong]) VALUES (N'9a2b3705-16e8-4fee-9f16-1aac66d53620', N'3f0c5ff5-b54e-481a-9372-a2fc302cd5f4', N'd5385f29-7da4-4c10-8103-5b502a12dfc9', 5)
INSERT [dbo].[chi_tiet_hoa_don] ([ma_chi_tiet], [ma_hoa_don], [item_id], [so_luong]) VALUES (N'e4f755b1-b770-4d4d-8992-44bdc118c7cc', N'dc6111e9-acda-46e0-813a-f370b13903d2', N'5845f819-72ac-4cda-929f-e8f906de7ba1', 4)
INSERT [dbo].[chi_tiet_hoa_don] ([ma_chi_tiet], [ma_hoa_don], [item_id], [so_luong]) VALUES (N'f9beae1b-2add-453e-aa15-ecd13381648c', N'ba8e40d9-d93c-41a5-a88b-6779996b3942', N'5845f819-72ac-4cda-929f-e8f906de7ba1', 4)
INSERT [dbo].[chi_tiet_hoa_don] ([ma_chi_tiet], [ma_hoa_don], [item_id], [so_luong]) VALUES (N'fee00555-618a-4a5e-a33c-7b87fb874b2f', N'3f0c5ff5-b54e-481a-9372-a2fc302cd5f4', N'd6ef52e7-fa2d-4f56-991f-ea09d23f0410', 5)
GO
INSERT [dbo].[hoa_don] ([ma_hoa_don], [ho_ten], [dia_chi]) VALUES (N'3f0c5ff5-b54e-481a-9372-a2fc302cd5f4', N'Khách hàng 1', N'Hưng Yên')
INSERT [dbo].[hoa_don] ([ma_hoa_don], [ho_ten], [dia_chi]) VALUES (N'ba8e40d9-d93c-41a5-a88b-6779996b3942', N'Vũ Chung Dũng', N'Hưng Yên')
INSERT [dbo].[hoa_don] ([ma_hoa_don], [ho_ten], [dia_chi]) VALUES (N'dc6111e9-acda-46e0-813a-f370b13903d2', N'Nguyễn Thị Thảo', N'Hưng Yên')
GO
INSERT [dbo].[item] ([item_id], [item_group_id], [item_name], [item_image], [item_price], [item_description], [item_content]) VALUES (N'079c0327-dd48-41d9-b9dd-1a4c462c717c', N'8240d2fb-972d-42f5-a568-10362bbbdaff', N'9 miếng Gà McNuggets', N'wwwroot/img\9pcs-chicken-mcnuggets.png', 69000, N'9 miếng Gà McNuggets', N'<p>9 miếng G&agrave; McNuggets</p>
')
INSERT [dbo].[item] ([item_id], [item_group_id], [item_name], [item_image], [item_price], [item_description], [item_content]) VALUES (N'252ab41b-b042-459f-a027-28bf54626f92', N'8240d2fb-972d-42f5-a568-10362bbbdaff', N'Phần ăn 2 miếng gà rán', N'wwwroot/img\6-wings.png', 166000, N'Phần ăn 2 miếng gà rán', N'<p>Phần ăn 2 miếng g&agrave; r&aacute;n</p>
')
INSERT [dbo].[item] ([item_id], [item_group_id], [item_name], [item_image], [item_price], [item_description], [item_content]) VALUES (N'5845f819-72ac-4cda-929f-e8f906de7ba1', N'f0343da4-e5dc-42aa-ba91-e6359dbe29d9', N'Bò phô mai đặc biệt', N'wwwroot/img\bigmac.png', 49000, N'Bò phô mai đặc biệt', N'<p>B&ograve; ph&ocirc; mai đặc biệt</p>
')
INSERT [dbo].[item] ([item_id], [item_group_id], [item_name], [item_image], [item_price], [item_description], [item_content]) VALUES (N'c3741bfa-f7a0-448d-9521-a29d5d4b3c1a', N'f0343da4-e5dc-42aa-ba91-e6359dbe29d9', N'Burger Gà', N'wwwroot/img\cheese-burger-deluxe.png', 32000, N'Burger Gà', N'<p>Burger G&agrave;</p>
')
INSERT [dbo].[item] ([item_id], [item_group_id], [item_name], [item_image], [item_price], [item_description], [item_content]) VALUES (N'd5385f29-7da4-4c10-8103-5b502a12dfc9', N'8240d2fb-972d-42f5-a568-10362bbbdaff', N'6 Miếng Cánh Gà', N'wwwroot/img\6-wings.png', 165000, N'6 Miếng Cánh Gà', N'<p>6 Miếng C&aacute;nh G&agrave;</p>
')
INSERT [dbo].[item] ([item_id], [item_group_id], [item_name], [item_image], [item_price], [item_description], [item_content]) VALUES (N'd6ef52e7-fa2d-4f56-991f-ea09d23f0410', N'f0343da4-e5dc-42aa-ba91-e6359dbe29d9', N'Burger Bò miếng lớn phô-mai', N'wwwroot/img\mcroyal-with-cheese.png', 49000, N'Burger Bò miếng lớn phô-mai', N'<p>Burger B&ograve; miếng lớn ph&ocirc;-mai</p>
')
INSERT [dbo].[item] ([item_id], [item_group_id], [item_name], [item_image], [item_price], [item_description], [item_content]) VALUES (N'd99f3e3e-c32c-4459-b843-091fbd7d6a96', N'f0343da4-e5dc-42aa-ba91-e6359dbe29d9', N'Burger phi-lê gà cay đặc biệt', N'wwwroot/img\mcspicy-deluxe.png', 79000, N'Burger phi-lê gà cay đặc biệt', N'<p>Burger phi-l&ecirc; g&agrave; cay đặc biệt</p>
')
INSERT [dbo].[item] ([item_id], [item_group_id], [item_name], [item_image], [item_price], [item_description], [item_content]) VALUES (N'f9b7996b-eea9-4b16-812c-b75c12102582', N'f0343da4-e5dc-42aa-ba91-e6359dbe29d9', N'Burger Bò miếng lớn phô-mai', N'wwwroot/img\bigmac.png', 59000, N'Burger Bò miếng lớn phô-mai', N'<p>Burger B&ograve; miếng lớn ph&ocirc;-mai</p>
')
GO
INSERT [dbo].[item_group] ([parent_item_group_id], [item_group_id], [item_group_name], [seq_num], [url]) VALUES (NULL, N'2046176a-27a4-4934-8c5c-8a2e0b41445d', N'Phần ăn cho bé', NULL, NULL)
INSERT [dbo].[item_group] ([parent_item_group_id], [item_group_id], [item_group_name], [seq_num], [url]) VALUES (NULL, N'2b0e01ef-e8d0-4dc8-ae95-4136e8a72ab1', N'Gà rán', NULL, NULL)
INSERT [dbo].[item_group] ([parent_item_group_id], [item_group_id], [item_group_name], [seq_num], [url]) VALUES (NULL, N'2d8eddf8-9f72-4ad1-8f91-c086e587ebbd', N'Thức uống', NULL, NULL)
INSERT [dbo].[item_group] ([parent_item_group_id], [item_group_id], [item_group_name], [seq_num], [url]) VALUES (NULL, N'8240d2fb-972d-42f5-a568-10362bbbdaff', N'Combo', NULL, NULL)
INSERT [dbo].[item_group] ([parent_item_group_id], [item_group_id], [item_group_name], [seq_num], [url]) VALUES (NULL, N'826cc3af-c7dd-4db1-bd20-7707676736e6', N'Tráng miệng', NULL, NULL)
INSERT [dbo].[item_group] ([parent_item_group_id], [item_group_id], [item_group_name], [seq_num], [url]) VALUES (NULL, N'8f31c7c8-8b6f-45f7-b54b-a7418d9f7ae7', N'Món ăn nhẹ', NULL, NULL)
INSERT [dbo].[item_group] ([parent_item_group_id], [item_group_id], [item_group_name], [seq_num], [url]) VALUES (NULL, N'93b413e4-9c69-40f2-9bbe-0fa03eb52854', N'Cơm', NULL, NULL)
INSERT [dbo].[item_group] ([parent_item_group_id], [item_group_id], [item_group_name], [seq_num], [url]) VALUES (NULL, N'dd968796-bc9c-4dcf-bd66-8a6bc9166ca3', N'Phần ăn EVM', NULL, NULL)
INSERT [dbo].[item_group] ([parent_item_group_id], [item_group_id], [item_group_name], [seq_num], [url]) VALUES (NULL, N'f0343da4-e5dc-42aa-ba91-e6359dbe29d9', N'Bánh Burgers', NULL, NULL)
GO
/****** Object:  StoredProcedure [dbo].[sp_hoa_don_create]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_hoa_don_create]
(@ma_hoa_don              VARCHAR(50), 
 @ho_ten          NVARCHAR(150), 
 @dia_chi          NVARCHAR(250),  
 @listjson_chitiet NVARCHAR(MAX)
)
AS
    BEGIN
        INSERT INTO hoa_don
                (ma_hoa_don, 
                 ho_ten, 
                 dia_chi               
                )
                VALUES
                (@ma_hoa_don, 
                 @ho_ten, 
                 @dia_chi
                );
                IF(@listjson_chitiet IS NOT NULL)
                    BEGIN
                        INSERT INTO chi_tiet_hoa_don
                        (ma_chi_tiet, 
                         ma_hoa_don, 
                         item_id, 
                         so_luong                       
                        )
                               SELECT JSON_VALUE(p.value, '$.ma_chi_tiet'), 
                                      @ma_hoa_don, 
                                      JSON_VALUE(p.value, '$.item_id'), 
                                      JSON_VALUE(p.value, '$.so_luong')    
                               FROM OPENJSON(@listjson_chitiet) AS p;
                END;
        SELECT '';
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_hoa_don_delete]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_hoa_don_delete]
(@ma_hoa_don              varchar(50) 
)
AS
    BEGIN
		delete from [chi_tiet_hoa_don] where ma_hoa_don = @ma_hoa_don;
		delete from [hoa_don] where ma_hoa_don = @ma_hoa_don;
        SELECT '';
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_hoa_don_get_by_id]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_hoa_don_get_by_id](@ma_hoa_don VARCHAR(50))
AS
    BEGIN
        SELECT u.ma_hoa_don, 
               u.ho_ten, 
               u.dia_chi,
        (
            SELECT p.ma_chi_tiet, 
                   p.ma_hoa_don, 
                   p.item_id, 
                   p.so_luong
				   FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        ) AS listjson_chitiet
        FROM dbo.hoa_don AS u,
             dbo.chi_tiet_hoa_don AS p WHERE u.ma_hoa_don = p.ma_hoa_don
        AND u.ma_hoa_don = @ma_hoa_don
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_hoa_don_search]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_hoa_don_search] (@page_index  INT, 
                                       @page_size   INT,
									   @hoten Nvarchar(150),
									   @diachi Nvarchar(250)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY ho_ten ASC)) AS RowNumber, 
                              h.ma_hoa_don, 
                              h.ho_ten, 
							  h.dia_chi                               
                        INTO #Results1
                        FROM [hoa_don] AS h
					    WHERE  (@hoten = '' Or h.ho_ten like N'%'+@hoten+'%') and	
						(@diachi = '' Or h.dia_chi like N'%'+@diachi+'%');                  
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
                         SELECT(ROW_NUMBER() OVER(
                              ORDER BY ho_ten ASC)) AS RowNumber, 
                              h.ma_hoa_don, 
                              h.ho_ten, 
							  h.dia_chi                               
                        INTO #Results2
                        FROM [hoa_don] AS h
					    WHERE  (@hoten = '' Or h.ho_ten like N'%'+@hoten+'%') and	
						(@diachi = '' Or h.dia_chi like N'%'+@diachi+'%');                        
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_hoa_don_update]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_hoa_don_update]
(@ma_hoa_don              VARCHAR(50), 
 @ho_ten          NVARCHAR(150), 
 @dia_chi          NVARCHAR(250),  
 @listjson_chitiet NVARCHAR(MAX)
)
AS
    BEGIN
        UPDATE hoa_don
                SET ho_ten = @ho_ten, dia_chi = @dia_chi WHERE ma_hoa_don = @ma_hoa_don;
                IF(@listjson_chitiet IS NOT NULL)
                    BEGIN
                        UPDATE chi_tiet_hoa_don
                        SET
                            ma_hoa_don = JSON_VALUE(p.value, '$.ma_hoa_don'), 
							item_id = JSON_VALUE(p.value, '$.item_id'), 
							so_luong = JSON_VALUE(p.value, '$.so_luong')   
						FROM OPENJSON(@listjson_chitiet) AS p
						WHERE ma_chi_tiet = JSON_VALUE(p.value, '$.ma_chi_tiet')
                END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_item_all]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create PROCEDURE [dbo].[sp_item_all]
AS
    BEGIN
        SELECT item.item_id, 
               item.item_group_id, 
               item.item_image, 
			   item.item_name, 
			   item.item_price                         
        FROM item 
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_item_create]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_item_create]
(@item_id             VARCHAR(50), 
 @item_group_id       VARCHAR(50), 
 @item_image          VARCHAR(250), 
 @item_name           NVARCHAR(150), 
 @item_price          float,
 @item_description	  NVARCHAR(MAX),
 @item_content   	  NVARCHAR(MAX)
)
AS
    BEGIN
      INSERT INTO item
                (item_id, 
                 item_group_id, 
                 item_image, 
                 item_name, 
                 item_price,
				 item_description,
				 item_content
                )
                VALUES
                (@item_id, 
                 @item_group_id, 
                 @item_image, 
                 @item_name, 
                 @item_price,
				 @item_description,
				 @item_content
                );
        SELECT '';
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_item_del]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_item_del]
(@id varchar(50))
as
begin
	delete item where item_id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[sp_item_get_by_id]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_item_get_by_id](@item_id VARCHAR(50))
AS
    BEGIN
        SELECT item.item_id, 
               item.item_group_id, 
               item.item_image, 
			   item.item_name, 
			   item.item_price,
			   item.item_description,
			   item.item_content
        FROM item
      where  item.item_id = @item_id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_item_group_create]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_item_group_create]
(@item_group_id              varchar(50), 
 @item_group_name         nvarchar(150) ,
 @parent_item_group_id varchar(50)
)
AS
    BEGIN
      INSERT INTO [item_group]
                (
				 	 item_group_id              , 
					 item_group_name           ,
					 parent_item_group_id          
					 
				)
                VALUES
                (
				 @item_group_id               , 
				 @item_group_name           ,
				 @parent_item_group_id          
				);
        SELECT '';
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_item_group_delete]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_item_group_delete]
(@item_group_id              varchar(50) 
)
AS
    BEGIN
		delete from [item_group] where item_group_id = @item_group_id;
        SELECT '';
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_item_group_get_by_id]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_item_group_get_by_id]
(@item_group_id              varchar(50) 
)
AS
    BEGIN
		select * from [item_group] where item_group_id = @item_group_id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_item_group_get_data]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_item_group_get_data]
AS
    BEGIN
        SELECT item_group.parent_item_group_id, 
               item_group.item_group_id, 
               item_group.item_group_name, 
               item_group.seq_num,
			   item_group.url
        FROM item_group
        ORDER BY item_group.seq_num;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_item_group_search]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_item_group_search] (@page_index  INT, 
                                       @page_size   INT
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF @page_size <> 0
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY item_group_name ASC)) AS RowNumber, 
                              i.item_group_id, 
							  i.item_group_name
                        INTO #Results1
                        FROM [item_group] AS i
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
        end;
GO
/****** Object:  StoredProcedure [dbo].[sp_item_group_update]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_item_group_update]
(@item_group_id             VARCHAR(50), 
 @parent_item_group_id       VARCHAR(50), 
 @item_group_name           NVARCHAR(150)
)
as
begin
	update item_group set parent_item_group_id = @parent_item_group_id, item_group_name = @item_group_name
	where item_group_id = @item_group_id
end
GO
/****** Object:  StoredProcedure [dbo].[sp_item_search]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE PROCEDURE [dbo].[sp_item_search] (@page_index  INT, 
                                       @page_size   INT,
									   @item_group_id Nvarchar(50))
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF @page_size <> 0 AND @item_group_id <> NULL
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY item_name ASC)) AS RowNumber, 
                              i.item_id, 
                              i.item_group_id, 
                              i.item_name , 
                              i.item_image, 
                              i.item_price,
							  i.item_description
                        INTO #Results1
                        FROM [item] AS i
					    WHERE i.item_group_id = @item_group_id;                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
		IF(@item_group_id IS NULL)
			BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY item_name ASC)) AS RowNumber, 
                              i.item_id, 
                              i.item_group_id, 
                              i.item_name , 
                              i.item_image, 
                              i.item_price,
							  i.item_description
                        INTO #Results3
                        FROM [item] AS i					              
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results3;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results3
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results3; 
            END;
			
        ELSE
            BEGIN
                SET NOCOUNT ON;
                         SELECT(ROW_NUMBER() OVER(
                               ORDER BY item_name ASC)) AS RowNumber, 
                              i.item_id, 
                              i.item_group_id, 
                              i.item_name , 
                              i.item_image, 
                              i.item_price,
							  i.item_description
                        INTO #Results2
                        FROM [item] AS i
						WHERE i.item_group_id = @item_group_id;  
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_item_update]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_item_update]
(@item_id             VARCHAR(50), 
 @item_group_id       VARCHAR(50), 
 @item_image          VARCHAR(250), 
 @item_name           NVARCHAR(150), 
 @item_price          float,
 @item_description	  NVARCHAR(MAX),
 @item_content   	  NVARCHAR(MAX)
)
as
begin
	update item set item_name = @item_name, item_price = @item_price, item_image = @item_image, item_group_id = @item_group_id, item_description = @item_description, item_content = @item_content
	where item_id = @item_id
end
GO
/****** Object:  StoredProcedure [dbo].[sp_user_create]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_user_create]
(@user_id              varchar(50), 
 @hoten          nvarchar(150) ,
 @ngaysinh         date  ,
 @diachi          nvarchar(250)  ,
 @gioitinh         nvarchar(30)  ,
 @email          varchar(150) ,
 @taikhoan         varchar(30) ,
 @matkhau         varchar(60)  ,
 @role          varchar(30) ,
 @image_url varchar(300) 
)
AS
    BEGIN
      INSERT INTO [user]
                (
				 	 [user_id]               , 
					 hoten           ,
					 ngaysinh          ,
					 diachi           ,
					 gioitinh           ,
					 email           ,
					 taikhoan         ,
					 matkhau           ,
					 role    ,
					 image_url
				)
                VALUES
                (
				 @user_id               , 
				 @hoten           ,
				 @ngaysinh          ,
				 @diachi           ,
				 @gioitinh           ,
				 @email           ,
				 @taikhoan         ,
				 @matkhau           ,
				 @role ,
				 @image_url
				);
        SELECT '';
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_user_delete]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_user_delete]
(@user_id              varchar(50) 
)
AS
    BEGIN
		delete from [user] where user_id = @user_id;
        SELECT '';
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_user_get_by_id]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_user_get_by_id](@user_id VARCHAR(50))
AS
    BEGIN
        SELECT  [user_id]               , 
					 hoten           ,
					 ngaysinh          ,
					 diachi           ,
					 gioitinh           ,
					 email           ,
					 taikhoan         ,
					 matkhau           ,
					 role      ,
					 image_url  
        FROM [user]
      where  [user_id] = @user_id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_user_get_by_username_password]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_user_get_by_username_password](@taikhoan varchar(30), @matkhau varchar(60))
AS
    BEGIN
        SELECT  [user_id]               , 
					 hoten           ,
					 ngaysinh          ,
					 diachi           ,
					 gioitinh           ,
					 email           ,
					 taikhoan         ,
					 role      ,
					 image_url  
        FROM [user]
      where  taikhoan = @taikhoan and matkhau = @matkhau ;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_user_search]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_user_search] (@page_index  INT, 
                                       @page_size   INT,
									   @hoten nvarchar(150),
									    @taikhoan varchar(30)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY u.hoten ASC)) AS RowNumber, 
                             u.user_id              , 
							 u.hoten           ,
							 u.ngaysinh          ,
							 u.diachi           ,
							 u.gioitinh           ,
							 u.email           ,
							 u.taikhoan         ,
							 u.matkhau           ,
							 u.role  ,
							 u.image_url  
                        INTO #Results1
                        FROM [user] AS u
						WHERE (u.taikhoan <> 'Admin') and ((@hoten = '') OR (u.hoten LIKE '%' + @hoten + '%')) and  ((@taikhoan = '') OR (u.taikhoan = @taikhoan));
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
                         SELECT(ROW_NUMBER() OVER(
                              ORDER BY u.hoten ASC)) AS RowNumber, 
                             u.user_id              , 
							 u.hoten           ,
							 u.ngaysinh          ,
							 u.diachi           ,
							 u.gioitinh           ,
							 u.email           ,
							 u.taikhoan         ,
							 u.matkhau           ,
							 u.role     ,
							 u.image_url  
                        INTO #Results2
                        FROM [user] AS u
						WHERE (u.taikhoan <> 'Admin') and ((@hoten = '') OR (u.hoten LIKE '%' + @hoten + '%')) and  ((@taikhoan = '') OR (u.taikhoan = @taikhoan));
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_user_update]    Script Date: 6/6/2021 3:39:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_user_update]
(@user_id              varchar(50), 
 @hoten          nvarchar(150) ,
 @ngaysinh         date  ,
 @diachi          nvarchar(250)  ,
 @gioitinh         nvarchar(30)  ,
 @email          varchar(150) ,
 @taikhoan         varchar(30) ,
 @matkhau         varchar(60)  ,
 @role          varchar(30),
 @image_url         varchar(300)
)
AS
    BEGIN
   update [user] set 
				hoten= @hoten           ,
				ngaysinh= @ngaysinh          ,
				diachi= @diachi           ,
				gioitinh= @gioitinh           ,
				email= @email           ,
				matkhau = @matkhau           ,
				role= @role ,
				image_url = @image_url 
				where user_id = @user_id;
			 
        SELECT '';
    END;
GO
USE [master]
GO
ALTER DATABASE [ECO] SET  READ_WRITE 
GO
