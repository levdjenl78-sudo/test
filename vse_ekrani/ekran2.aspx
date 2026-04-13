<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ekran2.aspx.cs" Inherits="test.scrins.ekran2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Создать тест - ТестМир</title>
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
            max-width: 1000px;
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

        .btn-back {
            padding: 10px 20px;
            background: #ff6b6b;
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
        }

        .btn-back:hover {
            background: #ee5a5a;
        }

        .form-container {
            background: rgba(255,255,255,0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }

        .form-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }

        .form-section {
            margin-bottom: 30px;
            padding: 25px;
            background: #f8f9fa;
            border-radius: 10px;
            border: 1px solid #e9ecef;
        }

        .section-title {
            font-size: 18px;
            color: #667eea;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        .form-input, .form-textarea, .form-select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-input:focus, .form-textarea:focus, .form-select:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-textarea {
            min-height: 100px;
            resize: vertical;
        }

        .image-upload {
            border: 2px dashed #667eea;
            padding: 30px;
            text-align: center;
            border-radius: 10px;
            background: #f8f9fa;
            cursor: pointer;
            transition: background 0.3s;
        }

        .image-upload:hover {
            background: #e9ecef;
        }

        .image-preview {
            max-width: 200px;
            max-height: 200px;
            margin: 15px auto;
            border-radius: 10px;
            display: none;
        }

        .question-block {
            background: white;
            padding: 25px;
            margin: 20px 0;
            border-radius: 10px;
            border: 1px solid #e9ecef;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .question-number {
            font-size: 16px;
            font-weight: bold;
            color: #667eea;
        }

        .answer-option {
            display: flex;
            align-items: center;
            gap: 15px;
            margin: 15px 0;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .answer-input {
            flex: 1;
        }

        .points-input {
            width: 80px;
            text-align: center;
        }

        .btn {
            padding: 14px 30px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s;
            margin: 5px;
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

        .btn-success {
            background: #28a745;
            color: white;
        }

        .result-block {
            background: white;
            padding: 25px;
            margin: 15px 0;
            border-radius: 10px;
            border-left: 4px solid #667eea;
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
            .form-container {
                padding: 25px;
            }
            
            .answer-option {
                flex-direction: column;
                align-items: stretch;
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
                    <i class="fas fa-brain"></i> Конструктор тестов
                </div>
                <asp:Button ID="btnBack" runat="server" Text="← Назад" CssClass="btn-back" OnClick="btnBack_Click" />
            </div>

            <!-- FORM -->
            <div class="form-container">
                <h1 class="form-title">Создать тест</h1>
                
                <asp:Label ID="lblMessage" runat="server" CssClass="message message-success" Visible="false"></asp:Label>
                <asp:Label ID="lblError" runat="server" CssClass="message message-error" Visible="false"></asp:Label>

                <!-- Основная информация -->
                <div class="form-section">
                    <h2 class="section-title">
                        <i class="fas fa-info-circle"></i> Основная информация
                    </h2>
                    
                    <div class="form-group">
                        <label class="form-label">Название теста</label>
                        <asp:TextBox ID="txtTestName" runat="server" CssClass="form-input" placeholder="Например: Какой вы тип личности?"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Описание теста</label>
                        <asp:TextBox ID="txtTestDescription" runat="server" CssClass="form-textarea" TextMode="MultiLine" placeholder="Опишите что узнает пользователь после прохождения..."></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Обложка теста</label>
                        <div class="image-upload">
                            <i class="fas fa-cloud-upload-alt" style="font-size: 40px; color: #667eea;"></i>
                            <p style="margin: 15px 0; color: #666;">Перетащите изображение или нажмите для выбора</p>
                            <asp:FileUpload ID="fuCoverImage" runat="server" CssClass="form-input" Accept="image/*" />
                            <asp:Image ID="imgPreview" runat="server" CssClass="image-preview" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Количество вопросов</label>
                        <asp:DropDownList ID="ddlQuestionCount" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlQuestionCount_SelectedIndexChanged">
                            <asp:ListItem Text="3 вопроса" Value="3"></asp:ListItem>
                            <asp:ListItem Text="5 вопросов" Value="5"></asp:ListItem>
                            <asp:ListItem Text="7 вопросов" Value="7" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="10 вопросов" Value="10"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <!-- Вопросы -->
                <div class="form-section">
                    <h2 class="section-title">
                        <i class="fas fa-question-circle"></i> Вопросы и варианты ответов
                    </h2>
                    <p style="color: #666; margin-bottom: 20px;">Каждый ответ имеет баллы. В конце считается сумма и показывается результат по диапазону.</p>
                    
                    <asp:Panel ID="pnlQuestions" runat="server"></asp:Panel>
                </div>

                <!-- Результаты по диапазонам -->
                <div class="form-section">
                    <h2 class="section-title">
                        <i class="fas fa-chart-bar"></i> Результаты по баллам
                    </h2>
                    <p style="color: #666; margin-bottom: 20px;">Укажите какой результат показывается при определённом количестве баллов.</p>
                    
                    <asp:Panel ID="pnlResults" runat="server"></asp:Panel>
                </div>

                <!-- Кнопки -->
                <div style="text-align: center; margin-top: 30px;">
                    <asp:Button ID="btnCreateTest" runat="server" Text="🚀 Создать тест" CssClass="btn btn-primary" OnClick="btnCreateTest_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Отмена" CssClass="btn btn-secondary" OnClick="btnCancel_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>