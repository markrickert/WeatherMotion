class WeatherMotion::Image
  # the height of the image in pixels.
  attr_reader :height

  # the url intended to be used as a link wrapping the image, for
  # instance, to send the user to the main Yahoo Weather home page.
  attr_reader :link

  # the title of hte image.
  attr_reader :title

  # the full url to the image.
  attr_reader :url

  # the width of the image in pixels.
  attr_reader :width

  def initialize (payload)
    @title = payload.valueForKey('title').first.content
    @link = payload.valueForKey('link').first.content
    @url = payload.valueForKey('url').first.content
    @height = payload.valueForKey('height').first.content.to_i
    @width = payload.valueForKey('width').first.content.to_i
  end
end
