class CheckIn < ActiveRecord::Base
  belongs_to :task

  def count_checkins(access_token, set_of_place_ids, time_length)
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
