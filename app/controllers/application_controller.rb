class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include ApplicationHelper
  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end
