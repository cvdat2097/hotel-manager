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
        private static bool isCustomer = true;


        public static bool GetLoginStatus()
        {
            return isLoggedIn;
        }

        public static bool GetLoggedInUserTypeIsCustomer()
        {
            return isCustomer;
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
                isCustomer = false;
            }
            else
            {
                userId = dbQLKS.Func_DangNhap_KhachHang(userName, password);
                isCustomer = true;
            }


            if (userId != "0")
            {
                isLoggedIn = true;
                Auth.userId = userId;
                return true;
            }
            return false;
        }

        public static void Logout()
        {
            isLoggedIn = false;
            userId = "";
            isCustomer = true;
        }

        public static bool Register()
        {
            bool dataIsValid = true;
            // Validate data


            // Query DB
            if (dataIsValid)
            {

                
            }

            return true;
        }
    }
}
