class ActionsController < ApplicationController
  def search_twitter_user
    handle = params[:twitter_user][:handle].gsub(' ', '')
    handle = handle[0] == '@' ? handle : "@#{handle}"

    @twitter_user = TwitterUser.where('handle = ?', handle).first
    if @twitter_user.blank?
      @message = "Entered new twitter user"
      @twitter_user = TwitterUser.create(:handle => handle)
    else
      @message = "Found existing twitter user"
    end

    respond_to do |format|
      format.js { render 'twitter_user_response' }
    end
  end

  def fetch_tweets

  end
end
