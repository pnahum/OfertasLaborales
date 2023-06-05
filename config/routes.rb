Rails.application.routes.draw do
#  devise_scope :user do
#	get 'user/show' => 'devise/registrations#show'
#  end
#  devise_for :users,
#    controllers: {
#      registrations: 'devise/registrations'
#    }
  devise_for :users
  resources :offers
  get 'user/show' => 'user#show'	# Para que los usuarios puedan visualizar sus registros
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "offers#welcome"
end
