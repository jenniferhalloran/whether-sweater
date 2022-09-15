class Route 
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :end_latitude,
              :end_longitude,
              :hours_to_destination

  def initialize(origin, destination, route_data)
    @start_city = origin
    @end_city = destination
    @travel_time = route_data[:formattedTime]
    @end_latitude = route_data[:boundingBox][:ul][:lat]
    @end_longitude = route_data[:boundingBox][:ul][:lng]
    @hours_to_destination = time_in_hours(route_data[:formattedTime])
  end

  def time_in_hours(travel_time)
    split_time = travel_time.split(':')[0..1]
    if split_time.last.to_i > 30
      split_time.first.to_i + 1
    else
      split_time.first.to_i
    end
  end
end