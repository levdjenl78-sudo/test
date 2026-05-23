using System;
using System.Web.UI;
using test.Database;
using test.Models;
using System.Collections.Generic;
using System.Linq;

namespace test.vse_ekrani
{
    public partial class Ekran3 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("avtoriz.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadTest();
            }
        }

        private void LoadTest()
        {
            int testId = Session["CurrentTestId"] != null ? (int)Session["CurrentTestId"] : 1;
            var test = JsonDatabase.GetTestById(testId);

            if (test != null)
            {
                Session["CurrentTest"] = test;

                testTitle.InnerText = test.Title;
                testDescription.InnerText = test.Description;
                hdnTotalQuestions.Value = test.Questions.Count.ToString();
                hdnTestId.Value = test.Id.ToString();

                ShowQuestion(0);
            }
        }

        private Test GetCurrentTest()
        {
            return Session["CurrentTest"] as Test;
        }

        private void ShowQuestion(int index)
        {
            var test = GetCurrentTest();
            if (test == null || test.Questions == null) return;
            if (index >= test.Questions.Count) index = test.Questions.Count - 1;

            hdnCurrentQuestion.Value = index.ToString();

            var question = test.Questions[index];
            questionNumber.InnerText = $"Вопрос {index + 1} из {test.Questions.Count}";
            progressText.InnerText = $"Вопрос {index + 1} из {test.Questions.Count}";
            questionText.InnerText = question.Text;

            // Генерация вариантов ответов
            optionsContainer.InnerHtml = "";
            foreach (var answer in question.Answers)
            {
                optionsContainer.InnerHtml += $@"
                    <div class='option-item'>
                        <input type='radio' name='answer' value='{answer.Id}' class='option-radio' id='ans{answer.Id}' />
                        <label for='ans{answer.Id}'>{answer.Text}</label>
                    </div>";
            }

            // Обновляем прогресс бар
            int progress = ((index + 1) * 100) / test.Questions.Count;
            progressFill.Style["width"] = progress + "%";

            // Кнопки навигации
            btnPrevious.Visible = index > 0;
            btnNext.Visible = index < test.Questions.Count - 1;
            btnSubmit.Visible = index == test.Questions.Count - 1;
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            SaveCurrentAnswer(); // Сохраняем ответ перед переходом
            var test = GetCurrentTest();
            if (test == null) return;

            int currentIndex = string.IsNullOrEmpty(hdnCurrentQuestion.Value) ? 0 : int.Parse(hdnCurrentQuestion.Value);

            if (currentIndex < test.Questions.Count - 1)
            {
                ShowQuestion(currentIndex + 1);
            }
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            SaveCurrentAnswer(); // Сохраняем ответ перед переходом
            var test = GetCurrentTest();
            if (test == null) return;

            int currentIndex = string.IsNullOrEmpty(hdnCurrentQuestion.Value) ? 0 : int.Parse(hdnCurrentQuestion.Value);

            if (currentIndex > 0)
            {
                ShowQuestion(currentIndex - 1);
            }
        }

        private void SaveCurrentAnswer()
        {
            // Сохраняем выбранный ответ в HiddenField
            var selectedAnswer = Request.Form["answer"];
            if (!string.IsNullOrEmpty(selectedAnswer))
            {
                int currentIndex = string.IsNullOrEmpty(hdnCurrentQuestion.Value) ? 0 : int.Parse(hdnCurrentQuestion.Value);

                // Загружаем предыдущие ответы
                var userAnswers = new Dictionary<int, int>();
                if (!string.IsNullOrEmpty(hdnUserAnswers.Value))
                {
                    var pairs = hdnUserAnswers.Value.Split(';');
                    foreach (var pair in pairs)
                    {
                        if (!string.IsNullOrEmpty(pair))
                        {
                            var parts = pair.Split(':');
                            if (parts.Length == 2)
                            {
                                userAnswers[int.Parse(parts[0])] = int.Parse(parts[1]);
                            }
                        }
                    }
                }

               

                // Сохраняем обратно
                hdnUserAnswers.Value = string.Join(";", userAnswers.Select(kvp => $"{kvp.Key}:{kvp.Value}"));
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                var test = GetCurrentTest();

                if (test == null || test.Questions == null)
                {
                    lblError.Text = "Ошибка: тест не найден. Попробуйте начать заново.";
                    lblError.Visible = true;
                    return;
                }

                // ✅ ИСПРАВЛЕНО: Подсчёт СУММЫ БАЛЛОВ (не процент!)
                int totalScore = 0;
                int answeredQuestions = 0;

                // Парсим ответы пользователя из HiddenField
                var userAnswers = new Dictionary<int, int>();
                if (!string.IsNullOrEmpty(hdnUserAnswers.Value))
                {
                    var pairs = hdnUserAnswers.Value.Split(';');
                    foreach (var pair in pairs)
                    {
                        if (!string.IsNullOrEmpty(pair))
                        {
                            var parts = pair.Split(':');
                            if (parts.Length == 2)
                            {
                                userAnswers[int.Parse(parts[0])] = int.Parse(parts[1]);
                            }
                        }
                    }
                }

                // Суммируем баллы за каждый выбранный ответ
                for (int i = 0; i < test.Questions.Count; i++)
                {
                    if (userAnswers.ContainsKey(i))
                    {
                        int selectedAnswerId = userAnswers[i];
                        var question = test.Questions[i];
                        var selectedAnswer = question.Answers.Find(a => a.Id == selectedAnswerId);

                        if (selectedAnswer != null)
                        {
                            totalScore += selectedAnswer.Points; // ✅ СУММИРУЕМ БАЛЛЫ!
                            answeredQuestions++;
                        }
                    }
                }

                // Сохранение результата
                var result = new TestResult
                {
                    UserId = (int)Session["UserId"],
                    TestId = test.Id,
                    Score = totalScore, // ✅ СОХРАНЯЕМ СУММУ БАЛЛОВ (не процент!)
                    CorrectAnswers = answeredQuestions,
                    TotalQuestions = test.Questions.Count,
                    TimeSpentSeconds = 1200 - (string.IsNullOrEmpty(hdnTimeRemaining.Value) ? 0 : int.Parse(hdnTimeRemaining.Value)),
                    Status = "completed"
                };

                JsonDatabase.AddResult(result);

                // Обновление статистики пользователя
                var users = JsonDatabase.GetUsers();
                var user = users.Find(u => u.Id == (int)Session["UserId"]);
                if (user != null)
                {
                    user.TestsCompleted += 1;
                    user.AverageScore = (user.AverageScore + totalScore) / 2;
                    user.TotalTimeSeconds += result.TimeSpentSeconds;
                    JsonDatabase.SaveUsers(users);
                }

                Session["LastTestResult"] = result;
                Session["LastTestId"] = test.Id;
                Session.Remove("CurrentTest");
                Response.Redirect("Results.aspx");
            }
            catch (Exception ex)
            {
                lblError.Text = "Ошибка: " + ex.Message;
                lblError.Visible = true;
            }
        }

        protected void btnExit_Click(object sender, EventArgs e)
        {
            Session.Remove("CurrentTest");
            Response.Redirect("../scrins/main.aspx");
        }
    }
}
