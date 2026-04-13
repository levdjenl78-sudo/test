using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using test.Models;

namespace test.Database
{
    public class JsonDatabase
    {
        // ПРЯМОЙ ПУТЬ - БЕЗ Server.MapPath
        private static string GetBasePath()
        {
            return HttpContext.Current.Server.MapPath("~");
        }

        private static string GetDataPath(string fileName)
        {
            return Path.Combine(GetBasePath(), "App_Data", fileName);
        }

        // ==================== ПОЛЬЗОВАТЕЛИ ====================

        public static List<User> GetUsers()
        {
            string path = GetDataPath("users.json");
            if (!File.Exists(path))
            {
                // Создаём файл если нет
                File.WriteAllText(path, "[]");
                return new List<User>();
            }
            string json = File.ReadAllText(path);
            if (string.IsNullOrEmpty(json)) return new List<User>();
            return JsonConvert.DeserializeObject<List<User>>(json) ?? new List<User>();
        }

        public static void SaveUsers(List<User> users)
        {
            string path = GetDataPath("users.json");
            string json = JsonConvert.SerializeObject(users, Formatting.Indented);
            File.WriteAllText(path, json);
        }

        public static User GetUserByUsername(string username)
        {
            var users = GetUsers();
            return users.Find(u => u.Username == username);
        }

        public static User GetUserById(int id)
        {
            var users = GetUsers();
            return users.Find(u => u.Id == id);
        }

        public static void AddUser(User user)
        {
            var users = GetUsers();
            user.Id = users.Count > 0 ? users.Max(u => u.Id) + 1 : 1;
            user.CreatedAt = DateTime.Now;
            users.Add(user);
            SaveUsers(users);
        }

        // ==================== ТЕСТЫ ====================

        public static List<Test> GetTests()
        {
            string path = GetDataPath("tests.json");
            if (!File.Exists(path))
            {
                File.WriteAllText(path, "[]");
                return new List<Test>();
            }
            string json = File.ReadAllText(path);
            if (string.IsNullOrEmpty(json)) return new List<Test>();
            return JsonConvert.DeserializeObject<List<Test>>(json) ?? new List<Test>();
        }

        public static void SaveTests(List<Test> tests)
        {
            string path = GetDataPath("tests.json");
            string json = JsonConvert.SerializeObject(tests, Formatting.Indented);
            File.WriteAllText(path, json);
        }

        public static Test GetTestById(int id)
        {
            var tests = GetTests();
            return tests.Find(t => t.Id == id);
        }

        public static void AddTest(Test test)
        {
            var tests = GetTests();
            test.Id = tests.Count > 0 ? tests.Max(t => t.Id) + 1 : 1;
            test.CreatedAt = DateTime.Now;
            tests.Add(test);
            SaveTests(tests);
        }

        // ==================== РЕЗУЛЬТАТЫ ====================

        public static List<TestResult> GetResults()
        {
            string path = GetDataPath("results.json");
            if (!File.Exists(path))
            {
                File.WriteAllText(path, "[]");
                return new List<TestResult>();
            }
            string json = File.ReadAllText(path);
            if (string.IsNullOrEmpty(json)) return new List<TestResult>();
            return JsonConvert.DeserializeObject<List<TestResult>>(json) ?? new List<TestResult>();
        }

        public static void SaveResults(List<TestResult> results)
        {
            string path = GetDataPath("results.json");
            string json = JsonConvert.SerializeObject(results, Formatting.Indented);
            File.WriteAllText(path, json);
        }

        public static void AddResult(TestResult result)
        {
            var results = GetResults();
            result.Id = results.Count > 0 ? results.Max(r => r.Id) + 1 : 1;
            result.CompletedAt = DateTime.Now;
            results.Add(result);
            SaveResults(results);
        }

        public static List<TestResult> GetResultsByUserId(int userId)
        {
            var results = GetResults();
            return results.FindAll(r => r.UserId == userId);
        }
    }
}