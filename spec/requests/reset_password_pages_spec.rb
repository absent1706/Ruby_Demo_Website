require 'spec_helper'

shared_examples "coolable" do |target_name|
  it "should make #{ target_name } cool" do
    target.make_cool
    target.should be_cool
  end
end

describe "New reset password page" do
  before {visit reset_password_path}
  subject { page }
  it { should have_selector('h1',    text: 'Reset password') }
  it { should have_selector('title', text: 'Reset password') }

  describe "with invalid email" do
    before {click_button "Reset password"}
    it { should have_selector('div', text: "There's no user with such email") }
    it "doesn't send any e-mail" do
      last_email.should be_nil
    end
  end

  describe "with existing email" do
    let!(:u) { FactoryGirl.create(:user) }
    before do
      fill_in "Email", with: u.email
      click_button "Reset password"
    end

	let(:user) { u.reload }

	specify {user.reset_password_token.should_not be_nil}
    it { should have_content('Email sent') }

    it "should redirect to root_path" do
      current_path.should == root_path
    end

    it "should dispatch email to the user" do
      expect(last_email).to have_content(user.email)
    end



    describe "setting new password" do
	  def fill_and_click
          fill_in "Password", :with => "foobar"
          fill_in "Password confirmation", :with => "foobar"
          click_button "Update Password"	  	
	  end

      before {visit edit_new_password_path(user.reset_password_token)}
	  it {should have_content("Reset Password")}      

      context "it updates password when input is correct" do
        before {fill_and_click}
        it {should have_content("Password has been reset")}
      end

       context "it doesn't update password when token has expired" do
        before do
  	      user.update_attribute(:reset_password_sent_at, 5.hours.ago)
  	      visit edit_new_password_path(user.reload.reset_password_token)
  	      fill_and_click
        end
        it {should have_content("Password reset has expired")}
      end
    end


  end
end
