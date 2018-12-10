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
        //public static String connectionString = "server=DESKTOP-TKKCCPU\\SQLEXPRESS; database=QuanLyKhachSan;user id=sa; password=123456";
        public static String connectionString = "server=LAP10719\\SQLEXPRESS; database=QLKS;user id=sa; password=123456";
        public static SqlConnection dbConnection = new SqlConnection(connectionString);

        public static IDbCommand CreateCommand(String query)
        {
            IDbCommand cmd = new SqlCommand();
            cmd.Connection = dbConnection;
            cmd.CommandText = query;
            cmd.CommandType = CommandType.Text;

            return cmd;
        }

        public static int Proc_DangKyTaiKhoanKhachHang(String HoTen, String TenDangNhap, String MatKhau, int SoCMND, String DiaChi,
            int SoDienThoai, String MoTa, String Email)
        {
            SqlCommand cmd = new SqlCommand("Proc_DangKyTaiKhoanKhachHang", dbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@hoTen", HoTen);
            cmd.Parameters.AddWithValue("@tenDangNhap", TenDangNhap);
            cmd.Parameters.AddWithValue("@matKhau", MatKhau);
            cmd.Parameters.AddWithValue("@soCMND", SoCMND);
            cmd.Parameters.AddWithValue("@diaChi", DiaChi);
            cmd.Parameters.AddWithValue("@soDienThoai", SoDienThoai);
            cmd.Parameters.AddWithValue("@moTa", MoTa);
            cmd.Parameters.AddWithValue("@email", Email);

            var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
            returnParameter.Direction = ParameterDirection.ReturnValue;

            dbConnection.Open();
            int Status = (int)cmd.ExecuteNonQuery();
            dbConnection.Close();

            return (int) returnParameter.Value;
        }
        public static void Proc_TimKiemThongTinKhachSan(int giaCa, int hangSao) { }
        public static String Func_DangNhap_KhachHang(String TenDangNhap, String MatKhau)
        {
            SqlCommand cmd = (SqlCommand)CreateCommand("SELECT dbo.Func_DangNhap_KhachHang(@TenDangNhap, @MatKhau)");
            cmd.Parameters.AddWithValue("@TenDangNhap", TenDangNhap);
            cmd.Parameters.AddWithValue("@MatKhau", MatKhau);


            dbConnection.Open();
            String Username = (String)cmd.ExecuteScalar();
            dbConnection.Close();

            return Username;
        }

        public static String Func_DangNhap_NhanVien(String TenDangNhap, String MatKhau)
        {
            SqlCommand cmd = (SqlCommand)CreateCommand("SELECT dbo.Func_DangNhap_NhanVien(@TenDangNhap, @MatKhau)");
            cmd.Parameters.AddWithValue("@TenDangNhap", TenDangNhap);
            cmd.Parameters.AddWithValue("@MatKhau", MatKhau);


            dbConnection.Open();
            String Username = (String)cmd.ExecuteScalar();
            dbConnection.Close();

            return Username;
        }


        public static int Proc_DatPhong(String MaKhachSan, String MaLoaiPhong, DateTime NgayDat, DateTime NgayBatDau,
            DateTime NgayTraPhong, String MaKH) 
        {
            SqlCommand cmd = new SqlCommand("Proc_DatPhong", dbConnection);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@MaKhachSan", MaKhachSan);
            cmd.Parameters.AddWithValue("@MaLoaiPhong", MaLoaiPhong);
            cmd.Parameters.AddWithValue("@NgayDat", NgayDat);
            cmd.Parameters.AddWithValue("@NgayBatDau", NgayBatDau);
            cmd.Parameters.AddWithValue("@NgayTraPhong", NgayTraPhong);
            //cmd.Parameters.AddWithValue("@TinhTrang", TinhTrang);
            cmd.Parameters.AddWithValue("@MaKH", MaKH);

            var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
            returnParameter.Direction = ParameterDirection.ReturnValue;

            dbConnection.Open();
            int Status = (int)cmd.ExecuteNonQuery();
            dbConnection.Close();

            return (int)returnParameter.Value;
        }


        public static void Proc_LapHoaDon(String MaDP, String MaKS, String TenDangNhap, String MatKhau) { }
        public static void Proc_KiemTraTinhTrangPhong(String MaLoaiPhong, DateTime Ngay, String MaKS, String TenDangNhap, String MatKhau,
            String NhapButton, String PhongDuocChon) { }
        public static void Proc_TimKiemThongTinHoaDon(String MaKH, DateTime NgayLap, int ThanhTien, String MaKS, String TenDangNhap, String MatKhau, String HoaDonDuocChon) { }
        public static void Proc_ThongKe(int MaThongKe) { }
    }
}
