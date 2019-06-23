Rails.application.routes.draw do
  get '/pics', to: 'pics#index'
  get '/pics/:id', to: 'pics#show'
  post '/pics', to: 'pics#create'
  delete '/pics/:id', to: 'pics#delete'
  put '/pics/:id', to: 'pics#update'
end
