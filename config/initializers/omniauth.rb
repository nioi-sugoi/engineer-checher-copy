Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.credentials.twitter[:consumer_key], Rails.application.credentials.twitter[:consumer_secret]
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
