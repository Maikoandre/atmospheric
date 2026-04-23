### How to make an API call

## API call

```
https://api.openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}
```

Copy Icon

<!-- image -->

| Parameters       |          |                                                                                                                                                                                                                        |
|------------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ``` lat, lon ``` | required | Geographical coordinates (latitude, longitude)                                                                                                                                                                         |
| ``` appid ```    | required | Your unique API key (you can always find it on your account page under the ["API key" tab](https://home.openweathermap.org/api_keys) )                                                                                 |
| ``` exclude ```  | optional | By  using this parameter you can exclude some parts of the weather data  from the API response. It should be a comma-delimited list (without  spaces). Available values:  ``` current minutely hourly daily alerts ``` |
| ``` units ```    | optional | Units of measurement. `standard` , `metric` and `imperial` units are available. If you do not use the `units` parameter, `standard` units will be applied by default. [Learn more](#data)                              |
| ``` lang ```     | optional | You can use the `lang` parameter to get the output in your language. [Learn more](#multi)                                                                                                                              |

## Example of API call

```
https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=hourly,daily&appid={API key}
```

Copy Icon

<!-- image -->

## Example of API response

```
To view the API response, expand the example by clicking the triangle.
```

Toggle

<!-- image -->

Copy Icon

<!-- image -->

### Fields in API response

- `lat` Geographical coordinates of the location (latitude)
- `lon` Geographical coordinates of the location (longitude)
- `timezone` Timezone name for the requested location
- `timezone_offset` Shift in seconds from UTC
- `current` **Current weather data API response**
    - `current.dt` Current time, Unix, UTC
    - `current.sunrise` Sunrise time, Unix, UTC
    - `current.sunset` Sunset time, Unix, UTC
    - `current.temp` Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit. [How to change units used](#data)
    - `current.feels_like` Temperature. This temperature parameter accounts for the human perception of weather. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    - `current.pressure` Atmospheric pressure on the sea level, hPa
    - `current.humidity` Humidity, %
    - `current.dew_point` Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    - `current.clouds` Cloudiness, %
    - `current.uvi` Current UV index
    - `current.visibility` Average visibility, metres. The maximum value of the visibility is 10km
    - `current.wind_speed` Wind speed. Wind speed. Units - default: metre/sec, metric: metre/sec, imperial: miles/hour. [How to change units used](#data)
    - `current.wind_gust` (where available) Wind gust. Units - default: metre/sec, metric: metre/sec, imperial: miles/hour. [How to change units used](#data)
    - `current.wind_deg` Wind direction, degrees (meteorological)
    - current.rain
        - `current.rain.1h` (where available) Rain, mm/h
    - current.snow
        - `current.snow.1h` (where available) Precipitation, mm/h
    - current.weather
        - `current.weather.id` [Weather condition id](https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2)
        - `current.weather.main` Group of weather parameters (Rain, Snow, Extreme etc.)
        - `current.weather.description` Weather condition within the group ( [full list of weather conditions](https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2) ). Get the output in [your language](https://openweathermap.org/api/one-call-api#multi)
        - `current.weather.icon` Weather icon id. [How to get icons](https://openweathermap.org/weather-conditions#How-to-get-icon-URL)
- `minutely` **Minute forecast weather data API response**
    - `minutely.dt` Time of the forecasted data, unix, UTC
    - `minutely.precipitation` Precipitation, mm/h
- `hourly` **Hourly forecast weather data API response**
    - `hourly.dt` Time of the forecasted data, Unix, UTC
    - `hourly.temp` Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit. [How to change units used](#data)
    - `hourly.feels_like` Temperature. This accounts for the human perception of weather. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    - `hourly.pressure` Atmospheric pressure on the sea level, hPa
    - `hourly.humidity` Humidity, %
    - `hourly.dew_point` Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    - `hourly.uvi` UV index
    - `hourly.clouds` Cloudiness, %
    - `hourly.visibility` Average visibility, metres. The maximum value of the visibility is 10km
    - `hourly.wind_speed` Wind speed. Units - default: metre/sec, metric: metre/sec, imperial: miles/hour. [How to change units used](#data)
    - `hourly.wind_gust` (where available) Wind gust. Units - default: metre/sec, metric: metre/sec, imperial: miles/hour. [How to change units used](#data)
    - `chourly.wind_deg` Wind direction, degrees (meteorological)
    - `hourly.pop` Probability of precipitation. The values of the parameter vary between 0 and 1, where 0 is equal to 0%, 1 is equal to 100%
    - hourly.rain
        - `hourly.rain.1h` (where available) Rain, mm/h
    - hourly.snow
        - `hourly.snow.1h` (where available) Precipitation, mm/h
    - hourly.weather
        - `hourly.weather.id` [Weather condition id](https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2)
        - `hourly.weather.main` Group of weather parameters (Rain, Snow, Extreme etc.)
        - `hourly.weather.description` Weather condition within the group ( [full list of weather conditions](https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2) ). Get the output in [your language](https://openweathermap.org/api/one-call-api#multi)
        - `hourly.weather.icon` Weather icon id. [How to get icons](https://openweathermap.org/weather-conditions#How-to-get-icon-URL)
- `daily` **Daily forecast weather data API response**
    - `daily.dt` Time of the forecasted data, Unix, UTC
    - `daily.sunrise` Sunrise time, Unix, UTC
    - `daily.sunset` Sunset time, Unix, UTC
    - `daily.moonrise` The time of when the moon rises for this day, Unix, UTC
    - `daily.moonset` The time of when the moon sets for this day, Unix, UTC
    - `daily.moon_phase` Moon phase. `0` and `1` are 'new moon', `0.25` is 'first quarter moon', `0.5` is 'full moon' and `0.75` is 'last quarter moon'. The periods in between are called 'waxing crescent', 'waxing gibous', 'waning gibous', and 'waning crescent', respectively.
    - `daily.temp` Units - default: kelvin, metric: Celsius, imperial: Fahrenheit. [How to change units used](#data)
        - `daily.temp.morn` Morning temperature.
        - `daily.temp.day` Day temperature.
        - `daily.temp.eve` Evening temperature.
        - `daily.temp.night` Night temperature.
        - `daily.temp.min` Min daily temperature.
        - `daily.temp.max` Max daily temperature.
    - `daily.feels_like` This accounts for the human perception of weather. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit. [How to change units used](#data)
        - `daily.feels_like.morn` Morning temperature.
        - `daily.feels_like.day` Day temperature.
        - `daily.feels_like.eve` Evening temperature.
        - `daily.feels_like.night` Night temperature.
    - `daily.pressure` Atmospheric pressure on the sea level, hPa
    - `daily.humidity` Humidity, %
    - `daily.dew_point` Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    - `daily.wind_speed` Wind speed. Units - default: metre/sec, metric: metre/sec, imperial: miles/hour. [How to change units used](#data)
    - `daily.wind_gust` (where available) Wind gust. Units - default: metre/sec, metric: metre/sec, imperial: miles/hour. [How to change units used](#data)
    - `daily.wind_deg` Wind direction, degrees (meteorological)
    - `daily.clouds` Cloudiness, %
    - `daily.uvi` The maximum value of UV index for the day
    - `daily.pop` Probability of precipitation. The values of the parameter vary between 0 and 1, where 0 is equal to 0%, 1 is equal to 100%
    - `daily.rain` (where available) Rain volume, mm
    - `daily.snow` (where available) Snow volume, mm
    - daily.weather
        - `daily.weather.id` [Weather condition id](https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2)
        - `daily.weather.main` Group of weather parameters (Rain, Snow, Extreme etc.)
        - `daily.weather.description` Weather condition within the group ( [full list of weather conditions](https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2) ). Get the output in [your language](https://openweathermap.org/api/one-call-api#multi)
        - `daily.weather.icon` Weather icon id. [How to get icons](https://openweathermap.org/weather-conditions#How-to-get-icon-URL)
- `alerts` **National weather alerts data from major national weather warning systems**
    - `alerts.sender_name` Name of the alert source. Please read here the [full list of alert sources](#listsource)
    - `alerts.event` Alert event name
    - `alerts.start` Date and time of the start of the alert, Unix, UTC
    - `alerts.end` Date and time of the end of the alert, Unix, UTC
    - `alerts.description` Description of the alert
    - `alerts.tags` Type of severe weather

National weather alerts are provided in English by default. Please note that some agencies provide the alert's description only in a local language.

Historical weather data

To learn about how get access to historical weather data for the **previous 5 days** , please use this section of the documentation.

If you are interested in current weather data, forecasts and weather alerts please read the ["Current and forecast weather data" section](#how) .

### How to make an API call

## API call

```
https://api.openweathermap.org/data/2.5/onecall/timemachine?lat={lat}&lon={lon}&dt={time}&appid={API key}
```

Copy Icon

<!-- image -->

| Parameters           |          |                                                                                                                                                                                                                                                                                                                                                                                          |
|----------------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ``` lat, lon ```     | required | Geographical coordinates (latitude, longitude)                                                                                                                                                                                                                                                                                                                                           |
| ``` dt ```           | required | Date from the **previous five days** (Unix time, UTC time zone), e.g. dt=1586468027                                                                                                                                                                                                                                                                                                      |
| ``` appid ```        | required | Your unique API key (you can always find it on your account page under the ["API key" tab](https://home.openweathermap.org/api_keys) )                                                                                                                                                                                                                                                   |
| ``` only_current ``` | optional | By  using this parameter you can exclude full historical weather data for  the specified day, but received the data for only the specified  timestamp. If the user specifies this parameter, then the API response  will contain only the  `current` section. To activate this option, please use default value `only_current = {true}` . Please find the example of the API call below. |
| ``` units ```        | optional | Units of measurement. `standard` , `metric` and `imperial` units are available. If you do not use the `units` parameter, `standard` units will be applied by default. [Learn more](#data)                                                                                                                                                                                                |
| ``` lang ```         | optional | You can use the `lang` parameter to get the output in your language. [Learn more](#multi)                                                                                                                                                                                                                                                                                                |

Please

note that in order to get historical data for the last five days, you

need to make five API calls (one call for each day).

In

case you need historical data only for the specified timestamp (not the

whole day), we strongly recommend you to use the parameter

`only_current={true}` .

Example of the API call to get all historical weather data for a day, covered by specified timestamp:

## Examples of API call

```
http://api.openweathermap.org/data/2.5/onecall/timemachine?lat=60.99&lon=30.9&dt=1586468027&appid={API key}
```

Copy Icon

<!-- image -->

Example of the API call to get historical weather data only for the specified timestamp:

## Example of API response

```
https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=60&lon=30&dt=1650445666&appid={API key}&only_current={true}
```

Copy Icon

<!-- image -->

## Example of API response

```
To view the API response, expand the example by clicking the triangle.
```

Toggle

<!-- image -->

Copy Icon

<!-- image -->

## Example of API response

```
To view the API response, expand the example by clicking the triangle.
```

Toggle

<!-- image -->

Copy Icon

<!-- image -->

### Fields in API response

- `lat` Geographical coordinates of the location (latitude)
- `lon` Geographical coordinates of the location (longitude)
- `timezone` Timezone name for the requested location
- `timezone_offset` Shift in seconds from UTC
- `current` **Data point dt refers to the requested time, rather than the current time**
    - `current.dt` Requested time, Unix, UTC
    - `current.sunrise` Sunrise time, Unix, UTC
    - `current.sunset` Sunset time, Unix, UTC
    - `current.temp` Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit. [How to change units used](#data)
    - `current.feels_like` Temperature. This accounts for the human perception of weather. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    - `current.pressure` Atmospheric pressure on the sea level, hPa
    - `current.humidity` Humidity, %
    - `current.dew_point` Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    - `current.clouds` Cloudiness, %
    - `current.uvi` Midday UV index
    - `current.visibility` Average visibility, metres. The maximum value of the visibility is 10km
    - `current.wind_speed` Wind speed. Units - default: metre/sec, metric: metre/sec, imperial: miles/hour. [How to change units used](#data)
    - `current.wind_gust` (where available) Wind gust. Wind speed. Units - default: metre/sec, metric: metre/sec, imperial: miles/hour. [How to change units used](#data)
    - `current.wind_deg` Wind direction, degrees (meteorological)
    - `current.rain` (where available) Precipitation, mm/h
    - `current.snow` (where available) Precipitation, mm/h
    - current.weather
        - `current.weather.id` [Weather condition id](https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2)
        - `current.weather.main` Group of weather parameters (Rain, Snow, Extreme etc.)
        - `current.weather.description` Weather condition within the group ( [full list of weather conditions](https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2) ). Get the output in [your language](https://openweathermap.org/api/one-call-api#multi)
        - `current.weather.icon` Weather icon id. [How to get icons](https://openweathermap.org/weather-conditions#How-to-get-icon-URL)
- `hourly` **Data block contains hourly historical data starting at 00:00 on the requested day and continues until 23:59 on the same day (UTC time)**
    - `hourly.dt` Time of historical data, Unix, UTC
    - `hourly.temp` Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit. [How to change units used](#data)
    - `hourly.feels_like` Temperature. This accounts for the human perception of weather. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    - `hourly.pressure` Atmospheric pressure on the sea level, hPa
    - `hourly.humidity` Humidity, %
    - `hourly.dew_point` Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit.
    - `hourly.clouds` Cloudiness, %
    - `hourly.visibility` Average visibility, metres. The maximum value of the visibility is 10km
    - `hourly.wind_speed` Wind speed. Wind speed. Units - default: metre/sec, metric: metre/sec, imperial: miles/hour. [How to change units used](#data)
    - `hourly.wind_gust` (where available) Wind gust. Units - default: metre/sec, metric: metre/sec, imperial: miles/hour. [How to change units used](#data)
    - `chourly.wind_deg` Wind direction, degrees (meteorological)
    - `hourly.rain` (where available) Precipitation, mm/h
    - `hourly.snow` (where available) Precipitation, mm/h
    - hourly.weather
        - `hourly.weather.id` [Weather condition id](https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2)
        - `hourly.weather.main` Group of weather parameters (Rain, Snow, Extreme etc.)
        - `hourly.weather.description` Weather condition within the group ( [full list of weather conditions](https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2) ). Get the output in [your language](https://openweathermap.org/api/one-call-api#multi)
        - `hourly.weather.icon` Weather icon id. [How to get icons](https://openweathermap.org/weather-conditions#How-to-get-icon-URL)

### List of weather condition codes

List of [weather condition codes](https://openweathermap.org/weather-conditions) with icons (range of thunderstorm, drizzle, rain, snow, clouds,

atmosphere including extreme conditions like tornado, hurricane etc.)

Other features

### Units of measurement

`standard` , `metric` and `imperial` units are available.

| Parameter                                                                                               | Description                                                                           | Standard                 | Metric                   | Imperial                 |
|---------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|--------------------------|--------------------------|--------------------------|
| ``` lat ```                                                                                             | City geo location, latitude                                                           | -                        | -                        | -                        |
| ``` lon ```                                                                                             | City geo location, longitude                                                          | -                        | -                        | -                        |
| ``` timezone ```                                                                                        | Timezone name for the requested location                                              | -                        | -                        | -                        |
| ``` timezone_offset ```                                                                                 | Shift in seconds from UTC                                                             | -                        | -                        | -                        |
| **Current weather**                                                                                     |                                                                                       |                          |                          |                          |
| ``` current.dt ```                                                                                      | Current time                                                                          | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` current.sunrise ```                                                                                 | Sunrise time                                                                          | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` current.sunset ```                                                                                  | Sunset time                                                                           | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` current.temp ```                                                                                    | Temperature                                                                           | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` current.feels_like ```                                                                              | Feels like temperature                                                                | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` current.humidity ```                                                                                | Humidity                                                                              | %                        | %                        | %                        |
| ``` current.pressure ```                                                                                | Atmospheric pressure on the sea level                                                 | hPa                      | hPa                      | hPa                      |
| ``` current.dew_point ```                                                                               | Atmospheric temperature below which water droplets begin to condense and dew can form | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` current.clouds ```                                                                                  | Cloudiness                                                                            | %                        | %                        | %                        |
| ``` current.uvi ```                                                                                     | UV index                                                                              | -                        | -                        | -                        |
| ``` current.visibility ```                                                                              | Average visibility                                                                    | Metres                   | Metres                   | Metres                   |
| ``` current.wind_speed ```                                                                              | Wind speed                                                                            | metre/sec                | metre/sec                | miles/hour               |
| ``` current.wind_gust ```                                                                               | Wind gust                                                                             | metre/sec                | metre/sec                | miles/hour               |
| ``` current.wind_deg ```                                                                                | Wind direction                                                                        | degrees (meteorological) | degrees (meteorological) | degrees (meteorological) |
| ``` current.rain.1h ```                                                                                 | Rain                                                                                  | mm/h                     | mm/h                     | mm/h                     |
| ``` current.snow.1h ```                                                                                 | Snow                                                                                  | mm/h                     | mm/h                     | mm/h                     |
| `current.weather` (more info [Weather condition codes](https://openweathermap.org/weather-conditions) ) |                                                                                       |                          |                          |                          |
| ``` current.weather.id ```                                                                              | Weather condition id                                                                  | -                        | -                        | -                        |
| ``` current.weather.main ```                                                                            | Group of weather parameters (Rain, Snow, Extreme etc.)                                | -                        | -                        | -                        |
| ``` current.weather.description ```                                                                     | Weather condition within the group                                                    | -                        | -                        | -                        |
| ``` current.weather.icon ```                                                                            | Weather icon id                                                                       | -                        | -                        | -                        |
| **Minute forecast**                                                                                     |                                                                                       |                          |                          |                          |
| ``` minutely.dt ```                                                                                     | Current time                                                                          | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` minutely.precipitation ```                                                                          | Precipitation                                                                         | mm/h                     | mm/h                     | mm/h                     |
| **Hourly forecast**                                                                                     |                                                                                       |                          |                          |                          |
| ``` hourly.dt ```                                                                                       | Time of the forecasted data                                                           | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` hourly.temp ```                                                                                     | Temperature                                                                           | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` hourly.feels_like ```                                                                               | Feels like temperature                                                                | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` hourly.pressure ```                                                                                 | Atmospheric pressure on the sea level                                                 | hPa                      | hPa                      | hPa                      |
| ``` hourly.humidity ```                                                                                 | Humidity                                                                              | %                        | %                        | %                        |
| ``` hourly.dew_point ```                                                                                | Atmospheric temperature below which water droplets begin to condense and dew can form | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` hourly.clouds ```                                                                                   | Cloudiness                                                                            | %                        | %                        | %                        |
| ``` hourly.uvi ```                                                                                      | UV index                                                                              | -                        | -                        | -                        |
| ``` hourly.visibility ```                                                                               | Average visibility                                                                    | Metres                   | Metres                   | Metres                   |
| ``` hourly.wind_speed ```                                                                               | Wind speed                                                                            | metre/sec                | metre/sec                | miles/hour               |
| ``` hourly.wind_gust ```                                                                                | Wind gust                                                                             | metre/sec                | metre/sec                | miles/hour               |
| ``` hourly.wind_deg ```                                                                                 | Wind direction                                                                        | degrees (meteorological) | degrees (meteorological) | degrees (meteorological) |
| ``` hourly.pop ```                                                                                      | Probability of precipitation                                                          | %                        | %                        | %                        |
| ``` hourly.rain.1h ```                                                                                  | Rain                                                                                  | mm/h                     | mm/h                     | mm/h                     |
| ``` hourly.snow.1h ```                                                                                  | Snow                                                                                  | mm/h                     | mm/h                     | mm/h                     |
| `hourly.weather` (more info [Weather condition codes](https://openweathermap.org/weather-conditions) )  |                                                                                       |                          |                          |                          |
| ``` hourly.weather.id ```                                                                               | Weather condition id                                                                  | -                        | -                        | -                        |
| ``` hourly.weather.main ```                                                                             | Group of weather parameters (Rain, Snow, Extreme etc.)                                | -                        | -                        | -                        |
| ``` hourly.weather.description ```                                                                      | Weather condition within the group                                                    | -                        | -                        | -                        |
| ``` hourly.weather.icon ```                                                                             | Weather icon id                                                                       | -                        | -                        | -                        |
| **Daily forecast**                                                                                      |                                                                                       |                          |                          |                          |
| ``` daily.dt ```                                                                                        | Time of the forecasted data                                                           | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` daily.sunrise ```                                                                                   | Sunrise time                                                                          | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` daily.sunset ```                                                                                    | Sunset time                                                                           | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` daily.moonrise ```                                                                                  | The time of when the moon rises for this day                                          | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` daily.moonset ```                                                                                   | The time of when the moon sets for this day                                           | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` daily.moon_phase ```                                                                                | Moon phase                                                                            | -                        | -                        | -                        |
| ``` daily.temp ```                                                                                      |                                                                                       |                          |                          |                          |
| ``` daily.temp.morn ```                                                                                 | Morning temperature                                                                   | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` daily.temp.day ```                                                                                  | Day temperature                                                                       | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` daily.temp.eve ```                                                                                  | Evening temperature                                                                   | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` daily.temp.night ```                                                                                | Night temperature                                                                     | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` daily.temp.min ```                                                                                  | Min daily temperature                                                                 | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` daily.temp.max ```                                                                                  | Max daily temperature                                                                 | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` daily.feels_like ```                                                                                |                                                                                       |                          |                          |                          |
| ``` daily.temp.feels_like ```                                                                           | Morning temperature                                                                   | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` daily.temp.feels_like ```                                                                           | Day temperature                                                                       | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` daily.temp.feels_like ```                                                                           | Evening temperature                                                                   | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` daily.temp.feels_like ```                                                                           | Night temperature                                                                     | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` daily.pressure ```                                                                                  | Atmospheric pressure on the sea level                                                 | hPa                      | hPa                      | hPa                      |
| ``` daily.humidity ```                                                                                  | Humidity                                                                              | %                        | %                        | %                        |
| ``` daily.dew_point ```                                                                                 | Atmospheric temperature below which water droplets begin to condense and dew can form | Kelvin                   | Celsius                  | Fahrenheit               |
| ``` daily.clouds ```                                                                                    | Cloudiness                                                                            | %                        | %                        | %                        |
| ``` daily.uvi ```                                                                                       | UV index                                                                              | -                        | -                        | -                        |
| ``` daily.visibility ```                                                                                | Average visibility                                                                    | Metres                   | Metres                   | Metres                   |
| ``` daily.wind_speed ```                                                                                | Wind speed                                                                            | metre/sec                | metre/sec                | miles/hour               |
| ``` daily.wind_gust ```                                                                                 | Wind gust                                                                             | metre/sec                | metre/sec                | miles/hour               |
| ``` daily.wind_deg ```                                                                                  | Wind direction                                                                        | degrees (meteorological) | degrees (meteorological) | degrees (meteorological) |
| ``` daily.pop ```                                                                                       | Probability of precipitation                                                          | %                        | %                        | %                        |
| ``` daily.rain ```                                                                                      | Rain                                                                                  | mm                       | mm                       | mm                       |
| ``` daily.snow ```                                                                                      | Snow                                                                                  | mm                       | mm                       | mm                       |
| `daily.weather` (more info [Weather condition codes](https://openweathermap.org/weather-conditions) )   |                                                                                       |                          |                          |                          |
| ``` daily.weather.id ```                                                                                | Weather condition id                                                                  | -                        | -                        | -                        |
| ``` daily.weather.main ```                                                                              | Group of weather parameters (Rain, Snow, Extreme etc.)                                | -                        | -                        | -                        |
| ``` daily.weather.description ```                                                                       | Weather condition within the group                                                    | -                        | -                        | -                        |
| ``` daily.weather.icon ```                                                                              | Weather icon id                                                                       | -                        | -                        | -                        |
| **Alerts**                                                                                              |                                                                                       |                          |                          |                          |
| ``` alerts.sender_name ```                                                                              | Name of the alert source                                                              | -                        | -                        | -                        |
| ``` alerts.event ```                                                                                    | Alert event name                                                                      | -                        | -                        | -                        |
| ``` alerts.start ```                                                                                    | Date and time of the start of the alert                                               | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` alerts.end ```                                                                                      | Date and time of the end of the alert                                                 | unix, UTC                | unix, UTC                | unix, UTC                |
| ``` alerts.description ```                                                                              | Description of the alert                                                              | -                        | -                        | -                        |
| ``` alerts.tags ```                                                                                     | Type of severe weather                                                                | -                        | -                        | -                        |

## API call

```
http://api.openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&units={units}
```

Copy Icon

<!-- image -->

| Parameters    |          |                                                                                                                                                                       |
|---------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ``` units ``` | optional | Units of measurement. `standard` , `metric` and `imperial` units are available. If you do not use the `units` parameter, `standard` units will be applied by default. |

Wind speed is available in miles/hour and metre/sec.

Standard (default)

## Examples of API calls

```
api.openweathermap.org/data/2.5/onecall?lat=30.489772&lon=-99.771335
```

Copy Icon

<!-- image -->

Metric

## Example of API call

```
api.openweathermap.org/data/2.5/onecall?lat=30.489772&lon=-99.771335&units=metric
```

Copy Icon

<!-- image -->

Imperial

## Example of API call

```
api.openweathermap.org/data/2.5/onecall?lat=30.489772&lon=-99.771335&units=imperial
```

Copy Icon

<!-- image -->

### Multilingual support

You can use `lang` parameter to get the output in your language.

The contents of the `description` field will be translated.

## API call

```
http://api.openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&lang={lang}
```

Copy Icon

<!-- image -->

| Parameters   |          |                                                                      |
|--------------|----------|----------------------------------------------------------------------|
| ``` lang ``` | optional | You can use the `lang` parameter to get the output in your language. |

## Example of API call

```
http://api.openweathermap.org/data/2.5/onecall?lat=30.489772&lon=-99.771335&lang=zh_cn
```

Copy Icon

<!-- image -->

We support the following languages. To select one, you can use the corresponding language code:

- `af` Afrikaans
- `al` Albanian
- `ar` Arabic
- `az` Azerbaijani
- `bg` Bulgarian
- `ca` Catalan
- `cz` Czech
- `da` Danish
- `de` German
- `el` Greek
- `en` English
- `eu` Basque
- `fa` Persian (Farsi)
- `fi` Finnish
- `fr` French
- `gl` Galician
- `he` Hebrew
- `hi` Hindi
- `hr` Croatian
- `hu` Hungarian
- `id` Indonesian
- `it` Italian
- `ja` Japanese
- `kr` Korean
- `la` Latvian
- `lt` Lithuanian
- `mk` Macedonian
- `no` Norwegian
- `nl` Dutch
- `pl` Polish
- `pt` Portuguese
- `pt_br` Português Brasil
- `ro` Romanian
- `ru` Russian
- `sv, se` Swedish
- `sk` Slovak
- `sl` Slovenian
- `sp, es` Spanish
- `sr` Serbian
- `th` Thai
- `tr` Turkish
- `ua, uk` Ukrainian
- `vi` Vietnamese
- `zh_cn` Chinese Simplified
- `zh_tw` Chinese Traditional
- `zu` Zulu

### List of national weather alerts sources

| Country                                              | Agency                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Afghanistan                                          | National Disaster Management Authority                                                                                                                                                                                                                                                                                                                                                                                                       |
| Albania                                              | Institute of GeoSciences, Energy, Water and Environment                                                                                                                                                                                                                                                                                                                                                                                      |
| Algeria                                              | National Meteorological Office                                                                                                                                                                                                                                                                                                                                                                                                               |
| Anguilla                                             | Disaster Management Anguilla                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Antigua and Barbuda                                  | Meteorological Services                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Argentina                                            | Servicio Meteorologico Nacional                                                                                                                                                                                                                                                                                                                                                                                                              |
| Aruba                                                | Meteorological Department of Aruba                                                                                                                                                                                                                                                                                                                                                                                                           |
| Austria                                              | Central Institute for Meteorology and Geodynamics Water Balance Department                                                                                                                                                                                                                                                                                                                                                                   |
| Barbados                                             | Department of Emergency Management                                                                                                                                                                                                                                                                                                                                                                                                           |
| Belgium                                              | Royal Meteorological Institute                                                                                                                                                                                                                                                                                                                                                                                                               |
| Bosnia and Herzegovin                                | Federal Hydrometeorological Institute of BiH Republic Hydrometeorological Institute                                                                                                                                                                                                                                                                                                                                                          |
| Botswana                                             | Department of Meteorological Services                                                                                                                                                                                                                                                                                                                                                                                                        |
| Brazil                                               | National Meteorological Institute - INMET                                                                                                                                                                                                                                                                                                                                                                                                    |
| Bulgaria                                             | National Institute of Meteorology and Hydrology - Plovdiv branch                                                                                                                                                                                                                                                                                                                                                                             |
| Canada                                               | Alberta Emergency Management Agency (Government of Alberta, Ministry of Municipal Affairs) Meteorological Service of Canada Quebec Ministry of Public Safety                                                                                                                                                                                                                                                                                 |
| Colombia                                             | UNGRD (National Unit for Disaster Risk Management)                                                                                                                                                                                                                                                                                                                                                                                           |
| Croatia                                              | State Hydrometeorological Institute (DHMZ)                                                                                                                                                                                                                                                                                                                                                                                                   |
| Cyprus                                               | Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                                       |
| Czech Republic                                       | Czech Hydrometeorological Institute                                                                                                                                                                                                                                                                                                                                                                                                          |
| Denmark                                              | Danmarks Meteorologiske Instituts                                                                                                                                                                                                                                                                                                                                                                                                            |
| Estonia                                              | State Weather Service                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Federated States of Micronesia                       | Weather Service Office Chuuk Weather Service Office Pohnpei Weather Service Office Yap                                                                                                                                                                                                                                                                                                                                                       |
| Finland                                              | Finnish Meteorological Institute                                                                                                                                                                                                                                                                                                                                                                                                             |
| France                                               | Meteo-France                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Germany                                              | German Meteorological Office                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Greece                                               | Hellenic National Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                     |
| Guyana                                               | Hydrometeorological Service                                                                                                                                                                                                                                                                                                                                                                                                                  |
| Hungary                                              | Hungarian Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                             |
| Iceland                                              | Icelandic Meteorological Office                                                                                                                                                                                                                                                                                                                                                                                                              |
| India                                                | Meteorological Department                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Indonesia                                            | Agency for Meteorology Climatology and Geophysics of Republic Indonesia (BMKG) InaTEWS BMKG, Earthquake with magnitude 5.0 above                                                                                                                                                                                                                                                                                                             |
| Ireland                                              | Met Eireann - Irish Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                   |
| Israel                                               | Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                                       |
| Italy                                                | National Center of Meteorology and Aeronautical Climatology (CNMCA)                                                                                                                                                                                                                                                                                                                                                                          |
| Jamaica                                              | Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                                       |
| Kenya                                                | Meteorological Department                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Kuwait                                               | Meteorological Department                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Latvia                                               | Latvian Environment, Geology and Meteorology Center                                                                                                                                                                                                                                                                                                                                                                                          |
| Lithuania                                            | Lithuanian Hydrometeorological Service                                                                                                                                                                                                                                                                                                                                                                                                       |
| Luxembourg                                           | Luxembourg Airport Administration                                                                                                                                                                                                                                                                                                                                                                                                            |
| Madagascar                                           | Operational Meteorology                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Malawi                                               | Meteorological Services                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Malta                                                | Meteorological Office                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Marshall Islands                                     | Majuro Weather Service Office                                                                                                                                                                                                                                                                                                                                                                                                                |
| Mexico                                               | CONAGUA - National Meteorological Service of Mexico                                                                                                                                                                                                                                                                                                                                                                                          |
| Moldova                                              | State Hydrometeorological Service                                                                                                                                                                                                                                                                                                                                                                                                            |
| Mongolia                                             | National Agency for Meteorology and Environmental Monitoring                                                                                                                                                                                                                                                                                                                                                                                 |
| Montenegro                                           | Institute of Hydrometeorology and Seismology                                                                                                                                                                                                                                                                                                                                                                                                 |
| Myanmar                                              | Department of Meteorology and Hydrology                                                                                                                                                                                                                                                                                                                                                                                                      |
| Netherlands                                          | Royal Netherlands Meteorological Institute                                                                                                                                                                                                                                                                                                                                                                                                   |
| New Zealand                                          | GNS Science MetService National Emergency Management Agency                                                                                                                                                                                                                                                                                                                                                                                  |
| North Macedonia                                      | Republic Hydrometeorological Organization                                                                                                                                                                                                                                                                                                                                                                                                    |
| Norway                                               | Norwegian Meteorological Institute Norwegian Water Resources and Energy Directorate                                                                                                                                                                                                                                                                                                                                                          |
| Oman                                                 | Directorate General of Meteorology                                                                                                                                                                                                                                                                                                                                                                                                           |
| Palau                                                | Weather Service Office                                                                                                                                                                                                                                                                                                                                                                                                                       |
| Papua New Guinea                                     | Papua New Guinea Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                      |
| Paraguay                                             | Directorate of Meteorology and Hydrology                                                                                                                                                                                                                                                                                                                                                                                                     |
| Philippines                                          | Philippine Atmospheric Geophysical and Astronomical Services Administration                                                                                                                                                                                                                                                                                                                                                                  |
| Poland                                               | Institute of Meteorology and Water Management                                                                                                                                                                                                                                                                                                                                                                                                |
| Portugal                                             | Portuguese Institute of Sea and Atmosphere, I.P.                                                                                                                                                                                                                                                                                                                                                                                             |
| Romania                                              | National Meteorological Administration                                                                                                                                                                                                                                                                                                                                                                                                       |
| Russia                                               | Russian Federal Service for Hydrometeorology and Environmental Monitoring                                                                                                                                                                                                                                                                                                                                                                    |
| Saint Lucia                                          | Meteorological Services                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Saint Vincent and the Grenadines                     | Meteorological Services                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Samoa                                                | Meteorology Division                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Senegal                                              | National Agency of Civil Aviation and Meteorology                                                                                                                                                                                                                                                                                                                                                                                            |
| Serbia                                               | Republic Hydrometeorological Institute                                                                                                                                                                                                                                                                                                                                                                                                       |
| Slovakia                                             | Slovak Hydrometeorological Institute                                                                                                                                                                                                                                                                                                                                                                                                         |
| Slovenia                                             | National Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                              |
| Solomon Islands                                      | Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                                       |
| South Africa                                         | South Africa Weather Service                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Spain                                                | Meteorology Statal Agency                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Suriname                                             | Suriname Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                              |
| Sweden                                               | Swedish Meteorological and Hydrological Institute                                                                                                                                                                                                                                                                                                                                                                                            |
| Switzerland                                          | MeteoSwiss, Bundesamt für Meteorologie und Klimatologie                                                                                                                                                                                                                                                                                                                                                                                      |
| Tanzania                                             | Meteorological Authority                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Thailand                                             | Thai Meteorological Department                                                                                                                                                                                                                                                                                                                                                                                                               |
| Tonga                                                | Tonga Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Trinidad and Tobago                                  | Trinidad and Tobago Meteorological Service                                                                                                                                                                                                                                                                                                                                                                                                   |
| United Kingdom of Great Britain and Northern Ireland | Met Office                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| United States                                        | Environmental Protection Agency (EPA), Air Quality Alerts Integrated Public Alerrt and Warning System (IPAWS) National Oceanic and Atmospheric Administration (NOAA), National Tsunami Warning Center National Oceanic and Atmospheric Administration (NOAA), National Weather Service National Oceanic and Atmospheric Administration (NOAA), National Weather Service - Marine Zones U.S. Geological Survey (USGS), Volcano Hazard Program |
| Vanuatu                                              | Meteorological Services                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Zimbabwe                                             | Meteorological Services Department                                                                                                                                                                                                                                                                                                                                                                                                           |

Please

note that some agencies from the list may cease to provide us the

weather alert information.  In case you don't receive alerts from any

agency, please

[contact us](mailto:info@openweathermap.org) . We constantly work on our product's improvement and keep expanding the list of partner agencies.

### Call back function for JavaScript code

To use JavaScript code you can transfer `callback` functionName to JSONP callback.

## API call example

```
To view the API response, expand the example by clicking the triangle.
```

Toggle

<!-- image -->

Copy Icon

<!-- image -->

# Build smarter, plan better with the world's most flexible weather data platform

Build smarter, plan better with the world's most flexible weather data platform

- [Get API Key](https://home.openweathermap.org/users/sign_in)
- [Explore API Docs](https://openweathermap.org/api/one-call-3)

Products

- [Current and Forecast APIs](https://openweathermap.org/api#current)
- [Historical Weather Data](https://openweathermap.org/api#history)
- [Weather Maps](https://openweathermap.org/api#maps)
- [Weather Dashboard](https://dashboard.openweather.co.uk/)
- [Widgets](https://openweathermap.org/widgets-constructor)

Subscription

- [How to start](https://openweathermap.org/appid)
- [Pricing](https://openweathermap.org/price)
- [Subscribe for free](https://home.openweathermap.org/)
- [FAQ](https://openweathermap.org/faq)

Technologies

- [Our technology](https://openweathermap.org/technology)
- [Accuracy and quality of weather data](https://openweather.co.uk/accuracy-and-quality)
- [Connect your weather station](https://openweathermap.org/stations)

[Offices](https://openweathermap.org/about/our-offices)

- London, UK The Gherkin, 30 St Mary`s Axe, The City Of London, London EC3A 8BF, United Kingdom
- Paphos, Cyprus Gladstonos 12-14, Office 1 Hugge Space, Paphos 8046, Cyprus
- Delaware, US 16192 Coastal Highway, Lewes, Delaware 19958, United States

App Store

<!-- image -->
Google Play

<!-- image -->

Instagram icon

<!-- image -->
Facebook icon

<!-- image -->
Telegram icon

<!-- image -->
LinkedIn icon

<!-- image -->
Medium icon

<!-- image -->
GitHub icon

<!-- image -->
Discord icon

<!-- image -->

ISO 9001

<!-- image -->
ISO 27001

<!-- image -->
CNB Business Logo

<!-- image -->
RMets Logo

<!-- image -->
ESPO logo

<!-- image -->
LCRIG logo

<!-- image -->

Company

**OpenWeather** is a London-based weather intelligence company serving enterprises,

developers, businesses, and researchers worldwide. Through its developer

business, the company provides global weather data and forecasting

services via fast, reliable APIs, delivering historical, current, and

forecast weather data for any location worldwide. Combining advanced

meteorology, AI-enhanced forecasting models, and scalable data

infrastructure, OpenWeather helps customers integrate weather

intelligence into applications, services, and operational workflows.

Supplier of Achilles UVDB community © 2012 - 2026 OpenWeather ® All rights reserved

- [Terms &amp; conditions of sale](https://openweather.co.uk/api/files/file/OpenWeather_T%26C_of_sale.pdf)
- [Website terms &amp; conditions](https://openweather.co.uk/api/files/file/Openweather_website_terms_and_conditions_of_use.pdf)
- [Privacy policy](https://openweather.co.uk/privacy-policy)

<!-- image -->