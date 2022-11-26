class Customers::PasswordsController < Devise::PasswordsController
  before_action :ensure_normal_customer, only: :create

  def ensure_normal_customer
    if params[:user][:email].downcase == 'guest@example.com'
      redirect_to new_customer_session_path, alert: 'ゲストユーザーのパスワード再設定はできません。'
    end
  end
end