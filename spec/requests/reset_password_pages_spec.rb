require 'spec_helper'

describe "Reset password page" do
	before {visit reset_password_path}
	subject { page }
		it { should have_selector('h1',    text: 'Reset password') }
		it { should have_selector('title', text: 'Reset password') }

	# describe "signup page" do
	# 	before { visit signup_path }

	# 	it { should have_selector('h1',    text: 'Sign up') }
	# 	it { should have_selector('title', text: 'Sign up') }
	# end

end