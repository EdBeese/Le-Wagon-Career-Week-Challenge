class MuseumsController < ApplicationController
  def index
    # raise
    @museum_data = get_api_data(params[:longitude], params[:latitude])
  end

  private

  def get_api_data(longitude, latitude)
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{longitude},#{latitude}&access_token=#{ENV['MAPBOX_API_KEY']}"
    serialized = URI.parse(url).open.read
    map_data = JSON.parse(serialized, object_class: OpenStruct)
    map_data.features
  end

  def museum_params
    params.require(:museum).permit()
  end
end
