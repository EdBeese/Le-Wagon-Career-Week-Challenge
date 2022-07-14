require "json"
require "open-uri"
require "ostruct"
require "nokogiri"
class MuseumsController < ApplicationController
  def index
    # raise
    @museums = get_api_data(params[:longitude], params[:latitude])
  end

  private
  def get_api_data(longitude, latitude)
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{longitude},#{latitude}&access_token=pk.eyJ1IjoiYmVlc2UiLCJhIjoiY2wzYWw0b2V4MDZtZjNkbnJzdW5rZjZqMyJ9.r0LGJiSrXeytauzSf1QhXA"

    serialized = URI.parse(url).open.read
    map_data = JSON.parse(serialized, object_class: OpenStruct)
    map_data.features
  end

  def museum_params
    params.require(:museum).permit()
  end

  def get_website(museum)
    url = "https://www.google.com/search?q=#{museum.gsub(" ", "+")}"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)
    if html_doc.search(".VGHMXd").count > 0
      URI.parse(html_doc.search(".VGHMXd")[1].attribute("href").value.match(/(?:\/.*?)(\/.*)/)[1]).host
    end
  end
  helper_method :get_website
end
