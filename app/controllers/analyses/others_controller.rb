class Analyses::OthersController < ApplicationController

  def create
    # Twitterのメンションに含まれる特殊文字を削除(コピペへの対応)
    screen_name = Addressable::URI.encode(params[:screen_name]).gsub(/%E3%80%80|%E2%81%A6|%E2%80%AA|%E2%80%AC|%E2%81%A9|%20/, '')
    @user = development_client.user(screen_name)
    session[:user] = @user
    redirect_to analyses_other_path(@user.id)
  end

  def show
    @user = session[:user]
    @tweets = development_client.user_timeline(params[:id].to_i, :count => 200, :tweet_mode => 'extended')
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

  private

  def development_client
    @development_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.credentials.twitter[:consumer_key]
      config.consumer_secret = Rails.application.credentials.twitter[:consumer_secret]
      config.access_token = Rails.application.credentials.twitter[:access_token]
      config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
    end
  end
end
