using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HotelManager.Model;

namespace HotelManager.Services
{
    public static class Auth
    {
        private static bool isLoggedIn = false;



        public static bool GetLoginStatus()
        {
            return isLoggedIn;
        }

        public static bool Login(String userName, String password, bool isForCustomer = true)
        {
            if (isForCustomer == true)
            {
                dbQLKS.Func_DangNhap_KhachHang(userName, password);
            }

            dbQLKS.Func_DangNhap_NhanVien(userName, password);


            Auth.isLoggedIn = true;
            return true;
        }
    }
}
