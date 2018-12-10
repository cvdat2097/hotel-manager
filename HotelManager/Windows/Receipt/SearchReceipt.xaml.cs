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
using HotelManager.Services;
using HotelManager.Model;
using HotelManager.Authentication;

namespace HotelManager.Receipt
{
    /// <summary>
    /// Interaction logic for SearchReceipt.xaml
    /// </summary>
    public partial class SearchReceipt : Page
    {

       
        public SearchReceipt()
        {
            InitializeComponent();

            lblStatus.Content = "";
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            App.mainWindow.Hide();
            ReceiptDetail x = new ReceiptDetail();
            x.Show();
        }

        private void btnSearch_Click(object sender, RoutedEventArgs e)
        {
            bool dataIsValid = true;
            int priceFrom = 0;
            int priceTo = 1;
            String CustomerID;


            // Validate 
            if (!(txtCustomerId.Text.Length > 0))
            {
                MessageBox.Show("Customer ID can't be empty");
                dataIsValid = false;
            }
            if (/*(txtPriceFrom.Text.Length > 0 || txtPriceTo.Text.Length > 0) && */
                dataIsValid && (!Int32.TryParse(txtPriceFrom.Text, out priceFrom) ||
            !Int32.TryParse(txtPriceTo.Text, out priceTo) || !(priceFrom >= 0 && priceTo > 0 && priceTo >= priceFrom)))
            {
                MessageBox.Show("Price is not valid");
                dataIsValid = false;
            }
            if (dataIsValid && dpkIssuedDate.SelectedDate == null)
            {
                dataIsValid = false;
                MessageBox.Show("Please select a date");
            }

            // Query Receipts

            if (dataIsValid)
            {
                CustomerID = txtCustomerId.Text;
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = dbQLKS.dbConnection;
                cmd.CommandText = "TimKiemHoaDon";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MaNV", Auth.GetLoggedInUserId());
                cmd.Parameters.AddWithValue("@MaKH", CustomerID);
                cmd.Parameters.AddWithValue("@GiaBatDau", priceFrom);
                cmd.Parameters.AddWithValue("@GiaKetThuc", priceTo);
                cmd.Parameters.AddWithValue("@NgayXuatHoaDon", dpkIssuedDate.SelectedDate);

                SqlDataReader dr;

                dbQLKS.dbConnection.Open();
                dr = cmd.ExecuteReader();


                List<ReceiptRow> ReceiptList = new List<ReceiptRow>();

                // Fill Datagrid
                while (dr.Read())
                {
                    ReceiptRow row = new ReceiptRow();

                    row.MaHD = dr["maHD"].ToString();
                    row.NgayLap = (DateTime)dr["ngayThanhToan"];
                    row.TongTien = Math.Round((double)dr["tongTien"], 1);
                    row.MaDP = dr["maDP"].ToString();

                    ReceiptList.Add(row);
                }

                dgReceipt.ItemsSource = ReceiptList;

                dbQLKS.dbConnection.Close();

                // Show status
                lblStatus.Content = "Found " + ReceiptList.Count;

            }
        }

        private void pdgSearchReceipt_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (App.mainWindow.Visibility == Visibility.Visible)
            {
                if (Auth.GetLoginStatus() && Auth.GetLoggedInUserTypeIsCustomer() == false)
                {
                }
                else
                {
                    App.mainWindow.Hide();
                    Login x = new Login();
                    x.Show();
                }
            }
        }

        private void btnExport_Click(object sender, RoutedEventArgs e)
        {
            if (dgReceipt.SelectedIndex == -1)
            {
                MessageBox.Show("Please select a Receipt!");
            }
            else
            {
                SharedData.CurrentReceipt = (ReceiptRow)dgReceipt.Items[dgReceipt.SelectedIndex];

                App.mainWindow.Hide();
                ReceiptDetail x = new ReceiptDetail();
                x.Show();
            }
        }
    }
}
