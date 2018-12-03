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
        public ActionResult Login(string Account, string Password,int optionsRadios)
        {
            if (optionsRadios == 1)
            {
                //普通用户登录
                var userInfo = Entity.UserInfo.FirstOrDefault(a => a.StuNo == Account && a.Password == Password);
                if (userInfo == null)
                    return RedirectDialogToAction("Login", "Home", "账号或密码输入错误！请重新检查。");
                else
                {
                    Session["UserId"] = userInfo.Id;
                    return RedirectToAction("Index", "UserInfo");
                }
            }
            else
            {
                //管理员登陆
                var adminInfo = Entity.Admin.FirstOrDefault(a => a.AdminName == Account && a.AdminPwd == Password);
                if (adminInfo == null)
                    return RedirectDialogToAction("Login", "Home", "账号或密码输入错误！请重新检查。");
                else
                {
                    Session["AdminId"] = adminInfo.Id;
                    return RedirectToAction("Index", "Admin"); 
                }
            }
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
            //设置账户
            if (accountType == 1)
            {
                userInfo.Email = Account;
            }
            else
                userInfo.Tel = Account;

            //随机生成照片
            Random rd = new Random();
            int num = rd.Next(1, 28);
            userInfo.Image = string.Format("/File/face{0}.jpg", num);
            userInfo.Name = "匿名";
            userInfo.RegTime = DateTime.Now;
            //保存
            Entity.UserInfo.Add(userInfo);
            if (Entity.SaveChanges() > 0)
            {
                Session["UserId"]=userInfo.Id;
                return RedirectToAction("Index", "UserInfo"); 
            }
            else
                return RedirectDialogToAction("Register", "Home", "注册失败");
        }
        #endregion
        
    }
}
