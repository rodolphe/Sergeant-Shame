Tc2011::Application.routes.draw do
  root :to => "tasks#new"
  resources :check_ins
  resources :tasks
end
