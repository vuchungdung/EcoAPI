using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EcoAPI.Model
{
    public class SearchModel
    {
        public int pageIndex { get; set; }
        public int pageSize { get; set; }
        public string item_group_id { get; set; }
        public string hoten { get; set; }
        public string diachi { get; set; }
    }
}
