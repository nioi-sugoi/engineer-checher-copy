class TweetsController < ApplicationController
  def destroy
    # 削除したツイートをsessionの中から削除
    fucking_tweets = session[:fucking_tweets]
    fucking_tweets.reject! { |f| f[:tweet] == params[:id].to_i }
    session[:fucking_tweets] = fucking_tweets
    # ツイート削除
    twitter_client.destroy_status(params[:id])
    @deleted_tweet_id = params[:id]
  end
end
