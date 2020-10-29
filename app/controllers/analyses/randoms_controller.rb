class Analyses::RandomsController < ApplicationController
  # ランダム診断の初回のアクション
  def new
    # ユーザーがフォローしてるアカウントのIDを取得
    follow_list = twitter_client.friend_ids.to_h
    random_id = follow_list[:ids].sample
    # 再度ランダム診断する際にもう一度APIを叩かなくていいようにsessionに格納
    session[:follow_ids] = follow_list[:ids]
    if random_id
      redirect_to analyses_random_path(random_id)
    else
      flash[:danger] = '⚠️ フォローしてるアカウントがありません'
      redirect_to root_path
    end
  end

  def show
    unless session[:follow_ids].empty?
      @random_id = params[:id].to_i
      @user = twitter_client.user(@random_id)
      @tweets = twitter_client.user_timeline(@random_id, :count => 200, :tweet_mode => 'extended')
      # ツイート等の分析
      analysis = UserAnalyzeService.call(@user, @tweets)
      @result = TweetsAnalyzeService.call(@user, @tweets, analysis)
      # シェアツイート作成（メンション有り）
      name = @user.name
      @screen_name = @user.screen_name
      @share_tweet = TweetShareService.call(name, @result, @screen_name)
      # インフルツイート一覧のためにsessionに格納
      session[:fucking_tweets] = analysis[:fucking_tweets]
      session[:screen_name] = @screen_name
      session[:name] = name
      session[:protected?] = @user.protected?
    else
      # フォロー解除によってフォロー0人になった場合の処理
      flash[:danger] = '⚠️ フォローしてるアカウントがありません'
      redirect_to root_path
    end
  end

  def influ_tweets
    @screen_name = session[:screen_name]
    fucking_tweets = session[:fucking_tweets]
    @name = session[:name]
    @tweets = Kaminari.paginate_array(fucking_tweets, :total_count => fucking_tweets.length).page(params[:page]).per(5)
  end

end
