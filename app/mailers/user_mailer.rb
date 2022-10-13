class UserMailer < ApplicationMailer
  def verify_email(user)
    @user = user
    mail to: user.email, subject: 'Email Verifiaction'
  end

  def verify_email_for_forgot_password(user)
    @user = user
    mail to: user.email, subject: 'Email verification for forgot password'
  end
end
