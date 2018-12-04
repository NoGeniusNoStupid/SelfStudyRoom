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
    public class AdminController : PowerController
    {
        
      

        #region 管理员管理
        //管理员主页
        public ActionResult Index()
        {
        
            //获取学习记录
            var seatDetail = Entity.SeatDetail.Where(a => true).ToList();
            //计算总的学习时间
            TimeSpan span = CommonTool.CalculationStudyTime(seatDetail);
            //设置时间格式
            StringBuilder sb = CommonTool.SetStudyTimeFormat(span);
            ViewData["StudyTime"] = sb.ToString();
            //计算总的学习次数
            ViewData["Count"] = seatDetail.Count;
            //获取第一名
            CalculationRank();
            return View();
        }
        //计算第一名
        private void CalculationRank()
        {
            //统计学习记录
            List<Study> studyList = new List<Study>();
            //设置分页
            int pageIndex = Request.QueryString["pageIndex"] != null ? int.Parse(Request.QueryString["pageIndex"]) : 1;
            int pageSize = 2;//页面记录数

            //获取所有用户
            var userList = Entity.UserInfo.Where(a => true).ToList();
            UserInfo user=new UserInfo();
            TimeSpan maxTimeSpan=new TimeSpan();
            Study study = null;
            //查询第一名
            foreach (var item in userList)
            {
                study = new Study();
                study.UserInfo = item;
                if (item.SeatDetail != null && item.SeatDetail.Count > 0)
                {
                    TimeSpan span = CommonTool.CalculationStudyTime(item.SeatDetail.ToList());//获取学习时间
                    if (span > maxTimeSpan)
                    { 
                        maxTimeSpan = span;
                        user = item;
                    }
                    study.Count = item.SeatDetail.Count;
                    study.TimeSpan = span;
                    study.FormartTimeSpan = CommonTool.SetStudyTimeFormat(span).ToString();
                }
                studyList.Add(study);
            }
            ViewData["UserName"] = user.Name;
            StringBuilder sb = CommonTool.SetStudyTimeFormat(maxTimeSpan);
            ViewData["MaxTimeSpan"] = sb.ToString();
            ViewData["MaxCount"] = user.SeatDetail.Count;

            //生成导航条
            string strBar = PageBarHelper.GetPagaBar(pageIndex, studyList.Count, pageSize);
            //设置每页展示指定的记录
            studyList = studyList.Where(a => true).OrderBy(a => a.UserInfo.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<Study>();
 
            ViewData["List"] = studyList;
            ViewData["Bar"] = strBar;
        }
        //退出
        public ActionResult Out()
        {
            Session["AdminId"] = null;
            return RedirectToAction("Login", "Home");
        }
        //管理员管理
        public ActionResult Manage(string search)
        {
            //分页设置
            int pageIndex = Request.QueryString["pageIndex"] != null ? int.Parse(Request.QueryString["pageIndex"]) : 1;
            int pageSize = 10;//页面记录数
            List<Admin> mlist = new List<Admin>();

            int adminId=Convert.ToInt32( Session["AdminId"]);
            //查询记录
            if (string.IsNullOrEmpty(search))
            {
                mlist = Entity.Admin.Where(a => true && a.Id != adminId).OrderByDescending(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<Admin>();
            }
            else
            {
                mlist = Entity.Admin.Where(a =>a.Id != adminId &&( a.AdminName.Contains(search) || a.Name.Contains(search) || a.Tel.Contains(search))).OrderByDescending(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<Admin>();
            }
            int listCount = Entity.Admin.Where(a => true && a.Id != adminId).Count();
            //生成导航条
            string strBar = PageBarHelper.GetPagaBar(pageIndex, listCount, pageSize);

            ViewData["List"] = mlist;
            ViewData["Bar"] = strBar;

            return View();
        }
        public ActionResult Add()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Add(Admin admin)
        {
            admin.State = "普通管理员";
          
            //设置头像
            Random rd = new Random();
            int num = rd.Next(1, 28);
            admin.Image = string.Format("/File/face{0}.jpg", num);
            Entity.Admin.Add(admin);
            Entity.SaveChanges();
            return RedirectToAction("Manage");
        }
        //完善个人信息
        public ActionResult SelfEdit()
        {
            int adminId = Convert.ToInt32(Session["AdminId"]);
            var adminInfo = Entity.Admin.FirstOrDefault(a => a.Id == adminId);
            return View(adminInfo);
        }
        //修改
        public ActionResult Edit(int id)
        {
            var adminInfo = Entity.Admin.FirstOrDefault(a => a.Id == id);
            return View(adminInfo);
        }
        //修改
        [HttpPost]
        public ActionResult Edit(Admin admin, string oldPic)
        {
            //图片处理
            if (Request.Files.Count > 0)
            {
                admin.Image = SaveImage(Request.Files["Image"]);
            }
            if (string.IsNullOrEmpty(admin.Image))
                admin.Image = oldPic;

            Entity.Entry(admin).State = EntityState.Modified;
            Entity.SaveChanges();
            return RedirectToAction("Manage");
        }
        //修改密码
        public ActionResult UpdatePassword()
        {
            return View();
        }
        [HttpPost]
        public ActionResult UpdatePassword(string OldPwd, string NowPwd)
        {
            int adminId = Convert.ToInt32(Session["AdminId"]);
            var adminInfo = Entity.Admin.FirstOrDefault(a => a.Id == adminId);
            if (adminInfo.AdminPwd != OldPwd)
            {
                return RedirectDialogToAction("原密码错误！请检查。", true);
            }
            adminInfo.AdminPwd = NowPwd;
            return RedirectDialogToAction("Index", "Admin", "密码修改成功！", Entity.SaveChanges());
        }
        //删除
        public ActionResult Delete(int id)
        {
            var adminInfo = Entity.Admin.FirstOrDefault(a => a.Id == id);
            Entity.Entry(adminInfo).State = EntityState.Deleted;
            Entity.SaveChanges();
            return RedirectToAction("Manage");
        }
        #endregion

        #region 用户管理
        //用户管理
        public ActionResult UserInfoManage(string search)
        {
            //分页设置
            int pageIndex = Request.QueryString["pageIndex"] != null ? int.Parse(Request.QueryString["pageIndex"]) : 1;
            int pageSize = 10;//页面记录数
            List<UserInfo> mlist = new List<UserInfo>();
            //查询记录
            if (string.IsNullOrEmpty(search))
            {
                mlist = Entity.UserInfo.Where(a => true).OrderByDescending(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<UserInfo>();
            }
            else
            {
                mlist = Entity.UserInfo.Where(a => a.StuNo.Contains(search) || a.Name.Contains(search) || a.Tel.Contains(search)).OrderByDescending(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<UserInfo>();
            }
            int listCount = Entity.UserInfo.Where(a => true).Count();
            //生成导航条
            string strBar = PageBarHelper.GetPagaBar(pageIndex, listCount, pageSize);

            ViewData["List"] = mlist;
            ViewData["Bar"] = strBar;

            return View();
        }
        //查看详情
        public ActionResult UserInfoDetail(int id)
        {
            var userInfo = Entity.UserInfo.FirstOrDefault(a => a.Id == id);
            return View(userInfo);
        }
        //重置密码
        public ActionResult UserInfoInitPwd(int id)
        {
            var userInfo = Entity.UserInfo.FirstOrDefault(a => a.Id == id);
            userInfo.Password = "123456";
            Entity.Entry(userInfo).State = EntityState.Modified;
            Entity.SaveChanges();
            return RedirectToAction("UserInfoManage");
        }
        //删除
        public ActionResult UserInfoDelete(int id)
        {
            var userInfo = Entity.UserInfo.FirstOrDefault(a => a.Id == id);
            Entity.Entry(userInfo).State = EntityState.Deleted;
            Entity.SaveChanges();
            return RedirectToAction("UserInfoManage");
        }
        #endregion


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
