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
using HotelManager.Authentication;
using HotelManager.Services;
using HotelManager.Windows.Receipt;

namespace HotelManager
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            App.mainWindow = this;
            MainFrame.Source = SharedData.HotelSearchPage;
            SharedData.MainFrame = MainFrame;

            //// Kiem tra khi Cua so xuat hien
            //if (Auth.GetLoginStatus() == false)
            //{
            //    App.mainWindow.Hide();
            //    Login x = new Login();
            //    x.Show();
            //}
        }


        private void MainFrame_Navigated(object sender, NavigationEventArgs e)
        {
            if (Auth.GetLoginStatus() == true)
            {
                String pageName = MainFrame.Source.ToString();
                pageName = pageName.Substring(pageName.LastIndexOf('/') + 1);
                pageName = pageName.Substring(0, pageName.Length - 5);

                for (int i = 0; i < pageName.Length; i++)
                {
                    if (Char.IsUpper(pageName[i]))
                    {
                        pageName = pageName.Insert(i, " ");
                        i++;
                    }
                }

                lblPageName.Content = pageName;
            }
        }

        private void lblLogin_MouseDown(object sender, MouseButtonEventArgs e)
        {
            Auth.Logout();

            Login x = new Login();
            App.mainWindow.Hide();
            x.Show();
        }

        private void lblRegister_MouseDown(object sender, MouseButtonEventArgs e)
        {
            Register x = new Register();
            App.mainWindow.Hide();
            x.Show();
        }

        private void menuItemHotel_Click(object sender, RoutedEventArgs e)
        {
            if (MainFrame.Source != SharedData.HotelSearchPage)
            {
                MainFrame.Source = SharedData.HotelSearchPage;

            }
        }

        private void menuItemRoomList_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Source = SharedData.RoomListPage;
            //MainFrame.Refresh();
        }

        private void menuItemRoomStatus_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Source = SharedData.RoomStatusPage;
        }

        private void menuItemReceiptSearch_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Source = SharedData.ReceiptSearchPage;
        }

        private void menuItemReport_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Source = SharedData.ReportPage;
        }

        private void frmMain_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (this.Visibility == Visibility.Visible)
            {
                if (Auth.GetLoginStatus())
                {
                    lblLogin.Content = "Logout";
                }
                else
                {
                    lblLogin.Content = "Login";
                }
            }
        }

        private void menuItemExportBill_Click(object sender, RoutedEventArgs e)
        {
            if (Auth.GetLoginStatus() && Auth.GetLoggedInUserTypeIsCustomer() == false)
            {
                App.mainWindow.Hide();
                ExportReceipt x = new ExportReceipt();
                x.Show();
            }

            else
            {
                App.mainWindow.Hide();
                Login x = new Login();
                x.Show();
            }
        }
    }
}
