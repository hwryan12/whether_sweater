require 'rails_helper'

RSpec.describe Forecast do
  let!(:forecast_data) do
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
  
  describe 'attributes' do
    let!(:forecast) { Forecast.new(forecast_data) }
    it 'has a null id, current_weather, daily_weather, and hourly_weather' do
      expect(forecast.id).to be_nil
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.daily_weather).to be_an(Array)
      expect(forecast.hourly_weather).to be_an(Array)
    end

    it "has a current_weather hash with the correct keys" do
      expect(forecast.current_weather.keys.nil?).to eq(false)
      expect(forecast.current_weather.keys).to eq(
                                                    [
                                                      :last_updated, 
                                                      :temperature, 
                                                      :feels_like, 
                                                      :humidity, 
                                                      :uvi, 
                                                      :visibility, 
                                                      :condition, 
                                                      :icon
                                                    ]
                                                  )
    end

    it "has a daily_weather array with the correct keys" do
      expect(forecast.daily_weather[0].keys.nil?).to eq(false)
      expect(forecast.daily_weather[0].keys).to eq(
                                                    [
                                                      :date,
                                                      :sunrise,
                                                      :sunset,
                                                      :max_temp,
                                                      :min_temp,
                                                      :condition,
                                                      :icon
                                                    ]
                                                  )
    end

    it "has a hourly_weather array with the correct keys" do
      expect(forecast.hourly_weather[0].keys.nil?).to eq(false)
       expect(forecast.hourly_weather[0].keys).to eq(
                                                      [
                                                        :time,
                                                        :temperature,
                                                        :conditions,
                                                        :icon
                                                      ]
                                                    )
    end
  end
end