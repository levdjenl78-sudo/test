<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="test.vse_ekrani.profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Профиль - ТестМир</title>
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
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

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
            font-size: 24px;
            font-weight: bold;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
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
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .profile-container {
            background: rgba(255,255,255,0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .avatar-section {
            margin-bottom: 30px;
        }

        .avatar-preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #667eea;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.3);
            margin-bottom: 15px;
        }

        .avatar-placeholder {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 60px;
            color: white;
            margin: 0 auto 15px;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.3);
        }

        .avatar-upload {
            display: inline-block;
            padding: 10px 25px;
            background: #f0f0f0;
            border-radius: 25px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .avatar-upload:hover {
            background: #e0e0e0;
        }

        .avatar-upload input[type="file"] {
            display: none;
        }

        .user-name {
            font-size: 28px;
            color: #333;
            margin-bottom: 10px;
        }

        .user-email {
            color: #666;
            font-size: 16px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin: 30px 0;
        }

        .stat-card {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 25px;
            border-radius: 12px;
            text-align: center;
            border: 1px solid #dee2e6;
        }

        .stat-icon {
            font-size: 32px;
            color: #667eea;
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 32px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #666;
            font-size: 14px;
        }

        .section-title {
            font-size: 20px;
            color: #333;
            margin: 30px 0 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }

        .tests-list {
            list-style: none;
        }

        .test-item {
            padding: 15px;
            margin: 10px 0;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #667eea;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .test-name {
            font-weight: 600;
            color: #333;
        }

        .test-score {
            color: #667eea;
            font-weight: bold;
        }

        .message {
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            font-weight: 500;
        }

        .message-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .message-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }

            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="container">
            <!-- HEADER -->
            <div class="header">
                <div class="logo">
                    <i class="fas fa-brain"></i> ТестМир
                </div>
                <div class="header-buttons">
                   <button type="button" class="btn btn-primary" onclick="window.location.href='<%= ResolveUrl("~/vse_ekrani/main.aspx") %>'">🏠 Главная</button>
                    <asp:Button ID="btnLogout" runat="server" Text="Выйти" CssClass="btn btn-secondary" OnClick="btnLogout_Click" />
                </div>
            </div>

            <!-- PROFILE -->
            <div class="profile-container">
                <div class="profile-header">
                    <!-- Аватар -->
                    <div class="avatar-section">
                        <asp:Image ID="imgAvatar" runat="server" CssClass="avatar-preview" Visible="false" />
                        <div id="avatarPlaceholder" runat="server" class="avatar-placeholder" visible="false">
                            <i class="fas fa-user"></i>
                        </div>
                        
                        <label class="avatar-upload">
                            <i class="fas fa-camera"></i> Изменить фото
                            <asp:FileUpload ID="fuAvatar" runat="server" Accept="image/*" OnChange="uploadAvatar()" />
                        </label>
                        <asp:Button ID="btnSaveAvatar" runat="server" Text="Сохранить" CssClass="btn btn-primary" OnClick="btnSaveAvatar_Click" Style="margin-left: 10px;" />
                    </div>

                    <h1 class="user-name" id="userName" runat="server">Имя пользователя</h1>
                    <p class="user-email" id="userEmail" runat="server">email@example.com</p>
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="message message-success" Visible="false"></asp:Label>
                <asp:Label ID="lblError" runat="server" CssClass="message message-error" Visible="false"></asp:Label>

                <!-- СТАТИСТИКА -->
                <h2 class="section-title"><i class="fas fa-chart-bar"></i> Моя статистика</h2>
                
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-clipboard-check"></i>
                        </div>
                        <div class="stat-value" id="testsCompleted" runat="server">0</div>
                        <div class="stat-label">Пройдено тестов</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="stat-value" id="averageScore" runat="server">0</div>
                        <div class="stat-label">Средний балл</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-value" id="timeSpent" runat="server">0 ч</div>
                        <div class="stat-label">Время в тестах</div>
                    </div>
                </div>

                <!-- ПОСЛЕДНИЕ РЕЗУЛЬТАТЫ -->
                <h2 class="section-title"><i class="fas fa-history"></i> Последние результаты</h2>
                
                <asp:Repeater ID="rptResults" runat="server">
                    <HeaderTemplate>
                        <ul class="tests-list">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li class="test-item">
                            <span class="test-name"><%# Eval("TestTitle") %></span>
                            <span class="test-score"><%# Eval("Score") %> баллов</span>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>
                        </ul>
                    </FooterTemplate>
                </asp:Repeater>

                <asp:Label ID="lblNoResults" runat="server" Text="Вы ещё не проходили тесты" Visible="false"></asp:Label>
            </div>
        </div>
    </form>

    <script>
        function uploadAvatar() {
            // Предпросмотр аватара
            const fileInput = document.getElementById('<%= fuAvatar.ClientID %>');
            const imgPreview = document.getElementById('<%= imgAvatar.ClientID %>');
            const placeholder = document.getElementById('<%= avatarPlaceholder.ClientID %>');

            if (fileInput.files && fileInput.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    if (imgPreview) {
                        imgPreview.src = e.target.result;
                        imgPreview.style.display = 'block';
                    }
                    if (placeholder) {
                        placeholder.style.display = 'none';
                    }
                };
                reader.readAsDataURL(fileInput.files[0]);
            }
        }
    </script>
</body>
</html>