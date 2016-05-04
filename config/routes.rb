IVI::Application.routes.draw do

  root :to => 'home#index'
  use_doorkeeper
  mount Users::UsersController => '/api'
  mount Events::EventsController => '/api/events'
  mount Comments::CommentsController => '/api/comments'

end
