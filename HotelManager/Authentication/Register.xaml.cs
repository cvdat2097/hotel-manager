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
    /// Interaction logic for Register.xaml
    /// </summary>
    public partial class Register : Window
    {
        private bool mainWindowLock = false;

        public Register()
        {
            InitializeComponent();
        }


        private void RegisterWindow_Closed(object sender, EventArgs e)
        {
            if (!mainWindowLock)
            {
                App.mainWindow.Show();
            }
        }

        private void lblLogin_MouseDown(object sender, MouseButtonEventArgs e)
        {
            mainWindowLock = true;

            this.Close();
            Login x = new Login();
            x.Show();
        }
    }
}
