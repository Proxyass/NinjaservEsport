class StaticsController < ApplicationController

  def about_us
    @full_banner = 'ninja-banner.png'
  end

  def show_contact
  end

  def contact
    if ContactMailer.send_contact_formular(message_params).deliver_now
      flash[:success] = "Message sent successfully."
    end
    redirect_to contact_path
  end

  def message_params
    params.permit(:mail, :content)
  end

end
