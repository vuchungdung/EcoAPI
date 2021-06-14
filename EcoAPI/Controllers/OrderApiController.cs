using EcoAPI.Helper;
using EcoAPI.Model;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Threading.Tasks;
using Spire.Doc;
using Spire.Doc.Documents;
using System.Globalization;

namespace EcoAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderApiController : ControllerBase
    {
        private readonly IDatabaseHelper _db;
        private IHostingEnvironment _environment;
        public OrderApiController(IDatabaseHelper db, IHostingEnvironment environment)
        {
            _db = db;
            _environment = environment;
        }
        [HttpPost]
        [Route("create")]
        public IActionResult Create(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                model.ma_hoa_don = Guid.NewGuid().ToString();
                if (model.listjson_chitiet != null)
                {
                    foreach (var item in model.listjson_chitiet)
                    {
                        item.ma_hoa_don = model.ma_hoa_don;
                        item.ma_chi_tiet = Guid.NewGuid().ToString();
                    }

                }
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoa_don_create",
                "@ma_hoa_don", model.ma_hoa_don,
                "@ho_ten", model.ho_ten,
                "@dia_chi", model.dia_chi,
                "@email", model.email,
                "@phone", model.phone,
                "@total", model.total,
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
        [HttpPost]
        [Route("edit")]
        public IActionResult Update(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                if (model.listjson_chitiet != null)
                {
                    foreach (var item in model.listjson_chitiet)
                    {
                        if (item.status == 1)
                        {
                            item.ma_chi_tiet = Guid.NewGuid().ToString();
                        }
                    }
                }
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoa_don_update",
                "@ma_hoa_don", model.ma_hoa_don,
                "@ho_ten", model.ho_ten,
                "@dia_chi", model.dia_chi,
                "@email", model.email,
                "@phone", model.phone,
                "@total", model.total,
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
                var list = dt.ConvertTo<HoaDonModel>().ToList();
                var hoa_don = new HoaDonModel();
                hoa_don.listjson_chitiet = new List<ChiTietHoaDonModel>();
                foreach(var item in list)
                {
                    hoa_don.listjson_chitiet.Add(JsonConvert.DeserializeObject<ChiTietHoaDonModel>(item.chi_tiet));
                }
                hoa_don.ma_hoa_don = id;
                hoa_don.ho_ten = list.FirstOrDefault().ho_ten;
                hoa_don.dia_chi = list.FirstOrDefault().dia_chi;
                hoa_don.email = list.FirstOrDefault().email;
                hoa_don.phone = list.FirstOrDefault().phone;
                return Ok(hoa_don);
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
                model.diachi = "";
                model.hoten = "";
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_hoa_don_search",
                    "@page_index", model.pageIndex,
                    "@page_size", model.pageSize,
                    "@hoten", model.hoten,
                    "@diachi", model.diachi);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return Ok(dt.ConvertTo<HoaDonModel>().ToList());
            }
            catch
            {
                throw;
            }
        }
        [HttpGet]
        [Route("download/{id}")]      
        public FileStreamResult Download(string id)
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_hoa_don_get_by_id",
                     "@ma_hoa_don", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                var list = dt.ConvertTo<HoaDonModel>().ToList();
                var hoa_don = new HoaDonModel();
                hoa_don.listjson_chitiet = new List<ChiTietHoaDonModel>();
                foreach (var item in list)
                {
                    hoa_don.listjson_chitiet.Add(JsonConvert.DeserializeObject<ChiTietHoaDonModel>(item.chi_tiet));
                }
                hoa_don.ma_hoa_don = id;
                hoa_don.ho_ten = list.FirstOrDefault().ho_ten;
                hoa_don.dia_chi = list.FirstOrDefault().dia_chi;
                hoa_don.email = list.FirstOrDefault().email;
                hoa_don.phone = list.FirstOrDefault().phone;
                hoa_don.total = list.FirstOrDefault().total;
                var webRoot = _environment.ContentRootPath;
                var filePath = webRoot + "/wwwroot/file\\hoadon.doc";
                Document document = new Document();
                document.LoadFromFile(filePath);
                Section sec = document.Sections[0];
                TextSelection[] find_1 = document.FindAllString("{{$name}}", true, true);
                find_1[0].GetAsOneRange().Text = hoa_don.ho_ten;
                TextSelection[] find_2 = document.FindAllString("{{$phone}}", true, true);
                find_2[0].GetAsOneRange().Text = hoa_don.phone;
                TextSelection[] find_3 = document.FindAllString("{{$address}}", true, true);
                find_3[0].GetAsOneRange().Text = hoa_don.dia_chi;
                TextSelection[] find_4 = document.FindAllString("{{$id}}", true, true);
                find_4[0].GetAsOneRange().Text = hoa_don.ma_hoa_don.Substring(0, 8);
                Table table = document.Sections[0].Tables[1] as Table;
                int stt = 1;
                CultureInfo cul = CultureInfo.GetCultureInfo("vi-VN");
                foreach (var item in hoa_don.listjson_chitiet)
                {                    
                    TableRow newRow = table.Rows[table.Rows.Count-1].Clone();
                    table.Rows.Insert(table.Rows.Count, newRow);
                    TextSelection[] find_5 = document.FindAllString("{{$stt}}", true, true);
                    find_5[0].GetAsOneRange().Text = stt.ToString();
                    TextSelection[] find_6 = document.FindAllString("{{$item_name}}", true, true);
                    find_6[0].GetAsOneRange().Text = item.item_name;
                    TextSelection[] find_7 = document.FindAllString("{{$item_count}}", true, true);
                    find_7[0].GetAsOneRange().Text = item.so_luong.ToString();
                    TextSelection[] find_8 = document.FindAllString("{{$item_price}}", true, true);
                    find_8[0].GetAsOneRange().Text = item.item_price.ToString("#,###", cul.NumberFormat);
                    TextSelection[] find_9 = document.FindAllString("{{$item_total}}", true, true);
                    find_9[0].GetAsOneRange().Text = (item.so_luong*item.item_price).ToString("#,###", cul.NumberFormat);
                    stt++;
                }
                TextSelection[] find_10 = document.FindAllString("{{$created_at}}", true, true);
                find_10[0].GetAsOneRange().Text = DateTime.Now.ToString("dd-MM-yyyy");
                table.Rows.Remove(table.Rows[table.Rows.Count - 1]);
                TextSelection[] find_11 = document.FindAllString("{{$total}}", true, true);
                find_11[0].GetAsOneRange().Text = hoa_don.total.ToString("#,###", cul.NumberFormat);
                var newFile = webRoot + "/wwwroot/file\\hoadon-"+DateTime.Now.ToString("dd-MM-yyyy")+"-"+hoa_don.ma_hoa_don+".doc";
                document.SaveToFile(newFile, FileFormat.Docm2013);
                var stream = System.IO.File.OpenRead(newFile);
                return new FileStreamResult(stream, "application/doc");
            }
            catch
            {
                throw;
            }
        }
    }
}
