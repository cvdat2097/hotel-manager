using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Controls;

namespace HotelManager.Services
{
    public static class SharedData
    {
        public static Uri HotelSearchPage = new Uri("Windows/Hotel/HotelSearch.xaml", UriKind.Relative);
        public static Uri RoomListPage = new Uri("Windows/Room/RoomList.xaml", UriKind.Relative);
        public static Uri RoomStatusPage = new Uri("Windows/Room/RoomStatus.xaml", UriKind.Relative);
        public static Uri ReceiptSearchPage = new Uri("Windows/Receipt/SearchReceipt.xaml", UriKind.Relative);
        public static Uri ReportPage = new Uri("Windows/Report/Report.xaml", UriKind.Relative);
        public static Frame MainFrame;

        public static HotelRow CurrentHotel; // Switch to RoomList
        public static ReceiptRow CurrentReceipt; // Switch to ReceiptDetail
    }

     public class ReceiptRow
        {
            public String MaHD { get; set; }
            public DateTime NgayLap { get; set; }
            public double TongTien { get; set; }
            public String MaDP { get; set; }
        }

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
}
