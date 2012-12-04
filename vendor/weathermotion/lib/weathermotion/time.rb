class WeatherMotion::Time
	def self.parse (text)
		(text) ? NSDate.dateWithNaturalLanguageString(text) : nil
	end
end
