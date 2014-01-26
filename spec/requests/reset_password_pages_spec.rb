require 'spec_helper'

describe "Reset password page" do
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

	 	it { should have_selector('div', text: 'Email sent') }
	 end

end