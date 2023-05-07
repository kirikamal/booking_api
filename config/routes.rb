Rails.application.routes.draw do
  post '/reservations', to: 'reservations#create'
end
