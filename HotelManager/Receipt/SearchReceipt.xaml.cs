﻿using System;
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
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            App.mainWindow.Hide();
            ReceiptDetail x = new ReceiptDetail();
            x.Show();
        }
    }
}
