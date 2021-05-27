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
    }
}
