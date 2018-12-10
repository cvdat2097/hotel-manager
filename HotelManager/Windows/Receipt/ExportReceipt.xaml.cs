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
using HotelManager.Authentication;

namespace HotelManager.Windows.Receipt
{
    /// <summary>
    /// Interaction logic for ExportReceipt.xaml
    /// </summary>
    public partial class ExportReceipt : Window
    {
        public ExportReceipt()
        {
            InitializeComponent();
        }

        private void wndExportBill_Closed(object sender, EventArgs e)
        {
            App.mainWindow.Show();
        }

        private void btnExport_Click(object sender, RoutedEventArgs e)
        {
            bool dataIsValid = true;

            // validate
            if (!(txtBookingID.Text.Length > 0))
            {
                MessageBox.Show("Booking ID can not be empty!");
                dataIsValid = false;
            }

            // query
            if (dataIsValid)
            {
                SqlConnection dbConnection = dbQLKS.dbConnection;
                SqlCommand cmd = new SqlCommand("Proc_LapHoaDon", dbConnection);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@MaDP", txtBookingID.Text);
                cmd.Parameters.AddWithValue("@MaNV", Auth.GetLoggedInUserId());
                cmd.Parameters.AddWithValue("@NhapHoaDon", 1);
                

                var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;

                dbConnection.Open();
                int Status = (int)cmd.ExecuteNonQuery();
                dbConnection.Close();

                int returnParam =  (int)returnParameter.Value;

                if (returnParam == 2)
                {
                    MessageBox.Show("Export Receipt successfully");
                }
                else
                {
                    MessageBox.Show("Export Receipt failed");
                }
            }
        }

        private void wndExportBill_Loaded(object sender, RoutedEventArgs e)
        {
            
        }
    }
}
