Rails.application.routes.draw do
  root :to => 'static_pages#top'
  get '/help' => 'static_pages#help'
  get '/terms' => 'static_pages#terms'
  get '/privacy' => 'static_pages#privacy'
  get '/inquiry' => 'static_pages#inquiry'
  get '/auth/twitter/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'

  concern :influ_tweets do
    get 'influ_tweets', on: :member
  end

  namespace :analyses do
    resource :myself, :only => %i[show] do
      get 'influ_tweets', on: :collection
    end
    resources :others, :only => %i[create show], concerns: :influ_tweets 
    resources :randoms, :only => %i[new show], concerns: :influ_tweets
  end
  resources :follows, :only => %i[destroy]
  resources :tweets, :only => %i[destroy]
  get '*path', to: 'application#render_404' if Rails.env.production?
end
