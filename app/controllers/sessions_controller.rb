class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:create, :new]
  
  def new
    @user = User.new
    if user_logged_in?
      redirect_to deals_url(status: 'live'), notice: 'Logout to login as other user'
    end
  end

  def create
    user = User.find_by(email: permitted_params[:email])
    cookie_expiration = FlashSales::User::COOKIE_EXPIRATION_DURATION.from_now if permitted_params[:remember_me] == '1'

    if user.try(:authenticate, permitted_params[:password])
      if user.verified_at.present?
        cookies.encrypted[:user_id] = {
          value: user.id,
          expires: cookie_expiration
        }
        redirect_to deals_path(status: 'live'), notice: t(:successfull, resource_name: 'login')
      else
        redirect_to login_url, notice: t(:verify_email)
      end
    else
      redirect_to login_url, notice: t(:invalid, resource_name: 'credentials')
    end
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to login_url, notice: t(:successfull, resource_name: 'logout')
  end

  private
    def permitted_params
      params.require(:user).permit(:email, :password, :remember_me)
    end
end
