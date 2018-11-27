using SelfStudyRoom.Public;
using System.Web;
using System.Web.Mvc;

namespace SelfStudyRoom
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new MyExceptionAttribute());
        }
    }
}