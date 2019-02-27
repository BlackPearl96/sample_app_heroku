class UserMailerPreview < ActionMailer::Preview
  def account_activation
    UserMailer.account_activation
  end

  def password_reset
    UserMailer.password_reset
  end
end
