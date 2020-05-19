class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reminder_email.subject
  #
  def reminder_email
    @user = User.find(params[:user_id])
    mail(to: @user.email, subject: "REMINDER: Interview in 30 Minutes")
  end
end
