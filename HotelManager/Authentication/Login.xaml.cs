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

namespace HotelManager.Authentication
{
    /// <summary>
    /// Interaction logic for Login.xaml
    /// </summary>
    public partial class Login : Window
    {
        private bool mainWindowLock = false;

        public Login()
        {
            InitializeComponent();
        }

        private void LoginWindow_Closed(object sender, EventArgs e)
        {
            if (!mainWindowLock)
            {
                App.mainWindow.Show();
            }

        }

        private void lblRegister_MouseDown(object sender, MouseButtonEventArgs e)
        {
            mainWindowLock = true;

            this.Close();
            Register x = new Register();
            x.Show();
        }
    }
}
