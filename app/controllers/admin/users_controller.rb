class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(permitted_params)
    user.verified_at = Time.current
    if user.save
      redirect_to admin_users_url, notice: t(:successfull, resource_name: 'created user')
    else
      redirect_to new_admin_user_url, notice: t(:default_error_message)
    end
  end

  private 

    def permitted_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :verification_token, :id)
    end
end
