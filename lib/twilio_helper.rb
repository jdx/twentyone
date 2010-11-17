require 'twiliolib'

API_VERSION = '2010-04-01'
ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
ACCOUNT_TOKEN = ENV['TWILIO_ACCOUNT_TOKEN']
PHONE_NUMBER = ENV['TWILIO_PHONE_NUMBER']

module TwilioHelper
  def TwilioHelper.send_sms(to, body)
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    data = {
      'From' => PHONE_NUMBER,
      'To' => to,
      'Body' => body
    }
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", "POST", data)
    resp.error! unless resp.kind_of? Net::HTTPSuccess
  end
end
