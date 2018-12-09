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
using HotelManager.Model;

namespace HotelManager.Hotel
{
    /// <summary>
    /// Interaction logic for HotelSearch.xaml
    /// </summary>
    public partial class HotelSearch : Page
    {
        public class HotelRow
        {
            public String maKS { get; set; }
            public String tenKS { get; set; }
            public int soSao { get; set; }
            public String soNha { get; set; }
            public String duong { get; set; }
            public String quan { get; set; }
            public String thanhPho { get; set; }
            public String moTa { get; set; }
            public int giaTB { get; set; }

            public HotelRow()
            {

            }

            public HotelRow(String maKS, String tenKS, int soSao, int soNha, String duong, String quan, String thanhPho, String moTa, int giaTB)
            {

            }
        }
        public HotelSearch()
        {
            InitializeComponent();
        }

        private void pgHotelSearch_Initialized(object sender, EventArgs e)
        {

        }

        private void btnSearch_Click(object sender, RoutedEventArgs e)
        {
            bool dataIsValid = true;
            String cityKeyword = txtCity.Text;
            String starKeyword = cmbStar.Text;
            int priceFrom = 0;
            int priceTo = 0;

            if ((txtPriceFrom.Text.Length > 0 || txtPriceTo.Text.Length > 0) && (!Int32.TryParse(txtPriceFrom.Text, out priceFrom) ||
            !Int32.TryParse(txtPriceTo.Text, out priceTo) || !(priceFrom >= 0 && priceTo > 0 && priceTo >= priceFrom)))
            {
                MessageBox.Show("Price is not valid");
                dataIsValid = false;
            }

            // validate input data
            if (dataIsValid && !(cityKeyword.Length > 0) && !(cityKeyword.Length > 0) && !(starKeyword.Length > 0))
            {
                MessageBox.Show("At least one info must be provided");
                dataIsValid = false;
            }


            // Execute query
            if (dataIsValid)
            {
                IDbCommand cmd = new SqlCommand("SELECT * FROM KhachSan WHERE ", dbQLKS.dbConnection);
                cmd.CommandType = CommandType.Text;

                if (cityKeyword.Length > 0)
                {
                    cmd.CommandText += "(thanhPho like N'%" + cityKeyword + "%' )";
                }
                if (starKeyword.Length > 0)
                {
                    if (cityKeyword.Length > 0)
                    {
                        cmd.CommandText += ("AND soSao = " + starKeyword);
                    }
                    else
                    {
                        cmd.CommandText += ("soSao = " + starKeyword);
                    }
                }
                if (priceFrom >= 0 && priceTo > 0 && priceTo >= priceFrom)
                {
                    if (cityKeyword.Length > 0)
                    {
                        cmd.CommandText += ("AND (giaTB >= " + priceFrom + " AND giaTB <=" + priceTo + ")");
                    }
                    else
                    {
                        cmd.CommandText += ("(giaTB >= " + priceFrom + " AND giaTB <=" + priceTo + ")");
                    }
                }

                dbQLKS.dbConnection.Open();

                IDataReader dr = cmd.ExecuteReader();

                List<HotelRow> HotelList = new List<HotelRow>();

                while (dr.Read())
                {
                    HotelRow row = new HotelRow();

                    row.maKS = dr["maKS"].ToString();
                    row.moTa = dr["moTa"].ToString();
                    row.quan = dr["quan"].ToString();
                    row.soNha = dr["soNha"].ToString();
                    row.soSao = (int)dr["soSao"];
                    row.giaTB = (int)dr["giaTB"];
                    row.tenKS = dr["tenKS"].ToString();
                    row.thanhPho = dr["thanhPho"].ToString();
                    row.duong = dr["duong"].ToString();

                    HotelList.Add(row);
                }

                dgHotel.ItemsSource = HotelList;
                dbQLKS.dbConnection.Close();

                // Notify
                lblStatus.Content = "Found " + HotelList.Count.ToString();
            }
        }
    }
}
