CREATE DATABASE QuanLyKhachSan
GO

USE QuanLyKhachSan
GO
/*
DECLARE @DatabaseName nvarchar(50)
SET @DatabaseName = N'QuanLyKhachSan'

DECLARE @SQL varchar(max)

SELECT @SQL = COALESCE(@SQL,'') + 'Kill ' + Convert(varchar, SPId) + ';'
FROM MASTER..SysProcesses
WHERE DBId = DB_ID(@DatabaseName) AND SPId <> @@SPId

--SELECT @SQL 
EXEC(@SQL)
*/
--DECLARE @MoTa NVARCHAR(100)

-- 100 dòng
CREATE TABLE KhachSan
(
	maKS VARCHAR(10) NOT NULL, --PRIMARY KEY
	tenKS NVARCHAR(50) NOT NULL,
	soSao INT NOT NULL,
	soNha NVARCHAR(10),
	duong NVARCHAR(50),
	quan NVARCHAR(50),
	thanhPho NVARCHAR(50) NOT NULL,
	giaTB INT NOT NULL,
	moTa NVARCHAR(50),
	
	PRIMARY KEY(maKS)
)
GO

-- 2.000 dòng
CREATE TABLE LoaiPhong
(
	maLoaiPhong VARCHAR(10) NOT NULL, --PRIMARY KEY
	tenLoaiPhong NVARCHAR(30),
	maKS VARCHAR(10) NOT NULL,	--FOREIGN KEY
	donGia INT NOT NULL,
	moTa NVARCHAR(50),
	slTrong INT NOT NULL,
	PRIMARY KEY(maLoaiPhong)
)
GO

-- 30.000 dòng
CREATE TABLE Phong
(
	maPhong VARCHAR(10) NOT NULL, --PRIMARY KEY
	loaiPhong VARCHAR(10) NOT NULL, --FOREIGN KEY
	soPhong INT IDENTITY NOT NULL,
	PRIMARY KEY(maPhong)
)
GO

-- 1.000.000 dòng
CREATE TABLE TrangThaiPhong
(
	maPhong VARCHAR(10) NOT NULL, --KEY
	ngay DATE NOT NULL,
	tinhTrang NVARCHAR(30) NOT NULL, --KEY
	PRIMARY KEY(maPhong, ngay)
)
GO

-- 5.000.000 dòng
CREATE TABLE KhachHang
(
	maKH VARCHAR(10) NOT NULL, --PRIMARY KEY
	hoTen NVARCHAR(40),
	tenDangNhap VARCHAR(20) UNIQUE NOT NULL,
	matKhau VARCHAR(20),
	soCMND INT UNIQUE NOT NULL,
	diaChi NVARCHAR(50),
	soDienThoai INT NOT NULL,
	moTa NVARCHAR(50),
	email VARCHAR(20) NOT NULL,
	PRIMARY KEY(maKH)
)
GO

-- 6.000.000 dòng
CREATE TABLE DatPhong
(
	maDP VARCHAR(10) NOT NULL,--PRIMARY KEY
	maLoaiPhong VARCHAR(10) NOT NULL, --FOREIGN KEY
	maKH VARCHAR(10) NOT NULL, --FOREIGN KEY
	ngayBatDau DATE NOT NULL,
	ngayTraPhong DATE,
	ngayDat DATE NOT NULL,
	donGia FLOAT NOT NULL,
	moTa NVARCHAR(50),
	tinhTrang NVARCHAR(30) NOT NULL,
	PRIMARY KEY(maDP)
)
GO

-- 5.000.000 dòng
CREATE TABLE HoaDon
(
	maHD VARCHAR(10) NOT NULL, --PRIMARY KEY
	ngayThanhToan DATE NOT NULL,
	tongTien FLOAT NOT NULL,
	maDP VARCHAR(10) NOT NULL, --FOREIGN KEY
	PRIMARY KEY(maHD)
)
GO

--50 dòng
CREATE TABLE NhanVien
(
	maNV VARCHAR(10) NOT NULL, --PRIMARY KEY
	hoTen NVARCHAR(40),
	tenDangNhap VARCHAR(20) UNIQUE NOT NULL,
	matKhau VARCHAR(20),
	MaKS VARCHAR(10) NOT NULL, --FOREIGN KEY
	PRIMARY KEY(maNV)
)
GO

--RBTV--

ALTER TABLE LoaiPhong
ADD CONSTRAINT FK_LoaiPhong_KhachSan
FOREIGN KEY(maKS) REFERENCES KhachSan(maKS)

ALTER TABLE Phong
ADD CONSTRAINT FK_Phong_LoaiPhong
FOREIGN KEY(loaiPhong) REFERENCES LoaiPhong(maLoaiPhong)

ALTER TABLE TrangThaiPhong
ADD CONSTRAINT Check_tinhTrangPhong 
CHECK (tinhTrang=N'đang sử dụng' OR tinhTrang=N'đang bảo trì' 
OR tinhTrang=N'còn trống')

ALTER TABLE TrangThaiPhong
ADD CONSTRAINT Default_tinhTrangPhong 
DEFAULT N'còn trống' FOR tinhTrang

ALTER TABLE TrangThaiPhong
ADD CONSTRAINT FK_TrangThaiPhong_Phong
FOREIGN KEY(maPhong) REFERENCES Phong(maPhong)

ALTER TABLE DatPhong
ADD CONSTRAINT Check_tinhTrangDatPhong 
CHECK(tinhTrang=N'đã xác nhận' or tinhtrang=N'chưa xác nhận')

ALTER TABLE DatPhong
ADD CONSTRAINT Default_tinhTrangDatPhong 
DEFAULT N'chưa xác nhận' FOR tinhTrang

ALTER TABLE DatPhong
ADD CONSTRAINT FK_DatPhong_LoaiPhong
FOREIGN KEY(maLoaiPhong) REFERENCES LoaiPhong(maLoaiPhong)

ALTER TABLE DatPhong
ADD CONSTRAINT FK_DatPhong_KhachHang
FOREIGN KEY(maKH) REFERENCES KhachHang(maKH)

ALTER TABLE HoaDon
ADD CONSTRAINT FK_HoaDon_DatPhong
FOREIGN KEY(maDP) REFERENCES DatPhong(maDP)

ALTER TABLE NhanVien
ADD CONSTRAINT FK_NhanVien_KhachSan
FOREIGN KEY(MaKS) REFERENCES dbo.KhachSan(maKS)
GO
--1.Nhân viên Khách sạn nào thì chỉ có thể sử dụng các chức năng của nv trong phạm vi ks 


---------------------------------------------------
--[STORE PROCEDURE - FUNCTION]

--*Các PROC và FUNCTION phát sinh*

--Hàm phát sinh Các loại Mã: 1 - KH, 2 - NV, 3 - DatPhong, 4 - Phong
-- 5 - HoaDon

CREATE FUNCTION Func_GenerateMa(@Loai INT)
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

-- 1.Đăng ký tài khoản khách hàng
--Return 0: thành công, 1:thất bại
CREATE PROC Proc_DangKyTaiKhoanKhachHang 
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


--2.Tìm kiếm thông tin khách sạn theo các tiêu chí tìm kiếm
--CREATE NONCLUSTERED INDEX Index_TimKiemKhachSan ON dbo.KhachSan(thanhPho,giaTB,soSao)
CREATE PROC Proc_TimKiemThongTinKhachSan
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

--3.Đăng nhập
/*CREATE NONCLUSTERED INDEX Index_Login_KhachHang ON dbo.KhachHang()GO*/

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

CREATE FUNCTION Func_DangNhap_KhachHang
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
CREATE PROC Proc_DatPhong
@MaKhachSan VARCHAR(10), @MaLoaiPhong VARCHAR(10), 
@NgayDat DATE, @NgayBatDau DATE, @NgayTraPhong DATE, 
@TinhTrang NVARCHAR(30),@MaKH VARCHAR(10)
AS
BEGIN
	--B1: Khách hàng chọn Khách sạn và các Loại phòng cần đặt
	--B2: Hệ thống kiểm tra việc đặt phòng có hợp lệ không
	BEGIN
		--1.Kiểm tra Khách sạn này có tồn tại trog CSDL
		IF (NOT EXISTS (SELECT * FROM KhachSan WHERE maKS = @MaKhachSan))
		BEGIN
			PRINT N'Khách sạn này không tồn tại.'
			RETURN -1
		END
		--2.Kiểm tra xem Khách sạn này có Loại phòng này hay không
		IF (NOT EXISTS (SELECT * 
		FROM LoaiPhong
		WHERE maLoaiPhong = @MaLoaiPhong
		AND maKS = @MaKhachSan))
		BEGIN
			PRINT N'Không tồn tại KS nào có Loại phòng này.'
			RETURN -2
		END
		
		--3.Kiểm tra SL trống của Loại phòng này
		DECLARE @SlTrong INT
		SELECT @SlTrong=slTrong FROM LoaiPhong 
		WHERE maLoaiPhong = @MaLoaiPhong
		IF (@SlTrong = 0)
		BEGIN
			PRINT N'Loại phòng này không còn phòng trống'
			RETURN -3
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

CREATE FUNCTION Func_DangNhap_NhanVien
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

--5.Lập hóa đơn
CREATE PROC Proc_LapHoaDon
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

--6.Kiểm tra tình trạng phòng
CREATE PROC Proc_KiemTraTinhTrangPhong
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

-- Kiem Tra Quyen Nhan Vien
CREATE PROC KiemTraQuyenCuaNV
@MaNV NVARCHAR(10),
@MaKH NVARCHAR(10)
AS
BEGIN
	DECLARE @MaKS VARCHAR(10);
	SET @MaKS  = (
	SELECT maKS 
	FROM NhanVien
	WHERE maNV = @MaNV)
	
	(SELECT * FROM DatPhong as DP, Phong as PH, LoaiPhong as LPAD
	WHERE DP.maPhong = PH.maPhong
	AND PH.loaiPhong = LP.maLP
	AND LP.maKS = @MaKS
	AND DP.maKH = @MaKH
	)
	BEGIN
		PRINT N'Mã Khách hàng này không thuộc KS do NV này quản lý.'
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END
END

--7.Tìm kiếm thông tin hóa đơn
CREATE PROC Proc_TimKiemThongTinHoaDon
@MaKH VARCHAR(10), @NgayLap DATE, @ThanhTien INT,
@MaKS VARCHAR(10), @TenDangNhap VARCHAR(20), @MatKhau VARCHAR(20),
@HoaDonDuocChon VARCHAR(10)
AS
BEGIN
	-- --Nhân viên phải đăng nhập thành công
	-- DECLARE @MaNV VARCHAR(10)
	-- SELECT @MaNV = dbo.Func_DangNhap_NhanVien(@MaKS, @TenDangNhap, @MatKhau)
	-- IF (@MaNV LIKE '0')
	-- BEGIN
		-- PRINT N'Đăng nhập không thành công'
		-- RETURN 0
	-- END
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
/*
--8.Thống kê, báo cáo
CREATE PROC Proc_ThongKe_BaoCao
@ThangBatDau INT, @ThangKetThuc INT,
@NamBatDau INT, @NamKetThuc INT,
@ThoiGianBatDau DATE, @ThoiGianKetThuc DATE,
@SoNgayToiThieu INT,
@MaSoThongKe INT -- 1 - Báo cáo doanh thu theo tháng
--2 - Báo cáo doanh thu theo năm , 3 - ...
AS
BEGIN
	--B1: Nhân viên nhập vào tiêu chí cần thống kê
	--Nếu tiêu chí nào để NULL (Không chọn) thì 
	--tiêu chí đó không có trong tập tiêu chí thống kê.
	
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
	/*IF (NOT EXISTS (SELECT *
	FROM DatPhong dp, LoaiPhong lp
	WHERE dp.maKH = @MaKH
	AND dp.maLoaiPhong = lp.maLoaiPhong
	AND lp.maKS = @MaKS))
	BEGIN
		PRINT N'Mã Khách hàng này không thuộc KS do NV này quản lý.'
		RETURN 0
	END*/
	
	ELSE
	BEGIN
		IF (@MaSoThongKe = 1)
		BEGIN
		--+Báo cáo doanh thu theo tháng
		SELECT SUM(tongTien) AS N'Doanh thu theo tháng'
		FROM HoaDon
		WHERE MONTH(ngayThanhToan) BETWEEN @ThangBatDau AND @ThangKetThuc
		RETURN 1
		END
		
		--+Báo cáo doanh thu theo năm
		IF (@MaSoThongKe = 2)
		BEGIN
		SELECT SUM(tongTien) AS N'Doanh thu theo tháng'
		FROM HoaDon
		WHERE YEAR(ngayThanhToan) BETWEEN @NamBatDau AND @NamKetThuc
		RETURN 1
		END
		
		--+Báo cáo doanh thu theo từng loại phòng trong 1 khoảng thời gian 
		IF (@MaSoThongKe = 3)
		BEGIN
		SELECT SUM(tongTien) AS N'Doanh thu theo tháng'
		FROM HoaDon
		WHERE YEAR(ngayThanhToan) BETWEEN @NamBatDau AND @NamKetThuc
		RETURN 1
		END
		
		--+Báo cáo doanh thu theo từng loại phòng trong 1 khoảng thời gian 
		IF (@MaSoThongKe = 4)
		BEGIN
		SELECT SUM(hd.tongTien)
		FROM HoaDon hd, DatPhong dp
		WHERE hd.maDP = dp.maDP
		AND hd.ngayThanhToan BETWEEN @ThoiGianBatDau AND @ThoiGianKetThuc
		GROUP BY dp.maLoaiPhong
		RETURN 1
		END
		
		--+Thống kê tình trạng phòng 
		IF (@MaSoThongKe = 5)
		BEGIN
		/*SELECT 
		FROM Phong p
		AND @SoNgayToiThieu <= (SELECT COUNT(ngay) 
								FROM TrangThaiPhong ttp
								WHERE ttp.tinhTrang LIKE N'đang bảo trì'
								AND p.maPhong = ttp.maPhong
								AND ttp.ngay BETWEEN @ThoiGianBatDau
								AND @ThoiGianKetThuc)*/
		RETURN 1
		END
		
		--+Thống kê số lượng phòng trống theo từng loại phòng
		IF (@MaSoThongKe = 6)
		BEGIN
		SELECT ()
		FROM Phong p, TrangThaiPhong ttp
		WHERE p.maPhong = ttp.maPhong
		AND ttp.tinhTrang LIKE N'còn trống'
		AND ttp.ngay BETWEEN @ThoiGianBatDau AND @ThoiGianKetThuc
		GROUP BY p.loaiPhong
		RETURN 1
		END
		
		
	END
END
GO
*/
--Stored Procedure không có Index
--EXEC Proc_DangKyTaiKhoanKhachHang

--Stored Procedure không có Index