class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    session[:twitter] = {}
    session[:twitter][:consumer_key] = auth.extra.access_token.consumer.key
    session[:twitter][:consumer_secret] = auth.extra.access_token.consumer.secret
    session[:twitter][:access_token] = auth.extra.access_token.token
    session[:twitter][:access_token_secret] = auth.extra.access_token.secret
    # 「自分を診断」と「ランダム診断」で認証を共通化
    if params[:myself_or_random] == 'myself'
      redirect_to analyses_myself_path
    elsif params[:myself_or_random] == 'random'
      redirect_to new_analyses_random_path
    end
  end

  def failure
    redirect_to root_url
  end
end

