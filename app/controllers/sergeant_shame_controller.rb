require 'mini_fb'

class SergeantShameController < ApplicationController
  @@FB_APP_ID = '138843786134894'
  @@FB_APP_SECRET = 'a6f20701d3ca3ee9655bb5fb51103ea4'

  def welcome
    @fb_app_id = @@FB_APP_ID
  end

  def logged_in    
    @access_token = params["access_token"]
  end

end
