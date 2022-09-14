require 'rails_helper'

RSpec.describe GeocodingService do
    describe "#get_coordinates(location)" do
        it 'returns latitude, longitude, and other data based on given location' do
            geodata = GeocodingService.get_coordinates("denver,co")

            expect(geodata).to be_a Hash 
            expect(geodata[:results]).to be_an Array 
            expect(geodata[:results][0][:providedLocation][:location]).to eq("denver,co")
            expect(geodata[:results][0][:locations][0][:adminArea5]).to eq('Denver')
            expect(geodata[:results][0][:locations][0][:adminArea3]).to eq('CO')
            expect(geodata[:results][0][:locations][0][:latLng]).to eq({ lat: 39.738453, lng: -104.984853 })
        end
    end

    describe "#get_route(origin, desination)" do
        xit "returns a routes starting geolocation, ending geolocation, and time to get there" do
            route_data = GeocodingService.get_route("Denver,CO","Pueblo,CO")

   
            expect(route_data).to be_a Hash
            expect(route_data[:route][:boundingBox][:lr][:lng]).to eq(-104.60508)
            expect(route_data[:route][:boundingBox][:lr][:lat]).to eq(38.265427)
            expect(route_data[:route][:boundingBox][:ul][:lng]).to eq(-104.987602)
            expect(route_data[:route][:boundingBox][:ul][:lat]).to eq(39.738453)
            expect(route_data[:route][:formattedTime]).to eq("01:45:23")
        end
      end
end