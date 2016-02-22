Rails.application.routes.draw do

  root 'marketing#index'

  get 'happenings/:happening_key', to: 'happenings#show'

end