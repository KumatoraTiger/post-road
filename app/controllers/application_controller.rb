class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_request_devise

  private

  def twitter_client
    credentials = session["twitter_credentials"]
    redirect_to root_url, flash: {alert: "ログインしてください。"} and return unless credentials
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET"]
      config.access_token        = credentials["token"]
      config.access_token_secret = credentials["secret"]
    end
  end

  protected

  def after_sign_in_path_for(resource)
    new_map_url
  end

  def set_request_devise
    @request_devise = request.from_smartphone? ? 'smartphone' : 'pc'

    if request.env["HTTP_USER_AGENT"].include?('Googlebot') \
      && request.env["HTTP_USER_AGENT"].include?('Android')
      @request_devise = 'smartphone'
    end
    if request.env["HTTP_USER_AGENT"].include?('AdsBot-Google-Mobile')
      @request_devise = 'smartphone'
    end
  end

end
