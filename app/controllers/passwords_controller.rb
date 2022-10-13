class PasswordsController < ApplicationController
  skip_before_action :authorize

  def new
    @user = User.new
  end

  def forgot_password_verify_email
    @user = User.find_by(email: permitted_params[:email])
    render 'email_confirmation'
    UserMailer.verify_email_for_forgot_password(@user).deliver_now
  end

  def edit
    @user = User.find_by(verification_token: params[:token])
  end

  def update
    user = User.find_by(verification_token: params[:verification_token])
    if user.present?
      user.update!(permitted_params)
      redirect_to deals_url
    else
      redirect_to user_email_url, notice: t(:not_exist, resource_name: 'User')
    end
  end

  private

    def permitted_params
      params.require(:user).permit(:email, :user_id, :password, :password_confirmation)
    end
end
