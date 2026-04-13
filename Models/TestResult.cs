using System;

namespace test.Models
{
    public class TestResult
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int TestId { get; set; }
        public int Score { get; set; }
        public int CorrectAnswers { get; set; }
        public int TotalQuestions { get; set; }
        public int TimeSpentSeconds { get; set; }
        public DateTime CompletedAt { get; set; }
        public string Status { get; set; }
        public string ResultTitle { get; set; }
    }
}