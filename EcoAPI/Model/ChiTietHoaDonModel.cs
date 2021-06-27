using System;
using System.Collections.Generic;

namespace Model
{
    public class ChiTietHoaDonModel
    {
        public string ma_chi_tiet { get; set; }
        public string ma_hoa_don { get; set; }
        public string item_id { get; set; }
        public string item_name { get; set; }
        public string item_image { get; set; }
        public float item_price { get; set; }
        public float invest { get; set; }
        public int so_luong { get; set; }
        public float total { get; set; }
        public int status { get; set; }
    }
}
