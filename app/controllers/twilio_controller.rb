class TwilioController < ApplicationController
  def sms
    unless request.post?
      render_404
    end
    logger.info params.inspect
  end
end
