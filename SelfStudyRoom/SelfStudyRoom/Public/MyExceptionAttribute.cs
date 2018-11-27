using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace SelfStudyRoom.Public
{
    /// <summary>
    /// 表示捕获异常的处理类
    /// </summary>
    public class MyExceptionAttribute : HandleErrorAttribute
    {
        /// <summary>
        /// 定义一个队列
        /// </summary>
        public static Queue<Exception> ExecptionQueue = new Queue<Exception>();
        /// <summary>
        /// 可以捕获异常数据
        /// </summary>
        /// <param name="filterContext"></param>
        public override void OnException(ExceptionContext filterContext)
        {
            base.OnException(filterContext);
            Exception ex = filterContext.Exception;
            //写到队列
            ExecptionQueue.Enqueue(ex);
            //跳转到错误页面.
            filterContext.HttpContext.Response.Redirect("/error-404.Html");
        }
    }
}
