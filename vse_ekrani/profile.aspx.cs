using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using test.Database;
using test.Models;
using System.Collections.Generic;
using System.Linq;
using System.IO;

namespace test.vse_ekrani
{
    public partial class profile : Page
    {
        protected User currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("avtoriz.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        private void LoadProfile()
        {
            int userId = (int)Session["UserId"];
            currentUser = JsonDatabase.GetUserById(userId);

            if (currentUser != null)
            {
                // Имя и email
                userName.InnerText = currentUser.Username;
                userEmail.InnerText = currentUser.Email;

                // Аватар
                if (!string.IsNullOrEmpty(currentUser.Avatar))
                {
                    imgAvatar.ImageUrl = currentUser.Avatar;
                    imgAvatar.Visible = true;
                    avatarPlaceholder.Visible = false;
                }
                else
                {
                    imgAvatar.Visible = false;
                    avatarPlaceholder.Visible = true;
                }

                // Статистика
                testsCompleted.InnerText = currentUser.TestsCompleted.ToString();

                // ✅ ИСПРАВЛЕНО: Средний балл считаем правильно
                var results = JsonDatabase.GetResultsByUserId(userId);
                if (results.Count > 0)
                {
                    int totalScore = results.Sum(r => r.Score);
                    int avgScore = totalScore / results.Count;
                    averageScore.InnerText = avgScore.ToString();
                }
                else
                {
                    averageScore.InnerText = "0";
                }

                // Время в часах
                int hours = currentUser.TotalTimeSeconds / 3600;
                int minutes = (currentUser.TotalTimeSeconds % 3600) / 60;
                timeSpent.InnerText = hours > 0 ? $"{hours} ч {minutes} мин" : $"{minutes} мин";

                // Последние результаты
                LoadResults();
            }
        }

        private void LoadResults()
        {
            var results = JsonDatabase.GetResultsByUserId((int)Session["UserId"]);

            if (results.Count == 0)
            {
                rptResults.Visible = false;
                lblNoResults.Visible = true;
            }
            else
            {

                // Добавляем названия тестов
                var resultsWithTitles = new List<object>();
                foreach (var result in lastResults)
                {
                    var test = JsonDatabase.GetTestById(result.TestId);
                    resultsWithTitles.Add(new
                    {
                        TestTitle = test != null ? test.Title : "Удалённый тест",
                        Score = result.Score
                    });
                }

                rptResults.DataSource = resultsWithTitles;
                rptResults.DataBind();
                rptResults.Visible = true;
                lblNoResults.Visible = false;
            }
        }

        protected void btnSaveAvatar_Click(object sender, EventArgs e)
        {
            try
            {
                if (fuAvatar.HasFile)
                {
                    // Проверка типа файла
                    string ext = Path.GetExtension(fuAvatar.FileName).ToLower();
                    if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".gif")
                    {
                        lblError.Text = "❌ Загрузите изображение (JPG, PNG, GIF)";
                        lblError.Visible = true;
                        lblMessage.Visible = false;
                        return;
                    }

                    // Создаём папку если нет
                    string uploadPath = Server.MapPath("~/uploads/avatars/");
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }

                    // Сохраняем файл
                    string fileName = $"avatar_{currentUser.Id}_{DateTime.Now.Ticks}{ext}";
                    string savePath = Path.Combine(uploadPath, fileName);
                    fuAvatar.SaveAs(savePath);

                    // Обновляем аватар в профиле
                    string avatarUrl = "~/uploads/avatars/" + fileName;
                    currentUser.Avatar = avatarUrl;

                    // Сохраняем пользователя
                    var users = JsonDatabase.GetUsers();
                    var user = users.Find(u => u.Id == currentUser.Id);
                    if (user != null)
                    {
                        user.Avatar = avatarUrl;
                        JsonDatabase.SaveUsers(users);
                    }

                    lblMessage.Text = "✅ Аватар сохранён!";
                    lblMessage.Visible = true;
                    lblError.Visible = false;

                    // Обновляем отображение
                    imgAvatar.ImageUrl = avatarUrl;
                    imgAvatar.Visible = true;
                    avatarPlaceholder.Visible = false;
                }
                else
                {
                    lblError.Text = "❌ Выберите файл";
                    lblError.Visible = true;
                    lblMessage.Visible = false;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "❌ Ошибка: " + ex.Message;
                lblError.Visible = true;
                lblMessage.Visible = false;
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/scrins/main.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("avtoriz.aspx");
        }
    }
}
