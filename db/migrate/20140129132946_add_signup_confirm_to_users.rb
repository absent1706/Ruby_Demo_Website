class AddSignupConfirmToUsers < ActiveRecord::Migration
  def change
    add_column :users, :signup_confirm_token, :string
    add_column :users, :signup_confirm_sent_at, :datetime
    add_column :users, :active, :boolean, default: false
  end
end
