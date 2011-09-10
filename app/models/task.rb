class Task < ActiveRecord::Base
  has_many :check_ins
  belongs_to :user

  def count_checkins(set_of_place_ids, time_length)
    access_token = user.fb_access_token
    times_checkedin = 0
    checkins = MiniFB.get(access_token, 'me/checkins')
    checkins['data'].each do |checkin|
      if Time.now - Time.parse(checkin['created_time']) > time_length
        break
      end
      times_checkedin += 1 if set_of_place_ids.include? checkin['place']['id']
    end
    
    return times_checkedin
  end

end
