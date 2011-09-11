require 'mini_fb'

class SergeantShameController < ApplicationController
  @@FB_APP_ID = '138843786134894'
  @@FB_APP_SECRET = 'a6f20701d3ca3ee9655bb5fb51103ea4'

  def welcome
    @fb_app_id = @@FB_APP_ID
  end

  def logged_in    
    @access_token = params["access_token"]
    session[:access_token] = params["access_token"]
    search = User.where(:fb_access_token => params["access_token"])
    if search.empty?
      user = User.create(:fb_access_token => params["access_token"])
      session[:user_id] = user.id
      redirect_to "/tasks/new/"
    else
      user = search.first
      session[:user_id] = user.id
      redirect_to "/tasks/"
    end
  end

end
