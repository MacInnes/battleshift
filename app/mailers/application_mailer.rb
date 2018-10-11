class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@battleshift.com'
  layout 'mailer'
end
