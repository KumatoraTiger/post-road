class MapsController < ApplicationController
  before_action :set_twitter_client

  def new
    tweets = twitter_client.user_timeline(count: 1000)
    @tweets = only_geo_tweets(tweets)
    # longtitude, latitude = 0, 0
    # @tweets[0].place.bounding_box.coordinates[0].each do |item|
    #   longtitude += item[0]
    #   latitude += item[1]
    # end
    # binding.pry
  end

  def create

  end

  private

  def set_twitter_client
    @twitter_client ||= twitter_client
  end

  def only_geo_tweets(tweets)
    return tweets.select do |tweet|
      tweet.geo.to_s.present? || tweet.place.present?
    end
  end
end
