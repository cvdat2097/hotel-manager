using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HotelManager.Model;
using System.Windows;

namespace HotelManager.Services
{
    public static class Auth
    {
        private static bool isLoggedIn = false;
        private static String userId = "";


        public static bool GetLoginStatus()
        {
            return isLoggedIn;
        }

        public static String GetLoggedInUserId()
        {
            if (isLoggedIn == true)
            {
                return userId;
            }

            return "";
        }

        public static bool Login(String userName, String password, bool isForCustomer = true)
        {
            String userId = "";

            if (isForCustomer == false)
            {
                userId = dbQLKS.Func_DangNhap_NhanVien(userName, password);
            }

            userId = dbQLKS.Func_DangNhap_KhachHang(userName, password);


            if (userId != "0")
            {
                isLoggedIn = true;
                Auth.userId = userId;
                MessageBox.Show(userId);
                return true;
            }
            return false;
        }

        public static void Logout()
        {
            isLoggedIn = false;
        }
    }
}
