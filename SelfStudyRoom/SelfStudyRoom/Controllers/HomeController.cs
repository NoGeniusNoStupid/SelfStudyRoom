using SelfStudyRoom.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SelfStudyRoom.Controllers
{
    public class HomeController : BaseController
    {
        #region 登陆
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string UserName,string Pwd)
        {
            return View();
        }
        #endregion

        #region 注册
        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register(string Account, string password, int accountType)
        {
            //判断
            UserInfo Info= Entity.UserInfo.FirstOrDefault(a => a.StuNo == Account);
            if (Info != null)
            {
                return RedirectDialogToAction("Register", "Home", "该账号已被注册，请更换手机或邮箱号");
            }

            //对象赋值
            UserInfo userInfo = new UserInfo();
            userInfo.StuNo = Account;
            userInfo.Password = password;
            if (accountType == 1)
            {
                userInfo.Email = Account;
            }
            else
                userInfo.Tel = Account;

            userInfo.RegTime = DateTime.Now;


            //保存
            Entity.UserInfo.Add(userInfo);
            if (Entity.SaveChanges() > 0)
              return RedirectToAction("Index", "UserInfo"); 
            else
              return RedirectDialogToAction("Register", "Home", "注册失败");
        }
        #endregion
        
    }
}
