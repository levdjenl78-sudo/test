using System;
using System.Web.UI;
using System.Security.Cryptography;
using System.Text;
using test.Database;
using test.Models;

namespace test.vse_ekrani
{
    public partial class avtoriz : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] != null)
                {
                    Response.Redirect("main.aspx");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Введите логин и пароль";
                lblMessage.Visible = true;
                return;
            }

            var user = JsonDatabase.GetUserByUsername(username);

            if (user == null)
            {
                lblMessage.Text = "Неверный логин или пароль";
                lblMessage.Visible = true;
                return;
            }

            if (!VerifyPassword(password, user.PasswordHash))
            {
                lblMessage.Text = "Неверный логин или пароль";
                lblMessage.Visible = true;
                return;
            }

            Session["UserId"] = user.Id;
            Session["Username"] = user.Username;
            Session["UserRole"] = user.Role;

            user.LastLogin = DateTime.Now;
            var users = JsonDatabase.GetUsers();
            var existingUser = users.Find(u => u.Id == user.Id);
            if (existingUser != null)
            {
                existingUser.LastLogin = user.LastLogin;
                JsonDatabase.SaveUsers(users);
            }

            Response.Redirect("main.aspx");
        }

        private string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                var bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(bytes);
            }
        }

        private bool VerifyPassword(string password, string hash)
        {
            return HashPassword(password) == hash;
        }
    }
}