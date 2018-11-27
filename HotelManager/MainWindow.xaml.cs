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
        public MainWindow()
        {
            InitializeComponent();

            App.mainWindow = this;
        }

        private void Label_MouseDown(object sender, MouseButtonEventArgs e)
        {
            Login x = new Login();
            App.mainWindow.Hide();
            x.Show();            
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
    }
}
