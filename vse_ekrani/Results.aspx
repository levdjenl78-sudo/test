<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="test.vse_ekrani.Results" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Результат - ТестМир</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .results-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 50px;
            background: rgba(255,255,255,0.95);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
            text-align: center;
        }
        .trophy-icon {
            font-size: 80px;
            color: #ffd700;
            margin-bottom: 20px;
            animation: bounce 1s infinite;
        }
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        .test-name { color: #667eea; font-size: 24px; margin-bottom: 30px; }
        .result-box {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 40px;
            border-radius: 15px;
            margin: 30px 0;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }
        .result-title { font-size: 36px; font-weight: bold; margin-bottom: 20px; }
        .result-description { font-size: 18px; line-height: 1.8; opacity: 0.95; }
        .score-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
        }
        .score-value { font-size: 32px; font-weight: bold; color: #667eea; }
        .score-label { color: #666; font-size: 14px; }
        .buttons {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        .btn {
            padding: 15px 35px;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary { background: #6c757d; color: white; }
        .btn-secondary:hover { background: #5a6268; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="results-container">
            <div class="trophy-icon">
                <i class="fas fa-trophy"></i>
            </div>
            
            <h2 class="test-name" id="testName" runat="server">Название теста</h2>
            
            <div class="result-box">
                <h1 id="resultTitle" runat="server" class="result-title">Ваш результат</h1>
                <p id="resultDescription" runat="server" class="result-description">Описание</p>
            </div>
            
            <div class="score-info">
                <div class="score-value" id="scoreValue" runat="server">0</div>
                <div class="score-label">баллов набрано</div>
            </div>
            
            <div class="buttons">
                <button type="button" class="btn btn-secondary" onclick="window.location.href='<%= ResolveUrl("~/vse_ekrani/main.aspx") %>'">← К тестам</button>
                <button type="button" class="btn btn-primary" onclick="window.location.href='<%= ResolveUrl("~/vse_ekrani/profile.aspx") %>'">📊 Профиль</button>
            </div>
        </div>
    </form>
</body>
</html>