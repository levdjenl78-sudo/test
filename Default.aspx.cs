using System;
using System.Web.UI;

namespace test
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("vse_ekrani/avtoriz.aspx");
        }
    }
}