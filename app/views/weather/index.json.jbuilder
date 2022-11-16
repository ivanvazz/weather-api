json.array! @weathers do |weather|
  json.date weather.date
  json.lat weather.lat.to_f
  json.lon weather.lon.to_f
  json.city weather.city.capitalize()
  json.state weather.state
  json.temperatures JSON.parse(weather.temperatures)
end