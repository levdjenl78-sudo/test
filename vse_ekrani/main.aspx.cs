using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using test.Database;
using test.Models;

namespace test.scrins
{
    public partial class main : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../vse_ekrani/avtoriz.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadTests();
                LoadUserInfo();
            }
        }

        private void LoadTests()
        {
            var tests = JsonDatabase.GetTests();

            if (tests.Count == 0)
            {
                rptTests.Visible = false;
                lblNoTests.Visible = true;
            }
            else
            {
                rptTests.DataSource = tests;
                rptTests.DataBind();
                rptTests.Visible = true;
                lblNoTests.Visible = false;
            }
        }

        private void LoadUserInfo()
        {
            var user = JsonDatabase.GetUserById((int)Session["UserId"]);
            if (user != null)
            {
                userAvatar.InnerText = user.Avatar;
            }
        }

        protected void rptTests_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "StartTest")
            {
                int testId = int.Parse(e.CommandArgument.ToString());
                Session["CurrentTestId"] = testId;
                Response.Redirect("Ekran3.aspx");
            }
        }

        protected void btnAddTest_Click(object sender, EventArgs e)
        {
            Response.Redirect("ekran2.aspx");
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("../vse_ekrani/profile.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("../vse_ekrani/avtoriz.aspx");
        }
    }
}