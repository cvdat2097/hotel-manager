USE [master]
GO
/****** Object:  Database [QuanLyKhachSan]    Script Date: 12/7/2018 4:49:34 AM ******/
CREATE DATABASE [QuanLyKhachSan]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyKhachSan', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QuanLyKhachSan.mdf' , SIZE = 3677376KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyKhachSan_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QuanLyKhachSan_log.ldf' , SIZE = 39936KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLyKhachSan] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyKhachSan].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyKhachSan] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyKhachSan] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyKhachSan] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyKhachSan] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyKhachSan] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyKhachSan] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyKhachSan] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyKhachSan] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyKhachSan] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyKhachSan] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyKhachSan] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuanLyKhachSan] SET DELAYED_DURABILITY = DISABLED 
GO
USE [QuanLyKhachSan]
GO
/****** Object:  UserDefinedFunction [dbo].[Func_DangNhap_KhachHang]    Script Date: 12/7/2018 4:49:34 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[Func_DangNhap_NhanVien]    Script Date: 12/7/2018 4:49:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Store Procedure Đăng nhập/đăng xuất cho Nhân viên
--CREATE NONCLUSTERED INDEX Index_Login_NhanVien ON dbo.NhanVien
--Trả về 1: Đăng nhập thành công, 0:Thất bại

/*CREATE PROC Proc_DangNhap_NhanVien
@MaKS VARCHAR(10), @TenDangNhap VARCHAR(20), @MatKhau VARCHAR(20)
AS
BEGIN
	BEGIN TRAN
		IF (EXISTS (SELECT * FROM dbo.KhachSan WHERE maKS=@MaKS))
			BEGIN
				IF (EXISTS(SELECT * FROM dbo.NhanVien WHERE tenDangNhap=@TenDangNhap))
					BEGIN
						IF (NOT EXISTS(SELECT * FROM dbo.NhanVien WHERE matKhau=@MatKhau))
							PRINT N'Mật khẩu không đúng'
						ELSE
							BEGIN
							SELECT * FROM dbo.NhanVien WHERE tenDangNhap=@TenDangNhap AND matKhau=@MatKhau
							RETURN 1
							END 
					END
				ELSE
					BEGIN	
						RAISERROR(N'Tên đăng nhập không tồn tại',16,1)
						RETURN 0
					END
			END
		ELSE
			BEGIN
				PRINT N'Khách sạn này không tồn tại trong hệ thống'
				RETURN 0
			END		
	COMMIT TRAN
END
GO*/


--Tạo RBTV 1 : Nhân viên của khách sạn nào thì chỉ được sử dụng
--trong phạm vi khách sạn mà nhân viên đó làm việc
/*CREATE FUNCTION Func_RBTV_1
(@MaKS VARCHAR(10), @MaNV VARCHAR(10))
RETURNS BIT
AS
BEGIN
	
	
	RETURN 1
END
GO*/

CREATE FUNCTION [dbo].[Func_DangNhap_NhanVien]
(@MaKS VARCHAR(10), @TenDangNhap VARCHAR(20), @MatKhau VARCHAR(20))
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @MaNV VARCHAR(10)
	IF (EXISTS (SELECT * FROM dbo.KhachSan WHERE maKS=@MaKS))
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
/****** Object:  UserDefinedFunction [dbo].[Func_GenerateMa]    Script Date: 12/7/2018 4:49:34 AM ******/
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
/****** Object:  Table [dbo].[DatPhong]    Script Date: 12/7/2018 4:49:34 AM ******/
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
/****** Object:  Table [dbo].[HoaDon]    Script Date: 12/7/2018 4:49:34 AM ******/
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
/****** Object:  Table [dbo].[KhachHang]    Script Date: 12/7/2018 4:49:34 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[tenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[soCMND] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhachSan]    Script Date: 12/7/2018 4:49:34 AM ******/
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
/****** Object:  Table [dbo].[LoaiPhong]    Script Date: 12/7/2018 4:49:34 AM ******/
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
/****** Object:  Table [dbo].[NhanVien]    Script Date: 12/7/2018 4:49:34 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[tenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Phong]    Script Date: 12/7/2018 4:49:34 AM ******/
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
/****** Object:  Table [dbo].[TrangThaiPhong]    Script Date: 12/7/2018 4:49:34 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_DangKyTaiKhoanKhachHang]    Script Date: 12/7/2018 4:49:34 AM ******/
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
			RETURN 0
		END
	IF (EXISTS(SELECT * FROM dbo.KhachHang WHERE soCMND=@soCMND))
		BEGIN
			PRINT N'Số CMND đã tồn tại, yêu cầu nhập lại'
			RETURN 0
		END
	IF (EXISTS(SELECT * FROM dbo.KhachHang WHERE email=@email))
		BEGIN
			PRINT N'Email đã tồn tại, yêu cầu nhập lại'		
			RETURN 0
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
/****** Object:  StoredProcedure [dbo].[Proc_DatPhong]    Script Date: 12/7/2018 4:49:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
--3_2.Đăng xuất
CREATE PROC Proc_DangXuat_KhachHang
@MaKH VARCHAR(10)
AS
BEGIN
	
END
GO*/

--4.Đặt phòng
--0:Đặt phòng thành công, 1:Đặt phòng thất bại
--Tham số Mã Phòng phải do hệ thống phát sinh cho 1 lượt đặt phòng (thành công) của khách hàng
CREATE PROC [dbo].[Proc_DatPhong]
@MaKhachSan VARCHAR(10), @MaLoaiPhong VARCHAR(10), 
@NgayDat DATE, @NgayBatDau DATE, @NgayTraPhong DATE, 
@TinhTrang NVARCHAR(30), @TenDangNhap VARCHAR(20), @MatKhau VARCHAR(20)
AS
BEGIN
	DECLARE @MaKH VARCHAR(10)
	SELECT @MaKH = dbo.Func_DangNhap_KhachHang(@TenDangNhap, @MatKhau)
	--Khách hàng phải đăng nhập thành công
	IF (@MaKH LIKE '0')
	BEGIN
		PRINT N'Đăng nhập không thành công'
		RETURN 0
	END
	ELSE
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
			PRINT N'Không tồn tại KS nào có Loại phòng này.'
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
			IF (@TinhTrang LIKE N'đã xác nhận')
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
								
			RETURN 1
		END
		--Kiểm tra mã khách sạn + Lookup trong Bảng LoaiPhong xem loại phòng này còn phòng trống không
		/*IF (EXISTS(SELECT COUNT(*) FROM LoaiPhong WHERE maKS=@MaKhachSan							--(1)
		AND maLoaiPhong=@MaLoaiPhong AND slTrong > 0))
			BEGIN	
				--Hệ thống tìm phòng còn trống dựa vào trạng thái "còn trống"
				DECLARE @DonGia FLOAT, @MaPhong VARCHAR(10)
				IF (IF EXISTS(SELECT *, @DonGia=l.donGia, @MaPhong=p.maPhong 
				FROM dbo.TrangThaiPhong tt,Phong p,dbo.LoaiPhong l WHERE tinhTrang=N'còn trống' 
				AND tt.maPhong=p.maPhong AND l.maLoaiPhong=p.loaiPhong))
					BEGIN
							--Lưu trữ thông tin đặt phòng
						INSERT INTO dbo.DatPhong
								        ( maLoaiPhong ,
								          maKH ,
								          ngayBatDau ,
								          ngayTraPhong ,
								          ngayDat ,
								          donGia ,
								          tinhTrang
								        )
						VALUES  ( @MaLoaiPhong , -- maLoaiPhong - varchar(10)
								          @MaKH , -- maKH - varchar(10)
								          @NgayBatDau , -- ngayBatDau - date
								          @NgayTraPhong , -- ngayTraPhong - date
								          @NgayDat , -- ngayDat - date
								          @DonGia , -- donGia - float
								          N'đã xác nhận'  -- tinhTrang - nvarchar(30)
								        )
								
						--Cập nhật các bảng: LoaiPhong, TrangThaiPhong
						UPDATE dbo.LoaiPhong SET slTrong = slTrong - 1 
						WHERE maKS=@MaKhachSan AND maLoaiPhong=@MaLoaiPhong
								
						UPDATE dbo.TrangThaiPhong SET tinhTrang=N'đang sử dụng' 
						WHERE maPhong=@MaPhong  AND ngay=GETDATE()
								
						RETURN 1
					END 		
			END
		ELSE
			BEGIN
				PRINT N'Loại phòng này không còn phòng trống'
				RETURN 0
			END*/
	END
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_KiemTraTinhTrangPhong]    Script Date: 12/7/2018 4:49:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--6.Kiểm tra tình trạng phòng
CREATE PROC [dbo].[Proc_KiemTraTinhTrangPhong]
@MaLoaiPhong VARCHAR(10), @Ngay DATE,
@MaKS VARCHAR(10), @TenDangNhap VARCHAR(20), @MatKhau VARCHAR(20),
@NhapButton BIT = 0, @PhongDuocChon VARCHAR(10)
AS
BEGIN
	--Nhân viên phải đăng nhập thành công
	DECLARE @MaNV VARCHAR(10)
	SELECT @MaNV = dbo.Func_DangNhap_NhanVien(@MaKS, @TenDangNhap, @MatKhau)
	IF (@MaNV LIKE '0')
	BEGIN
		PRINT N'Đăng nhập không thành công'
		RETURN 0
	END
	--*RBTV*
	--+Kiểm tra số lượng phòng trống của Loại phòng này
	DECLARE @SLTrong INT
	SELECT @SLTrong=slTrong FROM LoaiPhong 
	WHERE maLoaiPhong=@MaLoaiPhong
	AND maKS = @MaKS
	IF (@SLTrong = 0)
	BEGIN
		PRINT N'Loại phòng này không còn phòng trống.'
		RETURN 0
	END
	
	--+Nhân viên của khách sạn nào thì chỉ được sử dụng chức
	--trong phạm vi khách sạn mà nhân viên đó làm việc:
	--Kiểm tra xem Mã Loại Phòng(MaLoaiPhong) này
	--có thuộc về MaKS của Nhân viên này hay không
	IF (NOT EXISTS (SELECT *
	FROM LoaiPhong
	WHERE maKS = @MaKS
	AND maLoaiPhong = @MaLoaiPhong))
	BEGIN
		PRINT N'Loại phòng này không trực thuộc phạm vi quản lý KS của NV.'
		RETURN 0
	END
	ELSE
	BEGIN
		--B2.Hiển thị DSach (phòng và tình trạng) phòng thuộc loại phòng này
		SELECT ttp.maPhong, ttp.ngay, ttp.tinhTrang
		FROM LoaiPhong lp, Phong p, TrangThaiPhong ttp
		WHERE lp.maKS = @MaKS
		AND lp.maLoaiPhong = @MaLoaiPhong
		AND lp.maLoaiPhong = p.loaiPhong
		AND p.maPhong = ttp.maPhong
		AND ttp.ngay = @Ngay
		
		IF (@NhapButton = 1)
		BEGIN
			--B3.Nhân viên nhấp vào bất kỳ 1 phòng
			--B4.Hệ thống tiếp tục hiển thị thông tin chi tiết về phòng đó.
			SELECT *
			FROM Phong p, TrangThaiPhong ttp
			WHERE p.maPhong = ttp.maPhong
			AND p.maPhong = @PhongDuocChon
			AND ttp.ngay = @Ngay
		END
		
		PRINT N'Kiểm tra tình trạng phòng kết thúc thành công.'
		RETURN 1
	END
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_LapHoaDon]    Script Date: 12/7/2018 4:49:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--5.Lập hóa đơn
CREATE PROC [dbo].[Proc_LapHoaDon]
--@NgayLap DATE,
@MaDP VARCHAR(10),
@MaKS VARCHAR(10), @TenDangNhap VARCHAR(20), @MatKhau VARCHAR(20),
@NhapHoaDon BIT = 0 
-- Trả về: 0 - Lập HD không thành công, 1 - Lập HD thành công
-- 2 - Lưu HD thành công
AS
BEGIN
	--Nhân viên phải đăng nhập thành công
	DECLARE @MaNV VARCHAR(10)
	SELECT @MaNV = dbo.Func_DangNhap_NhanVien(@MaKS, @TenDangNhap, @MatKhau)
	IF (@MaNV LIKE '0')
	BEGIN
		PRINT N'Đăng nhập không thành công'
		RETURN 0
	END
	--*RBTV* 
	--Nhân viên của khách sạn nào thì chỉ được sử dụng chức
	--trong phạm vi khách sạn mà nhân viên đó làm việc:
	--Kiểm tra xem Mã Đặt phòng này có thuộc Khách sạn này hay không
	IF (NOT EXISTS (SELECT * 
	FROM DatPhong dp, LoaiPhong lp
	WHERE dp.maLoaiPhong = lp.maLoaiPhong
	AND lp.maKS = @MaKS
	AND dp.maDP = @MaDP))
	BEGIN
		PRINT N'Mã Đặt phòng này(@MaDP) không thuộc Khách sạn(@MaKS) do Nv quản lý.'
		RETURN 0
	END
	
	--MaDP này phải là tinhTrang=N'đã xác nhận'
	IF (NOT EXISTS (SELECT * FROM DatPhong 
	WHERE maDP=@MaDP AND tinhTrang=N'đã xác nhận'))
	BEGIN
		PRINT N'Tình trạng Phòng này chưa xác nhận.'
		RETURN 0
	END
		
	ELSE
	BEGIN
		--Hệ thống tạo hóa đơn mới với mã hóa đơn theo quy tắc của khách sạn, 
		--ngày lập là ngày hiện tại và thành tiền được tính 
		--từ thông tin ở phiếu đặt phòng tương ứng
		DECLARE @MaHD VARCHAR(10)
		SET @MaHD = dbo.Func_GenerateMa(5)
		
		DECLARE @TongTien INT
		DECLARE @NgayLapDon DATE
		SELECT @TongTien=donGia, @NgayLapDon=ngayTraPhong 
		FROM DatPhong
		WHERE maDP=@MaDP
		
		DECLARE @Ngay VARCHAR(20)
		SET @Ngay = CAST(@NgayLapDon AS VARCHAR(20))
		--Xuất thông tin về hóa đơn vừa tạo cho nhân viên
		PRINT @MaHD + ' ' + @Ngay + ' ' + @TongTien + ' ' + @MaDP
			
		--B4: Nhân viên chọn lưu trữ lại thông tin hóa đơn vừa kết xuất vào hệ thống
		IF (@NhapHoaDon = 1)
		BEGIN	
			INSERT INTO HoaDon
			VALUES  ( @MaHD, -- maHD - varchar(10)
						@NgayLapDon, -- ngayThanhToan - date
						@TongTien, -- tongTien - float
						@MaDP						 
					)
			PRINT N'Lưu hóa đơn thành công'
			RETURN 2
		END
		PRINT N'Lập hóa đơn thành công'
		RETURN 1
	END
	--B1: Nhân viên tiếp tân nhập đơn mã phiếu đặt cần kết xuất hóa đơn
	--B2: Hệ thống tạo hóa đơn mới với mã hóa đơn theo quy tắc của khách sạn, ngày lập là ngày hiện tại 
	--và thành tiền được tính từ thông tin ở phiếu đặt phòng tương ứng
	/*IF (Proc_DangNhap_KhachHang(@TenDangNhap, @MatKhau) = 1)
		BEGIN
			DECLARE @ThanhTien FLOAT --Thành tiền
			SELECT @ThanhTien=dp.donGia, @NgayLap=dp.ngayTraPhong FROM dbo.DatPhong dp, dbo.HoaDon hd
			WHERE dp.maDP=hd.maDP
			--B3: Hệ thống xuất thông tin về hóa đơn vừa tạo cho nhân viên
			PRINT @MaHoaDon + ' ' + @NgayLap + ' ' + @ThanhTien + ' ' + @MaPhieuDat
			--B4: Nhân viên chọn lưu trữ lại thông tin hóa đơn vừa kết xuất vào hệ thống
			IF (@NhapHoaDon = 1)
				BEGIN	
					INSERT INTO dbo.HoaDon
							( maHD, ngayThanhToan, tongTien, maDP )
					VALUES  ( @MaHoaDon, -- maHD - varchar(10)
							  @NgayLap, -- ngayThanhToan - date
							  @ThanhTien, -- tongTien - float
							  @MaPhieuDat  -- maDP - varchar(10)
							  )
				END	
		END
	ELSE		
		BEGIN
			PRINT N'Yêu cầu đăng nhập trước khi sử dụng chức năng này'
			RETURN 0
		END*/
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_TimKiemThongTinHoaDon]    Script Date: 12/7/2018 4:49:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--7.Tìm kiếm thông tin hóa đơn
CREATE PROC [dbo].[Proc_TimKiemThongTinHoaDon]
@MaKH VARCHAR(10), @NgayLap DATE, @ThanhTien INT,
@MaKS VARCHAR(10), @TenDangNhap VARCHAR(20), @MatKhau VARCHAR(20),
@HoaDonDuocChon VARCHAR(10)
AS
BEGIN
	--Nhân viên phải đăng nhập thành công
	DECLARE @MaNV VARCHAR(10)
	SELECT @MaNV = dbo.Func_DangNhap_NhanVien(@MaKS, @TenDangNhap, @MatKhau)
	IF (@MaNV LIKE '0')
	BEGIN
		PRINT N'Đăng nhập không thành công'
		RETURN 0
	END
	--*RBTV*	
	--+Nhân viên của khách sạn nào thì chỉ được sử dụng chức
	--trong phạm vi khách sạn mà nhân viên đó làm việc:
	--Kiểm tra xem Mã Khách hàng(MaKH) này có đặt phòng (và đã thanh toán), 
	--phòng đó thuộc về MaKS của Nhân viên này hay không
	IF (NOT EXISTS (SELECT *
	FROM DatPhong dp, LoaiPhong lp
	WHERE dp.maKH = @MaKH
	AND dp.maLoaiPhong = lp.maLoaiPhong
	AND lp.maKS = @MaKS))
	BEGIN
		PRINT N'Mã Khách hàng này không thuộc KS do NV này quản lý.'
		RETURN 0
	END
	ELSE
	BEGIN		
		--B2.Hiển thị danh sách các hóa đơn thỏa tiêu chí tìm kiếm
		SELECT hd.maHD , hd.ngayThanhToan, hd.tongTien
		FROM HoaDon hd, DatPhong dp
		WHERE (hd.maDP = dp.maDP
		AND dp.maKH = @MaKH)
		OR hd.ngayThanhToan = @NgayLap
		OR hd.tongTien = @ThanhTien
		
		--B3.Nhân viên chọn hóa đơn cần in cho khách hàng
		SELECT *
		FROM HoaDon
		WHERE maHD = @HoaDonDuocChon
		
		PRINT N'Tìm kiếm hóa đơn kết thúc thành công.'
		RETURN 1
	END
END

GO
/****** Object:  StoredProcedure [dbo].[Proc_TimKiemThongTinKhachSan]    Script Date: 12/7/2018 4:49:34 AM ******/
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
USE [master]
GO
ALTER DATABASE [QuanLyKhachSan] SET  READ_WRITE 
GO
