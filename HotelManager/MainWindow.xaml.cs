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

namespace HotelManager
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private static Uri HotelSearchPage = new Uri("Hotel/HotelSearch.xaml", UriKind.Relative);
        private static Uri RoomListPage = new Uri("Room/RoomList.xaml", UriKind.Relative);
        private static Uri RoomStatusPage = new Uri("Room/RoomStatus.xaml", UriKind.Relative);
        private static Uri ReceiptSearchPage = new Uri("Receipt/SearchReceipt.xaml", UriKind.Relative);
        private static Uri ReportPage = new Uri("Report/Report.xaml", UriKind.Relative);

        public MainWindow()
        {
            InitializeComponent();

            App.mainWindow = this;

            MainFrame.Source = HotelSearchPage;
        }


        private void MainFrame_Navigated(object sender, NavigationEventArgs e)
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

        private void lblLogin_MouseDown(object sender, MouseButtonEventArgs e)
        {
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
            if (MainFrame.Source != HotelSearchPage)
            {
                MainFrame.Source = HotelSearchPage;

            }
        }

        private void menuItemRoomList_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Source = RoomListPage;
            //MainFrame.Refresh();
        }

        private void menuItemRoomStatus_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Source = RoomStatusPage;
        }

        private void menuItemReceiptSearch_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Source = ReceiptSearchPage;
        }

        private void menuItemReport_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Source = ReportPage;
        }

    }
}
