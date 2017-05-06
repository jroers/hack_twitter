class ActionsController < ApplicationController
  def search_twitter_user
    handle = params[:twitter_user][:handle].gsub(' ', '').gsub('@', '')

    @twitter_user = TwitterUser.where('handle = ?', handle).first
    if @twitter_user.blank?
      @message = "Entered new twitter user"
      @twitter_user = TwitterUser.create(:handle => handle)
    else
      @message = "Found existing twitter user"
    end
    fetch_tweets(@twitter_user)

    respond_to do |format|
      format.js { render 'twitter_user_response' }
    end
  end

  private

  def fetch_tweets(twitter_user)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
      config.access_token        = Rails.application.secrets.twitter_access_token
      config.access_token_secret = Rails.application.secrets.twitter_access_token_secret
    end

    recs = client.user_timeline("#{twitter_user.handle}")

    recs.each do |rec|
      if Tweet.where('twitter_tweet_id = ?', rec.id.to_s).first.blank?
        t = Tweet.new()
        t.body = rec.text
        t.twitter_tweet_id = rec.id
        t.twitter_user_id = twitter_user.id
        t.posted_at = rec.created_at
        t.save!
      end
    end
  end
end
