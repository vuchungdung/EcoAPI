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
                    return null;

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
    }
}
