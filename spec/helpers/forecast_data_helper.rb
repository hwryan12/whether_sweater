module ForecastDataHelper
  def forecast_data
    {
      current: {
        last_updated_epoch: 1617911700,
        temp_f: 72.0,
        feelslike_f: 70.0,
        humidity: 60,
        uv: 4.0,
        vis_miles: 10,
        condition: {
          text: "Partly cloudy",
          icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
        }
      },
      forecast: {
        forecastday: [
          {
            date: "2023-04-22",
            astro: {
              sunrise: "06:31 AM",
              sunset: "07:59 PM"
            },
            day: {
              maxtemp_f: 80.0,
              mintemp_f: 60.0,
              condition: {
                text: "Sunny",
                icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"
              }
            },
            hour: [
              {
                time: "2023-04-22 00:00",
                temp_f: 65.0,
                condition: {
                  text: "Partly cloudy",
                  icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
                }
              },
              {
                time: "2023-04-22 01:00",
                temp_f: 65.0,
                condition: {
                  text: "Partly cloudy",
                  icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
                }
              },
              {
                time: "2023-04-22 02:00",
                temp_f: 64.0,
                condition: {
                  text: "Partly cloudy",
                  icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
                }
              },
              {
                time: "2023-04-22 03:00",
                temp_f: 64.0,
                condition: {
                  text: "Partly cloudy",
                  icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
                }
              },
              {
                time: "2023-04-22 04:00",
                temp_f: 63.0,
                condition: {
                  text: "Partly cloudy",
                  icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
                }
              },
            ]
          },
          {
            date: "2023-04-23",
            astro: {
              sunrise: "06:30 AM",
              sunset: "08:00 PM"
            },
            day: {
              maxtemp_f: 82.0,
              mintemp_f: 62.0,
              condition: {
                text: "Partly cloudy",
                icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
              }
            },
            hour: [
            ]
          },
          {
            date: "2023-04-24",
            astro: {
              sunrise: "06:29 AM",
              sunset: "08:01 PM"
            },
            day: {
              maxtemp_f: 84.0,
              mintemp_f: 64.0,
              condition: {
                text: "Mostly sunny",
                icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"
              }
            },
            hour: [
            ]
          },
          {
            date: "2023-04-25",
            astro: {
              sunrise: "06:28 AM",
              sunset: "08:02 PM"
            },
            day: {
              maxtemp_f: 86.0,
              mintemp_f: 66.0,
              condition: {
                text: "Partly cloudy",
                icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
              }
            },
            hour: [
            ]
          },
          {
            date: "2023-04-26",
            astro: {
              sunrise: "06:27 AM",
              sunset: "08:03 PM"
            },
            day: {
              maxtemp_f: 90.0,
              mintemp_f: 69.0,
              condition: {
                text: "Mostly sunny",
                icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"
              }
            },
            hour: [
            ]
          }
        ]
      }
    }
  end
end