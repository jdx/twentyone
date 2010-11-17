class NotificationsController < ApplicationController
  skip_before_filter :require_login, :only => :send

  def send
    unless request.post?
      return render :nothing => true, :status => 404
    end
    logger.info 'Sending notifications...'
    render :text => 'Sent notifications.', :content_type => 'text/plain'
  end
end
