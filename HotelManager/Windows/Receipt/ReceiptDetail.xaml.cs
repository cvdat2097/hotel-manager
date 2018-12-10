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
using HotelManager.Services;
using HotelManager.Model;

namespace HotelManager.Receipt
{
    /// <summary>
    /// Interaction logic for ReceiptDetail.xaml
    /// </summary>
    public partial class ReceiptDetail : Window
    {
        public ReceiptDetail()
        {
            InitializeComponent();
        }

        private void Window_Closed(object sender, EventArgs e)
        {
            App.mainWindow.Show();            
        }

        private void wndReceiptDetail_Loaded(object sender, RoutedEventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = dbQLKS.dbConnection;
            cmd.CommandText = "XuatHoatDon";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@MaHD", SharedData.CurrentReceipt.MaHD);

            SqlDataReader dr;

            dbQLKS.dbConnection.Open();
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblCustomerName.Content = dr["hoTen"].ToString();
                lblCheckinDate.Content = dr["ngayBatDau"].ToString();
                lblCheckoutDate.Content = dr["ngayTraPhong"].ToString();
                lblHotelName.Content = dr["tenKS"].ToString();
                lblIssuedDate.Content = dr["ngayThanhToan"].ToString();
                lblRoomType.Content = dr["tenLoaiPhong"].ToString();
                lblTotal.Content = dr["tongTien"].ToString() + " USD";
            }

            dbQLKS.dbConnection.Close();
    
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
