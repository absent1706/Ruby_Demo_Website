require 'spec_helper'

describe "New reset password page" do
  before {visit reset_password_path}
  subject { page }
  it { should have_selector('h1',    text: 'Reset password') }
  it { should have_selector('title', text: 'Reset password') }

  describe "with invalid email" do
    before {click_button "Reset password"}
    it { should have_selector('div', text: "There's no user with such email") }
  end

  describe "with existing email" do
    let!(:user) { FactoryGirl.create(:user) }
    before do
      fill_in "Email", with: user.email
      click_button "Reset password"
    end

    it { should have_content('Email sent') }

    it "should redirect to root_path" do
      current_path.should == root_path
    end

    it "should dispatch email to the user" do
      expect(last_email).to have_content(user.email)
    end

  end
end
