USE [master]
GO
/****** Object:  Database [QLKS]    Script Date: 12/10/2018 10:28:16 PM ******/
CREATE DATABASE [QLKS]

ALTER DATABASE [QLKS] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLKS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLKS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLKS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLKS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLKS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLKS] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLKS] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QLKS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLKS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLKS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLKS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLKS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLKS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLKS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLKS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLKS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLKS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLKS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLKS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLKS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLKS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLKS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLKS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLKS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLKS] SET  MULTI_USER 
GO
ALTER DATABASE [QLKS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLKS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLKS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLKS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QLKS] SET DELAYED_DURABILITY = DISABLED 
GO
USE [QLKS]
GO
/****** Object:  UserDefinedFunction [dbo].[Func_DangNhap_KhachHang]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--3.Đăng nhập
/*CREATE NONCLUSTERED INDEX Index_Login_KhachHang ON dbo.KhachHang()
GO*/

--Trả về 1: Đăng nhập thành công, 0:Thất bại
/*CREATE PROC Proc_DangNhap_KhachHang
@TenDangNhap VARCHAR(20), @MatKhau VARCHAR(20)
AS
BEGIN
	IF (EXISTS(SELECT * FROM dbo.KhachHang WHERE tenDangNhap=@TenDangNhap))
		BEGIN
			IF (NOT EXISTS(SELECT * FROM dbo.KhachHang WHERE matKhau=@MatKhau))
			BEGIN
				PRINT N'Mật khẩu không đúng'
				RETURN 0
			END
			ELSE
			BEGIN
			
				DECLARE @MaKH VARCHAR(10)
				DECLARE @HoTen VARCHAR(40)
				SELECT @MaKH = maKH, @HoTen = hoTen FROM dbo.KhachHang 
				WHERE tenDangNhap=@TenDangNhap AND matKhau=@MatKhau
				
				PRINT N'Đăng nhập thành công'
				PRINT N'Xin chào ' + @HoTen + N'!, Mã: ' + @MaKH
				--Trả về Mã Khách hàng
				RETURN @MaKH
			END 
		END
	ELSE
		BEGIN	
			--RAISERROR(N'Tên đăng nhập không tồn tại',16,1)
			PRINT N'Tên đăng nhập không tồn tại'
			RETURN 0
		END	
END
GO*/

CREATE FUNCTION [dbo].[Func_DangNhap_KhachHang]
(@TenDangNhap VARCHAR(20), @MatKhau VARCHAR(20))
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @MaKH VARCHAR(10)
	IF (EXISTS(SELECT * FROM dbo.KhachHang WHERE tenDangNhap=@TenDangNhap))
		BEGIN
			IF (NOT EXISTS(SELECT * FROM dbo.KhachHang 
			WHERE matKhau=@MatKhau
			AND tenDangNhap=@TenDangNhap))
			BEGIN
				--PRINT N'Mật khẩu không đúng'
				RETURN '0'
			END
			ELSE
			BEGIN
				DECLARE @HoTen VARCHAR(40)
				SELECT @MaKH = maKH, @HoTen = hoTen FROM dbo.KhachHang 
				WHERE tenDangNhap=@TenDangNhap AND matKhau=@MatKhau
				
				--PRINT N'Đăng nhập thành công'
				--PRINT N'Xin chào ' + @HoTen + N'!, Mã: ' + @MaKH
				--Trả về Mã Khách hàng
				RETURN @MaKH
			END 
		END
	ELSE
		BEGIN	
			--RAISERROR(N'Tên đăng nhập không tồn tại',16,1)
			--PRINT N'Tên đăng nhập không tồn tại'		
			RETURN '0'
		END
	RETURN '0'
END

GO
/****** Object:  UserDefinedFunction [dbo].[Func_DangNhap_NhanVien]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Func_DangNhap_NhanVien]
(@TenDangNhap VARCHAR(20), @MatKhau VARCHAR(20))
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @MaNV VARCHAR(10)
	IF (EXISTS (SELECT * FROM dbo.KhachSan))
	BEGIN
		IF (EXISTS(SELECT * FROM NhanVien WHERE tenDangNhap=@TenDangNhap))
		BEGIN
			IF (NOT EXISTS(SELECT * FROM NhanVien
			WHERE matKhau=@MatKhau
			AND tenDangNhap=@TenDangNhap))
			BEGIN
				--PRINT N'Mật khẩu không đúng'
				RETURN '0'
			END
			ELSE
			BEGIN
				DECLARE @HoTen VARCHAR(40)
				SELECT @MaNV = maNV, @HoTen = hoTen FROM NhanVien 
				WHERE tenDangNhap=@TenDangNhap AND matKhau=@MatKhau
				
				--PRINT N'Đăng nhập thành công'
				--PRINT N'Xin chào ' + @HoTen + N'!, Mã: ' + @MaKH
				--Trả về Mã Khách hàng
				RETURN @MaNV
			END
		END
		ELSE
		--RAISERROR(N'Tên đăng nhập không tồn tại',16,1)
		--PRINT N'Tên đăng nhập không tồn tại'		
			RETURN '0'
	END
	
	--PRINT N'Khách sạn này không tồn tại trong hệ thống'
	RETURN '0'	
END

GO
/****** Object:  UserDefinedFunction [dbo].[Func_GenerateMa]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--1.Nhân viên Khách sạn nào thì chỉ có thể sử dụng các chức năng của nv trong phạm vi ks 


---------------------------------------------------
--[STORE PROCEDURE - FUNCTION]

--*Các PROC và FUNCTION phát sinh*

--Hàm phát sinh Các loại Mã: 1 - KH, 2 - NV, 3 - DatPhong, 4 - Phong
-- 5 - HoaDon

CREATE FUNCTION [dbo].[Func_GenerateMa](@Loai INT)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @Ma VARCHAR(10)
	DECLARE @ChuoiSo VARCHAR(8)
	DECLARE @So INT
	DECLARE @So2 VARCHAR(8)
	IF (@Loai = 1)
	BEGIN
		--Select last record of table
		SELECT TOP 1 @Ma = maKH FROM KhachHang ORDER BY maKH DESC
		--Lấy ra chuỗi con ko chứa 2 ký tự đầu để đc dãy số
		SELECT @ChuoiSo = SUBSTRING(@Ma, 3, 10)
		--Chuyển chữ thành số
		SELECT @So = CAST(@ChuoiSo AS INT)
		SET @So += 1
		--Chuyển số thành chữ
		SELECT @So2 = CAST(@So AS VARCHAR(8))
		--Thêm 2 ký tự đầu vào chuỗi
		SELECT @Ma = {fn CONCAT('KH', @So2)}
	END
	IF (@Loai = 2)
	BEGIN
		--Select last record of table
		SELECT TOP 1 @Ma = maNV FROM NhanVien ORDER BY maNV DESC
		--Lấy ra chuỗi con ko chứa 2 ký tự đầu để đc dãy số
		SELECT @ChuoiSo = SUBSTRING(@Ma, 3, 10)
		--Chuyển chữ thành số
		SELECT @So = CAST(@ChuoiSo AS INT)
		SET @So += 1
		--Chuyển số thành chữ
		SELECT @So2 = CAST(@So AS VARCHAR(8))
		--Thêm 2 ký tự đầu vào chuỗi
		SELECT @Ma = {fn CONCAT('NV', @So2)}
	END
	IF (@Loai = 3)
	BEGIN
		--Select last record of table
		SELECT TOP 1 @Ma = maDP FROM DatPhong ORDER BY maDP DESC
		--Lấy ra chuỗi con ko chứa 2 ký tự đầu để đc dãy số
		SELECT @ChuoiSo = SUBSTRING(@Ma, 3, 10)
		--Chuyển chữ thành số
		SELECT @So = CAST(@ChuoiSo AS INT)
		SET @So += 1
		--Chuyển số thành chữ
		SELECT @So2 = CAST(@So AS VARCHAR(8))
		--Thêm 2 ký tự đầu vào chuỗi
		SELECT @Ma = {fn CONCAT('DP', @So2)}
	END
	IF (@Loai = 4)
	BEGIN
		--Select last record of table
		SELECT TOP 1 @Ma = maPhong FROM Phong ORDER BY maPhong DESC
		--Lấy ra chuỗi con ko chứa 2 ký tự đầu để đc dãy số
		SELECT @ChuoiSo = SUBSTRING(@Ma, 3, 10)
		--Chuyển chữ thành số
		SELECT @So = CAST(@ChuoiSo AS INT)
		SET @So += 1
		--Chuyển số thành chữ
		SELECT @So2 = CAST(@So AS VARCHAR(8))
		--Thêm 2 ký tự đầu vào chuỗi
		SELECT @Ma = {fn CONCAT('PH', @So2)}
	END
	IF (@Loai = 5)
	BEGIN
		--Select last record of table
		SELECT TOP 1 @Ma = maHD FROM HoaDon ORDER BY maHD DESC
		--Lấy ra chuỗi con ko chứa 2 ký tự đầu để đc dãy số
		SELECT @ChuoiSo = SUBSTRING(@Ma, 3, 10)
		--Chuyển chữ thành số
		SELECT @So = CAST(@ChuoiSo AS INT)
		SET @So += 1
		--Chuyển số thành chữ
		SELECT @So2 = CAST(@So AS VARCHAR(8))
		--Thêm 2 ký tự đầu vào chuỗi
		SELECT @Ma = {fn CONCAT('HD', @So2)}
	END
	RETURN @Ma
END

GO
/****** Object:  Table [dbo].[DatPhong]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DatPhong](
	[maDP] [varchar](10) NOT NULL,
	[maLoaiPhong] [varchar](10) NOT NULL,
	[maKH] [varchar](10) NOT NULL,
	[ngayBatDau] [date] NOT NULL,
	[ngayTraPhong] [date] NULL,
	[ngayDat] [date] NOT NULL,
	[donGia] [float] NOT NULL,
	[moTa] [nvarchar](50) NULL,
	[tinhTrang] [nvarchar](30) NOT NULL CONSTRAINT [Default_tinhTrangDatPhong]  DEFAULT (N'chưa xác nhận'),
PRIMARY KEY CLUSTERED 
(
	[maDP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HoaDon](
	[maHD] [varchar](10) NOT NULL,
	[ngayThanhToan] [date] NOT NULL,
	[tongTien] [float] NOT NULL,
	[maDP] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[maHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhachHang](
	[maKH] [varchar](10) NOT NULL,
	[hoTen] [nvarchar](40) NULL,
	[tenDangNhap] [varchar](20) NOT NULL,
	[matKhau] [varchar](20) NULL,
	[soCMND] [int] NOT NULL,
	[diaChi] [nvarchar](50) NULL,
	[soDienThoai] [int] NOT NULL,
	[moTa] [nvarchar](50) NULL,
	[email] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[maKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhachSan]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhachSan](
	[maKS] [varchar](10) NOT NULL,
	[tenKS] [nvarchar](50) NOT NULL,
	[soSao] [int] NOT NULL,
	[soNha] [nvarchar](10) NULL,
	[duong] [nvarchar](50) NULL,
	[quan] [nvarchar](50) NULL,
	[thanhPho] [nvarchar](50) NOT NULL,
	[giaTB] [int] NOT NULL,
	[moTa] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[maKS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiPhong]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoaiPhong](
	[maLoaiPhong] [varchar](10) NOT NULL,
	[tenLoaiPhong] [nvarchar](30) NULL,
	[maKS] [varchar](10) NOT NULL,
	[donGia] [int] NOT NULL,
	[moTa] [nvarchar](50) NULL,
	[slTrong] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[maLoaiPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NhanVien](
	[maNV] [varchar](10) NOT NULL,
	[hoTen] [nvarchar](40) NULL,
	[tenDangNhap] [varchar](20) NOT NULL,
	[matKhau] [varchar](20) NULL,
	[MaKS] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[maNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Phong]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Phong](
	[maPhong] [varchar](10) NOT NULL,
	[loaiPhong] [varchar](10) NOT NULL,
	[soPhong] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[maPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrangThaiPhong]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrangThaiPhong](
	[maPhong] [varchar](10) NOT NULL,
	[ngay] [date] NOT NULL,
	[tinhTrang] [nvarchar](30) NOT NULL CONSTRAINT [Default_tinhTrangPhong]  DEFAULT (N'còn trống'),
PRIMARY KEY CLUSTERED 
(
	[maPhong] ASC,
	[ngay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[DatPhong] ([maDP], [maLoaiPhong], [maKH], [ngayBatDau], [ngayTraPhong], [ngayDat], [donGia], [moTa], [tinhTrang]) VALUES (N'DP001', N'LP001', N'KH001', CAST(N'2009-01-01' AS Date), CAST(N'2009-02-02' AS Date), CAST(N'2009-03-03' AS Date), 100, NULL, N'chưa xác nhận')
INSERT [dbo].[DatPhong] ([maDP], [maLoaiPhong], [maKH], [ngayBatDau], [ngayTraPhong], [ngayDat], [donGia], [moTa], [tinhTrang]) VALUES (N'DP2', N'LP001', N'KH001', CAST(N'2018-12-11' AS Date), CAST(N'2018-12-12' AS Date), CAST(N'2018-12-10' AS Date), 20000, NULL, N'chưa xác nhận')
INSERT [dbo].[DatPhong] ([maDP], [maLoaiPhong], [maKH], [ngayBatDau], [ngayTraPhong], [ngayDat], [donGia], [moTa], [tinhTrang]) VALUES (N'DP3', N'LP001', N'KH001', CAST(N'2018-12-11' AS Date), CAST(N'2018-12-13' AS Date), CAST(N'2018-12-10' AS Date), 20000, NULL, N'chưa xác nhận')
INSERT [dbo].[DatPhong] ([maDP], [maLoaiPhong], [maKH], [ngayBatDau], [ngayTraPhong], [ngayDat], [donGia], [moTa], [tinhTrang]) VALUES (N'DP4', N'LP001', N'KH001', CAST(N'2018-12-11' AS Date), CAST(N'2018-12-14' AS Date), CAST(N'2018-12-10' AS Date), 20000, NULL, N'chưa xác nhận')
INSERT [dbo].[DatPhong] ([maDP], [maLoaiPhong], [maKH], [ngayBatDau], [ngayTraPhong], [ngayDat], [donGia], [moTa], [tinhTrang]) VALUES (N'DP5', N'LP001', N'KH002', CAST(N'2018-12-12' AS Date), CAST(N'2018-12-14' AS Date), CAST(N'2018-12-10' AS Date), 20000, NULL, N'chưa xác nhận')
INSERT [dbo].[HoaDon] ([maHD], [ngayThanhToan], [tongTien], [maDP]) VALUES (N'HD001', CAST(N'2018-12-10' AS Date), 1200, N'DP001')
INSERT [dbo].[HoaDon] ([maHD], [ngayThanhToan], [tongTien], [maDP]) VALUES (N'HD002', CAST(N'2002-02-02' AS Date), 100, N'DP5')
INSERT [dbo].[KhachHang] ([maKH], [hoTen], [tenDangNhap], [matKhau], [soCMND], [diaChi], [soDienThoai], [moTa], [email]) VALUES (N'KH001', N'Nguyễn Văn A', N'user', N'123', 230094848, N'9 Le Duẩn, tp Hồ Chí Minh', 987678, NULL, N'user@gmai.com')
INSERT [dbo].[KhachHang] ([maKH], [hoTen], [tenDangNhap], [matKhau], [soCMND], [diaChi], [soDienThoai], [moTa], [email]) VALUES (N'KH002', N'Tran B', N'user2', N'123', 230094846, N'9 Le Duẩn, tp Hồ Chí Minh', 987678, NULL, N'users@gmai.com')
INSERT [dbo].[KhachSan] ([maKS], [tenKS], [soSao], [soNha], [duong], [quan], [thanhPho], [giaTB], [moTa]) VALUES (N'KS001', N'Monte Carlos', 5, N'4', N'Hai Bà Trưng', N'3', N'Hồ Chí Minh', 239999, N'Đắt')
INSERT [dbo].[LoaiPhong] ([maLoaiPhong], [tenLoaiPhong], [maKS], [donGia], [moTa], [slTrong]) VALUES (N'LP001', N'VIP', N'KS001', 20000, N'Đẹp', 7)
INSERT [dbo].[LoaiPhong] ([maLoaiPhong], [tenLoaiPhong], [maKS], [donGia], [moTa], [slTrong]) VALUES (N'LP002', N'Regular', N'KS001', 20, N'Được', 0)
INSERT [dbo].[NhanVien] ([maNV], [hoTen], [tenDangNhap], [matKhau], [MaKS]) VALUES (N'NV001', N'Nguyễn Nhân Viên', N'staff', N'123', N'KS001')
SET IDENTITY_INSERT [dbo].[Phong] ON 

INSERT [dbo].[Phong] ([maPhong], [loaiPhong], [soPhong]) VALUES (N'PH001', N'LP001', 1)
INSERT [dbo].[Phong] ([maPhong], [loaiPhong], [soPhong]) VALUES (N'PH002', N'LP001', 2)
INSERT [dbo].[Phong] ([maPhong], [loaiPhong], [soPhong]) VALUES (N'PH003', N'LP002', 3)
SET IDENTITY_INSERT [dbo].[Phong] OFF
INSERT [dbo].[TrangThaiPhong] ([maPhong], [ngay], [tinhTrang]) VALUES (N'PH001', CAST(N'2018-12-10' AS Date), N'còn trống')
INSERT [dbo].[TrangThaiPhong] ([maPhong], [ngay], [tinhTrang]) VALUES (N'PH002', CAST(N'2018-12-10' AS Date), N'đang bảo trì')
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__KhachHan__59267D4A0982CEFE]    Script Date: 12/10/2018 10:28:16 PM ******/
ALTER TABLE [dbo].[KhachHang] ADD UNIQUE NONCLUSTERED 
(
	[tenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__KhachHan__C4EF4BE5D0AAC88B]    Script Date: 12/10/2018 10:28:16 PM ******/
ALTER TABLE [dbo].[KhachHang] ADD UNIQUE NONCLUSTERED 
(
	[soCMND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__NhanVien__59267D4AA5D9E152]    Script Date: 12/10/2018 10:28:16 PM ******/
ALTER TABLE [dbo].[NhanVien] ADD UNIQUE NONCLUSTERED 
(
	[tenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [FK_DatPhong_KhachHang] FOREIGN KEY([maKH])
REFERENCES [dbo].[KhachHang] ([maKH])
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [FK_DatPhong_KhachHang]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [FK_DatPhong_LoaiPhong] FOREIGN KEY([maLoaiPhong])
REFERENCES [dbo].[LoaiPhong] ([maLoaiPhong])
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [FK_DatPhong_LoaiPhong]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_DatPhong] FOREIGN KEY([maDP])
REFERENCES [dbo].[DatPhong] ([maDP])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_DatPhong]
GO
ALTER TABLE [dbo].[LoaiPhong]  WITH CHECK ADD  CONSTRAINT [FK_LoaiPhong_KhachSan] FOREIGN KEY([maKS])
REFERENCES [dbo].[KhachSan] ([maKS])
GO
ALTER TABLE [dbo].[LoaiPhong] CHECK CONSTRAINT [FK_LoaiPhong_KhachSan]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_KhachSan] FOREIGN KEY([MaKS])
REFERENCES [dbo].[KhachSan] ([maKS])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_KhachSan]
GO
ALTER TABLE [dbo].[Phong]  WITH CHECK ADD  CONSTRAINT [FK_Phong_LoaiPhong] FOREIGN KEY([loaiPhong])
REFERENCES [dbo].[LoaiPhong] ([maLoaiPhong])
GO
ALTER TABLE [dbo].[Phong] CHECK CONSTRAINT [FK_Phong_LoaiPhong]
GO
ALTER TABLE [dbo].[TrangThaiPhong]  WITH CHECK ADD  CONSTRAINT [FK_TrangThaiPhong_Phong] FOREIGN KEY([maPhong])
REFERENCES [dbo].[Phong] ([maPhong])
GO
ALTER TABLE [dbo].[TrangThaiPhong] CHECK CONSTRAINT [FK_TrangThaiPhong_Phong]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [Check_tinhTrangDatPhong] CHECK  (([tinhTrang]=N'đã xác nhận' OR [tinhtrang]=N'chưa xác nhận'))
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [Check_tinhTrangDatPhong]
GO
ALTER TABLE [dbo].[TrangThaiPhong]  WITH CHECK ADD  CONSTRAINT [Check_tinhTrangPhong] CHECK  (([tinhTrang]=N'đang sử dụng' OR [tinhTrang]=N'đang bảo trì' OR [tinhTrang]=N'còn trống'))
GO
ALTER TABLE [dbo].[TrangThaiPhong] CHECK CONSTRAINT [Check_tinhTrangPhong]
GO
/****** Object:  StoredProcedure [dbo].[Proc_DangKyTaiKhoanKhachHang]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 1.Đăng ký tài khoản khách hàng
--Return 0: thành công, 1:thất bại
CREATE PROC [dbo].[Proc_DangKyTaiKhoanKhachHang] 
@hoTen NVARCHAR(40), @tenDangNhap VARCHAR(20), @matKhau VARCHAR(20), 
@soCMND INT, @diaChi NVARCHAR(50), @soDienThoai INT, @moTa NVARCHAR(50), @email VARCHAR(20)	          
AS
BEGIN
	IF (EXISTS(SELECT * FROM dbo.KhachHang WHERE tenDangNhap=@tenDangNhap))
		BEGIN
			PRINT N'Tên đăng nhập đã tồn tại, yêu cầu nhập lại'
			RETURN -1
		END
	IF (EXISTS(SELECT * FROM dbo.KhachHang WHERE soCMND=@soCMND))
		BEGIN
			PRINT N'Số CMND đã tồn tại, yêu cầu nhập lại'
			RETURN -2
		END
	IF (EXISTS(SELECT * FROM dbo.KhachHang WHERE email=@email))
		BEGIN
			PRINT N'Email đã tồn tại, yêu cầu nhập lại'		
			RETURN -3
		END
	
	INSERT INTO dbo.KhachHang
	VALUES  ( dbo.Func_GenerateMa(1) , -- maKH - varchar(10)
		          @hoTen , -- hoTen - nvarchar(40)
		          @tenDangNhap , -- tenDangNhap - nvarchar(20)
		          @matKhau , -- matKhau - varchar(20)
		          @soCMND , -- soCMND - int
		          @diaChi , -- diaChi - nvarchar(50)
		          @soDienThoai , -- soDienThoai - int
		          @moTa , -- moTa - nvarchar(50)
		          @email  -- email - varchar(20)
		        )
	PRINT N'Đăng ký thành công'
	RETURN 1
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_DatPhong]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--4.Đặt phòng
--0:Đặt phòng thành công, 1:Đặt phòng thất bại
--Tham số Mã Phòng phải do hệ thống phát sinh cho 1 lượt đặt phòng (thành công) của khách hàng
CREATE PROC [dbo].[Proc_DatPhong]
@MaKH VARCHAR(10),@MaKhachSan VARCHAR(10), 
@MaLoaiPhong VARCHAR(10), @NgayDat DATE, 
@NgayBatDau DATE, @NgayTraPhong DATE
--@TinhTrang NVARCHAR(30)
AS
BEGIN
	--B1: Khách hàng chọn Khách sạn và các Loại phòng cần đặt
	--B2: Hệ thống kiểm tra việc đặt phòng có hợp lệ không
	BEGIN
		--1.Kiểm tra Khách sạn này có tồn tại trog CSDL
		IF (NOT EXISTS (SELECT * FROM KhachSan WHERE maKS = @MaKhachSan))
		BEGIN
			PRINT N'Khách sạn này không tồn tại.'
			RETURN 0
		END
		--2.Kiểm tra xem Khách sạn này có Loại phòng này hay không
		IF (NOT EXISTS (SELECT * 
		FROM LoaiPhong
		WHERE maLoaiPhong = @MaLoaiPhong
		AND maKS = @MaKhachSan))
		BEGIN
			PRINT N'Khách sạn này không có Loại phòng này.'
			RETURN 0
		END
		
		--3.Kiểm tra SL trống của Loại phòng này
		DECLARE @SlTrong INT
		SELECT @SlTrong=slTrong FROM LoaiPhong 
		WHERE maLoaiPhong = @MaLoaiPhong
		IF (@SlTrong = 0)
		BEGIN
			PRINT N'Loại phòng này không còn phòng trống'
			RETURN 0
		END
		ELSE
		BEGIN
			--Lấy đơn giá từ bảng LoaiPhong
			DECLARE @DonGia INT
			SELECT @DonGia = donGia FROM LoaiPhong 
			WHERE maLoaiPhong=@MaLoaiPhong
			
			DECLARE @MaDP VARCHAR(10)
			SET @MaDP = dbo.Func_GenerateMa(3)
			--Lưu trữ thông tin đặt phòng
			INSERT INTO dbo.DatPhong( maDP,
									  maLoaiPhong ,
								      maKH ,
								      ngayBatDau ,
								      ngayTraPhong ,
								      ngayDat ,
								      donGia)
			VALUES  ( @MaDP,
									   @MaLoaiPhong , -- maLoaiPhong - varchar(10)
								       @MaKH , -- maKH - varchar(10)
								       @NgayBatDau , -- ngayBatDau - date
								       @NgayTraPhong , -- ngayTraPhong - date
								       @NgayDat , -- ngayDat - date
								       @DonGia -- donGia - float
								       )
			--Nếu khách hàng xác nhận đặt phòng thì sẽ:
			--update thuộc tính tinhTrang của bảng DatPhong
			--và dữ liệu 2 bảng: LoaiPhong, TrangThaiPhong
			/*IF (@TinhTrang LIKE N'đã xác nhận')
			BEGIN
				--update thuộc tính tinhTrang của bảng DatPhong
				UPDATE DatPhong SET tinhTrang = @TinhTrang
				WHERE maDP = @MaDP
				
				--Cập nhật bảng LoaiPhong
				UPDATE dbo.LoaiPhong SET slTrong = slTrong - 1
				WHERE maLoaiPhong=@MaLoaiPhong
				
				--Cập nhật bảng TrangThaiPhong
				--Join 2 bảng Phong và TrangThaiPhong lại để tìm các
				--phòng trống có maLoaiPhong đang xét, vào @NgayBatDau
				
				DECLARE @MaPhong VARCHAR(10)
				
				SELECT TOP 1 @MaPhong = ttrp.maPhong
				FROM Phong p, TrangThaiPhong ttrp
				WHERE p.loaiPhong = @MaLoaiPhong
				AND p.maPhong = ttrp.maPhong
				AND ttrp.ngay = @NgayBatDau
				AND ttrp.tinhTrang LIKE N'còn trống'
				
				--Cập nhật thông tin bảng TrangThaiPhong
				UPDATE TrangThaiPhong SET tinhTrang=N'đang sử dụng'
				WHERE maPhong = @MaPhong AND ngay = @NgayBatDau
				RETURN 1
			END
			*/			
			RETURN 1
		END
	END
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_TimKiemThongTinKhachSan]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--2.Tìm kiếm thông tin khách sạn theo các tiêu chí tìm kiếm
--CREATE NONCLUSTERED INDEX Index_TimKiemKhachSan ON dbo.KhachSan(thanhPho,giaTB,soSao)
CREATE PROC [dbo].[Proc_TimKiemThongTinKhachSan]
@ThanhPho NVARCHAR(50), @GiaCa INT, @HangSao INT
AS
BEGIN
	--B1: Khách hàng nhập tiêu chí tìm kiếm
	--Nếu tiêu chí nào để NULL (Không chọn) thì 
	--tiêu chí đó không có trong tập tiêu chí tìm kiếm.
	--B2: Hệ thống tìm kiếm thông tin trong CSDL
	DECLARE @count INT --Trả về số khách sạn thỏa tiêu chí
	--SELECT * INTO DanhSachKhachSan -- Trả dữ liệu về bảng khác
	/*SELECT *
	FROM KhachSan
	WHERE (giaTB = @GiaCa and thanhPho = @ThanhPho)
	OR (soSao = @HangSao and thanhPho = @ThanhPho)
	OR thanhPho = @ThanhPho*/
	SELECT *
	FROM KhachSan
	WHERE giaTB = @GiaCa and thanhPho = @ThanhPho
	UNION
	SELECT *
	FROM KhachSan
	WHERE soSao = @HangSao and thanhPho = @ThanhPho
	SELECT *
	FROM KhachSan
	WHERE thanhPho = @ThanhPho

	--RETURN @count
	--B3: Hệ thống xuất ra danh sách và thông tin
	/*SELECT @count = COUNT(*) FROM DanhSachKhachSan
	IF (@count > 0)
	BEGIN
		PRINT @count
		SELECT * FROM DanhSachKhachSan
		RETURN @count
	END
	PRINT @count
	RETURN @count*/
END

GO
/****** Object:  StoredProcedure [dbo].[TimKiemHoaDon]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[TimKiemHoaDon]
@MaNV NVARCHAR(10),
@MaKH NVARCHAR(10),
@GiaBatDau int,
@GiaKetThuc int,
@NgayXuatHoaDon DATE
AS
BEGIN
	DECLARE @MaKS VARCHAR(10);
	SET @MaKS  = (
	SELECT maKS 
	FROM NhanVien
	WHERE maNV = @MaNV)
	
	(SELECT DISTINCT maHD, ngayThanhToan, tongTien, HD.maDP
	FROM DatPhong as DP, LoaiPhong as LP, HoaDon as HD
	WHERE DP.maKH = @MaKH
	AND LP.maKS = @MaKS
	AND DP.maLoaiPhong = LP.maLoaiPhong
	AND HD.maDP = DP.maDP
	AND tongTien >= @GiaBatDau AND tongTien <= @GiaKetThuc
	AND year(ngayThanhToan) = year(@NgayXuatHoaDon)
	AND month(ngayThanhToan) = month(@NgayXuatHoaDon)
	AND day(ngayThanhToan) = day(@NgayXuatHoaDon)
	)
END
GO
/****** Object:  StoredProcedure [dbo].[XuatHoatDon]    Script Date: 12/10/2018 10:28:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[XuatHoatDon]
@MaHD NVARCHAR(10)
AS
BEGIN
	SELECT *
	FROM HoaDon as HD, DatPhong as DP, LoaiPhong as LP, KhachSan as KS, KhachHang as KH
	WHERE HD.maHD = @MaHD
	AND DP.maDP = HD.maDP
	AND LP.maLoaiPhong = DP.maLoaiPhong
	AND LP.maKS = KS.maKS
	AND DP.maKH = KH.maKH
END
GO
USE [master]
GO
ALTER DATABASE [QLKS] SET  READ_WRITE 
GO
