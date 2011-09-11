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

  def we_good
    if count_checkins < frequency
      "YOU IDIOT WHAT IS WRONG WITH YOU"
    else
      "We good"
    end
  end

end
