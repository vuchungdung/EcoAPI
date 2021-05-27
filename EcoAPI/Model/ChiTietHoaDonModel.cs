using System;
using System.Collections.Generic;

namespace Model
{
    public class ChiTietHoaDonModel
    {
        public string ma_chi_tiet { get; set; } = Guid.NewGuid().ToString();
        public string ma_hoa_don { get; set; }
        public string item_id { get; set; }
        public int so_luong { get; set; }
    }
}
