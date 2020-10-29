class FollowerAnalyzeService
  include Service

  def initialize(user)
    @user = user
  end

  def call
    follow = @user.friends_count
    follower = @user.followers_count
    f_count = case follower
              when 0..100
                1
              when 101..300
                1.5
              when 301..500
                2
              when 501..1000
                2.5
              when 1001..3000
                3
              when 3001..5000
                3.5
              when 5001..10000
                4
              when 10001..20000
                4.5
              else
                5
              end
    f_ratio = if follow == 0
                if follower > 10
                  2
                else
                  1
                end
              elsif follower / follow.to_f >= 2
                2
              else
                follower / follow.to_f
              end
    follower_point = (f_count * f_ratio).round
    follower_point = 1 if follower_point < 1
    follower_point
  end
end
