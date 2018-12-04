using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SelfStudyRoom.Controllers
{
    /// <summary>
    /// 权限控制的操作类
    /// </summary>
    public class PowerController : BaseController
    {
        //<summary>
        //执行控制器中的方法之前先执行该方法。
        //</summary>
        //<param name="filterContext"></param>
        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            base.OnActionExecuted(filterContext);
            if (Session["AdminId"] == null)
            {
                string msg = "请先登录，再进行操作！";
                filterContext.Result = RedirectDialogToAction("Login", "Home", msg);
                return;
            }
            int adminId = Convert.ToInt32(Session["AdminId"]);
            var adminInfo = Entity.Admin.FirstOrDefault(a => a.Id == adminId);
            ViewData["AdminInfo"] = adminInfo;
        }
    }
}
