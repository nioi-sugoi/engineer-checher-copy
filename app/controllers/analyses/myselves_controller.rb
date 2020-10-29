module Analyses
  class MyselvesController < ApplicationController
    def show
      @user = twitter_client.user
      @tweets = twitter_client.user_timeline(:count => 200, :tweet_mode => 'extended')
      # ツイート等の分析
      analysis = UserAnalyzeService.call(@user, @tweets)
      @result = TweetsAnalyzeService.call(@user, @tweets, analysis)
      # シェアツイート作成
      name = @user.name
      @screen_name = @user.screen_name
      @share_tweet = TweetShareService.call(name, @result)
      # インフルツイート一覧のためにsessionに格納
      session[:fucking_tweets] = analysis[:fucking_tweets]
      session[:screen_name] = @screen_name
      session[:name] = name
      session[:protected?] = @user.protected?
    end

    def influ_tweets
      @screen_name = session[:screen_name]
      fucking_tweets = session[:fucking_tweets]
      @name = session[:name]
      @tweets = Kaminari.paginate_array(fucking_tweets, :total_count => fucking_tweets.length).page(params[:page]).per(5)
    end
  end
end
