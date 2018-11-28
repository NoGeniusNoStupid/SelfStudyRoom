using SelfStudyRoom.Models;
using SelfStudyRoom.Public;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SelfStudyRoom.Controllers
{
    public class SeatController : PowerController
    {
        //
        // GET: /Seat/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Manage(string search)
        {
            //分页设置
            int pageIndex = Request.QueryString["pageIndex"] != null ? int.Parse(Request.QueryString["pageIndex"]) : 1;
            int pageSize = 15;//页面记录数
            List<Seat> mlist = new List<Seat>();
            var roomList = Entity.StuRoom.Where(a => true).OrderBy(a => a.Id).ToList() ;
            //查询默认值
            if (string.IsNullOrEmpty(search))
            {
               
                if (roomList != null && roomList.Count>0)
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
            string strBar = PageBarHelper.GetPagaBar(pageIndex, listCount, pageSize);

            ViewData["List"] = mlist;
            ViewData["Bar"] = strBar;
            ViewData["roomList"] = roomList;
            ViewData["search"] = search;
            return View();
        }
    }
}
