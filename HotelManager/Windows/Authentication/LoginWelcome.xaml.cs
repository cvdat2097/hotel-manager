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
using HotelManager.Services;
using HotelManager.Model;
using System.Data.SqlClient;
using System.Data;

namespace HotelManager.Authentication
{
    /// <summary>
    /// Interaction logic for LoginWelcome.xaml
    /// </summary>
    public partial class LoginWelcome : Window
    {
        public LoginWelcome()
        {
            InitializeComponent();
        }

        private void wndLoginWelcom_Loaded(object sender, RoutedEventArgs e)
        {
            if (Auth.GetLoginStatus() && Auth.GetLoggedInUserId().Length > 1)
            {
                IDbCommand cmd;

                if (Auth.GetLoggedInUserTypeIsCustomer())
                {

                    cmd = dbQLKS.CreateCommand("SELECT * FROM KhachHang WHERE maKH = '" + Auth.GetLoggedInUserId() + "'");
                }
                else
                {
                    cmd = dbQLKS.CreateCommand("SELECT * FROM NhanVien WHERE maNV = '" + Auth.GetLoggedInUserId() + "'");
                }


                dbQLKS.dbConnection.Open();
                IDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblWelcome.Content = "Welcome, " + dr["hoTen"].ToString();
                    lblUsername.Content = dr["tenDangNhap"].ToString();
                    if (Auth.GetLoggedInUserTypeIsCustomer())
                    {
                        lblEmail.Content = dr["email"];
                        lblUsertype.Content = "Customer";
                    }
                    else
                    {
                        lblUsertype.Content = "Staff";
                    }

                }

                dbQLKS.dbConnection.Close();
            }
        }

        private void wndLoginWelcom_Closed(object sender, EventArgs e)
        {
            if (Auth.GetLoginStatus() == false)
            {
                MessageBox.Show("Application quitting...");
                Environment.Exit(1);
            }
            else
            {
                App.mainWindow.Show();
            }
        }

        private void btnContinue_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
