using System;
using System.Web.UI;
using test.Database;
using test.Models;
using System.Collections.Generic;
using System.Linq;

namespace test.vse_ekrani
{
    public partial class Results : Page
    {
        protected TestResult lastResult;
        protected Test currentTest;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("avtoriz.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadResults();
            }
        }

        private void LoadResults()
        {
            // Получаем результат из Session
            lastResult = Session["LastTestResult"] as TestResult;

            if (lastResult == null)
            {
                var results = JsonDatabase.GetResultsByUserId((int)Session["UserId"]);
                if (results.Count > 0)
                {
                    lastResult = results[results.Count - 1];
                }
            }

            if (lastResult != null)
            {
                currentTest = JsonDatabase.GetTestById(lastResult.TestId);

                if (currentTest != null)
                {
                    // Название теста
                    testName.InnerText = currentTest.Title;

                    // Находим результат из диапазона по баллам
                    string rangeTitle = "Результат";
                    string rangeDescription = "";

                    if (currentTest.ResultRanges != null && currentTest.ResultRanges.Count > 0)
                    {
                        foreach (var range in currentTest.ResultRanges)
                        {
                            if (lastResult.Score >= range.MinPoints && lastResult.Score <= range.MaxPoints)
                            {
                                rangeTitle = range.Title;
                                rangeDescription = range.Description;
                                break;
                            }
                        }
                    }

                    // Показываем результат
                    resultTitle.InnerText = rangeTitle;
                    resultDescription.InnerText = rangeDescription;

                    // Просто показываем сколько баллов набрано
                    scoreValue.InnerText = lastResult.Score.ToString();
                }
            }
        }

        protected void btnBackToTests_Click(object sender, EventArgs e)
        {
            Response.Redirect("../scrins/main.aspx");
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("profile.aspx");
        }
    }
}