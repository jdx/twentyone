class TwilioController < ApplicationController
  :skip_before_filter :require_login :sms
  def sms
    unless request.post?
      return render :nothing => true, :status => 404
    end
    logger.info params.inspect
    return render :nothing => true
  end
end
