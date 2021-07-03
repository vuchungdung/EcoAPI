using EcoAPI.Helper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Model;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.IO;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace EcoAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class AuthenApiController : ControllerBase
    {
        private readonly IDatabaseHelper _db;
        private string _path;
        private string Secret;
        public AuthenApiController(IDatabaseHelper db, IConfiguration configuration)
        {
            _db = db;
            Secret = configuration["AppSettings:Secret"];
            _path = configuration["AppSettings:PATH"];
        }
        [AllowAnonymous]
        [HttpPost("login")]
        public IActionResult Login([FromBody] AuthenticateModel model)
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_user_get_by_username_password",
                     "@taikhoan", model.Username,
                     "@matkhau", model.Password);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                var user = dt.ConvertTo<UserModel>().FirstOrDefault();
                if (user == null)
                    return BadRequest();

                var tokenHandler = new JwtSecurityTokenHandler();
                var key = Encoding.ASCII.GetBytes(Secret);
                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new Claim[]
                    {
                    new Claim(ClaimTypes.Name, user.hoten.ToString()),
                    new Claim(ClaimTypes.StreetAddress, user.diachi)
                    }),
                    Expires = DateTime.UtcNow.AddDays(7),
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
                };
                var token = tokenHandler.CreateToken(tokenDescriptor);
                user.token = tokenHandler.WriteToken(token);
                return Ok(new { user_id = user.user_id, hoten = user.hoten, taikhoan = user.taikhoan, token = user.token });
            }
            catch
            {
                throw;
            }
        }

        [HttpPost("add")]
        public bool Create([FromBody]UserModel model)
        {
            string msgError = "";
            try
            {
                model.user_id = Guid.NewGuid().ToString();
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_user_create",
                "@user_id", model.user_id,
                "@hoten", model.hoten,
                "@diachi", model.diachi,
                "@email", model.email,
                "@taikhoan", model.taikhoan,
                "@matkhau", model.matkhau);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch
            {
                throw;
            }
        }

        [HttpGet("delete/{id}")]
        public bool Delete(string id)
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_user_delete",
                "@user_id", id);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch
            {
                throw;
            }
        }
        [HttpPost("edit")]
        public bool Update([FromBody]UserModel model)
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_user_update",
                "@user_id", model.user_id,
                "@hoten", model.hoten,
                "@diachi", model.diachi,
                "@email", model.email,
                "@taikhoan", model.taikhoan,
                "@matkhau", model.matkhau);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch
            {
                throw;
            }
        }

        [HttpGet("item/{id}")]
        public UserModel GetDatabyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_user_get_by_id",
                     "@user_id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<UserModel>().FirstOrDefault();
            }
            catch
            {
                throw;
            }
        }
        [HttpPost("search")]
        public List<UserModel> Search(int pageIndex, int pageSize, out long total, string hoten, string taikhoan)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "sp_user_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@hoten", hoten,
                    "@taikhoan", taikhoan);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<UserModel>().ToList();
            }
            catch
            {
                throw;
            }
        }
    }
}
