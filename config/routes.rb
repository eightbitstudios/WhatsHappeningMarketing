Rails.application.routes.draw do

  root 'marketing#index'

  get 'view', to: 'happenings#show'

end