Tc2011::Application.routes.draw do
  #######################################################################
  # The Home page
  #######################################################################
  root :controller => "sergeant_shame", :action => "welcome"

  #######################################################################
  # Resources
  #######################################################################
  resources :users
  resources :check_ins
  resources :tasks
  
  #######################################################################
  # Sergeant Shame Application
  #######################################################################
  get 'sergeant_shame/welcome'
  get 'sergeant_shame/logged_in'
end
