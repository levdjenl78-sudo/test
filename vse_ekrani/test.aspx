<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="test.scrins.test" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Тест</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>ПРОВЕРКА КНОПКИ</h1>
            
            <asp:Label ID="lblResult" runat="server" ForeColor="Red" Font-Size="24px"></asp:Label>
            <br/><br/>
            
            <asp:Button ID="btnTest" runat="server" Text="НАЖМИ МЕНЯ" OnClick="btnTest_Click" />
        </div>
    </form>
</body>
</html>