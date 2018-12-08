using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;


namespace HotelManager.Model
{
    public static class dbQLKS
    {
        public static String connectionString = "server=DESKTOP-TKKCCPU\\SQLEXPRESS; database=QuanLyKhachSan;user id=sa; password=123456";
        public static SqlConnection dbConnection;

        public static void InitDB()
        {
            dbConnection = new SqlConnection(connectionString);
        }

        public static void Proc_DangKyTaiKhoanKhachHang(String HoTen, String TenDangNhap, String MatKhau, int SoCMND, String DiaChi,
            int SoDienThoai, String MoTa, String Email) { }
        public static void Proc_TimKiemThongTinKhachSan(int giaCa, int hangSao) { }
        public static void Func_DangNhap_KhachHang(String TenDangNhap, String MatKhau) { }
        public static void Proc_DatPhong(String MaKhachSan, String MaLoaiPhong, DateTime NgayDat, DateTime NgayBatDau,
            DateTime NgayTraPhong, String TinhTrang, String TenDangNhap, String MatKhau) { }
        public static void Func_DangNhap_NhanVien(String TenDangNhap, String MatKhau) { }
        public static void Proc_LapHoaDon(String MaDP, String MaKS, String TenDangNhap, String MatKhau) { }
        public static void Proc_KiemTraTinhTrangPhong(String MaLoaiPhong, DateTime Ngay, String MaKS, String TenDangNhap, String MatKhau,
            String NhapButton, String PhongDuocChon) { }
        public static void Proc_TimKiemThongTinHoaDon(String MaKH, DateTime NgayLap, int ThanhTien, String MaKS, String TenDangNhap, String MatKhau, String HoaDonDuocChon) { }
        public static void Proc_ThongKe(int MaThongKe) { }
    }
}
