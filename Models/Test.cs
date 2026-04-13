using System;
using System.Collections.Generic;

namespace test.Models
{
    public class Test
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string CoverImage { get; set; }
        public int AuthorId { get; set; }
        public DateTime CreatedAt { get; set; }
        public bool IsPublished { get; set; }
        public int TimeLimitSeconds { get; set; }
        public int QuestionCount { get; set; }
        public List<Question> Questions { get; set; }
        public List<TestResultRange> ResultRanges { get; set; }
    }

    public class Question
    {
        public int Id { get; set; }
        public int TestId { get; set; }
        public string Text { get; set; }
        public int QuestionNumber { get; set; }
        public List<Answer> Answers { get; set; }
    }

    public class Answer
    {
        public int Id { get; set; }
        public string Text { get; set; }
        public int Points { get; set; }
    }

    public class TestResultRange
    {
        public int Id { get; set; }
        public int MinPoints { get; set; }
        public int MaxPoints { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
    }
}