using System;
using System.Web.UI;
using System.Security.Cryptography;
using System.Text;
using test.Database;
using test.Models;

namespace test.vse_ekrani
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                Response.Redirect("main.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Заполните все поля";
                lblMessage.Visible = true;
                return;
            }

            if (password != confirmPassword)
            {
                lblMessage.Text = "Пароли не совпадают";
                lblMessage.Visible = true;
                return;
            }

            if (password.Length < 6)
            {
                lblMessage.Text = "Пароль должен быть не менее 6 символов";
                lblMessage.Visible = true;
                return;
            }

            var existingUser = JsonDatabase.GetUserByUsername(username);
            if (existingUser != null)
            {
                lblMessage.Text = "Пользователь с таким логином уже существует";
                lblMessage.Visible = true;
                return;
            }

            var newUser = new User
            {
                Username = username,
                Email = email,
                PasswordHash = HashPassword(password),
                Avatar = username.Substring(0, 1).ToUpper(),
                Role = "user",
                TestsCompleted = 0,
                AverageScore = 0,
                TotalTimeSeconds = 0,
                Rank = 0
            };

            JsonDatabase.AddUser(newUser);

            lblMessage.Visible = true;
            lblMessage.Visible = false;

            txtUsername.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";

            System.Threading.Thread.Sleep(2000);
            Response.Redirect("avtoriz.aspx");
        }

        private string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                var bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(bytes);
            }
        }
    }
}