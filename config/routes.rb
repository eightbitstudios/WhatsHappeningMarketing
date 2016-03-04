Rails.application.routes.draw do

  root 'marketing#index'
  get 'app', to: 'marketing#app'

  get 'view', to: 'happenings#show'

  namespace :legal do
    get 'terms'
    get 'privacy'
  end

end