require 'spec_helper'

describe "AuthentiacationPages" do
  subject{page}
  describe "SignIn page" do
    before do
      visit signin_path
    end
    describe "with invalid information" do
      before do
        click_button "Sign in"
      end
      it{should have_content("Sign In")}
      it{should have_title("Sign In")}
      it{should have_selector('div.alert.alert-error',text:"Invalid")}
    end
    describe "with valid sign in information" do
      let(:user){FactoryGirl.create(:user)}
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with:user.password
        click_button "Sign in"
      end
      it{should have_title(user.name)}
      it{should have_link("Profile",href:user_path(user))}
      it{should have_link("Sign out",href:signout_path)}
      #it{should have_link("Sign In",href:signin_path)}
    end

  end
end
