class AddTwitterTweetIdToTweets < ActiveRecord::Migration[5.0]
  def change
    unless column_exists?(:tweets, :twitter_tweet_id)
      add_column :tweets, :twitter_tweet_id, :string
    end
  end
end
