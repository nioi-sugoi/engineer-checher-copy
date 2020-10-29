class FollowsController < ApplicationController
  def destroy
    twitter_client.unfollow(params[:id].to_i)
    # リムーブしたアカウントのIDをセッションのフォローリストから削除
    session[:follow_ids].reject! {|id| id == params[:id].to_i}
  end
end
