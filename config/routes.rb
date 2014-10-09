Rails.application.routes.draw do

  get  '/', to: 'cart#index'
  post '/bill', to: 'cart#bill'

  root 'cart#index'

end
