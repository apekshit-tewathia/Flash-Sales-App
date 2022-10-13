class RegistrationController < ApplicationController
  skip_before_action :authorize
  
  def new
    @user = User.new
  end

  def create
    user = User.new(permitted_params)

    if user.save
      redirect_to login_url, notice: t(:verify_email)
    else
      redirect_to sign_up_url, notice: t(:default_error_message)
    end
  end

  private
  def permitted_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :verification_token, :id)
  end 
end
