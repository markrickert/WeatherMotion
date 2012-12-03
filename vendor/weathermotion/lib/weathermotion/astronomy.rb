# Describes astronomy information for a particular location.
class WeatherMotion::Astronomy
  # a Time object detailing the sunrise time for a location.
  attr_reader :sunrise

  # a Time object detailing the sunset time for a location.
  attr_reader :sunset

  def initialize (payload)
    @sunrise = WeatherMotion._parse_time(payload['sunrise'])
    @sunset = WeatherMotion._parse_time(payload['sunset'])
  end
end
