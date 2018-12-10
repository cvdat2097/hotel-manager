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
using System.Data;
using System.Data.SqlClient;
using HotelManager.Authentication;
using HotelManager.Services;
using HotelManager.Model;

namespace HotelManager.Room
{
    /// <summary>
    /// Interaction logic for RoomStatus.xaml
    /// </summary>
    public partial class RoomStatus : Page
    {
        private static bool isRoomTypeMode = true;
        private static String MaKS;


        public RoomStatus()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Visibility = Visibility.Hidden;
            this.Visibility = Visibility.Visible;
        }

        private void pgRoomStatus_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (App.mainWindow.Visibility == Visibility.Visible)
            {
                if (Auth.GetLoginStatus() && Auth.GetLoggedInUserTypeIsCustomer() == false)
                {
                    // Disable buttons
                    btnRoomDetail.IsEnabled = false;
                    btnSearch.IsEnabled = true;


                    // Load Hotel info
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = dbQLKS.dbConnection;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = @"select * from KhachSan as KS, NhanVien as NV
                                        where NV.maNV = '" + Auth.GetLoggedInUserId() + "' AND NV.MaKS = KS.maKS";

                    SqlDataReader dr;

                    dbQLKS.dbConnection.Open();

                    dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        lblHotelName.Content = dr["tenKS"].ToString();
                        lblHotelAddress.Content = dr["soNha"] + ", " + dr["duong"] + ", " + dr["quan"] + ", " + dr["thanhPho"];
                        MaKS = dr["maKS"].ToString();

                        // Load RoomType list
                        cmd.CommandText = "SELECT * FROM LoaiPhong WHERE maKS = '" + MaKS + "'";

                        List<RoomTypeRow> RoomtTypeList = new List<RoomTypeRow>();

                        dr.Close();

                        dr = cmd.ExecuteReader();

                        while (dr.Read())
                        {
                            RoomTypeRow roomTypeRow = new RoomTypeRow();
                            roomTypeRow.MaLoaiPhong = dr["maLoaiPhong"].ToString();
                            roomTypeRow.TenLoaiPhong = dr["tenLoaiPhong"].ToString();

                            RoomtTypeList.Add(roomTypeRow);
                        }

                        dgRoomStatus.ItemsSource = RoomtTypeList;
                    }
                    else
                    {
                        MessageBox.Show("You are not beloing to any Hotel");
                        Auth.Logout();
                        App.mainWindow.Hide();
                        Login x = new Login();
                        x.Show();
                    }

                    dbQLKS.dbConnection.Close();
                }
                else
                {
                    App.mainWindow.Hide();
                    Login x = new Login();
                    x.Show();
                }
            }
        }

        private void btnSearch_Click(object sender, RoutedEventArgs e)
        {
            if (dgRoomStatus.SelectedIndex != -1)
            {
                bool dataIsValid = true;

                // validate
                if (dpkDate.SelectedDate == null)
                {
                    MessageBox.Show("Please select a date");
                    dataIsValid = false;
                }


                // Query
                if (dataIsValid)
                {
                    DateTime selectedDate = (DateTime)dpkDate.SelectedDate;
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = dbQLKS.dbConnection;
                    cmd.CommandType = CommandType.Text;

                    RoomTypeRow row = (RoomTypeRow)dgRoomStatus.Items[dgRoomStatus.SelectedIndex];
                    cmd.CommandText = @"SELECT *
                                    FROM Phong as PH, LoaiPhong as LP, TrangThaiPhong as TTh
                                    WHERE LP.maLoaiPhong = PH.loaiPHong
                                    AND PH.loaiPhong = '" + row.MaLoaiPhong + "'" +
                                    @"AND TTh.maPhong = PH.maPhong
                                    AND year(TTh.ngay) =" + selectedDate.Year +
                                    "AND month(TTh.ngay) =" + selectedDate.Month +
                                    "AND day(TTh.ngay) =" + selectedDate.Day;


                    dbQLKS.dbConnection.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    List<RoomRow> RoomList = new List<RoomRow>();

                    while (dr.Read())
                    {
                        RoomRow r = new RoomRow();

                        r.LoaiPhong = dr["tenLoaiPhong"].ToString();
                        r.MaPhong = dr["maPhong"].ToString();
                        r.SoPhong = dr["soPhong"].ToString();
                        r.TrangThai = dr["tinhTrang"].ToString();

                        RoomList.Add(r);
                    }

                    dgRoomStatus.ItemsSource = RoomList;
                    dbQLKS.dbConnection.Close();

                    // Disable buttons
                    btnRoomDetail.IsEnabled = true;
                    btnSearch.IsEnabled = false;
                }
            }
            else
            {
                MessageBox.Show("Please select a Room Type");
            }
        }

        private void btnRoomDetail_Click(object sender, RoutedEventArgs e)
        {
            if (dgRoomStatus.SelectedIndex == -1)
            {
                MessageBox.Show("Please select a Room");
            }
            else
            {
                SharedData.CurrentRoom = (RoomRow)dgRoomStatus.Items[dgRoomStatus.SelectedIndex];

                App.mainWindow.Hide();
                RoomStatusDetail x = new RoomStatusDetail();
                x.Show();
            }
        }
    }
}
