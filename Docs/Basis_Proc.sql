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

--5.Lập hóa đơn
CREATE PROC Proc_LapHoaDon
--@NgayLap DATE,
@MaDP VARCHAR(10),
@MaNV VARCHAR(10),
@NhapHoaDon int = 0 
-- Trả về: 0 - Lập HD không thành công, 1 - Lập HD thành công
-- 2 - Lưu HD thành công
AS
BEGIN
	--Nhân viên phải đăng nhập thành công
	DECLARE @MaKS VARCHAR(10)
	SELECT @MaKS = maKS
	FROM NhanVien
	WHERE maNV = @MaNV

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
	
END
GO