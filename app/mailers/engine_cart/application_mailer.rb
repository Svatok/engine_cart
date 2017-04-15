module EngineCart
  class ApplicationMailer < ActionMailer::Base
    default from: EngineCart.email_order.to_s
    layout 'mailer'
  end
end
