class TweetShareService
  include Service
  
  def initialize(name, result, screen_name = nil)
    @result = result
    @name = name
    @screen_name = screen_name
  end

  def call
    if @screen_name
      text = "text=#{@name.truncate(15)}さん(@#{@screen_name})"
    else
      text = "text=#{@name.truncate(18)}さん"
    end
    share_tweet = URI.encode(
      "https://twitter.com/intent/tweet?" + 
      text + "は…\n\n【#{@result[:judgement].gsub(/\n/, '')}】です！\n\n#{@result[:comments][rand(3)]}\n\n#{@result[:label][:follower].gsub(/フォロワー/, 'フォロー')} #{@result[:points][:follower]}\n#{@result[:label][:beginner]} #{@result[:points][:beginner]}\n#{@result[:label][:design]} #{@result[:points][:design]}\n#{@result[:label][:development]} #{@result[:points][:development]}\n#{@result[:label][:strong]} #{@result[:points][:strong]}\n#{@result[:label][:influencer]} #{@result[:points][:influencer]}\n#エンジニアチェッカー\n" +
      "&url=https://engineer-checker.com/"
    )
    share_tweet
  end
end
