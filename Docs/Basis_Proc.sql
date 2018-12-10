Create proc Proc_DatPhong
@MaKH NVARCHAR(10),
@MaKhachSan NVARCHAR(10),
@MaLoaiPhong NVARCHAR(10),
@NgayDat DATE,
@NgayBatDau DATE,
@NgayTraPhong DATE
AS
BEGIN
	DECLARE @SLTRONG int;
	SET @SLTRONG = (
	select slTrong
	from LoaiPhong
	where maLoaiPhong = @MaLoaiPhong
	)

	IF (@SLTRONG > 0)
	BEGIN
		UPDATE LoaiPhong
		SET slTrong = (@SLTRONG - 1)
		WHERE maLoaiPhong = @MaLoaiPhong

		DECLARE @DonGia INT
		SELECT @DonGia = donGia FROM LoaiPhong 
		WHERE maLoaiPhong=@MaLoaiPhong

		DECLARE @MaDP VARCHAR(10)
		SET @MaDP = dbo.Func_GenerateMa(3)
		INSERT INTO dbo.DatPhong( maDP,
								  maLoaiPhong ,
							      maKH ,
							      ngayBatDau ,
							      ngayTraPhong ,
							      ngayDat ,
							      donGia,
								  tinhTrang)
		VALUES  (@MaDP,
				@MaLoaiPhong ,
			    @MaKH ,
			    @NgayBatDau ,
				@NgayTraPhong,
				@NgayDat,
				@DonGia,
				N'chưa xác nhận'
				 )

		RETURN 1;
	END
	ELSE
	BEGIN
		RETURN 0;
	END
END

-- So 7
CREATE proc TimKiemHoaDon
@MaNV NVARCHAR(10) = 'NV001',
@MaKH NVARCHAR(10) = 'KH001',
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

CREATE PROC XuatHoatDon
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