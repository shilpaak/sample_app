require 'spec_helper'

describe "UserPages" do
  subject { page }
  describe "Signup Page" do
    before { visit signup_path }
    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }

  end
  describe "Create new account" do
    before{visit signup_path}
    let(:submit){"Create my account"}
    describe "with all blank data" do
      it "should not create user" do
        expect{click_button submit}.not_to change(User,:count)
      end
    end
    describe "with all valid data" do
      before do
        fill_in "Name", with: "shilpa kondawar"
        fill_in "Email",        with: "shilpakondawar@gmail.com"
        fill_in "Password",     with: "shilpa"
        fill_in "Confirmation", with: "shilpa"
      end
      it "should create user" do
        expect{click_button submit}.to change(User,:count).by(1)
      end
    end
  end
  describe "User Profile" do
    let(:user) { FactoryGirl.create(:user) }
    before {
      visit user_path(user)
    }
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
end
