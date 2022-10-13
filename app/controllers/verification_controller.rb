class VerificationController < ApplicationController
  skip_before_action :authorize, only: :verify
  
  def verify
    user = User.find_by(verification_token: params[:verification_token])
    if user.present?
      user.update!(verified_at: Time.current)
      redirect_to login_url, notice: t(:successfull, resource_name: 'verification, ') + t(:login_for_app_access)
    end
  end
end
