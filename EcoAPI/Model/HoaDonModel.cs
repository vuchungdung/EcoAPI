using System;
using System.Collections.Generic;

namespace Model
{
    public class HoaDonModel
    {
        public string ma_hoa_don { get; set; }
        public string ho_ten { get; set; }
        public string dia_chi { get; set; }
        public string email { get; set; }
        public string phone { get; set; }
        public float total { get; set; }
        public string created_at { get; set; } = DateTime.Now.ToString("yyyy/MM/dd");
        public float invest { get; set; }
        public int total_item { get; set; }
        public System.Int64 RecordCount { get; set; }
        public string chi_tiet { get; set; }
        public List<ChiTietHoaDonModel> listjson_chitiet { get; set; }

    }
}
