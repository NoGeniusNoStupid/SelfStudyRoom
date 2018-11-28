

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SelfStudyRoom.Public
{
    public class PageBarHelper
    {

        public static string GetPagaBar(int pageIndex, int listCount, int pageSize = 10, int barCount = 5)
        {
            //空记录
            if (listCount == 0)
            {
                return string.Empty;
            }
            //求页面数
            int pageCount = Convert.ToInt32(Math.Ceiling(listCount * 1.0 / pageSize));

            if (pageCount == 1)
            {
                return string.Empty;
            }
            int start = 0;
            int end = 0;
            if (pageCount <= barCount)//页数小于指定页数
            {
                start = 1;
                end = pageCount;
            }
            else
            {
                //剩余页数
                int count = pageCount - pageIndex;
                if (count >= 2)
                {
                    start = pageIndex - 2;
                    if (start <= 0)
                    {
                        start = 1;
                        end = start + barCount - 1;
                    }
                    else
                        end = pageIndex + 2;
                }
                else
                {
                    start = pageIndex - barCount + 1 + count;
                    end = pageIndex + count;
                }
            }
         
            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("共 {0} 条数据   当前 {1}/{2} 页 &nbsp;&nbsp;&nbsp;&nbsp;", listCount, pageIndex, pageCount);
            //首页
            if (pageIndex > 1)
            {
                sb.AppendFormat("<a href='?pageIndex={0}'  onfocus='this.blur()' >首页</a>&nbsp;&nbsp;", 1);
                sb.AppendFormat("<a href='?pageIndex={0}'  onfocus='this.blur()' >上一页</a>&nbsp;&nbsp;", pageIndex - 1);
            }
            //计算中间页
            for (int i = start; i <= end; i++)
            {
                if (i == pageIndex)
                {
                    sb.Append(i + "&nbsp;&nbsp;&nbsp;&nbsp;");
                }
                else
                {
                    sb.AppendFormat("<a href='?pageIndex={0}' onfocus='this.blur()' >{0}</a>&nbsp;&nbsp;&nbsp;&nbsp;", i);
                }
            }
            //下一页
            if (pageIndex < pageCount)
            {
                sb.AppendFormat("<a href='?pageIndex={0}'  onfocus='this.blur()'>下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;", pageIndex + 1);
                sb.AppendFormat("<a href='?pageIndex={0}'  onfocus='this.blur()'>尾页</a>&nbsp;&nbsp;&nbsp;&nbsp;", pageCount);
            }

            return sb.ToString();
        }

    }
}
