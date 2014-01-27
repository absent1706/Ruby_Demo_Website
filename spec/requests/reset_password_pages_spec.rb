require 'spec_helper'

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
    let!(:user) { FactoryGirl.create(:user) }
    before do
      user.save!
      fill_in "Email", with: user.email
      click_button "Reset password"
    end

	let (:user_reloaded) {user.reload}
    specify {user_reloaded.reset_password_token.should_not be_nil}
    it { should have_content('Email sent') }

    it "should redirect to root_path" do
      current_path.should == root_path
    end

    it "should dispatch email to the user" do
      expect(last_email).to have_content(user.email)
    end



    describe "setting new password" do

      before {visit edit_new_password_path(user_reloaded.reset_password_token)}
	  it {should have_content("Reset Password")}      

      context "it updates the user password when confirmation matches" do
        #user.save!
        before do
          fill_in "Password", :with => "foobar"
          fill_in "Password confirmation", :with => "foobar"
          click_button "Update Password"
        end

        it {should have_content("Password has been reset")}
      end
    end


  end
end
