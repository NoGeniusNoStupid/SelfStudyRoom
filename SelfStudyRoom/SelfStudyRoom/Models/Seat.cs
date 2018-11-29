//------------------------------------------------------------------------------
// <auto-generated>
//    此代码是根据模板生成的。
//
//    手动更改此文件可能会导致应用程序中发生异常行为。
//    如果重新生成代码，则将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace SelfStudyRoom.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Seat
    {
        public Seat()
        {
            this.SeatDetail = new HashSet<SeatDetail>();
        }
    
        public int Id { get; set; }
        public Nullable<int> RoomId { get; set; }
        public string SeatNo { get; set; }
        public Nullable<System.DateTime> StartTime { get; set; }
        public Nullable<System.DateTime> EndTime { get; set; }
        public string State { get; set; }
        public Nullable<System.DateTime> SaveTime { get; set; }
    
        public virtual StuRoom StuRoom { get; set; }
        public virtual ICollection<SeatDetail> SeatDetail { get; set; }
    }
}
