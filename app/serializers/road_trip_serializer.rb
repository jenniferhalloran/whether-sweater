class RoadTripSerializer
  def self.format_roadtrip(route, weather)
    {
      "data": {
        "id": nil,
        "type": "roadtrip",
        "attributes": {
          "start_city": route.start_city,
          "end_city": route.end_city,
          "travel_time": route.travel_time,
          "weather_at_eta": {
            "temperature": weather[:temperature],
            "conditions": weather[:conditions]
          }
        }
      }
    }
  end

  def self.format_impossible_trip(origin, destination)
    {
      "data": {
        "id": nil,
        "type": "roadtrip",
        "attributes": {
          "start_city": origin,
          "end_city": destination,
          "travel_time": "Impossible Route",
          "weather_at_eta": nil
        }
      }
    }
  end
end