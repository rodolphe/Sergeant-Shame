Tc2011::Application.routes.draw do
  root :controller => 'tasks', :action => 'new'
  resources :check_ins
  resources :tasks
end
