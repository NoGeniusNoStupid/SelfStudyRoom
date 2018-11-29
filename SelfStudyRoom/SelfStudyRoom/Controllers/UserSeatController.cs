using SelfStudyRoom.Models;
using SelfStudyRoom.Public;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SelfStudyRoom.Controllers
{
    public class UserSeatController : UserPowerController
    {
        //查看所有座位
        public ActionResult Manage(string search)
        {
            //设置保留座位的状态
            SetSeatState();


            //分页设置
            int pageIndex = Request.QueryString["pageIndex"] != null ? int.Parse(Request.QueryString["pageIndex"]) : 1;
            search = Request.QueryString["search"] != null ? Request.QueryString["search"].ToString() : search;
            int pageSize = 15;//页面记录数
            List<Seat> mlist = new List<Seat>();
            var roomList = Entity.StuRoom.Where(a => true).OrderBy(a => a.Id).ToList();

            //查询默认值
            if (string.IsNullOrEmpty(search))
            {
                if (roomList != null && roomList.Count > 0)
                    search = roomList[0].Name;
            }
            //查询记录
            if (string.IsNullOrEmpty(search))
            {
                mlist = Entity.Seat.Where(a => true).OrderByDescending(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<Seat>();
            }
            else
            {
                mlist = Entity.Seat.Where(a => a.StuRoom.Name.Contains(search)).OrderByDescending(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<Seat>();
            }


            int listCount = Entity.Seat.Where(a => a.StuRoom.Name.Contains(search)).Count();
            //生成导航条
            string strBar = PageBarHelper.GetPagaBar(pageIndex, listCount, pageSize, search);

            ViewData["List"] = mlist;
            ViewData["Bar"] = strBar;
            ViewData["roomList"] = roomList;
            ViewData["search"] = search;
            return View();
        }

        //快速就坐
        public ActionResult OrderSeat(int id, int other)
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            SeatDetail IsExist = Entity.SeatDetail.FirstOrDefault(a => a.UserId == userId&&a.State!="离座");
            if (IsExist!=null)
            {
                return RedirectDialogToAction("已有未离座的记录，请注销其他记录，再进行操作！",true);
            }

            DateTime now = DateTime.Now;
            Seat seat = Entity.Seat.FirstOrDefault(a => a.Id == id && a.RoomId == other);
            seat.StartTime = now;
            seat.State = "使用中";

            Entity.Entry(seat).State = EntityState.Modified;

            
            SeatDetail seatDetail = new SeatDetail();
            seatDetail.SeatId = id;
            seatDetail.UserId = userId;
            seatDetail.StartTime = now;
            seatDetail.State = "正常";
            Entity.SeatDetail.Add(seatDetail);

            string msg = string.Format("就坐成功！{0}自习室{1}号座位， 开始时间{2}。", seat.StuRoom.Name, seat.Id, seatDetail.StartTime);
            return RedirectDialogToAction("OrderHistory", "UserSeat", msg,Entity.SaveChanges());
        }
       
        //查看就坐记录
        public ActionResult OrderHistory()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            //分页设置
            int pageIndex = Request.QueryString["pageIndex"] != null ? int.Parse(Request.QueryString["pageIndex"]) : 1;
            int pageSize = 6;//页面记录数
            List<SeatDetail> mlist = new List<SeatDetail>();
            //查询记录
            mlist = Entity.SeatDetail.Where(a => a.UserId == userId).OrderByDescending(a => a.StartTime).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<SeatDetail>();

            int listCount = Entity.SeatDetail.Where(a => a.UserId == userId).Count();
            //生成导航条
            string strBar = PageBarHelper.GetPagaBar(pageIndex, listCount, pageSize);

            ViewData["List"] = mlist;
            ViewData["Bar"] = strBar;

            return View();
        }
        //保留
        public ActionResult Save(int id)
        {
            SeatDetail seatDetail = Entity.SeatDetail.FirstOrDefault(a => a.Id == id);
            seatDetail.State = "保留";
            Entity.Entry(seatDetail).State = EntityState.Modified;

            seatDetail.Seat.State = "保留";
            seatDetail.Seat.SaveTime = DateTime.Now.AddMinutes(30);
            Entity.Entry(seatDetail.Seat).State = EntityState.Modified;
            Entity.SaveChanges();
            return RedirectToAction("OrderHistory");
           
        }
        //继续就坐
        public ActionResult SitDown(int id)
        {
            SeatDetail seatDetail = Entity.SeatDetail.FirstOrDefault(a => a.Id == id);
            seatDetail.State = "正常";
            Entity.Entry(seatDetail).State = EntityState.Modified;

            seatDetail.Seat.State = "使用中";
            seatDetail.Seat.SaveTime = null;
            Entity.Entry(seatDetail.Seat).State = EntityState.Modified;

            Entity.SaveChanges();
            return RedirectToAction("OrderHistory"); 
        }
        //离座
        public ActionResult Exit(int id)
        {
            SeatDetail seatDetail = Entity.SeatDetail.FirstOrDefault(a => a.Id == id);
            seatDetail.State = "离座";
            seatDetail.EndTime = DateTime.Now;
            Entity.Entry(seatDetail).State = EntityState.Modified;

            seatDetail.Seat.State = "空闲";
            seatDetail.Seat.SaveTime = null;
            Entity.Entry(seatDetail.Seat).State = EntityState.Modified;
            Entity.SaveChanges();
            return RedirectToAction("OrderHistory");  
        }
        // 设置保留座位的状态
        private void SetSeatState()
        {
            var tempList = Entity.Seat.Where(a => a.State == "保留").ToList<Seat>();
            DateTime now = DateTime.Now;//获取当前时间
            foreach (var seat in tempList)
            {
                if (DateTime.Compare(Convert.ToDateTime(seat.SaveTime), now) < 0)//比较时间大小
                {
                    foreach (var detail in seat.SeatDetail)
                    {
                        if (detail.State == "保留")
                        {
                            detail.State = "离座";
                            detail.EndTime = seat.SaveTime;
                            Entity.Entry(detail).State = EntityState.Modified;
                        }
                    }
                    seat.SaveTime = null;
                    seat.State = "空闲";
                    Entity.Entry(seat).State = EntityState.Modified;
                }
            }
            Entity.SaveChanges();
        }

        ////快速就坐
        //[HttpPost]
        //public ActionResult OrderSeat(SeatDetail orderInfo)
        //{
        //    orderInfo.State = "正常";
        //    orderInfo.AddTime = DateTime.Now;
        //    orderInfo.UserId = Convert.ToInt32(Session["UserId"]);
        //    Entity.SeatDetail.Add(orderInfo);
        //    Entity.SaveChanges();
        //    return RedirectDialogToAction("OrderHistory", "UserSeat","预约成功！");
        //}


    }
}
