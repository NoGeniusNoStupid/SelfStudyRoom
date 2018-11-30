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
        //
        // GET: /StuRoom/

        public ActionResult Index()
        {
            return View();
        }
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
        //列表
        public ActionResult Manage(string search)
        {
            //计算空余座位
            SetEmptySeat();


            //分页设置
            int pageIndex = Request.QueryString["pageIndex"] != null ? int.Parse(Request.QueryString["pageIndex"]) : 1;
            int pageSize = 15;//页面记录数
            List<StuRoom> mlist = new List<StuRoom>();
            //查询记录
            if (string.IsNullOrEmpty(search))
            {
                mlist = Entity.StuRoom.Where(a => true).OrderByDescending(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<StuRoom>();
            }
            else
            {
                mlist = Entity.StuRoom.Where(a => a.Name.Contains(search)).OrderByDescending(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<StuRoom>();
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
            var stuRoom = Entity.StuRoom.FirstOrDefault(a => a.Id == id); ;
            return View(stuRoom);
        }
        //修改页面
        [HttpPost]
        public ActionResult Edit(StuRoom room)
        {
            Entity.Entry(room).State = EntityState.Modified;
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
