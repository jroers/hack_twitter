class TweetsController < ApplicationController

  def index

  end

  def show
    tweet_id = params[:id]

    @tweet = Tweet.find_by_id(tweet_id)

    render :show
  end


end
