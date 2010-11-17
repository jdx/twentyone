class TwilioController < ApplicationController
  def sms
    unless request.post?
    end
    logger.info params.inspect
  end
end
