

using SelfStudyRoom.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SelfStudyRoom.Public
{
    public class Study
    {
        //学习次数
        public int Count { get; set; }
        //学习时长
        public TimeSpan TimeSpan { get; set; }
        //学习时长 格式化
        public string FormartTimeSpan{get; set;}
        //用户信息
        public UserInfo UserInfo { get; set; }
    }
}
