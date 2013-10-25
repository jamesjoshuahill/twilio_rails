class SendTextController < ApplicationController

  def new
  end
 
  def send_text_message
    number_to_send_to = params[:text][:number_to_send_to]
    message_body = params[:text][:message]
 
    twilio_sid = Rails.configuration.twilio[:sid]
    twilio_token = Rails.configuration.twilio[:token]
    twilio_phone_number = Rails.configuration.twilio[:phone_number]
 
    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)
 
    @twilio_client.account.sms.messages.create(
      :from => twilio_phone_number,
      :to => number_to_send_to,
      :body => message_body
    )

    flash[:notice] = 'Your text message was sent'
    redirect_to root_path
  end

end
