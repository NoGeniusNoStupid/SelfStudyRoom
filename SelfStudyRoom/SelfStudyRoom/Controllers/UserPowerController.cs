using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SelfStudyRoom.Controllers
{
    public class UserPowerController : BaseController
    {
        //<summary>
        //执行控制器中的方法之前先执行该方法。
        //</summary>
        //<param name="filterContext"></param>
        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            base.OnActionExecuted(filterContext);
            if (Session["UserId"] == null)
            {
                string msg = "请先登录，再进行操作！";
                filterContext.Result = RedirectDialogToAction("Login", "Home", msg);
                return;
            }
            int userId = Convert.ToInt32(Session["UserId"]);
            var UserInfo = Entity.UserInfo.FirstOrDefault(a => a.Id == userId);
            ViewData["UserInfo"] = UserInfo;

            //学习状态
            var seatDetail = Entity.SeatDetail.FirstOrDefault(a => a.UserId == UserInfo.Id && a.State == "正常");
            if (seatDetail == null)
                ViewData["State"] = "未就座";
            else
                ViewData["State"] = "学习中";
        }
    }
}
