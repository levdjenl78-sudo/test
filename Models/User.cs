using System;

namespace test.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string PasswordHash { get; set; }
        public string Avatar { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? LastLogin { get; set; }
        public string Role { get; set; }
        public int TestsCompleted { get; set; }
        public decimal AverageScore { get; set; }
        public int TotalTimeSeconds { get; set; }
        public int Rank { get; set; }
    }
}