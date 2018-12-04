using SelfStudyRoom.Models;
using SelfStudyRoom.Public;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
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
            //获取学习记录
            var seatDetail = Entity.SeatDetail.Where(a => a.UserId == userId).ToList();
            //计算总的学习时间
            TimeSpan span =CommonTool.CalculationStudyTime(seatDetail);
            //设置时间格式
            StringBuilder sb = CommonTool.SetStudyTimeFormat(span);
            ViewData["StudyTime"] = sb.ToString();
            //计算总的学习次数
            ViewData["Count"] = seatDetail.Count;
            //计算排名、击败次数
            CalculationRank(span, seatDetail.Count, userId);
            return View(userInfo);
        }
        //计算排名、击败人数
        private void CalculationRank(TimeSpan StudyTime, int Count,int userId)
        {
            //所有用户的学习时间
            List<TimeSpan> spanList = new List<TimeSpan>();
            //所有用户的学习次数
            List<int> countList = new List<int>();
            //记录每个用户的学习时间
            TimeSpan spanTemp = new TimeSpan();
            //获取所有用户
            var userList = Entity.UserInfo.Where(a => true).ToList();
            foreach (var item in userList)
            {
                //获取每个用户的学习记录
                var seatDetail = Entity.SeatDetail.Where(a => a.UserId == item.Id).ToList();
                //计算每个用户的学习时间
                if (userId == item.Id)
                    spanTemp = StudyTime;
                else
                    spanTemp = CommonTool.CalculationStudyTime(seatDetail);
                //记录每个有用户的学习时间和次数
                spanList.Add(spanTemp);
                countList.Add(seatDetail.Count);
            }
           //顺序排序
            spanList.Sort();
            countList.Sort();
            //倒序排序
            countList.Reverse();
            spanList.Reverse();
            int selfSpanRank = spanList.IndexOf(StudyTime) + 1;
            int selfCountRank = countList.IndexOf(Count) + 1;
            ViewData["SpanRank"] = selfSpanRank;//时间排名
            ViewData["CountRank"] = selfCountRank;//次数排名

            //时间击败百分比
            double spanPercent = Convert.ToDouble(selfSpanRank) / Convert.ToDouble(spanList.Count);
            ViewData["SpanPercent"] = string.Format("{0:0.00%}", 1 - spanPercent);
            //次数击败百分比
            double countPercent = Convert.ToDouble(selfCountRank) / Convert.ToDouble(countList.Count);
            ViewData["CountPercent"] = string.Format("{0:0.00%}", 1 - countPercent);
            //次数击败%
            ViewData["Rank"] = countList.Count - selfCountRank; //排名击败人数
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
