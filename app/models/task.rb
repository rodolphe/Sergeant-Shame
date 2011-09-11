class Task < ActiveRecord::Base
  has_many :check_ins
  belongs_to :user

  def count_checkins
    access_token = user.fb_access_token
    set_of_place_ids = Set.new([place_id.to_s])
    times_checkedin = 0
    time_length = 1.send(period)
    checkins = MiniFB.get(access_token, 'me/checkins')
    checkins['data'].each do |checkin|
      if Time.now - Time.parse(checkin['created_time']) > time_length
        break
      end
      times_checkedin += 1 if set_of_place_ids.include? checkin['place']['id']
    end
    
    return times_checkedin
  end

  def we_good?
    return false if count_checkins < frequency
    true
  end
  
  def shame
    access_token = user.fb_access_token
    MiniFB.post(access_token, 'me/feed',
                :message => "Please help me - I have failed at my goal!",
                :picture => "http://www.testpicture.com",
                :link => "http://sergeantshame.com",
                :name => "Shame on you!",
                :caption => "says Sergeant Shame",
                :description => "You have failed your mission by only going to the gym X times a week instead of 5")
  end

end
