using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using PREDJL.Model;
using DevExpress.Web;
using System.Web.UI.WebControls;
using System.Web;
using Microsoft.AspNet.Identity;

namespace PREDJL {
    public partial class Root : MasterPage {
        public bool EnableBackButton { get; set; }
        protected void Page_Load(object sender, EventArgs e) {
            if(!string.IsNullOrEmpty(Page.Header.Title))
                Page.Header.Title += " - ";
            Page.Header.Title = Page.Header.Title + "Tribunal Superior de Cuentas | PREDJL";

            Page.Header.DataBind();
            UpdateUserMenuItemsVisible();
            HideUnusedContent();
            UpdateUserInfo();
        }

        protected void HideUnusedContent()
        {
            //LeftAreaMenu.Items[1].Visible = EnableBackButton;

            bool hasLeftPanelContent = HasContent(LeftPanelContent);
            LeftAreaMenu.Items.FindByName("ToggleLeftPanel").Visible = hasLeftPanelContent;
            LeftPanel.Visible = hasLeftPanelContent;

            bool hasRightPanelContent = HasContent(RightPanelContent);
            ////RightAreaMenu.Items.FindByName("ToggleRightPanel").Visible = hasRightPanelContent;
            RightPanel.Visible = hasRightPanelContent;

            bool hasPageToolbar = HasContent(PageToolbar);
            PageToolbarPanel.Visible = hasPageToolbar;
        }

        protected bool HasContent(Control contentPlaceHolder)
        {
            if (contentPlaceHolder == null) return false;

            ControlCollection childControls = contentPlaceHolder.Controls;
            if (childControls.Count == 0) return false;

            return true;
        }

        // SignIn/Register

        protected void UpdateUserMenuItemsVisible()
        {
            var isAuthenticated = AuthHelper.IsAuthenticated();
            ////RightAreaMenu.Items.FindByName("SignInItem").Visible = !isAuthenticated;
            //RightAreaMenu.Items.FindByName("RegisterItem").Visible = !isAuthenticated;
            //RightAreaMenu.Items.FindByName("MyAccountItem").Visible = isAuthenticated;
            //RightAreaMenu.Items.FindByName("SignOutItem").Visible = isAuthenticated;
        }

        protected void UpdateUserInfo()
        {
            if (AuthHelper.IsAuthenticated())
            {
                var user = AuthHelper.GetLoggedInUserInfo();
                var myAccountItem = RightAreaMenu.Items.FindByName("MyAccountItem");
                var userName = (ASPxLabel)myAccountItem.FindControl("UserNameLabel");
                var email = (ASPxLabel)myAccountItem.FindControl("EmailLabel");
                var accountImage = (HtmlGenericControl)RightAreaMenu.Items[0].FindControl("AccountImage");
                userName.Text = string.Format("{0}", user.UserName.ToUpper());
                email.Text = user.Email;
                accountImage.Attributes["class"] = "account-image";

                if (string.IsNullOrEmpty(user.AvatarUrl))
                {
                    accountImage.InnerHtml = string.Format("{0}", user.UserName[0]).ToUpper();
                }
                else
                {
                    var avatarUrl = (HtmlImage)myAccountItem.FindControl("AvatarUrl");
                    avatarUrl.Attributes["src"] = ResolveUrl(user.AvatarUrl);
                    accountImage.Style["background-image"] = ResolveUrl(user.AvatarUrl);
                }
            }
        }

        protected void RightAreaMenu_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e)
        {
            if (e.Item.Name == "SignOutItem")
            {
                AuthHelper.SignOut(); // DXCOMMENT: Your Signing out logic
                Response.Redirect("~/Account/Login.aspx");
            }
        }

        protected void ApplicationMenu_ItemDataBound(object source, MenuItemEventArgs e)
        {
            e.Item.Image.Url = string.Format("Content/Images/{0}.svg", e.Item.Text);
            e.Item.Image.UrlSelected = string.Format("Content/Images/{0}-white.svg", e.Item.Text);
        }

        protected void HeadLoginStatus_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);

        }
    }
}