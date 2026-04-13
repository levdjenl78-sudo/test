<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ekran3.aspx.cs" Inherits="test.vse_ekrani.Ekran3" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Прохождение теста - ТестМир</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="styles/si.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <div class="logo">ТестМир</div>
                <div class="timer" id="timer" runat="server">⏱️ 20:00</div>
                <asp:Button ID="btnExit" runat="server" Text="Выйти" CssClass="btn btn-back" OnClick="btnExit_Click" />
            </div>

            <div class="test-container">
                <!-- Заголовок теста -->
                <div class="test-header">
                    <h1 class="test-title" id="testTitle" runat="server">Название теста</h1>
                    <p class="test-description" id="testDescription" runat="server">Описание теста будет здесь</p>
                </div>

                <!-- Прогресс-бар -->
                <div class="progress-bar">
                    <div class="progress-fill" id="progressFill" runat="server" style="width: 0%;"></div>
                </div>

                <!-- Индикаторы вопросов -->
                <div class="question-indicators" id="questionIndicators" runat="server">
                </div>

                <!-- Контейнер вопроса -->
                <div class="question-container">
                    <div class="question-header">
                        <div class="question-number" id="questionNumber" runat="server">Вопрос 1 из 10</div>
                    </div>

                    <h2 class="question-text" id="questionText" runat="server">Текст вопроса будет отображаться здесь...</h2>

                    <!-- Варианты ответов -->
                    <div class="options-container" id="optionsContainer" runat="server">
                    </div>
                </div>

                <!-- Навигация -->
                <div class="navigation">
                    <asp:Button ID="btnPrevious" runat="server" Text="← Назад" CssClass="btn-nav btn-prev" OnClick="btnPrevious_Click" Visible="false" />
                    
                    <div class="progress-text" id="progressText" runat="server">Вопрос 1 из 10</div>
                    
                    <asp:Button ID="btnNext" runat="server" Text="Далее →" CssClass="btn-nav btn-next" OnClick="btnNext_Click" />
                    <asp:Button ID="btnSubmit" runat="server" Text="Завершить тест" CssClass="btn-nav btn-submit" OnClick="btnSubmit_Click" Visible="false" />
                </div>

                <!-- Сообщение об ошибке -->
                <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="false"></asp:Label>
            </div>
        </div>

        <!-- Скрытые поля для хранения состояния -->
        <asp:HiddenField ID="hdnCurrentQuestion" runat="server" Value="0" />
        <asp:HiddenField ID="hdnTotalQuestions" runat="server" Value="0" />
        <asp:HiddenField ID="hdnUserAnswers" runat="server" Value="" />
        <asp:HiddenField ID="hdnTimeRemaining" runat="server" Value="1200" />
        <asp:HiddenField ID="hdnTestId" runat="server" Value="" />
    </form>

    <script>
        // JavaScript для интерактивности вариантов ответов
        document.addEventListener('DOMContentLoaded', function () {
            const options = document.querySelectorAll('.option-item');

            options.forEach(option => {
                option.addEventListener('click', function () {
                    options.forEach(opt => opt.classList.remove('selected'));
                    this.classList.add('selected');

                    const radio = this.querySelector('.option-radio');
                    if (radio) {
                        radio.checked = true;
                    }
                });
            });

            const radios = document.querySelectorAll('.option-radio');
            radios.forEach(radio => {
                radio.addEventListener('click', function (e) {
                    e.stopPropagation();
                    const optionItem = this.closest('.option-item');
                    options.forEach(opt => opt.classList.remove('selected'));
                    optionItem.classList.add('selected');
                });
            });
        });

        // Обновление прогресса
        function updateProgress(current, total) {
            const progress = (current / total) * 100;
            const progressFill = document.getElementById('progressFill');
            if (progressFill) {
                progressFill.style.width = progress + '%';
            }
        }

        // Таймер обратного отсчета
        function startTimer(duration) {
            let timer = duration, minutes, seconds;
            const timerElement = document.getElementById('timer');
            const timeRemainingField = document.getElementById('hdnTimeRemaining');

            if (!timerElement) return;

            const interval = setInterval(function () {
                minutes = parseInt(timer / 60, 10);
                seconds = parseInt(timer % 60, 10);

                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;

                timerElement.textContent = "⏱️ " + minutes + ":" + seconds;

                if (timeRemainingField) {
                    timeRemainingField.value = timer;
                }

                if (--timer < 0) {
                    clearInterval(interval);
                    timerElement.textContent = "⏱️ Время вышло!";
                    document.getElementById('btnSubmit').click();
                }
            }, 1000);
        }

        window.onload = function () {
            const timeRemainingField = document.getElementById('hdnTimeRemaining');
            const initialTime = timeRemainingField ? parseInt(timeRemainingField.value) : 20 * 60;
            startTimer(initialTime);

            const currentQuestion = document.getElementById('hdnCurrentQuestion').value;
            const totalQuestions = document.getElementById('hdnTotalQuestions').value;
            if (currentQuestion && totalQuestions) {
                updateProgress(parseInt(currentQuestion) + 1, parseInt(totalQuestions));
            }
        };
    </script>
</body>
</html>