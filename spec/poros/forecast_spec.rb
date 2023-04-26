require 'rails_helper'

RSpec.describe Forecast do
  let!(:data) { forecast_data }
  
  describe 'attributes' do
    let!(:forecast) { Forecast.new(data) }
    
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