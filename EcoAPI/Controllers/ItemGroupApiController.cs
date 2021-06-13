using EcoAPI.Helper;
using EcoAPI.Model;
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
        public List<ItemGroupModel> DropdownAdd(string parentid = null, string text = "")
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
        [HttpPost]
        [Route("add")]
        public IActionResult Create([FromBody] ItemGroupModel model)
        {
            string msgError = "";
            try
            {
                model.item_group_id = Guid.NewGuid().ToString();
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_item_group_create",
                "@parent_item_group_id", model.parent_item_group_id,
                "@item_group_id", model.item_group_id,
                "@item_group_name", model.item_group_name);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return Ok();
            }
            catch
            {
                throw;
            }
        }
        [HttpPost]
        [Route("search")]
        public IActionResult Search([FromBody] SearchModel model)
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_item_group_search",
                    "@page_index", model.pageIndex,
                    "@page_size", model.pageSize);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return Ok(dt.ConvertTo<ItemGroupModel>().ToList());
            }
            catch
            {
                throw;
            }
        }
        [HttpPost]
        [Route("edit")]
        public IActionResult Edit([FromBody] ItemGroupModel model)
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_item_group_update",
                "@parent_item_group_id", model.parent_item_group_id,
                "@item_group_id", model.item_group_id,
                "@item_group_name", model.item_group_name);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return Ok();
            }
            catch
            {
                throw;
            }
        }
        [HttpGet]
        [Route("itemgroup/{id}")]
        public IActionResult Item(string id)
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_item_group_get_by_id",
                     "@item_group_id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return Ok(dt.ConvertTo<ItemModel>().FirstOrDefault());
            }
            catch
            {
                throw;
            }
        }
        [HttpGet]
        [Route("delete/{id}")]
        public IActionResult Detele(string id)
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_item_group_delete",
                     "@item_group_id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return Ok();
            }
            catch
            {
                throw;
            }
        }
    }
} 
