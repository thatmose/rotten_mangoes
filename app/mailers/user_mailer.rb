class UserMailer < ApplicationMailer
  default from: 'notifications@rottenmangoes.com'

  def goodbye_email(user)
    @user = user
    @url = "www.rottenmangoes.com/users/new"
    mail(to: @user.email, subject: "Account closure")
  end

end
