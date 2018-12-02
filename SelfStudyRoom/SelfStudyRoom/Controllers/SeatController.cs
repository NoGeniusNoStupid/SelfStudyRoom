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
    public class SeatController : PowerController
    {
        //座位管理
        public ActionResult Manage(int search=0)
        {
            //分页设置
            int pageIndex = Request.QueryString["pageIndex"] != null ? int.Parse(Request.QueryString["pageIndex"]) : 1;
            search = Request.QueryString["search"] != null ? Convert.ToInt32( Request.QueryString["search"] ): search;
            int pageSize = 15;//页面记录数
            List<Seat> mlist = new List<Seat>();
            var roomList = Entity.StuRoom.Where(a => true).OrderBy(a => a.Id).ToList() ;
            //查询默认值
            if (search<=0)
            {
                if (roomList != null && roomList.Count>0)
                    search = roomList[0].Id;
            }
            //查询记录
            if (search <= 0)
            {
                mlist = Entity.Seat.Where(a => true).OrderBy(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<Seat>();
            }
            else
            {
                mlist = Entity.Seat.Where(a => a.StuRoom.Id == search).OrderBy(a => a.Id).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<Seat>();
            }


            int listCount = Entity.Seat.Where(a => a.StuRoom.Id == search).Count();
            //生成导航条
            string strBar = PageBarHelper.GetPagaBar(pageIndex, listCount, pageSize, search.ToString());

            ViewData["List"] = mlist;
            ViewData["Bar"] = strBar;
            ViewData["roomList"] = roomList;
            ViewData["search"] = search;
            return View();
        }
        //添加座位
        public ActionResult Add(int id)
        {
            //获取自习室对象
            var room = Entity.StuRoom.FirstOrDefault(a => a.Id == id);
            room.SeatNum += 1;
            room.Empty_Seat += 1;
            Entity.Entry(room).State = EntityState.Modified;
            //添加一个座位对象
            Seat seat = new Seat();
            seat.RoomId = room.Id;
            seat.SeatNo = room.SeatNum.ToString();
            seat.State = "空闲";
            Entity.Seat.Add(seat);

            Entity.SaveChanges();
            return RedirectDialogToAction(string.Format("添加座位{0}自习室 编号:{1}成功", room.Name, seat.SeatNo), true);
        }
        //删除座位
        public ActionResult Delete(int id)
        {
            //获取自习室对象
            var room = Entity.StuRoom.FirstOrDefault(a => a.Id == id);
            string seatNum=room.SeatNum.ToString();
            //获取要删除的座位对象
            var seat = Entity.Seat.FirstOrDefault(a => a.RoomId == id && a.SeatNo == seatNum);
            string msg = string.Format("删除座位{0}自习室 编号:{1}成功", room.Name, seat.SeatNo);

            Entity.Entry(seat).State = EntityState.Deleted;
            //更新自习室
            room.SeatNum -= 1;
            room.Empty_Seat -= 1;
            Entity.Entry(room).State = EntityState.Modified;

            Entity.SaveChanges();
            return RedirectDialogToAction(msg, true);
        }
        //就座记录
        public ActionResult HistoryManage(string search)
        {         
            //分页设置
            int pageIndex = Request.QueryString["pageIndex"] != null ? int.Parse(Request.QueryString["pageIndex"]) : 1;
            int pageSize = 10;//页面记录数
            List<SeatDetail> mlist = new List<SeatDetail>();
            //查询记录
            if (string.IsNullOrEmpty(search))
            {       
                mlist = Entity.SeatDetail.Where(a => true).OrderByDescending(a => a.StartTime).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<SeatDetail>();
            }
            else
            {
                mlist = Entity.SeatDetail.Where(a => a.UserInfo.StuNo.Contains(search) || a.UserInfo.Name.Contains(search) || a.Seat.StuRoom.Name.Contains(search)).OrderByDescending(a => a.StartTime).Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList<SeatDetail>();
            }
            int listCount = Entity.SeatDetail.Where(a => true).Count();
            //生成导航条
            string strBar = PageBarHelper.GetPagaBar(pageIndex, listCount, pageSize);

            ViewData["List"] = mlist;
            ViewData["Bar"] = strBar;

            return View();
        }
    }
}
