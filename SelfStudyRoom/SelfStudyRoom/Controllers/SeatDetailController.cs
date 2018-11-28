using SelfStudyRoom.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SelfStudyRoom.Controllers
{
    public class SeatDetailController : PowerController
    {
        //
        // GET: /SeatDetail/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Add(int id)
        {
            return View();
        }
        [HttpPost]
        public ActionResult Add(SeatDetail seatDetail)
        {
            return View();
        }
    }
}
