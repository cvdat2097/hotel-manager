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
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data.SqlClient;
using System.Data;
using HotelManager.Services;
using HotelManager.Model;
using HotelManager.Authentication;

namespace HotelManager.Room
{
    /// <summary>
    /// Interaction logic for RoomList.xaml
    /// </summary>
    public partial class RoomList : Page
    {

        class RoomRow
        {
            public String maPhong { get; set; }
            public String loaiPhong { get; set; }
            public String maLoaiPhong { get; set; }
            public int donGia { get; set; }
            public String moTa { get; set; }
            public int soPhong { get; set; }
            public int slTrong { get; set; }
        }

        public RoomList()
        {
            InitializeComponent();
        }

        private void pgRoomList_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (App.mainWindow.Visibility == Visibility.Visible)
            {
                if (Auth.GetLoginStatus() && Auth.GetLoggedInUserTypeIsCustomer())
                {

                    // Query Rooms
                    SqlCommand cmd = new SqlCommand(@"Select * from Phong as PH, LoaiPhong as LP
                                                Where PH.loaiPhong = LP.maLoaiPhong AND LP.maKS ='" + SharedData.CurrentHotel.maKS + "'",
                                               dbQLKS.dbConnection);
                    cmd.CommandType = CommandType.Text;

                    dbQLKS.dbConnection.Open();

                    IDataReader dr = cmd.ExecuteReader();

                    List<RoomRow> RoomList = new List<RoomRow>();

                    // Fill Datagrid
                    while (dr.Read())
                    {
                        RoomRow row = new RoomRow();

                        row.donGia = (int)dr["donGia"];
                        row.loaiPhong = dr["tenLoaiPhong"].ToString();
                        row.maLoaiPhong = dr["maLoaiPhong"].ToString();
                        row.maPhong = dr["maPhong"].ToString();
                        row.moTa = dr["moTa"].ToString();
                        row.slTrong = (int)dr["slTrong"];
                        row.soPhong = (int)dr["soPhong"];

                        RoomList.Add(row);
                    }

                    dgRoom.ItemsSource = RoomList;

                    dbQLKS.dbConnection.Close();

                    // Fill Hotel info
                    lblHotelName.Content = SharedData.CurrentHotel.tenKS;
                    lblAddress.Content = SharedData.CurrentHotel.soNha.ToString() + ", " + SharedData.CurrentHotel.quan + ", " + SharedData.CurrentHotel.thanhPho;
                }
                else
                {
                    App.mainWindow.Hide();
                    Login x = new Login();
                    x.Show();
                }
            }
        }

        private void btnBook_Click(object sender, RoutedEventArgs e)
        {
            // Validate
            bool dataIsValid = true;

            if (dpkCheckin.SelectedDate == null || dpkCheckout.SelectedDate == null)
            {
                dataIsValid = false;
                MessageBox.Show("Please select Check-in/Check-out date");
            }
            else
            {
                if (DateTime.Compare((DateTime)dpkCheckin.SelectedDate, (DateTime)dpkCheckout.SelectedDate) >= 0)
                {
                    MessageBox.Show("Selected date is not valid!");
                    dataIsValid = false;
                }
            }
            if (dgRoom.SelectedIndex == -1)
            {
                MessageBox.Show("Please select a room");
                dataIsValid = false;
            }



            // Query
            if (dataIsValid)
            {
                RoomRow currentSelectedRow = (RoomRow)dgRoom.Items[dgRoom.SelectedIndex];

                DateTime startDate = (DateTime)dpkCheckin.SelectedDate;
                DateTime endDate = (DateTime)dpkCheckout.SelectedDate;

                String hotelId = SharedData.CurrentHotel.maKS;
                String roomTypeId = currentSelectedRow.maLoaiPhong;
                String roomStatus = "đã xác nhận";
                String userId = Auth.GetLoggedInUserId();


                int status = dbQLKS.Proc_DatPhong(hotelId, roomTypeId, DateTime.Today, startDate, endDate, roomStatus, userId);

                switch (status)
                {
                    case -1:
                        MessageBox.Show("Hotel does not exist");
                        break;

                    case -2:
                        MessageBox.Show("Room Type does not exist");
                        break;

                    case -3:
                        MessageBox.Show("This room is not available");
                        break;
                    case 1:
                        MessageBox.Show("Book room " +currentSelectedRow.loaiPhong+ " successfully!");
                        break;

                    case 0:
                        MessageBox.Show("Sorry, Can not book this room.");
                        break;
                }
            }
        }
    }
}
