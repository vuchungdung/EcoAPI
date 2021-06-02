using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace Model
{
    public class ItemModel
    {
        public string item_id { get; set; } = Guid.NewGuid().ToString();
        public string item_group_id { get; set; }
        public string item_name { get; set; }
        public string item_image { get; set; }
        public float item_price { get; set; }
        public string item_description { get; set; }
        public string item_content { get; set; }
        public System.Int64 RecordCount { get; set; }
    }
}
