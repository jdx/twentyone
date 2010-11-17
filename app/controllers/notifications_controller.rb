class NotificationsController < ApplicationController
  def send
    logger.info 'Sending notifications...'
    render :text => 'sending notifications', :content_type => 'text/plain'
  end
end
