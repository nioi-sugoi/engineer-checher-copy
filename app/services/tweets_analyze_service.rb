class TweetsAnalyzeService
  include Service

  def initialize(user, tweets, analysis)
    @user = user
    @tweets = tweets
    @analysis = analysis
  end

  def call
    all_tweets_count = @user.statuses_count
    # フォロワーポイントの算出
    follower_point = FollowerAnalyzeService.call(@user)
    # プロフィール画像のURL
    image_url = @user.profile_image_url_https.to_s.sub(/_normal/, '')
    # Rekognitionで画像解析
    rekognition = ImageAnalyzeService.call(image_url)
    # 診断
    result = UserJudgeService.call(all_tweets_count, @tweets, follower_point, @analysis, rekognition)

    result
  end
end
