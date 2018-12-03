

using SelfStudyRoom.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SelfStudyRoom.Public
{
    public static class CommonTool
    {
        //计算学习时间
        public static TimeSpan CalculationStudyTime(List<SeatDetail> seatDetail)
        {
            TimeSpan studyTime = new TimeSpan();
            TimeSpan span = new TimeSpan();
            DateTime endTimeTemp = new DateTime();
            foreach (var item in seatDetail)
            {
                endTimeTemp = item.EndTime == null ? DateTime.Now : Convert.ToDateTime(item.EndTime);
                span = endTimeTemp.Subtract(Convert.ToDateTime(item.StartTime));
                studyTime = studyTime.Add(span);
            }
            return studyTime;
        }
        //学习时间格式化
        public static StringBuilder SetStudyTimeFormat(TimeSpan span)
        {
            StringBuilder sb = new StringBuilder();
            if (span.Days > 0)
                sb.Append(string.Format("{0}天", span.Days));
            if (span.Hours > 0)
                sb.Append(string.Format("{0}小时", span.Hours));
            if (span.Minutes > 0)
                sb.Append(string.Format("{0}分钟", span.Minutes));
            return sb;
        }
    }
}
