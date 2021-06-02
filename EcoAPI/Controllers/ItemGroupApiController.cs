using EcoAPI.Helper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EcoAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ItemGroupApiController : ControllerBase
    {
        private IDatabaseHelper _db;
        private List<ItemGroupModel> listResult = new List<ItemGroupModel>();
        public ItemGroupApiController(IDatabaseHelper db)
        {
            _db = db;
        }

        [HttpGet]
        [Route("list")]
        public IActionResult List()
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_item_group_get_data");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return Ok(dt.ConvertTo<ItemGroupModel>().ToList());
            }
            catch
            {
                throw;
            }
        }
        [HttpGet]
        [Route("dropdown-add")]
        public IActionResult Dropdown()
        {
            try
            {
                var list = this.DropdownAdd();
                return Ok(list);
            }
            catch
            {
                throw;
            }
        }
        public List<ItemGroupModel> DropdownAdd(string parentid = "", string text = "")
        {
            string msgError = "";
            var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_item_group_get_data");
            if (!string.IsNullOrEmpty(msgError))
                throw new Exception(msgError);
            var list = dt.ConvertTo<ItemGroupModel>().ToList();

            foreach (var item in list)
            {
                if (item.parent_item_group_id == parentid)
                {
                    item.item_group_name = text + item.item_group_name;
                    listResult.Add(item);
                    this.DropdownAdd(item.item_group_id, text + "---");
                }
            }
            return listResult;
        }
    }
} 
