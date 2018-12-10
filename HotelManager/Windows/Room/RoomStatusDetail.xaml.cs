using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Data;
using System.Data.SqlClient;
using HotelManager.Authentication;
using HotelManager.Services;
using HotelManager.Model;

namespace HotelManager.Room
{
    /// <summary>
    /// Interaction logic for RoomStatusDetail.xaml
    /// </summary>
    public partial class RoomStatusDetail : Window
    {
        public RoomStatusDetail()
        {
            InitializeComponent();
        }

        private void Window_Closed(object sender, EventArgs e)
        {
            App.mainWindow.Show();
        }

        private void wndRoomStatusDetail_Loaded(object sender, RoutedEventArgs e)
        {
            String MaPhong = SharedData.CurrentRoom.MaPhong;

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbQLKS.dbConnection;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = @"SELECT *
                                FROM Phong as PH, LoaiPhong as LP, KhachSan as KS
                                WHERE PH.loaiPhong = LP.maLoaiPhong
                                AND LP.maKS = KS.maKS
                                AND PH.maPhong = '" + MaPhong + "'";

            dbQLKS.dbConnection.Open();
            SqlDataReader dr = cmd.ExecuteReader();



            if (dr.Read())
            {
                lblDescription.Content = dr["moTa"];
                lblHotelName.Content = dr["tenKS"];
                lblPrice.Content = dr["donGia"] + " USD";
                lblRoomNumber.Content = "Room " +  dr["soPhong"];
                lblRoomType.Content = dr["tenLoaiPhong"];
            }

            dbQLKS.dbConnection.Close();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
