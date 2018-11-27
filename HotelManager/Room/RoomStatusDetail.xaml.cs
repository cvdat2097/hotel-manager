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

namespace HotelManager.Room
{
    /// <summary>
    /// Interaction logic for RoomStatusDetail.xaml
    /// </summary>
    public partial class RoomStatusDetail : Window
    {
        public RoomStatusDetail()
        {
            InitializeComponent();
        }

        private void Window_Closed(object sender, EventArgs e)
        {
            App.mainWindow.Show();
        }
    }
}
