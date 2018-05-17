class ContactMailer < ApplicationMailer
  default from: Rails.application.secrets.mail_user

  def send_contact_formular(message)
    @contact_mail = message["mail"]
    @message_content = message["content"]
    mail(to: Rails.application.secrets.dest_mail_user, subject: "Message from "+@contact_mail.to_s, reply_to: @contact_mail)
  end
  
end
