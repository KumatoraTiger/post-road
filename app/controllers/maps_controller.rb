class MapsController < ApplicationController
  before_action :set_twitter_client

  def new
    tweets = twitter_client.user_timeline(count: 1000)
    geo_tweets = only_geo_tweets(tweets)

    @tweets = to_hash(geo_tweets)
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

  # { geo: {lat: , lng: }, oembed_html: }
  def to_hash(tweets)
    array = []
    tweets.each do |tweet|
      array.push({geo: create_geo(tweet), oembed_html: get_oembed_html(tweet)})
    end
    return array
  end

  def create_geo(tweet)
    if tweet.geo.present?
      geo_array = tweet.geo.coordinates
      geo = { lat: geo_array[0], lng: geo_array[1] }
      return geo
    end

    longtitude, latitude = 0, 0
    tweet.place.bounding_box.coordinates[0].each do |item|
      longtitude += item[0]
      latitude += item[1]
    end
    longtitude = longtitude/4
    latitude = latitude/4
    return geo = {lat:latitude, lng:longtitude}
  end

  def get_oembed_html(tweet)
    id = @twitter_client.status(tweet.id).id
    return @twitter_client.oembed(id).html
  end
end
