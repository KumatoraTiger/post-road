class MapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_twitter_client

  def new
    tweets = @twitter_client.user_timeline(count: 1000)
    geo_tweets = only_geo_tweets(tweets)

    @tweets = to_hash(geo_tweets)
  end

  def create
    tweet_ids = params["tweet"].keys.to_json
    map = Map.create(tweet_ids:tweet_ids)
    redirect_to edit_map_path(map)
  end

  def edit
    @map = Map.find(params["id"])
    tweet_ids = JSON.parse(@map.tweet_ids)

    tweets = @twitter_client.user_timeline(count:1000)
    geo_tweets = only_geo_tweets(tweets)
    matched_tweets = []
    geo_tweets.each do |tweet|
      matched_tweets.push(tweet) if tweet_ids.include?(tweet.id.to_s)
    end
    @tweets = to_hash(matched_tweets)
  end

  def update
    if params["update"] == "保存"
      map = Map.find(params["id"])
      map.update_attributes(map_params)
    end
    redirect_to new_map_url
  end

  private

  def map_params
    params.require(:map).permit(:name)
  end

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
      if oembed_html = get_oembed_html(tweet)
        array.push({id: tweet.id, geo: create_geo(tweet), oembed_html: oembed_html})
      end
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
    begin
      return @twitter_client.oembed(id, :hide_media => true, :align => "center").html
    rescue => e
      return nil
    end
  end
end
