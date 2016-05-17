IVI::Application.routes.draw do

  root :to => 'home#index'
  use_doorkeeper
  mount Users::UsersController => '/api'
  mount Events::EventsController => '/api'
  mount Comments::CommentsController => '/api'
end
