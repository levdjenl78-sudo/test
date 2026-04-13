using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using test.Database;
using test.Models;
using System.Collections.Generic;
using System.Linq;
using System.IO;

namespace test.scrins
{
    public partial class ekran2 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../vse_ekrani/avtoriz.aspx");
                return;
            }

            // ВАЖНО: Генерируем вопросы НА КАЖДОЙ загрузке (не только !IsPostBack)
            // Иначе при нажатии кнопки контролов не будет в дереве!
            GenerateQuestions();
            GenerateResults();
        }

        private void GenerateQuestions()
        {
            // Не очищаем если это PostBack и контролы уже есть
            if (pnlQuestions.Controls.Count > 0 && IsPostBack)
            {
                return; // Контролы уже есть, не пересоздаём
            }

            pnlQuestions.Controls.Clear();
            int questionCount = 3;

            if (ddlQuestionCount.SelectedValue != null)
            {
                questionCount = int.Parse(ddlQuestionCount.SelectedValue);
            }

            for (int i = 0; i < questionCount; i++)
            {
                var questionBlock = new Panel { CssClass = "question-block" };

                var header = new Panel { CssClass = "question-header" };
                header.Controls.Add(new Label
                {
                    Text = $"<span class='question-number'><i class='fas fa-question'></i> Вопрос {i + 1}</span>",
                    ID = "lblQNum_" + i
                });
                questionBlock.Controls.Add(header);

                questionBlock.Controls.Add(new Label { Text = "<label class='form-label'>Текст вопроса:</label>" });
                var txtQuestion = new TextBox
                {
                    ID = "txtQuestion_" + i,
                    CssClass = "form-input",
                    TextMode = TextBoxMode.MultiLine,
                    Rows = 3
                };
                txtQuestion.Attributes.Add("placeholder", "Введите вопрос...");
                questionBlock.Controls.Add(txtQuestion);

                questionBlock.Controls.Add(new Label { Text = "<label class='form-label' style='margin-top:15px;'>Варианты ответов (укажите баллы):</label>" });

                for (int j = 0; j < 4; j++)
                {
                    var answerPanel = new Panel { CssClass = "answer-option" };

                    answerPanel.Controls.Add(new Label { Text = (j + 1) + ") " });

                    var txtAnswer = new TextBox
                    {
                        ID = "txtAnswer_" + i + "_" + j,
                        CssClass = "form-input answer-input"
                    };
                    txtAnswer.Attributes.Add("placeholder", "Вариант ответа...");
                    answerPanel.Controls.Add(txtAnswer);

                    answerPanel.Controls.Add(new Label { Text = "Баллы: " });

                    var txtPoints = new TextBox
                    {
                        ID = "txtPoints_" + i + "_" + j,
                        CssClass = "form-input points-input",
                        Text = (j + 1).ToString(),
                        MaxLength = 3
                    };
                    answerPanel.Controls.Add(txtPoints);

                    questionBlock.Controls.Add(answerPanel);
                }

                pnlQuestions.Controls.Add(questionBlock);
            }
        }

        private void GenerateResults()
        {
            // Не очищаем если это PostBack и контролы уже есть
            if (pnlResults.Controls.Count > 0 && IsPostBack)
            {
                return;
            }

            pnlResults.Controls.Clear();
            int questionCount = 3;

            if (ddlQuestionCount.SelectedValue != null)
            {
                questionCount = int.Parse(ddlQuestionCount.SelectedValue);
            }

            int maxPoints = questionCount * 4;
            int range = maxPoints / 3;

            for (int i = 0; i < 3; i++)
            {
                var resultBlock = new Panel { CssClass = "result-block" };

                int minPoints = i * range + 1;
                int maxRangePoints = (i + 1) * range;
                if (i == 2) maxRangePoints = maxPoints;

                resultBlock.Controls.Add(new Label
                {
                    Text = $"<strong>Результат {i + 1}:</strong> ({minPoints}-{maxRangePoints} баллов)",
                    ID = "lblResultTitle_" + i
                });

                var txtResultTitle = new TextBox
                {
                    ID = "txtResultTitle_" + i,
                    CssClass = "form-input",
                    Style = { ["margin-top"] = "10px" }
                };
                txtResultTitle.Attributes.Add("placeholder", "Название результата (например: Интроверт)");
                resultBlock.Controls.Add(txtResultTitle);

                var txtResultDesc = new TextBox
                {
                    ID = "txtResultDesc_" + i,
                    CssClass = "form-textarea",
                    TextMode = TextBoxMode.MultiLine,
                    Rows = 3,
                    Style = { ["margin-top"] = "10px" }
                };
                txtResultDesc.Attributes.Add("placeholder", "Описание результата...");
                resultBlock.Controls.Add(txtResultDesc);

                pnlResults.Controls.Add(resultBlock);
            }
        }

        protected void ddlQuestionCount_SelectedIndexChanged(object sender, EventArgs e)
        {
            GenerateQuestions();
            GenerateResults();
        }

        protected void btnCreateTest_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtTestName.Text.Trim()))
                {
                    lblError.Text = "❌ Введите название теста";
                    lblError.Visible = true;
                    lblMessage.Visible = false;
                    return;
                }

                int questionCount = int.Parse(ddlQuestionCount.SelectedValue);
                var questions = new List<Question>();

                for (int i = 0; i < questionCount; i++)
                {
                    var txtQuestion = (TextBox)pnlQuestions.FindControl("txtQuestion_" + i);

                    // ОТЛАДКА - проверим что нашли контрол
                    if (txtQuestion == null)
                    {
                        lblError.Text = "❌ Ошибка: не найден вопрос " + (i + 1) + ". Попробуйте обновить страницу.";
                        lblError.Visible = true;
                        return;
                    }

                    if (string.IsNullOrEmpty(txtQuestion.Text.Trim()))
                    {
                        lblError.Text = "❌ Заполните вопрос " + (i + 1);
                        lblError.Visible = true;
                        return;
                    }

                    var question = new Question
                    {
                        Id = i + 1,
                        Text = txtQuestion.Text.Trim(),
                        QuestionNumber = i + 1,
                        Answers = new List<Answer>()
                    };

                    for (int j = 0; j < 4; j++)
                    {
                        var txtAnswer = (TextBox)pnlQuestions.FindControl("txtAnswer_" + i + "_" + j);
                        var txtPoints = (TextBox)pnlQuestions.FindControl("txtPoints_" + i + "_" + j);

                        if (txtAnswer != null && !string.IsNullOrEmpty(txtAnswer.Text.Trim()))
                        {
                            int points = 1;
                            if (txtPoints != null && !string.IsNullOrEmpty(txtPoints.Text.Trim()))
                            {
                                int.TryParse(txtPoints.Text.Trim(), out points);
                            }

                            question.Answers.Add(new Answer
                            {
                                Id = j + 1,
                                Text = txtAnswer.Text.Trim(),
                                Points = points
                            });
                        }
                    }

                    if (question.Answers.Count == 0)
                    {
                        lblError.Text = "❌ Добавьте хотя бы один ответ для вопроса " + (i + 1);
                        lblError.Visible = true;
                        return;
                    }

                    questions.Add(question);
                }

                var testResults = new List<TestResultRange>();
                for (int i = 0; i < 3; i++)
                {
                    var txtTitle = (TextBox)pnlResults.FindControl("txtResultTitle_" + i);
                    var txtDesc = (TextBox)pnlResults.FindControl("txtResultDesc_" + i);

                    if (txtTitle != null && !string.IsNullOrEmpty(txtTitle.Text.Trim()))
                    {
                        testResults.Add(new TestResultRange
                        {
                            Id = i + 1,
                            MinPoints = i * (questionCount * 4 / 3) + 1,
                            MaxPoints = (i + 1) * (questionCount * 4 / 3),
                            Title = txtTitle.Text.Trim(),
                            Description = txtDesc != null ? txtDesc.Text.Trim() : ""
                        });
                    }
                }

                if (testResults.Count == 0)
                {
                    lblError.Text = "❌ Добавьте хотя бы один результат";
                    lblError.Visible = true;
                    return;
                }

                string coverImage = "https://i.pinimg.com/736x/31/15/15/311515f117a1d7500eb1542ff77b5826.jpg";
                if (fuCoverImage.HasFile)
                {
                    try
                    {
                        string fileName = Path.GetFileName(fuCoverImage.FileName);
                        string savePath = Server.MapPath("~/uploads/") + fileName;

                        if (!Directory.Exists(Server.MapPath("~/uploads/")))
                        {
                            Directory.CreateDirectory(Server.MapPath("~/uploads/"));
                        }

                        fuCoverImage.SaveAs(savePath);
                        coverImage = "~/uploads/" + fileName;
                    }
                    catch { }
                }

                var newTest = new Test
                {
                    Title = txtTestName.Text.Trim(),
                    Description = txtTestDescription.Text.Trim(),
                    CoverImage = coverImage,
                    AuthorId = (int)Session["UserId"],
                    CreatedAt = DateTime.Now,
                    IsPublished = true,
                    TimeLimitSeconds = 1200,
                    QuestionCount = questionCount,
                    Questions = questions,
                    ResultRanges = testResults
                };

                JsonDatabase.AddTest(newTest);
                var allTests = JsonDatabase.GetTests();

                lblMessage.Text = $"✅ Тест создан! Всего тестов: {allTests.Count}";
                lblMessage.Visible = true;
                lblError.Visible = false;

                txtTestName.Text = "";
                txtTestDescription.Text = "";

                System.Threading.Thread.Sleep(2000);
                Response.Redirect("main.aspx");
            }
            catch (Exception ex)
            {
                lblError.Text = "❌ Ошибка: " + ex.Message;
                lblError.Visible = true;
                lblMessage.Visible = false;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("main.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("main.aspx");
        }
    }
}