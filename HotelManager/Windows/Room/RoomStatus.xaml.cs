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

namespace HotelManager.Room
{
    /// <summary>
    /// Interaction logic for RoomStatus.xaml
    /// </summary>
    public partial class RoomStatus : Page
    {
        public RoomStatus()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            App.mainWindow.Hide();
            RoomStatusDetail x = new RoomStatusDetail();
            x.Show();
        }
    }
}