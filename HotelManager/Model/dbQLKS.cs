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
        public static SqlConnection dbConnection = new SqlConnection(connectionString);

        private static SqlCommand CreateCommand(String query)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;
            cmd.CommandText = query;
            cmd.CommandType = CommandType.Text;

            return cmd;
        }

        public static void Proc_DangKyTaiKhoanKhachHang(String HoTen, String TenDangNhap, String MatKhau, int SoCMND, String DiaChi,
            int SoDienThoai, String MoTa, String Email) { }
        public static void Proc_TimKiemThongTinKhachSan(int giaCa, int hangSao) { }
        public static String Func_DangNhap_KhachHang(String TenDangNhap, String MatKhau)
        {
            SqlCommand cmd = CreateCommand("SELECT dbo.Func_DangNhap_KhachHang(@TenDangNhap, @MatKhau)");
            cmd.Parameters.AddWithValue("@TenDangNhap", TenDangNhap);
            cmd.Parameters.AddWithValue("@MatKhau", MatKhau);

            dbConnection.Open();
            String Username = (String)cmd.ExecuteScalar();
            dbConnection.Close();

            return Username;
        }
        public static void Proc_DatPhong(String MaKhachSan, String MaLoaiPhong, DateTime NgayDat, DateTime NgayBatDau,
            DateTime NgayTraPhong, String TinhTrang, String TenDangNhap, String MatKhau) { }
        public static String Func_DangNhap_NhanVien(String TenDangNhap, String MatKhau)
        {
            return "";
        }
        public static void Proc_LapHoaDon(String MaDP, String MaKS, String TenDangNhap, String MatKhau) { }
        public static void Proc_KiemTraTinhTrangPhong(String MaLoaiPhong, DateTime Ngay, String MaKS, String TenDangNhap, String MatKhau,
            String NhapButton, String PhongDuocChon) { }
        public static void Proc_TimKiemThongTinHoaDon(String MaKH, DateTime NgayLap, int ThanhTien, String MaKS, String TenDangNhap, String MatKhau, String HoaDonDuocChon) { }
        public static void Proc_ThongKe(int MaThongKe) { }
    }
}
