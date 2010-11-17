class TwilioController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :verify_authenticity_token

  def sms
    unless request.post?
      return render :nothing => true, :status => 404
    end
    body = params[:Body].upcase.strip
    user ||= User.find_by_phone_number(params[:From])
    if user
      if body == 'STOP'
        logger.info "Received STOP sms from user: \"#{ user }\"."
      elsif body == 'DONE'
        logger.info "Received DONE sms from user: \"#{ user }\"."
      else
        logger.info "Received unknown sms from user: \"#{ user }\" saying \"#{ body }\"."
      end
    else
      logger.info "Received text from unknown phone number: \"#{ params[:From] }\" saying: \"#{ body }\""
    end
    return render :nothing => true
  end

end
