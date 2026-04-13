<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="test.scrins.main" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ТестМир - Главная</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* HEADER */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255,255,255,0.95);
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .logo {
            font-size: 28px;
            font-weight: bold;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .user-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .profile-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .profile-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        .avatar {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 18px;
        }

        .logout-btn {
            padding: 10px 20px;
            background: #ff6b6b;
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background: #ee5a5a;
        }

        /* CONTENT */
        .content {
            background: rgba(255,255,255,0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .page-title {
            font-size: 32px;
            color: #333;
            margin-bottom: 10px;
        }

        .page-subtitle {
            color: #666;
            margin-bottom: 30px;
        }

        .add-test-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 15px 30px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 30px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .add-test-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }

        /* TESTS GRID */
        .tests-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
        }

        .test-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .test-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .test-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .test-content {
            padding: 25px;
        }

        .test-title {
            font-size: 20px;
            color: #333;
            margin-bottom: 10px;
        }

        .test-description {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 20px;
            min-height: 60px;
        }

        .test-meta {
            display: flex;
            gap: 15px;
            color: #999;
            font-size: 13px;
            margin-bottom: 20px;
        }

        .test-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .start-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: background 0.3s;
        }

        .start-btn:hover {
            background: linear-gradient(135deg, #764ba2, #667eea);
        }

        .no-tests {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .no-tests i {
            font-size: 60px;
            margin-bottom: 20px;
            color: #ddd;
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }

            .tests-grid {
                grid-template-columns: 1fr;
            }

            .content {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- HEADER -->
            <div class="header">
                <div class="logo">
                    <i class="fas fa-brain"></i> ТестМир
                </div>
                <div class="user-section">
                    <asp:LinkButton ID="btnProfile" runat="server" CssClass="profile-btn" OnClick="btnProfile_Click">
                        <i class="fas fa-user"></i>
                        <span id="userAvatar" runat="server"></span>
                        Профиль
                    </asp:LinkButton>
                    <asp:Button ID="btnLogout" runat="server" Text="Выйти" CssClass="logout-btn" OnClick="btnLogout_Click" />
                </div>
            </div>

            <!-- CONTENT -->
            <div class="content">
                <h1 class="page-title">Добро пожаловать!</h1>
                <p class="page-subtitle">Выберите тест или создайте свой собственный</p>
                
                <asp:LinkButton ID="btnAddTest" runat="server" CssClass="add-test-btn" OnClick="btnAddTest_Click">
                    <i class="fas fa-plus-circle"></i> Создать тест
                </asp:LinkButton>
                
                <!-- TESTS GRID -->
                <asp:Repeater ID="rptTests" runat="server" OnItemCommand="rptTests_ItemCommand">
                    <HeaderTemplate>
                        <div class="tests-grid">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="test-card">
                            <img src='<%# Eval("CoverImage") %>' alt="Тест" class="test-image" onerror="this.style.background='linear-gradient(135deg, #667eea, #764ba2)'" />
                            <div class="test-content">
                                <h3 class="test-title"><%# Eval("Title") %></h3>
                                <p class="test-description"><%# Eval("Description") %></p>
                                <div class="test-meta">
                                    <span><i class="fas fa-question-circle"></i> <%# Eval("QuestionCount") %> вопросов</span>
                                    <span><i class="fas fa-clock"></i> <%# Eval("TimeLimitSeconds") %> сек</span>
                                </div>
                                <asp:Button ID="btnStartTest" runat="server" Text="Начать тест" 
                                    CssClass="start-btn" CommandName="StartTest" 
                                    CommandArgument='<%# Eval("Id") %>' />
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
                
                <asp:Label ID="lblNoTests" runat="server" Visible="false">
                    <div class="no-tests">
                        <i class="fas fa-clipboard-list"></i>
                        <h2>Тестов пока нет</h2>
                        <p>Создайте первый тест прямо сейчас!</p>
                    </div>
                </asp:Label>
            </div>
        </div>
    </form>
</body>
</html>