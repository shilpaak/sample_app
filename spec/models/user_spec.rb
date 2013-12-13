require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "shilpak", email: "shilpak@tw.com", password: "shilpa", password_confirmation: "shilpa")
  end
  subject { @user }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:password_confirmation) }
  it { should be_valid }
  describe "should not be valid if name is not present." do
    before { @user.name=" " }
    it { should_not be_valid }
  end

  describe "should not be valid if email address is not present" do
    before { @user.email=" " }
    it { should_not be_valid }
  end

  describe "length should not be too large" do
    before { @user.name='a'*51 }
    it { should_not be_valid }
  end

  describe "when email are not in valid format" do
    it "should be invalid" do
      email_addresses=%w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
      email_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end

    end
  end
  describe "when email are in valid format" do
    it "should be invalid" do
      email_addresses=%w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      email_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  describe "when email address already exists." do
    before do
      user_with_same_email_address=@user.dup
      user_with_same_email_address.save

    end
    it { should_not be_valid }
  end
  describe "when password is not present" do
    before {
      @user=User.new(name: "shilpa", email: "sak@tw.com", password: " ", password_confirmation: " ")
    }
    it { should_not be_valid }
  end
  describe "when password doesn't match confirmation password" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  describe "should return value of authenticated methods" do
    before do
      @user.save
    end
    let(:found_user) { User.find_by(email: "shilpak@tw.com") }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end
    describe "with invalid password" do
      it { should_not eq found_user.authenticate("inavalid_password") }
    end
  end
  describe "remember the token" do
      before{@user.save}
      its(:remember_token){should_not be_blank}
  end
end
