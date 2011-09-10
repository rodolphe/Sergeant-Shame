require 'mini_fb'

# Returns the number of times a user has checked into a set of locations in the time_length specified.
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
# count_checkins('2227470867|2.AQBAovqK8CMLwFfQ.3600.1315699200.0-701789|Nzi-ApvNIJlnwbf4hocsgrzyRtw', Set.new(['113027475382252']), 30.days)
