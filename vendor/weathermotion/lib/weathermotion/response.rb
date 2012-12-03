# Describes the weather conditions for a particular requested location.
class WeatherMotion::Response
  # a WeatherMotion::Astronomy object detailing the sunrise and sunset
  # information for the requested location.
  attr_reader :astronomy

  # a WeatherMotion::Location object detailing the precise geographical names
  # to which the requested location was mapped.
  attr_reader :location

  # a WeatherMotion::Units object detailing the units corresponding to the
  # information detailed in the response.
  attr_reader :units

  # a WeatherMotion::Wind object detailing the wind information at the
  # requested location.
  attr_reader :wind

  # a WeatherMotion::Atmosphere object detailing the atmosphere information
  # of the requested location.
  attr_reader :atmosphere

  # a WeatherMotion::Condition object detailing the current conditions of the
  # requested location.
  attr_reader :condition

  # a list of WeatherMotion::Forecast objects detailing the high-level
  # forecasted weather conditions for upcoming days.
  attr_reader :forecasts

  # the raw HTML generated by the Yahoo! Weather service summarizing current
  # weather conditions for the requested location.
  attr_reader :description

  # a WeatherMotion::Image record describing an image icon
  # representing the current weather.
  attr_reader :image

  # the latitude of the location for which weather is detailed.
  attr_reader :latitude

  # the longitude of the location for which weather is detailed.
  attr_reader :longitude

  # a link to the Yahoo! Weather page with full detailed information on the
  # requested location's current weather conditions.
  attr_reader :page_url

  # the location string initially requested of the service.
  attr_reader :request_location

  # the url with which the Yahoo! Weather service was accessed to build the response.
  attr_reader :request_url

  # the prose descriptive title of the weather information.
  attr_reader :title

  def initialize (request_location, request_url, doc)
    # save off the request params
    @request_location = request_location
    @request_url = request_url

    # parse the nokogiri xml document to gather response data
    puts "Got to the initialization function."
    puts doc.valueForKeyPath('rss.channel')
    puts doc.valueForKeyPath('rss.channel').inspect

    root = doc.valueForKeyPath('rss.channel').first

    @astronomy = WeatherMotion::Astronomy.new(root.valueForKey('yweather:astronomy').first)
    @location = WeatherMotion::Location.new(root.valueForKey('yweather:location').first)
    @units = WeatherMotion::Units.new(root.valueForKey('yweather:units').first)
    @wind = WeatherMotion::Wind.new(root.valueForKey('yweather:wind').first)
    @atmosphere = WeatherMotion::Atmosphere.new(root.valueForKey('yweather:atmosphere').first)
    @image = WeatherMotion::Image.new(root.valueForKey('image').first)

    item = root.valueForKey('item').first
    @condition = WeatherMotion::Condition.
      new(item.valueForKey('yweather:condition').first)
    @forecasts = []
    item.valueForKey('yweather:forecast').each { |forecast| 
      @forecasts << WeatherMotion::Forecast.new(forecast) }
    @latitude = item.valueForKey('geo:lat').first.content.to_f
    @longitude = item.valueForKey('geo:long').first.content.to_f
    @page_url = item.valueForKey('link').first.content
    @title = item.valueForKey('title').first.content
    @description = item.valueForKey('description').first.content
  end
end