using SelfStudyRoom.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace SelfStudyRoom.Controllers
{
    public class UserInfoController : UserPowerController
    {
        //个人主页
        public ActionResult Index()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            var userInfo = Entity.UserInfo.FirstOrDefault(a => a.Id == userId);
            return View(userInfo);
        }

        //展示完善个人资料页面
        public ActionResult Edit()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            var userInfo = Entity.UserInfo.FirstOrDefault(a => a.Id == userId);
            return View(userInfo);
        }
        //完善个人资料页面操作
        [HttpPost]
        public ActionResult Edit(UserInfo userInfo, string oldPic)
        {
            //图片处理
            if (Request.Files.Count > 0)
            {
                userInfo.Image = SaveImage(Request.Files["Image"]);
            }
            if (string.IsNullOrEmpty(userInfo.Image))
                userInfo.Image = oldPic;

            Entity.Entry(userInfo).State = EntityState.Modified;

            // TODO: Add update logic here
            return RedirectDialogToAction("Index", "UserInfo", "", Entity.SaveChanges());      
        }
        //修改密码
        public ActionResult UpdatePassword()
        {
            return View();
        }
        [HttpPost]
        public ActionResult UpdatePassword(string OldPwd, string NowPwd)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            var userInfo = Entity.UserInfo.FirstOrDefault(a => a.Id == userId);
            if (userInfo.Password != OldPwd)
            {
                return RedirectDialogToAction("原密码错误！请检查。", true);
            }
            userInfo.Password = NowPwd;
            return RedirectDialogToAction("Index", "UserInfo", "密码修改成功！", Entity.SaveChanges());   
        }
        //退出
        public ActionResult Out()
        {
            Session["UserId"] = null;
            return RedirectToAction("Login", "Home");
        }


        /// <summary>
        /// 保存图片
        /// </summary>
        /// <param name="postFile"></param>
        /// <returns>获取保存的路径</returns>
        public string SaveImage(HttpPostedFileBase postFile)
        {
            string result = "";
            HttpPostedFileBase imageName = postFile;// 从前台获取文件
            string file = imageName.FileName;
            string fileFormat = file.Split('.')[file.Split('.').Length - 1]; // 以“.”截取，获取“.”后面的文件后缀
            Regex imageFormat = new Regex(@"^(bmp)|(png)|(gif)|(jpg)|(jpeg)"); // 验证文件后缀的表达式（自己写的，不规范别介意哈）
            if (string.IsNullOrEmpty(file) || !imageFormat.IsMatch(fileFormat)) // 验证后缀，判断文件是否是所要上传的格式
            {
                return null;
            }
            else
            {
                string timeStamp = DateTime.Now.Ticks.ToString(); // 获取当前时间的string类型
                string firstFileName = timeStamp.Substring(0, timeStamp.Length - 4); // 通过截取获得文件名
                string imageStr = "File/"; // 获取保存图片的项目文件夹
                string uploadPath = Server.MapPath("~/" + imageStr); // 将项目路径与文件夹合并
                string pictureFormat = file.Split('.')[file.Split('.').Length - 1];// 设置文件格式
                string fileName = firstFileName + "." + fileFormat;// 设置完整（文件名+文件格式） 
                string saveFile = uploadPath + fileName;//文件路径
                imageName.SaveAs(saveFile);// 保存文件
                // 如果单单是上传，不用保存路径的话，下面这行代码就不需要写了！
                string image = "/File/" + fileName;// 设置数据库保存的路径
                return image;
            }
        }
    }
}
