Rails.application.routes.draw do

  # user routes
  get '/pics', to: 'pics#index'
  get '/pics', to: 'pics#show'
  post '/pics', to: 'pics#create'
  put '/pics/:id', to: 'pics#update'
  delete '/pics/:id', to: 'pics#delete'

end
