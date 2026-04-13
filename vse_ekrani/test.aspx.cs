using System;
using System.Web.UI;

namespace test.scrins
{
    public partial class test : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblResult.Text = "Страница загружена!";
            }
        }

        protected void btnTest_Click(object sender, EventArgs e)
        {
            lblResult.Text = "✅ КНОПКА РАБОТАЕТ! " + DateTime.Now.ToString();
        }
    }
}