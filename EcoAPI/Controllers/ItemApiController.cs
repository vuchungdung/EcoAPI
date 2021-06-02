using EcoAPI.Helper;
using EcoAPI.Model;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace EcoAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ItemApiController : ControllerBase
    {
        private readonly IDatabaseHelper _db;
        public ItemApiController(IDatabaseHelper db)
        {
            _db = db;
        }

        [HttpPost]
        [Route("create")]
        public IActionResult Create([FromBody]ItemModel model)
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_item_create",
                "@item_id", model.item_id,
                "@item_group_id", model.item_group_id,
                "@item_image", model.item_image,
                "@item_name", model.item_name,
                "@item_price", model.item_price,
                "@item_description",model.item_description,
                "@item_content",model.item_content);
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
        [Route("edit")]
        public IActionResult Edit([FromBody] ItemModel model)
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_item_update",
                "@item_id", model.item_id,
                "@item_group_id", model.item_group_id,
                "@item_image", model.item_image,
                "@item_name", model.item_name,
                "@item_price", model.item_price,
                "@item_description", model.item_description,
                "@item_content", model.item_content);
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
        [Route("item/{id}")]
        public IActionResult Item(string id)
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_item_get_by_id",
                     "@item_id", id);
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
        [Route("list")]
        public IActionResult List()
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_item_all");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return Ok(dt.ConvertTo<ItemModel>().ToList());
            }
            catch
            {
                throw;
            }
        }
        [HttpPost]
        [Route("search")]
        public IActionResult Search([FromBody]SearchModel model)
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_item_search",
                    "@page_index", model.pageIndex,
                    "@page_size", model.pageSize,
                    "@item_group_id", model.item_group_id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return Ok(dt.ConvertTo<ItemModel>().ToList());
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
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_item_del",
                     "@id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return Ok();
            }
            catch
            {
                throw;
            }
        }

        [Route("upload")]
        [HttpPost, DisableRequestSizeLimit]
        public IActionResult UpLoad(IFormFile file)
        {
            if(file != null)
            {
                var folderName = Path.Combine("wwwroot/img");
                var pathToSave = Path.Combine(Directory.GetCurrentDirectory(), folderName);
                var fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
                var fullPath = Path.Combine(pathToSave, fileName);
                var dbPath = Path.Combine(folderName, fileName);
                using (var stream = new FileStream(fullPath, FileMode.Create))
                {
                    file.CopyTo(stream);
                }
                return Ok(dbPath);
            }
            else
            {
                return BadRequest();
            }
        }
    }
}
