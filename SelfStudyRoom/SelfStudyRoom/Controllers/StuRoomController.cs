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
    public class StuRoomController : PowerController
    {
       
        //添加自习室
        public ActionResult Add()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Add(StuRoom room)
        {

            room.AddTime = DateTime.Now;
            room.Empty_Seat=room.SeatNum;
            room.State = "正常";
            Entity.StuRoom.Add(room);

            Entity.SaveChanges();

            for (int i = 1; i <= room.SeatNum; i++)
            {
                 Seat seatInfo = new Seat();
                 seatInfo.RoomId = room.Id;
                 seatInfo.SeatNo = i.ToString();
                 seatInfo.State = "空闲";
                 Entity.Seat.Add(seatInfo);
            }
           
            Entity.SaveChanges();

            return RedirectToAction("Manage");
        }
        //自习室管理
        public ActionResult Manage(string search)
        {
            //计算空余座位
            SetEmptySeat();
            //分页设置
            int pageIndex = Request.QueryString["pageIndex"] != null ? int.Parse(Request.QueryString["pageIndex"]) : 1;
            int pageSize = 6;//页面记录数
            List<StuRoom> mlist = new List<StuRoom>();
            //查询记录
            if (string.IsNullOrEmpty(search))
            {
                mlist = Entity.StuRoom.Where(a => true).OrderBy(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<StuRoom>();
            }
            else
            {
                mlist = Entity.StuRoom.Where(a => a.Name.Contains(search)).OrderBy(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<StuRoom>();
            }
            int listCount = Entity.StuRoom.Where(a => true).Count();
            //生成导航条
            string strBar = PageBarHelper.GetPagaBar(pageIndex, listCount, pageSize);

            ViewData["List"] = mlist;
            ViewData["Bar"] = strBar;

            return View();
        }
        //计算空余座位
        private void SetEmptySeat()
        {
            var StuRoomList = Entity.StuRoom.Where(a => true).ToList();
            foreach (var item in StuRoomList)
            {
                int seat = Entity.Seat.Where(a => a.RoomId == item.Id&&a.State!="空闲").Count();
                item.Empty_Seat = item.SeatNum - seat;
                Entity.Entry(item).State = EntityState.Modified;
            }
            Entity.SaveChanges();
        }
        //展示修改页面
        public ActionResult Edit(int id)
        {
            var stuRoom = Entity.StuRoom.FirstOrDefault(a => a.Id == id); 
            return View(stuRoom);
        }
        //修改页面
        [HttpPost]
        public ActionResult Edit(StuRoom room,int id)
        {
            Entity.Entry(room).State = EntityState.Modified;
            Entity.SaveChanges();

            return RedirectToAction("Manage");
        }
        //停用和恢复
        public ActionResult SetState(int id)
        {
            var stuRoomTmep = Entity.StuRoom.FirstOrDefault(a => a.Id == id); //获取记录

            var seatlist = Entity.Seat.Where(a => a.RoomId == stuRoomTmep.Id).ToList();
            //停用
            if (stuRoomTmep.State == "正常")
            {

                foreach (var seat in seatlist)
                {
                    if (seat.SeatDetail != null && seat.SeatDetail.Count > 0)
                    {
                        var seatDetailList = seat.SeatDetail.Where(a => a.State == "保留" || a.State == "正常").ToList();
                        foreach (var seatDetail in seatDetailList)
                        {
                            //更新详细信息
                            seatDetail.EndTime = DateTime.Now;
                            seatDetail.State = "离座";
                            Entity.Entry(seatDetail).State = EntityState.Modified;
                        }
                    }
                    //更新座位状态
                    seat.State = "停用";
                    seat.SaveTime = null;
                    Entity.Entry(seat).State = EntityState.Modified;
                }
                //更新自习室
                stuRoomTmep.State = "停用";
                Entity.Entry(stuRoomTmep).State = EntityState.Modified;
            }
            else
            //正常
            {
                //更新座位
                foreach (var seat in seatlist)
                {
                    seat.State = "空闲";
                    Entity.Entry(seat).State = EntityState.Modified;
                }
                //更新自习室
                stuRoomTmep.State = "正常";
                Entity.Entry(stuRoomTmep).State = EntityState.Modified;
            }
            //更新记录
            Entity.SaveChanges();
            return RedirectToAction("Manage");
        }
        //删除
        public ActionResult Delete(int id)
        {
            var stuRoom = Entity.StuRoom.FirstOrDefault(a => a.Id == id); ;

            Entity.Entry(stuRoom).State = EntityState.Deleted;
            Entity.SaveChanges();
            return View(stuRoom);
        }
    }
}
