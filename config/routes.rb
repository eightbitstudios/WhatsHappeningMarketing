Rails.application.routes.draw do

  root 'marketing#index'

  get 'view', to: 'happenings#show'

  namespace :legal do
    get 'terms'
    get 'privacy'
  end

end