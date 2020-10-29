class ApplicationController < ActionController::Base
  if Rails.env.production?
    rescue_from ActionController::RoutingError, with: :render_404 
    rescue_from Exception, :with => :render_500
  end
  rescue_from Twitter::Error::TooManyRequests, :with => :too_many_requests
  rescue_from Twitter::Error::NotFound, :with => :not_found
  rescue_from Twitter::Error::Unauthorized, :with => :unauthorized
  rescue_from Twitter::Error::Forbidden, :with => :forbidden

  def render_404
    render :template => 'errors/error_404', :status => 404
  end

  def render_500(e)
    ExceptionNotifier.notify_exception(e, :env => request.env, :data => { :message => "error" })
    render :template => 'errors/error_500', :status => 500
  end

  def too_many_requests
    @screen_name = params[:screen_name]
    notifier = Slack::Notifier.new('https://hooks.slack.com/services/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') 
    notifier.ping('API制限に達しました')
    flash.now[:danger] = "アクセス過多でデータを取得できません\n最大15分待ってから再度試して下さい"
    render 'static_pages/top'
  end

  def not_found
    @screen_name = params[:screen_name]
    flash.now[:danger] = '⚠️ 該当のツイッターIDが存在しません'
    render 'static_pages/top'
  end

  def unauthorized
    @screen_name = params[:screen_name]
    flash.now[:danger] = "⚠️ 非公開アカウントは分析できません\n「自分を診断」から認証を行なって下さい"
    render 'static_pages/top'
  end
  
  def forbidden
    @screen_name = params[:screen_name]
    flash.now[:danger] = '⚠️ アカウントが凍結されています'
    render 'static_pages/top'
  end

  private

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = session[:twitter][:consumer_key]
      config.consumer_secret = session[:twitter][:consumer_secret]
      config.access_token = session[:twitter][:access_token]
      config.access_token_secret = session[:twitter][:access_token_secret]
    end
  end
end
