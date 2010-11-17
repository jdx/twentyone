class NotificationsController < ApplicationController
  skip_before_filter :require_login, :only => :send_all

  def send_all
    unless request.post?
      return render :nothing => true, :status => 404
    end
    logger.info 'Sending notifications...'
    return render :text => 'Sent notifications.', :content_type => 'text/plain'
  end
end
