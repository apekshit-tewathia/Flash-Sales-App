class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :authorize

  private
    def authorize
      redirect_to login_url, notice: t(:login_for_app_access) unless user_logged_in?
    end
end
