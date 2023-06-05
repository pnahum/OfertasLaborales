class UserMailer < ApplicationMailer
def notification_email
#    @user = params[:user]
#    @url  = 'http://www.vtr.net/login'
#    mail(to: @user.email, subject: 'Aviso de nueva postulacion')
    mail(to: 'esteban.sdfjsdfjdjgdf12124@gmail.com', subject: 'Aviso de nueva postulacion')
  end
end
