class UserMailer < ApplicationMailer

  def reminder_email
    @user = User.find(params[:user_id])
    mail(to: @user.email, subject: "REMINDER: Interview in 30 Minutes")
  end

  def updation_email
    @user = User.find(params[:user_id])
    mail(to: @user.email, subject: "Your interview has been rescheduled.")
  end

end
