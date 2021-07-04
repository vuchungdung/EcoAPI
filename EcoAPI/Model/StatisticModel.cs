using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EcoAPI.Model
{
    public class StatisticModel
    {
        public string id { get; set; }
        public string created_at { get; set; }
        public int total_item { get; set; }
        public float total { get; set; }
        public float invest { get; set; }
        public int total_order { get; set; }
    }
}
