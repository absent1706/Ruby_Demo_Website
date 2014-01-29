class UserMailer < ActionMailer::Base
  default from: "testpupkin577@gmail.com"

  def reset_password(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end

  def confirm_signup(user)
    @user = user
    mail :to => user.email, :subject => "Confirm registration"
  end
end
