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
using HotelManager.Services;
using HotelManager.Model;

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
            lblStatus.Content = "";
        }


        private void RegisterWindow_Closed(object sender, EventArgs e)
        {
            if (Auth.GetLoginStatus() == false)
            {
                if (!mainWindowLock)
                {
                    MessageBox.Show("Application quitting...");
                    Environment.Exit(1);
                }
            }
            else
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

        private void btnRegister_Click(object sender, RoutedEventArgs e)
        {
            bool infoIsValid = true;
            int idCard;
            int phone;

            // validate info

            if (!(txtFullname.Text.Length > 0))
            {
                MessageBox.Show("Fullname can not be empty");
                infoIsValid = false;
            }
            if (!(txtUsername.Text.Length > 0))
            {
                MessageBox.Show("Username can not be empty");
                infoIsValid = false;
            }
            if (!(txtPassword1.Password.Length > 0))
            {
                MessageBox.Show("Password can not be empty");
                infoIsValid = false;
            }
            if (!(txtPassword2.Password.Length > 0))
            {
                MessageBox.Show("Password can not be empty");
                infoIsValid = false;
            }
            if (!(txtPassword1.Password == txtPassword2.Password))
            {
                MessageBox.Show("Passwords mismatch");
                infoIsValid = false;
            }
            if (!(Int32.TryParse(txtIdCard.Text, out idCard)))
            {
                MessageBox.Show("CMND is invalid");
                infoIsValid = false;
            }
            if (!(txtAddress.Text.Length > 0))
            {
                MessageBox.Show("Address can not be empty");
                infoIsValid = false;
            }
            if (!(Int32.TryParse(txtPhone.Text, out phone)))
            {
                MessageBox.Show("Phone is invalid");
                infoIsValid = false;
            }
            if (!(txtEmail.Text.Length > 0))
            {
                MessageBox.Show("Email cant be empty");
                infoIsValid = false;
            }

            lblStatus.Content = "Registering...";
            // Execute Query

            if (infoIsValid)
            {
                int status = dbQLKS.Proc_DangKyTaiKhoanKhachHang(
                    txtFullname.Text,
                    txtUsername.Text,
                    txtPassword1.Password,
                    Int32.Parse(txtIdCard.Text),
                    txtAddress.Text,
                    Int32.Parse(txtPhone.Text),
                    "",
                    txtEmail.Text);

                switch (status)
                {
                    case -1:
                        MessageBox.Show("Username is existing");
                        break;
                    case -2:
                        MessageBox.Show("CMND is existing");
                        break;
                    case -3:
                        MessageBox.Show("Email is existing");
                        break;
                    case 1:
                        MessageBox.Show("Successfully!");
                        break;
                }
            }
            else
            {
                MessageBox.Show("Info is invalid");
            }
            lblStatus.Content = "";
        }
    }
}
