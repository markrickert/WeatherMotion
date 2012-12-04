class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    w = WeatherMotion::Client.new
    forecast = w.lookup_by_woeid(2488892)
    puts forecast
    puts forecast.inspect

    true
  end

end
