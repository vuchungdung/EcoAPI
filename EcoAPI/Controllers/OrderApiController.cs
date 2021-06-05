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
    public class OrderApiController : ControllerBase
    {
        private readonly IDatabaseHelper _db;
        public OrderApiController(IDatabaseHelper db)
        {
            _db = db;
        }
        [HttpPost]
        [Route("create")]
        public IActionResult Create(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoa_don_create",
                "@ma_hoa_don", model.ma_hoa_don,
                "@ho_ten", model.ho_ten,
                "@dia_chi", model.dia_chi,
                "@listjson_chitiet", model.listjson_chitiet != null ? MessageConvert.SerializeObject(model.listjson_chitiet) : null);
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
        [HttpPut]
        [Route("edit")]
        public IActionResult Update(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoa_don_update",
                "@ma_hoa_don", model.ma_hoa_don,
                "@ho_ten", model.ho_ten,
                "@dia_chi", model.dia_chi,
                "@listjson_chitiet", model.listjson_chitiet != null ? MessageConvert.SerializeObject(model.listjson_chitiet) : null);
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
        public IActionResult GetDatabyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_hoa_don_get_by_id",
                     "@ma_hoa_don", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return Ok(dt.ConvertTo<HoaDonModel>().FirstOrDefault());
            }
            catch
            {
                throw;
            }
        }
        [HttpGet]
        [Route("delete/{id}")]
        public IActionResult Delete(string id)
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoa_don_delete",
                "@ma_hoa_don", id);
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
        public IActionResult Search([FromBody]SearchModel model)
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_hoa_don_search",
                    "@page_index", model.pageIndex,
                    "@page_size", model.pageSize,
                    "@hoten", model.hoten,
                    "@diachi", model.diachi);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return Ok(dt.ConvertTo<OrderResponseItem>().ToList());
            }
            catch
            {
                throw;
            }
        }
    }
}
