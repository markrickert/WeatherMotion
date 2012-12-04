module WeatherMotion

	# The main client object through which the Yahoo! Weather service may be accessed.
	class Client
	  # the url with which we obtain weather information from yahoo
	  @@API_URL = "http://weather.yahooapis.com/forecastrss"

	  def initialize (api_url = @@API_URL)
	    @api_url = api_url
	  end

	  # Returns a WeatherMotion::Response object detailing the current weather
	  # information for the specified location.
	  #
	  # The lookup requires the unique WOEID for the location whose
	  # weather is sought.. To find your WOEID, browse or search for your
	  # city from the Weather (http://weather.yahoo.com/) home page. The
	  # WOEID is in the URL for the forecast page for that city. You can
	  # also get the WOEID by entering your zip code on the home page. For
	  # example, if you search for Los Angeles on the Weather home page,
	  # the forecast page for that city is
	  # http://weather.yahoo.com/united-states/california/los-angeles-2442047/. The
	  # WOEID is 2442047.
	  #
	  # +units+ allows specifying whether to retrieve information in
	  # +Fahrenheit+ as WeatherMotion::Units::FAHRENHEIT, or +Celsius+ as
	  # WeatherMotion::Units::CELSIUS, and defaults to fahrenheit.
	  #
	  def lookup_by_woeid (woeid, units = 'f')
	    url = @api_url + '?w=' + escape(woeid.to_s) + '&u=' + escape(units)
	    _lookup(woeid, url)
	  end

	  # Returns a WeatherMotion::Response object detailing the current weather
	  # information for the specified location.
	  #
	  # NOTE: This method is deprecated as Yahoo has deprecated this
	  # non-WOEID-based lookup function.  Please use the new
	  # +lookup_by_woeid+ method instead.
	  #
	  # +location+ can be either a US zip code or a location code.  Location
	  # codes can be looked up at http://weather.yahoo.com, where it will appear
	  # in the URL that results from searching on the city or zip code.  For
	  # instance, searching on 'Seattle, WA' results in a URL ending in
	  # 'USWA0395.html', so the location code for Seattle is 'USWA0395'.
	  #
	  # +units+ allows specifying whether to retrieve information in
	  # +Fahrenheit+ as WeatherMotion::Units::FAHRENHEIT, or +Celsius+ as
	  # WeatherMotion::Units::CELSIUS, and defaults to fahrenheit.
	  #
	  def lookup_location (location, units = 'f')
	    url = @api_url + '?p=' + escape(location) + '&u=' + escape(units)
	    _lookup(location, url)
	  end

	  private

	    def _lookup (src, url)
			puts "Getting URL: #{url}"

			data = NSMutableData.dataWithContentsOfURL(NSURL.URLWithString(url))
			doc = NSDictionary.dictionaryWithXMLData(data)
			puts doc
			WeatherMotion::Response.new(src, url, doc)
	    end

      # Excape strings... stolen from BubbleWrap since it's a private method.
      def escape(string)
        if string
          puts "Escaping String: #{string}"
          CFURLCreateStringByAddingPercentEscapes nil, string.to_s, "[]", ";=&,", KCFStringEncodingUTF8
        end
      end

	end
end