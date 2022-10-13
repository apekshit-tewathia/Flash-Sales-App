class ApplicationMailer < ActionMailer::Base
  default from: FlashSales::Mailer::DEFAULT_EMAIL
  layout "mailer"
end
